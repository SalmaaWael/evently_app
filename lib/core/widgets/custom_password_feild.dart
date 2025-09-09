import 'package:evently_app/core/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPasswordFormField extends StatefulWidget {
  const CustomPasswordFormField({
    super.key,
    required this.label,
    this.keyboardType = TextInputType.visiblePassword,
  });

  final String label;
  final TextInputType keyboardType;

  @override
  State<CustomPasswordFormField> createState() => _CustomPasswordFormFieldState();
}

class _CustomPasswordFormFieldState extends State<CustomPasswordFormField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        keyboardType: widget.keyboardType,
        obscureText: _obscureText,
        style: Theme.of(context).textTheme.displayMedium,


        decoration: InputDecoration(
          isDense: true,
          labelText: widget.label,
          prefixIcon: const Icon(Icons.lock),
          prefixIconColor: ColorsManager.grey,
          suffixIconColor: ColorsManager.grey,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
            ),


            onPressed: _togglePasswordVisibility,
          ),
        ),
      ),
    );
  }
}
