import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../core/assets_manager/assests_manager.dart';
import '../../core/colors_manager.dart';
import '../../core/extension/date_extension.dart';
import '../../core/firebase_utils.dart';
import '../../core/widgets/custom_elevated_button.dart';
import '../../core/widgets/custom_tab_bar.dart';
import '../../core/widgets/custom_text_button.dart';
import '../../core/widgets/custom_text_form_feild.dart';
import '../../l10n/app_localizations.dart';
import '../../models/category_model.dart';
import '../../models/event_model.dart';
import '../../providers/config_provider.dart';
import 'pick_location.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  LatLng? selectedLocation;

  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    bool isDark = themeProvider.isDark;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.create_event),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: SingleChildScrollView(

            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  ClipRRect(
                    borderRadius: BorderRadius.circular(24.r),
                    child: Image.asset(
                      _getImagePath(selectedCategoryIndex, isDark),
                      height: 200.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16.h),
      

                  CustomTabBar(
                    categories: CategoryModel.getCategories(context),
                    selectedBackgroundColor: ColorsManager.blue,
                    unselectedBackgroundColor: Colors.transparent,
                    selectedForegroundColor: ColorsManager.white,
                    unselectedForegroundColor: ColorsManager.blue,
                    onTabChanged: (index) {
                      setState(() {
                        selectedCategoryIndex = index;
                      });
                    },
                  ),
                  SizedBox(height: 16.h),
      
                  Text(AppLocalizations.of(context)!.title,
                      style: Theme.of(context).textTheme.bodySmall),
                  SizedBox(height: 8.h),
                  CustomTextFormFeild(
                    controller: titleController,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Please enter event title'
                        : null,
                    prefixIcon: Icons.edit_note,
                    hint: AppLocalizations.of(context)!.event_title,
                  ),
                  SizedBox(height: 16.h),
      
                  Text(AppLocalizations.of(context)!.description,
                      style: Theme.of(context).textTheme.bodySmall),
                  SizedBox(height: 8.h),
                  CustomTextFormFeild(
                    controller: descriptionController,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Please enter event description'
                        : null,
                    hint: AppLocalizations.of(context)!.event_description,
                    maxLines: 5,
                  ),
                  SizedBox(height: 16.h),
      
                  // === اختيار التاريخ ===
                  Row(
                    children: [
                      Icon(Icons.date_range_rounded,
                          color: isDark ? Colors.white : Colors.black),
                      SizedBox(width: 8.w),
                      Text(selectedDate.toFormatDate,
                          style: Theme.of(context).textTheme.bodySmall),
                      const Spacer(),
                      CustomTextButton(
                        title: AppLocalizations.of(context)!.choose_date,
                        onPressed: chooseEventDate,
                      )
                    ],
                  ),
                  SizedBox(height: 8.h),
      
                  // === اختيار الوقت ===
                  Row(
                    children: [
                      Icon(Icons.access_time_outlined,
                          color: isDark ? Colors.white : Colors.black),
                      SizedBox(width: 8.w),
                      Text(
                          "${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}",
                          style: Theme.of(context).textTheme.bodySmall),
                      const Spacer(),
                      CustomTextButton(
                        title: AppLocalizations.of(context)!.choose_time,
                        onPressed: () {
                          showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now())
                              .then((value) {
                            if (value != null) {
                              setState(() {
                                selectedTime = value;
                              });
                            }
                          });
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 8.h),
      
                  // === اختيار الموقع (هنا كان الـ Overflow) 🚧 ===
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Row(
                      children: [
                        Icon(Icons.location_on_outlined,
                            color: isDark ? Colors.white : Colors.black),
                        SizedBox(width: 8.w),
      
                        // العنوان الثابت
                        Text(
                          AppLocalizations.of(context)!.choose_event_location,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
      
                        SizedBox(width: 10.w),
      

                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              var result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const PickLocation()));
                              if (result != null) {
                                setState(() {
                                  selectedLocation = result as LatLng;
                                });
                              }
                            },
                            child: Text(
                              selectedLocation != null
                                  ? "Location Selected! ✅"
                                  : AppLocalizations.of(context)!
                                  .choose_event_location,
                              textAlign: TextAlign.end,
                              style: GoogleFonts.inter(
                                color: ColorsManager.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                decoration: TextDecoration.underline,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
      
                  // زرار الإضافة
                  CustomElevatedButton(
                    title: AppLocalizations.of(context)!.add_event,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // دمج التاريخ والوقت
                        DateTime finalDate = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );
      
                        var categories = CategoryModel.getCategories(context);
                        var selectedCategory = categories[selectedCategoryIndex];
                        var userId = FirebaseAuth.instance.currentUser?.uid;
      
                        // إنشاء الموديل
                        var newEvent = EventModel(
                          // مهم جداً: بنعمل generate لـ ID جديد هنا عشان نستخدمه
                          id: FirebaseFirestore.instance.collection('Events').doc().id,
                          title: titleController.text,
                          description: descriptionController.text,
                          date: finalDate,
                          category: selectedCategory.id,
                          lat: selectedLocation?.latitude ?? 0.0,
                          long: selectedLocation?.longitude ?? 0.0,
                          isFavorite: false,
                          userId: userId ?? '',
                        );
      
                        // الرفع للفايربيز
                        FirebaseUtils.addEventToFireStore(newEvent).then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Event added successfully! 🎉')));
                          Navigator.pop(context);
                        }).catchError((error) {
                          print("Error adding event: $error");
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $error')));
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void chooseEventDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  String _getImagePath(int index, bool isDark) {
    var categories = CategoryModel.getCategories(context);
    if (index < 0 || index >= categories.length) {
      return isDark ? ImageAssets.birthdayDark : ImageAssets.birthdayLight;
    }

    String categoryId = categories[index].id;
    // تأكدي إن الصور دي موجودة عندك في AssetsManager
    switch (categoryId) {
      case 'birthday':
        return isDark ? ImageAssets.birthdayDark : ImageAssets.birthdayLight;
      case 'sport':
        return isDark ? ImageAssets.sportDark : ImageAssets.sportLight;
      case 'meeting':
        return isDark ? ImageAssets.meetingDark : ImageAssets.meetingLight;
      case 'gaming':
        return isDark ? ImageAssets.gamingDark : ImageAssets.gamingLight;
      case 'eating':
        return isDark ? ImageAssets.eatingDark : ImageAssets.eatingLight;
      case 'holiday':
        return isDark ? ImageAssets.holidayDark : ImageAssets.holidayLight;
      case 'workshop':
        return isDark ? ImageAssets.workshopDark : ImageAssets.workshopLight;
      case 'book_club':
        return isDark ? ImageAssets.bookClubDark : ImageAssets.bookClubLight;
      case 'exhibition':
        return isDark ? ImageAssets.exhibitionDark : ImageAssets.exhibitionLight;
      default:
        return isDark ? ImageAssets.birthdayDark : ImageAssets.birthdayLight;
    }
  }
}