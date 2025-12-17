import 'package:flutter/material.dart';
import '../colors_manager.dart';

class CustomTextFormFeild extends StatelessWidget {
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int maxLines;

  const CustomTextFormFeild({
    super.key,
    this.label,
    this.hint,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      // 👇 1. لون الكتابة أسود صريح
      style: const TextStyle(color: Colors.black),

      decoration: InputDecoration(
        labelText: label,
        hintText: hint,

        // 👇 2. لون الليبل والهنت رصاصي غامق صريح
        labelStyle: const TextStyle(color: Colors.grey),
        hintStyle: const TextStyle(color: Colors.grey),

        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Colors.grey) : null,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ColorsManager.blue, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ColorsManager.blue, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ColorsManager.blue, width: 2),
        ),
      ),
    );
  }
}