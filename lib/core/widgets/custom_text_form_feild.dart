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

      style: Theme.of(context).textTheme.bodyMedium,

      decoration: InputDecoration(
        labelText: label,
        hintText: hint,

        labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
        hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,

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