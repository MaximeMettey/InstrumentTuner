import 'note.dart';

class StringTuning {
  final int stringNumber;
  final Note note;

  const StringTuning({
    required this.stringNumber,
    required this.note,
  });
}

class Tuning {
  final String id;
  final String nameKey; // For localization
  final List<StringTuning> strings;

  const Tuning({
    required this.id,
    required this.nameKey,
    required this.strings,
  });

  int get stringCount => strings.length;
}

class TuningPresets {
  // Helper to create note
  static Note _note(String name, int octave) {
    return Note(
      name: name,
      frequency: NoteHelper.getFrequency(name, octave),
      octave: octave,
    );
  }

  // Guitar 6 strings
  static final guitar6Standard = Tuning(
    id: 'guitar6_standard',
    nameKey: 'tuningStandard',
    strings: [
      StringTuning(stringNumber: 1, note: _note('E', 2)),
      StringTuning(stringNumber: 2, note: _note('A', 2)),
      StringTuning(stringNumber: 3, note: _note('D', 3)),
      StringTuning(stringNumber: 4, note: _note('G', 3)),
      StringTuning(stringNumber: 5, note: _note('B', 3)),
      StringTuning(stringNumber: 6, note: _note('E', 4)),
    ],
  );

  static final guitar6DropD = Tuning(
    id: 'guitar6_dropd',
    nameKey: 'tuningDropD',
    strings: [
      StringTuning(stringNumber: 1, note: _note('D', 2)),
      StringTuning(stringNumber: 2, note: _note('A', 2)),
      StringTuning(stringNumber: 3, note: _note('D', 3)),
      StringTuning(stringNumber: 4, note: _note('G', 3)),
      StringTuning(stringNumber: 5, note: _note('B', 3)),
      StringTuning(stringNumber: 6, note: _note('E', 4)),
    ],
  );

  static final guitar6DropC = Tuning(
    id: 'guitar6_dropc',
    nameKey: 'tuningDropC',
    strings: [
      StringTuning(stringNumber: 1, note: _note('C', 2)),
      StringTuning(stringNumber: 2, note: _note('G', 2)),
      StringTuning(stringNumber: 3, note: _note('C', 3)),
      StringTuning(stringNumber: 4, note: _note('F', 3)),
      StringTuning(stringNumber: 5, note: _note('A', 3)),
      StringTuning(stringNumber: 6, note: _note('D', 4)),
    ],
  );

  static final guitar6OpenG = Tuning(
    id: 'guitar6_openg',
    nameKey: 'tuningOpenG',
    strings: [
      StringTuning(stringNumber: 1, note: _note('D', 2)),
      StringTuning(stringNumber: 2, note: _note('G', 2)),
      StringTuning(stringNumber: 3, note: _note('D', 3)),
      StringTuning(stringNumber: 4, note: _note('G', 3)),
      StringTuning(stringNumber: 5, note: _note('B', 3)),
      StringTuning(stringNumber: 6, note: _note('D', 4)),
    ],
  );

  static final guitar6OpenD = Tuning(
    id: 'guitar6_opend',
    nameKey: 'tuningOpenD',
    strings: [
      StringTuning(stringNumber: 1, note: _note('D', 2)),
      StringTuning(stringNumber: 2, note: _note('A', 2)),
      StringTuning(stringNumber: 3, note: _note('D', 3)),
      StringTuning(stringNumber: 4, note: _note('F#', 3)),
      StringTuning(stringNumber: 5, note: _note('A', 3)),
      StringTuning(stringNumber: 6, note: _note('D', 4)),
    ],
  );

  static final guitar6DADGAD = Tuning(
    id: 'guitar6_dadgad',
    nameKey: 'tuningDADGAD',
    strings: [
      StringTuning(stringNumber: 1, note: _note('D', 2)),
      StringTuning(stringNumber: 2, note: _note('A', 2)),
      StringTuning(stringNumber: 3, note: _note('D', 3)),
      StringTuning(stringNumber: 4, note: _note('G', 3)),
      StringTuning(stringNumber: 5, note: _note('A', 3)),
      StringTuning(stringNumber: 6, note: _note('D', 4)),
    ],
  );

  static final guitar6HalfStep = Tuning(
    id: 'guitar6_halfstep',
    nameKey: 'tuningHalfStep',
    strings: [
      StringTuning(stringNumber: 1, note: _note('D#', 2)),
      StringTuning(stringNumber: 2, note: _note('G#', 2)),
      StringTuning(stringNumber: 3, note: _note('C#', 3)),
      StringTuning(stringNumber: 4, note: _note('F#', 3)),
      StringTuning(stringNumber: 5, note: _note('A#', 3)),
      StringTuning(stringNumber: 6, note: _note('D#', 4)),
    ],
  );

