import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/tuner_provider.dart';
import '../widgets/tuner_gauge.dart';
import '../widgets/string_selector.dart';
import 'package:instrument_tuner/generated/app_localizations.dart';

class TunerScreen extends StatelessWidget {
  const TunerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tunerProvider = context.watch<TunerProvider>();
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),

            // Instrument and tuning selector
            _InstrumentSelector(),

            const SizedBox(height: 32),

            // Current note display
            _NoteDisplay(
              currentPitch: tunerProvider.currentPitch,
              isListening: tunerProvider.isListening,
            ),

            const SizedBox(height: 24),

            // Tuner gauge
            if (tunerProvider.currentPitch != null)
              TunerGauge(
                cents: tunerProvider.currentPitch!.cents,
                status: tunerProvider.tuningStatus,
              ).animate().fadeIn(duration: 300.ms),

            const SizedBox(height: 24),

            // Status text
            _StatusText(
              status: tunerProvider.tuningStatus,
              cents: tunerProvider.currentPitch?.cents ?? 0,
              isListening: tunerProvider.isListening,
            ),

            const SizedBox(height: 32),

            // String selector
            if (!tunerProvider.autoDetectMode)
              StringSelector(
                tuning: tunerProvider.selectedTuning,
                selectedString: tunerProvider.selectedString,
                onStringSelected: (stringNumber) {
                  tunerProvider.setSelectedString(stringNumber);
                },
                onPlayNote: (stringNumber) {
                  final stringTuning = tunerProvider.selectedTuning.strings
                      .firstWhere((s) => s.stringNumber == stringNumber);
                  tunerProvider.playNote(stringTuning.note);
                },
              ),

            const Spacer(),

            // Auto detect toggle
            _AutoDetectToggle(),

            const SizedBox(height: 16),

            // Start/Stop button
            _ListenButton(),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _InstrumentSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tunerProvider = context.watch<TunerProvider>();
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        _showInstrumentPicker(context);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Text(
              tunerProvider.selectedInstrument.icon,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getInstrumentName(context, tunerProvider.selectedInstrument.nameKey),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _getTuningName(context, tunerProvider.selectedTuning.nameKey),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  String _getInstrumentName(BuildContext context, String key) {
    final l10n = AppLocalizations.of(context)!;
    switch (key) {
      case 'guitar6': return l10n.guitar6;
      case 'guitar7': return l10n.guitar7;
      case 'guitar8': return l10n.guitar8;
      case 'bass': return l10n.bass;
      case 'ukulele': return l10n.ukulele;
      case 'violin': return l10n.violin;
      case 'viola': return l10n.viola;
      case 'cello': return l10n.cello;
      case 'mandolin': return l10n.mandolin;
      case 'banjo': return l10n.banjo;
      default: return key;
    }
  }

  String _getTuningName(BuildContext context, String key) {
    final l10n = AppLocalizations.of(context)!;
    switch (key) {
      case 'tuningStandard': return l10n.tuningStandard;
      case 'tuningDropD': return l10n.tuningDropD;
      case 'tuningDropC': return l10n.tuningDropC;
      case 'tuningOpenG': return l10n.tuningOpenG;
      case 'tuningOpenD': return l10n.tuningOpenD;
      case 'tuningDADGAD': return l10n.tuningDADGAD;
      case 'tuningHalfStep': return l10n.tuningHalfStep;
      case 'tuningFullStep': return l10n.tuningFullStep;
      default: return key;
    }
  }

  void _showInstrumentPicker(BuildContext context) {
    Navigator.of(context).pushNamed('/instruments');
  }
}

class _NoteDisplay extends StatelessWidget {
  final dynamic currentPitch;
  final bool isListening;

  const _NoteDisplay({
    required this.currentPitch,
    required this.isListening,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    String displayText;
    if (!isListening) {
      displayText = '--';
    } else if (currentPitch?.note == null) {
      displayText = '...';
    } else {
      displayText = currentPitch!.note!.fullName;
    }

    return Column(
      children: [
        Text(
          displayText,
          style: theme.textTheme.displayLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 72,
          ),
        ).animate(key: ValueKey(displayText))
            .fadeIn(duration: 200.ms)
            .scale(begin: const Offset(0.8, 0.8)),

        if (currentPitch != null && currentPitch!.frequency > 0)
          Text(
            '${currentPitch!.frequency.toStringAsFixed(1)} ${l10n.hz}',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ).animate().fadeIn(duration: 300.ms),
      ],
    );
  }
}

class _StatusText extends StatelessWidget {
  final String status;
  final double cents;
  final bool isListening;

  const _StatusText({
    required this.status,
    required this.cents,
    required this.isListening,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    if (!isListening) return const SizedBox.shrink();

    String statusText;
    Color statusColor;

    switch (status) {
      case 'inTune':
        statusText = l10n.inTune;
        statusColor = Colors.green;
        break;
      case 'tooLow':
        statusText = l10n.tooLow;
        statusColor = Colors.orange;
        break;
      case 'tooHigh':
        statusText = l10n.tooHigh;
        statusColor = Colors.orange;
        break;
      default:
        statusText = l10n.listening;
        statusColor = theme.colorScheme.onSurfaceVariant;
    }

    return Column(
      children: [
        Text(
          statusText,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: statusColor,
            fontWeight: FontWeight.bold,
          ),
        ).animate(key: ValueKey(statusText))
            .fadeIn(duration: 200.ms)
            .shimmer(duration: 1000.ms, delay: 200.ms),

        if (cents.abs() > 0.1)
          Text(
            '${cents > 0 ? '+' : ''}${cents.toStringAsFixed(1)} ${l10n.cents}',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
      ],
    );
  }
}

class _AutoDetectToggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tunerProvider = context.watch<TunerProvider>();
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            l10n.autoDetect,
            style: theme.textTheme.titleMedium,
          ),
          Switch(
            value: tunerProvider.autoDetectMode,
            onChanged: (value) {
              tunerProvider.setAutoDetectMode(value);
            },
          ),
        ],
      ),
    );
  }
}

class _ListenButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tunerProvider = context.watch<TunerProvider>();
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          onPressed: () {
            tunerProvider.toggleListening();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: tunerProvider.isListening
                ? theme.colorScheme.error
                : theme.colorScheme.primary,
            foregroundColor: tunerProvider.isListening
                ? theme.colorScheme.onError
                : theme.colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                tunerProvider.isListening ? Icons.stop : Icons.mic,
                size: 28,
              ),
              const SizedBox(width: 12),
              Text(
                tunerProvider.isListening ? 'Stop' : l10n.tapToStart,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ).animate(target: tunerProvider.isListening ? 1 : 0)
            .shimmer(duration: 2000.ms, delay: 0.ms)
            .then()
            .shimmer(duration: 2000.ms),
      ),
    );
  }
}
