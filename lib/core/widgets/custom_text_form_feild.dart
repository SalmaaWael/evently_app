import 'package:evently_app/core/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormFeild extends StatelessWidget {
  const CustomTextFormFeild({super.key,
    this.prefixIcon,this.prefixIconColor= ColorsManager.grey,
    this. suffixIcon, this.label,
    this.keyboardType=TextInputType.text,
    this.obscureText, this.hint,
    this.maxLines=1, this.hintstyle ,
  });
  final IconData? prefixIcon;
  final Color prefixIconColor;
  final IconData? suffixIcon;
  final String? label;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final String? hint;
   final int maxLines;

  final dynamic hintstyle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(

      maxLines: maxLines ,
       style: Theme.of(context).textTheme.displayMedium,
        keyboardType: keyboardType,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            isDense: true,

          hintText: hint,

            prefixIcon: prefixIcon != null ?Icon(prefixIcon):null,
            suffixIcon: suffixIcon != null ?Icon(suffixIcon):null,

            labelText: label,

              )

      ),
    );
  }
}
