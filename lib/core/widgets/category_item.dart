import 'package:evently_app/core/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/category_model.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key,required this.category,
  required this.selectedBackgroundColor,required this.unselectedBackgroundColor,
    required this.selectedForegroundColor,required this.unselectedForegroundColor,
    required this.isSelected,
  });
final CategoryModel category;
  final Color selectedBackgroundColor;
  final Color unselectedBackgroundColor;
  final Color selectedForegroundColor;
  final Color unselectedForegroundColor;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
      child: Container(
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(45.r),
          border: Border.all(color: selectedBackgroundColor,width: 1.w),
          color: isSelected?selectedBackgroundColor:unselectedBackgroundColor,

        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(category.icon,color: isSelected?selectedForegroundColor:unselectedForegroundColor,),
              SizedBox(width: 8,),
              Text(category.name,style:GoogleFonts.inter(fontSize: 16.sp,fontWeight: FontWeight.w500,color: isSelected?selectedForegroundColor:unselectedForegroundColor)),
            ],
          ),
        ),
      ),
    );
  }
}
