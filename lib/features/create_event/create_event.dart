import 'package:firebase_auth/firebase_auth.dart'; // 👇 استيراد المكتبة
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    bool isDark = themeProvider.currentTheme == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.create_event),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // صورة الإيفنت المتغيرة
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
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
                    selectedCategoryIndex = index;
                    setState(() {});
                  },
                ),
                SizedBox(height: 16.h),

                Text(AppLocalizations.of(context)!.title, style: Theme.of(context).textTheme.bodySmall),
                SizedBox(height: 8.h),
                CustomTextFormFeild(
                  controller: titleController,
                  validator: (value) => (value == null || value.isEmpty) ? 'Please enter event title' : null,
                  prefixIcon: Icons.edit_note,
                  hint: AppLocalizations.of(context)!.event_title,
                ),
                SizedBox(height: 16.h),

                Text(AppLocalizations.of(context)!.description, style: Theme.of(context).textTheme.bodySmall),
                SizedBox(height: 8.h),
                CustomTextFormFeild(
                  controller: descriptionController,
                  validator: (value) => (value == null || value.isEmpty) ? 'Please enter event description' : null,
                  hint: AppLocalizations.of(context)!.event_description,
                  maxLines: 5,
                ),
                SizedBox(height: 16.h),

                // التاريخ والوقت
                Row(children: [Icon(Icons.date_range_rounded), SizedBox(width: 8.w), Text(selectedDate.toFormatDate, style: Theme.of(context).textTheme.bodySmall), Spacer(), CustomTextButton(title: AppLocalizations.of(context)!.choose_date, onPressed: chooseEventDate)]),
                Row(children: [Icon(Icons.access_time_outlined), SizedBox(width: 8.w), Text("${selectedTime.hour}:${selectedTime.minute}", style: Theme.of(context).textTheme.bodySmall), Spacer(), CustomTextButton(title: AppLocalizations.of(context)!.choose_time, onPressed: () { showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) { if (value != null) { selectedTime = value; setState(() {}); } }); })]),
                SizedBox(height: 16.h),

                // الموقع
                Row(children: [Icon(Icons.location_on_outlined), SizedBox(width: 8.w), Text(selectedLocation != null ? "Location Selected! ✅" : AppLocalizations.of(context)!.choose_event_location, style: Theme.of(context).textTheme.bodySmall), Spacer(), CustomTextButton(title: AppLocalizations.of(context)!.choose_event_location, onPressed: () async { var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => const PickLocation())); if (result != null) { selectedLocation = result as LatLng; setState(() {}); } })]),
                SizedBox(height: 18),

                // زرار الإضافة
                CustomElevatedButton(
                  title: AppLocalizations.of(context)!.add_event,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      DateTime finalDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, selectedTime.hour, selectedTime.minute);
                      var categories = CategoryModel.getCategories(context);
                      var selectedCategory = categories[selectedCategoryIndex];

                      // 👇 1. بنجيب الـ ID بتاع اليوزر الحالي
                      var userId = FirebaseAuth.instance.currentUser?.uid;

                      var newEvent = EventModel(
                        title: titleController.text,
                        description: descriptionController.text,
                        date: finalDate,
                        category: selectedCategory.id,
                        lat: selectedLocation?.latitude,
                        long: selectedLocation?.longitude,
                        isFavorite: false,
                        // 👇 2. بنسجله هنا (لو مش موجود بنحط نص فاضي تجنباً للخطأ)
                        userId: userId ?? '',
                      );

                      FirebaseUtils.addEventToFireStore(newEvent).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Event added successfully! 🎉')));
                        Navigator.pop(context);
                      }).catchError((error) {
                        print("Error adding event: $error");
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
    selectedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365))) ?? selectedDate;
    setState(() {});
  }

  String _getImagePath(int index, bool isDark) {
    var categories = CategoryModel.getCategories(context);
    // حماية لو الاندكس غلط
    if (index < 0 || index >= categories.length) return isDark ? ImageAssets.birthdayDark : ImageAssets.birthdayLight;

    String categoryId = categories[index].id;
    switch (categoryId) {
      case 'birthday': return isDark ? ImageAssets.birthdayDark : ImageAssets.birthdayLight;
      case 'sport': return isDark ? ImageAssets.sportDark : ImageAssets.sportLight;
      case 'meeting': return isDark ? ImageAssets.meetingDark : ImageAssets.meetingLight;
      case 'gaming': return isDark ? ImageAssets.gamingDark : ImageAssets.gamingLight;
      case 'eating': return isDark ? ImageAssets.eatingDark : ImageAssets.eatingLight;
      case 'holiday': return isDark ? ImageAssets.holidayDark : ImageAssets.holidayLight;
      case 'workshop': return isDark ? ImageAssets.workshopDark : ImageAssets.workshopLight;
      case 'book_club': return isDark ? ImageAssets.bookClubDark : ImageAssets.bookClubLight;
      case 'exhibition': return isDark ? ImageAssets.exhibitionDark : ImageAssets.exhibitionLight;
      default: return isDark ? ImageAssets.birthdayDark : ImageAssets.birthdayLight;
    }
  }
}