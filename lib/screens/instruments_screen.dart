import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/tuner_provider.dart';
import '../models/instrument.dart';
import '../models/tuning.dart';
import 'package:instrument_tuner/generated/app_localizations.dart';

class InstrumentsScreen extends StatelessWidget {
  const InstrumentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tunerProvider = context.watch<TunerProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.selectInstrument),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: InstrumentPresets.allInstruments.length,
        itemBuilder: (context, index) {
          final instrument = InstrumentPresets.allInstruments[index];
          final isSelected = tunerProvider.selectedInstrument.id == instrument.id;

          return _InstrumentCard(
            instrument: instrument,
            isSelected: isSelected,
            onTap: () {
              _showTuningSelector(context, instrument);
            },
          ).animate(delay: (index * 50).ms).fadeIn().slideX();
        },
      ),
    );
  }

  void _showTuningSelector(BuildContext context, Instrument instrument) {
    showModalBottomSheet(
      context: context,
      builder: (context) => _TuningSelector(instrument: instrument),
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
}

class _InstrumentCard extends StatelessWidget {
  final Instrument instrument;
  final bool isSelected;
  final VoidCallback onTap;

  const _InstrumentCard({
    required this.instrument,
    required this.isSelected,
    required this.onTap,
  });

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: isSelected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected ? theme.colorScheme.primary : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme.colorScheme.primaryContainer
                      : theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    instrument.icon,
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getInstrumentName(context, instrument.nameKey),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${instrument.tunings.length} tunings',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TuningSelector extends StatelessWidget {
  final Instrument instrument;

  const _TuningSelector({required this.instrument});

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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final tunerProvider = context.read<TunerProvider>();

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.selectTuning,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          ...instrument.tunings.map((tuning) {
            return ListTile(
              title: Text(_getTuningName(context, tuning.nameKey)),
              subtitle: Text(
                tuning.strings.map((s) => s.note.fullName).join(', '),
              ),
              onTap: () {
                tunerProvider.setInstrument(instrument);
                tunerProvider.setTuning(tuning);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}
