import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/tuning.dart';

class StringSelector extends StatelessWidget {
  final Tuning tuning;
  final int? selectedString;
  final Function(int) onStringSelected;
  final Function(int) onPlayNote;

  const StringSelector({
    Key? key,
    required this.tuning,
    required this.selectedString,
    required this.onStringSelected,
    required this.onPlayNote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: tuning.strings.length,
        itemBuilder: (context, index) {
          final stringTuning = tuning.strings[index];
          final isSelected = selectedString == stringTuning.stringNumber;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: _StringCard(
              stringTuning: stringTuning,
              isSelected: isSelected,
              onTap: () => onStringSelected(stringTuning.stringNumber),
              onPlayNote: () => onPlayNote(stringTuning.stringNumber),
            ),
          );
        },
      ),
    );
  }
}

class _StringCard extends StatelessWidget {
  final StringTuning stringTuning;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onPlayNote;

  const _StringCard({
    required this.stringTuning,
    required this.isSelected,
    required this.onTap,
    required this.onPlayNote,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 100,
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primaryContainer
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? colorScheme.primary : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: colorScheme.primary.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${stringTuning.stringNumber}',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: isSelected
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              stringTuning.note.fullName,
              style: theme.textTheme.titleLarge?.copyWith(
                color: isSelected
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            IconButton(
              onPressed: onPlayNote,
              icon: Icon(
                Icons.volume_up,
                color: isSelected
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    ).animate(target: isSelected ? 1 : 0).scale(
          duration: 200.ms,
          begin: const Offset(1, 1),
          end: const Offset(1.05, 1.05),
        );
  }
}
