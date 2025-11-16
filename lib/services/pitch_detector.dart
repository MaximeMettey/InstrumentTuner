import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:mic_stream/mic_stream.dart';
import 'package:fft/fft.dart';
import '../models/note.dart';

class PitchDetectionResult {
  final double frequency;
  final Note? note;
  final double cents;
  final double confidence;

  PitchDetectionResult({
    required this.frequency,
    this.note,
    required this.cents,
    required this.confidence,
  });
}

class PitchDetector {
  StreamSubscription<Uint8List>? _micSubscription;
  final _pitchController = StreamController<PitchDetectionResult>.broadcast();

  Stream<PitchDetectionResult> get pitchStream => _pitchController.stream;

  bool _isListening = false;
  bool get isListening => _isListening;

  // Audio processing parameters
  static const int sampleRate = 44100;
  static const int bufferSize = 4096;

  final List<int> _audioBuffer = [];

  Future<void> startListening() async {
    if (_isListening) return;

    try {
      final stream = await MicStream.microphone(
        audioSource: AudioSource.DEFAULT,
        sampleRate: sampleRate,
        channelConfig: ChannelConfig.CHANNEL_IN_MONO,
        audioFormat: AudioFormat.ENCODING_PCM_16BIT,
      );

      _isListening = true;
      _audioBuffer.clear();

      _micSubscription = stream?.listen(
        (samples) {
          _processAudioData(samples);
        },
        onError: (error) {
          print('Microphone error: $error');
          stopListening();
        },
      );
    } catch (e) {
      print('Error starting microphone: $e');
      _isListening = false;
    }
  }

  void _processAudioData(Uint8List samples) {
    // Convert bytes to 16-bit integers
    for (int i = 0; i < samples.length - 1; i += 2) {
      int sample = samples[i] | (samples[i + 1] << 8);
      if (sample > 32767) sample -= 65536;
      _audioBuffer.add(sample);
    }

    // Process when we have enough samples
    if (_audioBuffer.length >= bufferSize) {
      final data = _audioBuffer.sublist(0, bufferSize);
      _audioBuffer.removeRange(0, bufferSize ~/ 2); // 50% overlap

      final result = _detectPitch(data);
      if (result != null) {
        _pitchController.add(result);
      }
    }
  }

  PitchDetectionResult? _detectPitch(List<int> samples) {
    // Convert to doubles and normalize
    final doubles = samples.map((s) => s / 32768.0).toList();

    // Apply Hamming window
    final windowed = _applyHammingWindow(doubles);

    // Perform FFT
    final fft = FFT();
    final freq = fft.Transform(windowed);

    // Find the peak frequency
    final magnitudes = <double>[];
    for (int i = 0; i < freq.length ~/ 2; i++) {
      final real = freq[i].real;
      final imag = freq[i].imaginary;
      magnitudes.add(sqrt(real * real + imag * imag));
    }

    // Find peak in the musical range (80 Hz - 1200 Hz)
    const minFreq = 80.0;
    const maxFreq = 1200.0;
    final minBin = (minFreq * bufferSize / sampleRate).round();
    final maxBin = (maxFreq * bufferSize / sampleRate).round();

    double maxMagnitude = 0;
    int peakBin = 0;

    for (int i = minBin; i < maxBin && i < magnitudes.length; i++) {
      if (magnitudes[i] > maxMagnitude) {
        maxMagnitude = magnitudes[i];
        peakBin = i;
      }
    }

    // Calculate confidence based on peak magnitude
    final avgMagnitude = magnitudes.reduce((a, b) => a + b) / magnitudes.length;
    final confidence = min(1.0, maxMagnitude / (avgMagnitude * 10));

    if (confidence < 0.1 || peakBin == 0) {
      return null; // Not confident enough
    }

    // Parabolic interpolation for better frequency estimation
    double frequency = peakBin * sampleRate / bufferSize;

    if (peakBin > 0 && peakBin < magnitudes.length - 1) {
      final alpha = magnitudes[peakBin - 1];
      final beta = magnitudes[peakBin];
      final gamma = magnitudes[peakBin + 1];
      final p = 0.5 * (alpha - gamma) / (alpha - 2 * beta + gamma);
      frequency = (peakBin + p) * sampleRate / bufferSize;
    }

    // Get the closest note
    final note = NoteHelper.getNoteFromFrequency(frequency);

    if (note == null) return null;

    // Calculate cents difference
    final cents = NoteHelper.getCentsDifference(note.frequency, frequency);

    return PitchDetectionResult(
      frequency: frequency,
      note: note,
      cents: cents,
      confidence: confidence,
    );
  }

  List<double> _applyHammingWindow(List<double> data) {
    final windowed = <double>[];
    final n = data.length;

    for (int i = 0; i < n; i++) {
      final window = 0.54 - 0.46 * cos(2 * pi * i / (n - 1));
      windowed.add(data[i] * window);
    }

    return windowed;
  }

  Future<void> stopListening() async {
    await _micSubscription?.cancel();
    _micSubscription = null;
    _isListening = false;
    _audioBuffer.clear();
  }

  void dispose() {
    stopListening();
    _pitchController.close();
  }
}
