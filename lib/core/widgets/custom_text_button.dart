import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors_manager.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, required this.title,required this.onPressed});
 final String title;
 final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
    style: TextButton.styleFrom(


    ),
        onPressed:onPressed,
        child:Text(title));
  }
}
