import 'package:flutter/material.dart';

class OffenseButton extends StatelessWidget {
  final int count;
  final IconData icon;
  final String text;
  final void Function() onPressed;
  final Color color;

  const OffenseButton(
      {super.key,
      required this.count,
      required this.icon,
      required this.text,
      required this.onPressed,
      this.color = Colors.blue});

  @override
  Widget build(BuildContext context) {
    final y = 0.2126 * color.red + 0.7152 * color.green + 0.0722 * color.blue;
    final contentColor = y < 128 ? Colors.white : Colors.black;

    return MaterialButton(
      color: color,
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 45,
                  color: contentColor,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  count.toString(),
                  style: TextStyle(fontSize: 40, color: contentColor),
                ),
              ],
            ),
            Text(
              text,
              style: TextStyle(color: contentColor),
            )
          ],
        ),
      ),
    );
  }
}
