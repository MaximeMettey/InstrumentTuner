import 'tuning.dart';

class Instrument {
  final String id;
  final String nameKey; // For localization
  final String icon;
  final List<Tuning> tunings;

  const Instrument({
    required this.id,
    required this.nameKey,
    required this.icon,
    required this.tunings,
  });
}

class InstrumentPresets {
  static final guitar6 = Instrument(
    id: 'guitar6',
    nameKey: 'guitar6',
    icon: '🎸',
    tunings: [
      TuningPresets.guitar6Standard,
      TuningPresets.guitar6DropD,
      TuningPresets.guitar6DropC,
      TuningPresets.guitar6OpenG,
      TuningPresets.guitar6OpenD,
      TuningPresets.guitar6DADGAD,
      TuningPresets.guitar6HalfStep,
      TuningPresets.guitar6FullStep,
    ],
  );

  static final guitar7 = Instrument(
    id: 'guitar7',
    nameKey: 'guitar7',
    icon: '🎸',
    tunings: [
      TuningPresets.guitar7Standard,
    ],
  );

  static final guitar8 = Instrument(
    id: 'guitar8',
    nameKey: 'guitar8',
    icon: '🎸',
    tunings: [
      TuningPresets.guitar8Standard,
    ],
  );

  static final bass = Instrument(
    id: 'bass',
    nameKey: 'bass',
    icon: '🎸',
    tunings: [
      TuningPresets.bass4Standard,
    ],
  );

  static final ukulele = Instrument(
    id: 'ukulele',
    nameKey: 'ukulele',
    icon: '🎻',
    tunings: [
      TuningPresets.ukuleleStandard,
    ],
  );

  static final violin = Instrument(
    id: 'violin',
    nameKey: 'violin',
    icon: '🎻',
    tunings: [
      TuningPresets.violinStandard,
    ],
  );

  static final viola = Instrument(
    id: 'viola',
    nameKey: 'viola',
    icon: '🎻',
    tunings: [
      TuningPresets.violaStandard,
    ],
  );

  static final cello = Instrument(
    id: 'cello',
    nameKey: 'cello',
    icon: '🎻',
    tunings: [
      TuningPresets.celloStandard,
    ],
  );

  static final mandolin = Instrument(
    id: 'mandolin',
    nameKey: 'mandolin',
    icon: '🎵',
    tunings: [
      TuningPresets.mandolinStandard,
    ],
  );

  static final banjo = Instrument(
    id: 'banjo',
    nameKey: 'banjo',
    icon: '🪕',
    tunings: [
      TuningPresets.banjoStandard,
    ],
  );

  static final List<Instrument> allInstruments = [
    guitar6,
    guitar7,
    guitar8,
    bass,
    ukulele,
    violin,
    viola,
    cello,
    mandolin,
    banjo,
  ];
}
