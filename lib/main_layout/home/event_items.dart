import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/assets_manager/assests_manager.dart';
import '../../core/colors_manager.dart';
import '../../core/extension/date_extension.dart';
import '../../features/create_event/edit_event.dart';
import '../../models/event_model.dart';
import '../../core/firebase_utils.dart';
import '../../providers/config_provider.dart'; // تأكدي من المسار

class EventItem extends StatelessWidget {
  final EventModel event;

  const EventItem({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    bool isDark = themeProvider.isDark; // أو .currentTheme == ThemeMode.dark

    return InkWell(
      onTap: () {
        // الانتقال لصفحة التعديل مع إرسال بيانات الإيفنت
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditEventPage(event: event),
          ),
        );
      },
      child: Container(
        height: 200.h,
        margin: REdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: REdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      
        decoration: BoxDecoration(
          border: Border.all(color: ColorsManager.blue, width: 2.w),
          borderRadius: BorderRadius.circular(16.r),
          image: DecorationImage(
            fit: BoxFit.fill,
            //  هنا الدالة اللي بتختار الصورة بناءً على الـ ID والـ Theme
            image: AssetImage(_getBackgroundImage(event.category, isDark)),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // كارت التاريخ
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      event.date.day.toString(),
                      style: GoogleFonts.inter(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.blue),
                    ),
                    Text(
                      event.date.viewMonthText,
                      style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.blue),
                    ),
                  ],
                ),
              ),
            ),
      
            // كارت العنوان والقلب
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        event.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        FirebaseUtils.updateIsFavorite(event.id, !event.isFavorite);
                      },
                      child: Icon(
                        event.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: ColorsManager.blue,
                        size: 24.sp,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }



  String _getBackgroundImage(String categoryId, bool isDark) {
    switch (categoryId) {
      case 'birthday': // ID
        return isDark ? ImageAssets.birthdayDark : ImageAssets.birthdayLight;

      case 'sport': // ID
        return isDark ? ImageAssets.sportDark : ImageAssets.sportLight;

      case 'meeting': // ID
        return isDark ? ImageAssets.meetingDark : ImageAssets.meetingLight;

      case 'gaming': // ID
        return isDark ? ImageAssets.gamingDark : ImageAssets.gamingLight;

      case 'eating': // ID
        return isDark ? ImageAssets.eatingDark : ImageAssets.eatingLight;

      case 'holiday': // ID
        return isDark ? ImageAssets.holidayDark : ImageAssets.holidayLight;

      case 'workshop': // ID
        return isDark ? ImageAssets.workshopDark : ImageAssets.workshopLight;

      case 'book_club': // ID
        return isDark ? ImageAssets.bookClubDark : ImageAssets.bookClubLight;

      case 'exhibition': // ID
        return isDark ? ImageAssets.exhibitionDark : ImageAssets.exhibitionLight;

      default:
      // لو ملقاش أي حاجة، يرجع صورة العيد ميلاد
        return isDark ? ImageAssets.birthdayDark : ImageAssets.birthdayLight;
    }
  }
}