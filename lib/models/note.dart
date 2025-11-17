class Note {
  final String name;
  final double frequency;
  final int octave;

  const Note({
    required this.name,
    required this.frequency,
    required this.octave,
  });

  String get fullName => '$name$octave';

  @override
  String toString() => fullName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Note &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          octave == other.octave;

  @override
  int get hashCode => name.hashCode ^ octave.hashCode;
}

class NoteHelper {
  static const double a4Frequency = 440.0;

  static const List<String> noteNames = [
    'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B'
  ];

  // Calculate frequency from note name and octave
  static double getFrequency(String noteName, int octave) {
    final noteIndex = noteNames.indexOf(noteName);
    if (noteIndex == -1) return 0.0;

    // A4 is the 9th note (index 9) in octave 4
    final semitonesFromA4 = (octave - 4) * 12 + (noteIndex - 9);
    return a4Frequency * pow(2, semitonesFromA4 / 12);
  }

  // Get note from frequency
  static Note? getNoteFromFrequency(double frequency) {
    if (frequency <= 0) return null;

    // Calculate semitones from A4
    final semitones = 12 * (log(frequency / a4Frequency) / log(2));
    final roundedSemitones = semitones.round();

    // Calculate octave and note index
    final totalSemitones = 9 + roundedSemitones; // 9 is A in C-based indexing
    final octave = 4 + (totalSemitones / 12).floor();
    final noteIndex = totalSemitones % 12;

    if (noteIndex < 0 || noteIndex >= noteNames.length) return null;

    return Note(
      name: noteNames[noteIndex],
      frequency: getFrequency(noteNames[noteIndex], octave),
      octave: octave,
    );
  }

  // Calculate cents difference between two frequencies
  static double getCentsDifference(double frequency1, double frequency2) {
    if (frequency1 <= 0 || frequency2 <= 0) return 0;
    return 1200 * log(frequency2 / frequency1) / log(2);
  }
}

// Import for pow and log functions
import 'dart:math';
