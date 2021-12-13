import 'package:flutter/material.dart';

class UnitSelectorButton extends StatelessWidget {
  const UnitSelectorButton({
    required this.label,
    required this.selected,
    required this.onPressed,
  });

  final String label;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: selected,
      child: TextButton(
        onPressed: () {
          onPressed();
        },
        style: TextButton.styleFrom(
          side: const BorderSide(color: Colors.black12, width: 2),
          backgroundColor: selected ? Colors.grey : Colors.white,
        ),
        child: Text(label),
      ),
    );
  }
}
