import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/instrument.dart';
import '../models/tuning.dart';
import '../models/note.dart';
import '../services/pitch_detector.dart';
import '../services/audio_player_service.dart';

class TunerProvider with ChangeNotifier {
  final PitchDetector _pitchDetector = PitchDetector();
  final AudioPlayerService _audioPlayer = AudioPlayerService();

  Instrument _selectedInstrument = InstrumentPresets.guitar6;
  Tuning _selectedTuning = InstrumentPresets.guitar6.tunings.first;
  int? _selectedString;

  PitchDetectionResult? _currentPitch;
  bool _isListening = false;
  bool _autoDetectMode = true;

  StreamSubscription<PitchDetectionResult>? _pitchSubscription;

  // Getters
  Instrument get selectedInstrument => _selectedInstrument;
  Tuning get selectedTuning => _selectedTuning;
  int? get selectedString => _selectedString;
  PitchDetectionResult? get currentPitch => _currentPitch;
  bool get isListening => _isListening;
  bool get autoDetectMode => _autoDetectMode;

  Note? get targetNote {
    if (_selectedString == null) return null;
    final stringTuning = _selectedTuning.strings.firstWhere(
      (s) => s.stringNumber == _selectedString,
    );
    return stringTuning.note;
  }

  String get tuningStatus {
    if (_currentPitch == null || _currentPitch!.note == null) {
      return 'listening';
    }

    final cents = _currentPitch!.cents;

    if (cents.abs() < 5) {
      return 'inTune';
    } else if (cents < 0) {
      return 'tooLow';
    } else {
      return 'tooHigh';
    }
  }

  void setInstrument(Instrument instrument) {
    _selectedInstrument = instrument;
    _selectedTuning = instrument.tunings.first;
    _selectedString = null;
    notifyListeners();
  }

  void setTuning(Tuning tuning) {
    _selectedTuning = tuning;
    _selectedString = null;
    notifyListeners();
  }

  void setSelectedString(int? stringNumber) {
    _selectedString = stringNumber;
    notifyListeners();
  }

  void setAutoDetectMode(bool auto) {
    _autoDetectMode = auto;
    if (!auto) {
      _selectedString = _selectedTuning.strings.first.stringNumber;
    } else {
      _selectedString = null;
    }
    notifyListeners();
  }

  Future<void> toggleListening() async {
    if (_isListening) {
      await stopListening();
    } else {
      await startListening();
    }
  }

  Future<void> startListening() async {
    // Request microphone permission
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      print('Microphone permission denied');
      return;
    }

    await _pitchDetector.startListening();
    _isListening = true;

    _pitchSubscription = _pitchDetector.pitchStream.listen((pitch) {
      _currentPitch = pitch;

      // In auto-detect mode, find the closest string
      if (_autoDetectMode && pitch.note != null) {
        _findClosestString(pitch.note!);
      }

      notifyListeners();
    });

    notifyListeners();
  }

  void _findClosestString(Note detectedNote) {
    double minDifference = double.infinity;
    int? closestString;

    for (final stringTuning in _selectedTuning.strings) {
      final diff = (stringTuning.note.frequency - detectedNote.frequency).abs();
      if (diff < minDifference) {
        minDifference = diff;
        closestString = stringTuning.stringNumber;
      }
    }

    if (closestString != _selectedString) {
      _selectedString = closestString;
    }
  }

  Future<void> stopListening() async {
    await _pitchDetector.stopListening();
    await _pitchSubscription?.cancel();
    _pitchSubscription = null;
    _isListening = false;
    _currentPitch = null;
    notifyListeners();
  }

  Future<void> playNote(Note note) async {
    await _audioPlayer.playNote(note);
  }

  Future<void> stopPlayback() async {
    await _audioPlayer.stop();
  }

  @override
  void dispose() {
    stopListening();
    _pitchDetector.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }
}
