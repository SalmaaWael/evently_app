import 'package:evently_app/core/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormFeild extends StatelessWidget {
  const CustomTextFormFeild({super.key, this.prefixIcon, this. suffixIcon,required this.label,  this.keyboardType=TextInputType.text, this.obscureText, });
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String label;
  final bool? obscureText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(

        style: GoogleFonts.inter(fontSize: 16.sp,fontWeight: FontWeight.w500,color: Colors.black),
        keyboardType: keyboardType,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            isDense: true,

            prefixIcon: prefixIcon != null ?Icon(prefixIcon):null,
            suffixIcon: suffixIcon != null ?Icon(suffixIcon):null,

            labelText: label,

              )

      ),
    );
  }
}
