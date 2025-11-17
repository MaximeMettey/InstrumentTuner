import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:mic_stream/mic_stream.dart';
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

    // Use autocorrelation for pitch detection
    final frequency = _detectPitchAutocorrelation(doubles);

    if (frequency == null || frequency < 80 || frequency > 1200) {
      return null; // Out of valid range
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
      confidence: 0.8, // Fixed confidence for now
    );
  }

  // Autocorrelation-based pitch detection
  double? _detectPitchAutocorrelation(List<double> samples) {
    final n = samples.length;

    // Calculate autocorrelation
    final correlations = List<double>.filled(n ~/ 2, 0);

    for (int lag = 0; lag < n ~/ 2; lag++) {
      double correlation = 0;
      for (int i = 0; i < n - lag; i++) {
        correlation += samples[i] * samples[i + lag];
      }
      correlations[lag] = correlation;
    }

    // Find the first peak after the initial maximum
    const minPeriod = sampleRate ~/ 1200; // Max frequency 1200 Hz
    const maxPeriod = sampleRate ~/ 80;   // Min frequency 80 Hz

    double maxCorr = correlations[0];
    int period = 0;

    // Find maximum in valid range
    for (int i = minPeriod; i < maxPeriod && i < correlations.length; i++) {
      if (correlations[i] > maxCorr * 0.5) { // Threshold
        if (period == 0 || correlations[i] > correlations[period]) {
          period = i;
        }
      }
    }

    if (period == 0) return null;

    // Refine with parabolic interpolation
    if (period > 0 && period < correlations.length - 1) {
      final alpha = correlations[period - 1];
      final beta = correlations[period];
      final gamma = correlations[period + 1];

      if (alpha != beta && gamma != beta) {
        final delta = (alpha - gamma) / (2 * (alpha - 2 * beta + gamma));
        final refinedPeriod = period + delta;
        return sampleRate / refinedPeriod;
      }
    }

    return sampleRate / period;
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
