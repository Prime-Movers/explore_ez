import 'package:flutter/material.dart';

class VisibleButton extends StatelessWidget {
  final ColorScheme colorScheme;
  final bool visible;
  final Alignment alignment;
  final bool isPop;
  final bool isPush;
  final Widget widget;
  final String text;
  const VisibleButton({
    super.key,
    required this.colorScheme,
    required this.visible,
    required this.alignment,
    required this.isPop,
    required this.isPush,
    required this.widget,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              if (isPop) {
                Navigator.pop(context);
              } else if (isPush) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return widget;
                  }),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(color: colorScheme.onBackground),
            ),
          ),
        ),
      ),
    );
  }
}
