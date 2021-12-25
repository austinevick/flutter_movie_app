import 'package:flutter/material.dart';

class MovieHeaderText extends StatelessWidget {
  final String? text;
  const MovieHeaderText({
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        text!,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}
