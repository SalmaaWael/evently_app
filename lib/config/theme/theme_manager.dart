import 'package:evently_app/core/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager{

  static final ThemeData light= ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.lightblue,
      foregroundColor:ColorsManager.balck,
      centerTitle: true,
      titleTextStyle: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 18,color: ColorsManager.balck)
    ),
    scaffoldBackgroundColor: ColorsManager.lightblue,
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide:  BorderSide(width: 1.w,color: ColorsManager.grey),
      ),
      focusedBorder:OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide:  BorderSide(width: 1.w,color: ColorsManager.grey),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide:  BorderSide(width: 1.w,color: ColorsManager.red),
      ),
        prefixIconColor: ColorsManager.grey,
        labelStyle: GoogleFonts.inter(fontSize: 16.sp,fontWeight: FontWeight.w500,color: ColorsManager.grey,)
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(      style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      minimumSize: Size(double.infinity, 56.h),
      backgroundColor: ColorsManager.blue,
      foregroundColor: ColorsManager.white,
      textStyle: GoogleFonts.inter(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
      ),
    ),
    ),
    textButtonTheme: TextButtonThemeData( style: TextButton.styleFrom(
        textStyle: GoogleFonts.inter(fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: ColorsManager.blue,
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
        )
    ),)
  );
  static final ThemeData dark= ThemeData();
}