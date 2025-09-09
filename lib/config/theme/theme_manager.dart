import 'package:evently_app/core/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager{

  static final ThemeData light= ThemeData(
    dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: GoogleFonts.inter(color:ColorsManager.white,fontSize: 14.sp,fontWeight:FontWeight. w500),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all(ColorsManager.darkBlue),
        )
    ),
    primaryColor: ColorsManager.blue,
    useMaterial3: false,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.lightblue,
      foregroundColor:ColorsManager.black,
      centerTitle: true,
      titleTextStyle: GoogleFonts.roboto(fontWeight: FontWeight.w400,fontSize: 18,color: ColorsManager.black)
    ),
    scaffoldBackgroundColor: ColorsManager.lightblue,
    bottomAppBarTheme: BottomAppBarThemeData(
      color: ColorsManager.blue,
      shape: const CircularNotchedRectangle(),
    ),


      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorsManager.white,
        unselectedItemColor: ColorsManager.white,

      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorsManager.blue,
        foregroundColor: ColorsManager.white,
        shape: StadiumBorder(
          side: BorderSide(color: ColorsManager.white,width: 4.w),
        ),
      ),
    inputDecorationTheme: InputDecorationTheme(

    prefixIconColor: ColorsManager.grey,
      suffixIconColor:ColorsManager.grey ,
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

        labelStyle: GoogleFonts.inter(fontSize: 16.sp,fontWeight: FontWeight.w500,color: ColorsManager.grey,),
        hintStyle: GoogleFonts.inter(fontSize: 16.sp,fontWeight: FontWeight.w500,color: ColorsManager.grey,),
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
    ),),
    iconTheme: IconThemeData(
      color:ColorsManager.black,
    ),
    cardTheme: CardThemeData(
     color: ColorsManager.lightblue,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),

      ),
    ),
      cardColor: ColorsManager.lightblue,
      textTheme: TextTheme(
        titleSmall: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: ColorsManager.white,
        ),
        titleMedium: GoogleFonts.inter(fontSize: 24.sp,
            fontWeight: FontWeight.w500,
            color: ColorsManager.white),

        labelMedium: GoogleFonts.inter(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: ColorsManager.black,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: ColorsManager.blue,
        ),
          displayMedium: GoogleFonts.inter(fontSize: 16,color:ColorsManager.black),
          bodySmall: GoogleFonts.inter(color: ColorsManager.black,fontWeight: FontWeight.bold,fontSize: 14),

          displaySmall: GoogleFonts.inter(fontSize: 14,fontWeight: FontWeight. bold,color: ColorsManager.blue)
      ),);

  static final ThemeData dark = ThemeData(
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: GoogleFonts.inter(color:ColorsManager.ofWhite,fontSize: 14.sp,fontWeight:FontWeight. w500),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(ColorsManager.darkBlue),
      )
    ),
    primaryColor: ColorsManager.darkBlue,
    useMaterial3: false,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.darkBlue,
      foregroundColor: ColorsManager.blue,
      centerTitle: true,
      titleTextStyle: GoogleFonts.roboto(
        fontWeight: FontWeight.w400,
        fontSize: 18,
        color: ColorsManager.blue,
      ),
    ),
  scaffoldBackgroundColor: ColorsManager.darkBlue,
  bottomAppBarTheme: BottomAppBarThemeData(
  color: ColorsManager.blue,
  shape: const CircularNotchedRectangle(),
  ),


  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorsManager.lightblue,
      unselectedItemColor: ColorsManager.lightblue,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorsManager.darkBlue,
      foregroundColor: ColorsManager.white,
      shape: StadiumBorder(
        side: BorderSide(color: ColorsManager.lightblue, width: 4.w),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(

      prefixIconColor: ColorsManager.ofWhite,
      suffixIconColor:ColorsManager.ofWhite ,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(width: 1.w, color: ColorsManager.blue),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(width: 1.w, color: ColorsManager.blue),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(width: 1.w, color: ColorsManager.red),
      ),

      labelStyle: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.ofWhite,
      ),
      hintStyle: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.blue,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
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
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: GoogleFonts.inter(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: ColorsManager.blue,
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
        ),
      ),
    ),
    iconTheme: IconThemeData(
      color: ColorsManager.ofWhite,
    ),
   /// cardColor: ColorsManager.ofWhite,
    cardTheme: CardThemeData(
      color: ColorsManager.darkBlue,
      elevation: 8,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),

      ),
    ),
    textTheme: TextTheme(
      titleSmall: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.ofWhite,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 24.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.ofWhite,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: ColorsManager.ofWhite,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: ColorsManager.blue,
      ),
        displayMedium: GoogleFonts.inter(fontSize: 16,color:ColorsManager.ofWhite),

        displaySmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: ColorsManager.darkBlue,
      ),
      bodySmall: GoogleFonts.inter(color: ColorsManager.ofWhite,fontWeight: FontWeight.bold,fontSize: 14)
    ),
  );

  static BottomAppBarThemeData? get bottomAppBarTheme => null;
}