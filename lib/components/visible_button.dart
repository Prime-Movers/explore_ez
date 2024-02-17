import 'package:flutter/material.dart';

class VisibleButton extends StatelessWidget {
  final ColorScheme colorScheme;
  final bool visible;
  final Alignment alignment;
  final bool isPop;
  final bool isPush;
  final Widget widget;
  final String text;
  final Function()? onPressed;
  const VisibleButton({
    super.key,
    required this.colorScheme,
    required this.visible,
    required this.alignment,
    required this.isPop,
    required this.isPush,
    required this.widget,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FloatingActionButton.extended(
            onPressed: onPressed,
            backgroundColor: colorScheme.background,
            label: Padding(
              padding: const EdgeInsets.only(right: 8, left: 8),
              child: Text(
                text,
                style: TextStyle(color: colorScheme.onBackground, fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
