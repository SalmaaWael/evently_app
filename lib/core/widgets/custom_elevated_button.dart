import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed; // ضفنا المتغير ده

  const CustomElevatedButton({
    super.key,
    required this.title,
    this.onPressed, // ضفناه في الـ Constructor
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, // ربطناه هنا بدل () {}
      child: Text(title),
    );
  }
}