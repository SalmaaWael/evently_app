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

class EditEventPage extends StatefulWidget {
  final EventModel event;

  const EditEventPage({super.key, required this.event});

  @override
  State<EditEventPage> createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  late DateTime selectedDate;
  late TimeOfDay selectedTime;
  late LatLng? selectedLocation;
  int selectedCategoryIndex = 0; // شيلنا late عشان هنديها قيمة ابتدائية

  @override
  void initState() {
    super.initState();
    // ملء البيانات من الإيفنت القديم
    titleController = TextEditingController(text: widget.event.title);
    descriptionController = TextEditingController(text: widget.event.description);
    selectedDate = widget.event.date;
    selectedTime = TimeOfDay.fromDateTime(widget.event.date);

    if (widget.event.lat != null && widget.event.lat != 0.0) {
      selectedLocation = LatLng(widget.event.lat!, widget.event.long!);
    } else {
      selectedLocation = null;
    }


    WidgetsBinding.instance.addPostFrameCallback((_) {
      var categories = CategoryModel.getCategories(context);
      int index = categories.indexWhere((cat) => cat.id == widget.event.category);
      setState(() {
        selectedCategoryIndex = index != -1 ? index : 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    bool isDark = themeProvider.isDark; // تأكدي إن البروفايدر فيه isDark

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Event"),
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
                // صورة الإيفنت
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

                // التابات
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
                  validator: (value) =>
                  (value == null || value.isEmpty) ? 'Required' : null,
                  prefixIcon: Icons.edit_note,
                  hint: AppLocalizations.of(context)!.event_title,
                ),
                SizedBox(height: 16.h),

                Text(AppLocalizations.of(context)!.description,
                    style: Theme.of(context).textTheme.bodySmall),
                SizedBox(height: 8.h),
                CustomTextFormFeild(
                  controller: descriptionController,
                  validator: (value) =>
                  (value == null || value.isEmpty) ? 'Required' : null,
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
                        showTimePicker(context: context, initialTime: selectedTime)
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

                // === (تعديل الـ Overflow)  ===
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          color: isDark ? Colors.white : Colors.black),
                      SizedBox(width: 8.w),
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
                                : "No Location",
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

                SizedBox(height: 18.h),

                // زرار الحفظ
                CustomElevatedButton(
                  title: "Save Changes",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      DateTime finalDate = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedTime.hour,
                          selectedTime.minute);

                      var categories = CategoryModel.getCategories(context);

                      var updatedEvent = EventModel(
                        id: widget.event.id, // نفس الـ ID القديم
                        title: titleController.text,
                        description: descriptionController.text,
                        date: finalDate,
                        category: categories[selectedCategoryIndex].id,
                        lat: selectedLocation?.latitude ?? 0.0,
                        long: selectedLocation?.longitude ?? 0.0,
                        isFavorite: widget.event.isFavorite,
                        userId: widget.event.userId, // نحافظ على الـ User ID
                      );

                      FirebaseUtils.updateEvent(updatedEvent).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Event updated successfully! ✅')));
                        Navigator.pop(context);
                      }).catchError((error) {
                        print("Error updating: $error");
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Error Updating Event')));
                      });
                    }
                  },
                ),
              ],
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
        lastDate: DateTime.now().add(const Duration(days: 365)));

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  String _getImagePath(int index, bool isDark) {
    var categories = CategoryModel.getCategories(context);
    // حماية من الأخطاء لو الاندكس مش مظبوط
    if (index < 0 || index >= categories.length) {
      return isDark ? ImageAssets.birthdayDark : ImageAssets.birthdayLight;
    }

    String categoryId = categories[index].id;
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