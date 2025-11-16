import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import '../models/note.dart';

class AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  static const int sampleRate = 44100;
  static const double duration = 2.0; // seconds

  Future<void> playNote(Note note) async {
    try {
      // Generate sine wave for the note
      final samples = _generateSineWave(note.frequency, duration);

      // Convert to WAV format
      final wavBytes = _createWavFile(samples);

      // Play the audio
      await _audioPlayer.stop();
      await _audioPlayer.play(BytesSource(wavBytes));
    } catch (e) {
      print('Error playing note: $e');
    }
  }

  Float32List _generateSineWave(double frequency, double duration) {
    final numSamples = (sampleRate * duration).toInt();
    final samples = Float32List(numSamples);

    for (int i = 0; i < numSamples; i++) {
      final t = i / sampleRate;

      // Sine wave with envelope (fade in/out)
      final envelope = _getEnvelope(t, duration);
      samples[i] = sin(2 * pi * frequency * t) * envelope * 0.3;
    }

    return samples;
  }

  double _getEnvelope(double t, double duration) {
    const fadeTime = 0.05; // 50ms fade

    if (t < fadeTime) {
      // Fade in
      return t / fadeTime;
    } else if (t > duration - fadeTime) {
      // Fade out
      return (duration - t) / fadeTime;
    }

    return 1.0;
  }

  Uint8List _createWavFile(Float32List samples) {
    final numSamples = samples.length;
    final numChannels = 1;
    final bitsPerSample = 16;
    final byteRate = sampleRate * numChannels * bitsPerSample ~/ 8;
    final blockAlign = numChannels * bitsPerSample ~/ 8;
    final dataSize = numSamples * blockAlign;

    final buffer = ByteData(44 + dataSize);

    // RIFF header
    buffer.setUint8(0, 'R'.codeUnitAt(0));
    buffer.setUint8(1, 'I'.codeUnitAt(0));
    buffer.setUint8(2, 'F'.codeUnitAt(0));
    buffer.setUint8(3, 'F'.codeUnitAt(0));
    buffer.setUint32(4, 36 + dataSize, Endian.little);
    buffer.setUint8(8, 'W'.codeUnitAt(0));
    buffer.setUint8(9, 'A'.codeUnitAt(0));
    buffer.setUint8(10, 'V'.codeUnitAt(0));
    buffer.setUint8(11, 'E'.codeUnitAt(0));

    // Format chunk
    buffer.setUint8(12, 'f'.codeUnitAt(0));
    buffer.setUint8(13, 'm'.codeUnitAt(0));
    buffer.setUint8(14, 't'.codeUnitAt(0));
    buffer.setUint8(15, ' '.codeUnitAt(0));
    buffer.setUint32(16, 16, Endian.little); // Subchunk size
    buffer.setUint16(20, 1, Endian.little); // Audio format (PCM)
    buffer.setUint16(22, numChannels, Endian.little);
    buffer.setUint32(24, sampleRate, Endian.little);
    buffer.setUint32(28, byteRate, Endian.little);
    buffer.setUint16(32, blockAlign, Endian.little);
    buffer.setUint16(34, bitsPerSample, Endian.little);

    // Data chunk
    buffer.setUint8(36, 'd'.codeUnitAt(0));
    buffer.setUint8(37, 'a'.codeUnitAt(0));
    buffer.setUint8(38, 't'.codeUnitAt(0));
    buffer.setUint8(39, 'a'.codeUnitAt(0));
    buffer.setUint32(40, dataSize, Endian.little);

    // Audio data
    for (int i = 0; i < numSamples; i++) {
      final sample = (samples[i] * 32767).round().clamp(-32768, 32767);
      buffer.setInt16(44 + i * 2, sample, Endian.little);
    }

    return buffer.buffer.asUint8List();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
