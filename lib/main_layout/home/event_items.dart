import 'package:evently_app/core/colors_manager.dart';
import 'package:evently_app/core/extension/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/assets_manager/assests_manager.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime eventDate=DateTime.now().add(Duration(days: 35));
    return Container(

      margin: REdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
      padding: REdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),

      decoration: BoxDecoration(
        border: Border.all(color: ColorsManager.blue,width: 2.w) ,
        borderRadius: BorderRadius.circular(16.r),

        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(ImageAssets.birthday),)
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal:10),
              child: Column(
                children: [
                  Text(eventDate.day.toString(),style:GoogleFonts.inter(fontSize: 20.sp,fontWeight: FontWeight.bold,color: ColorsManager.blue)),
                  Text(eventDate.viewMonthText,style:GoogleFonts.inter(fontSize: 14.sp,fontWeight: FontWeight.bold,color: ColorsManager.blue)),
                ],
              ),
            ),
          ),
         SizedBox(height: 120.h),
          Card(
            ///color: ColorsManager.white,
           child:Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
               children: [
                 Expanded(child: Text("It's My Birthday!",
                 style: Theme.of(context).textTheme.bodySmall,
                 )),
                 Spacer(),
                 Icon(Icons.favorite_border,color: ColorsManager.blue,size: 24.sp,)
               ],
             ),
           ),

          )
        ],
      ),
      );
  }
}
