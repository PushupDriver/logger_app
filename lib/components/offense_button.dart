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
    return MaterialButton(
      color: color,
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 50,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  count.toString(),
                  style: const TextStyle(fontSize: 45),
                ),
              ],
            ),
            Text(text)
          ],
        ),
      ),
    );
  }
}