  static final guitar6FullStep = Tuning(
    id: 'guitar6_fullstep',
    nameKey: 'tuningFullStep',
    strings: [
      StringTuning(stringNumber: 1, note: _note('D', 2)),
      StringTuning(stringNumber: 2, note: _note('G', 2)),
      StringTuning(stringNumber: 3, note: _note('C', 3)),
      StringTuning(stringNumber: 4, note: _note('F', 3)),
      StringTuning(stringNumber: 5, note: _note('A', 3)),
      StringTuning(stringNumber: 6, note: _note('D', 4)),
    ],
  );

  // Guitar 7 strings
  static final guitar7Standard = Tuning(
    id: 'guitar7_standard',
    nameKey: 'tuningStandard',
    strings: [
      StringTuning(stringNumber: 1, note: _note('B', 1)),
      StringTuning(stringNumber: 2, note: _note('E', 2)),
      StringTuning(stringNumber: 3, note: _note('A', 2)),
      StringTuning(stringNumber: 4, note: _note('D', 3)),
      StringTuning(stringNumber: 5, note: _note('G', 3)),
      StringTuning(stringNumber: 6, note: _note('B', 3)),
      StringTuning(stringNumber: 7, note: _note('E', 4)),
    ],
  );

  // Guitar 8 strings
  static final guitar8Standard = Tuning(
    id: 'guitar8_standard',
    nameKey: 'tuningStandard',
    strings: [
      StringTuning(stringNumber: 1, note: _note('F#', 1)),
      StringTuning(stringNumber: 2, note: _note('B', 1)),
      StringTuning(stringNumber: 3, note: _note('E', 2)),
      StringTuning(stringNumber: 4, note: _note('A', 2)),
      StringTuning(stringNumber: 5, note: _note('D', 3)),
      StringTuning(stringNumber: 6, note: _note('G', 3)),
      StringTuning(stringNumber: 7, note: _note('B', 3)),
      StringTuning(stringNumber: 8, note: _note('E', 4)),
    ],
  );

  // Bass 4 strings
  static final bass4Standard = Tuning(
    id: 'bass4_standard',
    nameKey: 'tuningStandard',
    strings: [
      StringTuning(stringNumber: 1, note: _note('E', 1)),
      StringTuning(stringNumber: 2, note: _note('A', 1)),
      StringTuning(stringNumber: 3, note: _note('D', 2)),
      StringTuning(stringNumber: 4, note: _note('G', 2)),
    ],
  );

  // Ukulele
  static final ukuleleStandard = Tuning(
    id: 'ukulele_standard',
    nameKey: 'tuningStandard',
    strings: [
      StringTuning(stringNumber: 1, note: _note('G', 4)),
      StringTuning(stringNumber: 2, note: _note('C', 4)),
      StringTuning(stringNumber: 3, note: _note('E', 4)),
      StringTuning(stringNumber: 4, note: _note('A', 4)),
    ],
  );

  // Violin
  static final violinStandard = Tuning(
    id: 'violin_standard',
    nameKey: 'tuningStandard',
    strings: [
      StringTuning(stringNumber: 1, note: _note('G', 3)),
      StringTuning(stringNumber: 2, note: _note('D', 4)),
      StringTuning(stringNumber: 3, note: _note('A', 4)),
      StringTuning(stringNumber: 4, note: _note('E', 5)),
    ],
  );

  // Viola
  static final violaStandard = Tuning(
    id: 'viola_standard',
    nameKey: 'tuningStandard',
    strings: [
      StringTuning(stringNumber: 1, note: _note('C', 3)),
      StringTuning(stringNumber: 2, note: _note('G', 3)),
      StringTuning(stringNumber: 3, note: _note('D', 4)),
      StringTuning(stringNumber: 4, note: _note('A', 4)),
    ],
  );

  // Cello
  static final celloStandard = Tuning(
    id: 'cello_standard',
    nameKey: 'tuningStandard',
    strings: [
      StringTuning(stringNumber: 1, note: _note('C', 2)),
      StringTuning(stringNumber: 2, note: _note('G', 2)),
      StringTuning(stringNumber: 3, note: _note('D', 3)),
      StringTuning(stringNumber: 4, note: _note('A', 3)),
    ],
  );

  // Mandolin
  static final mandolinStandard = Tuning(
    id: 'mandolin_standard',
    nameKey: 'tuningStandard',
    strings: [
      StringTuning(stringNumber: 1, note: _note('G', 3)),
      StringTuning(stringNumber: 2, note: _note('D', 4)),
      StringTuning(stringNumber: 3, note: _note('A', 4)),
      StringTuning(stringNumber: 4, note: _note('E', 5)),
    ],
  );

  // Banjo (5 strings)
  static final banjoStandard = Tuning(
    id: 'banjo_standard',
    nameKey: 'tuningStandard',
    strings: [
      StringTuning(stringNumber: 1, note: _note('D', 3)),
      StringTuning(stringNumber: 2, note: _note('B', 3)),
      StringTuning(stringNumber: 3, note: _note('G', 3)),
      StringTuning(stringNumber: 4, note: _note('D', 4)),
      StringTuning(stringNumber: 5, note: _note('G', 4)),
    ],
  );
}
