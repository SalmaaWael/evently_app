import 'package:evently_app/core/assets_manager/assests_manager.dart';
import 'package:evently_app/core/colors_manager.dart';
import 'package:evently_app/providers/lang_provider.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 1. استيراد المكتبة
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/routes_manager/routes_manager.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/config_provider.dart';

typedef OnChange = void Function(String?);

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  // دالة تحديد صورة الحرف
  String _getProfileImage(String? userName) {
    if (userName == null || userName.isEmpty) {
      return ImageAssets.profile;
    }
    String firstLetter = userName[0].toUpperCase();
    // تأكدي إن الصور موجودة في المسار ده
    return "assets/images/$firstLetter.png";
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var langProvider = Provider.of<LanguageProvider>(context);

    // 👇 2. هنا بنجيب بيانات المستخدم اللي فاتح دلوقتي
    var user = FirebaseAuth.instance.currentUser;
    String displayName = user?.displayName ?? "User"; // الاسم
    String email = user?.email ?? "No Email";         // الإيميل

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // === Header ===
          Container(
            padding: REdgeInsets.all(15.r),
            decoration: BoxDecoration(
                color: ColorsManager.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.r),
                )),
            child: Row(
              children: [
                // صورة البروفايل (حرف الاسم)
                ClipOval(
                  child: Image.asset(
                    _getProfileImage(displayName), // 👇 بتاخد الاسم الحقيقي
                    width: 100.w,
                    height: 100.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // لو صورة الحرف مش موجودة، يعرض الصورة الافتراضية
                      return Image.asset(ImageAssets.profile, width: 100, height: 100, fit: BoxFit.cover);
                    },
                  ),
                ),
                Padding(
                  padding: REdgeInsets.all(16.0.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 👇 3. عرض الاسم الحقيقي
                      SizedBox(
                        width: 180.w, // عرض محدد عشان الاسم الطويل ينزل سطر
                        child: Text(
                          displayName,
                          style: GoogleFonts.inter(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 8.h),

                      // 👇 4. عرض الإيميل الحقيقي
                      SizedBox(
                        width: 180.w,
                        child: Text(
                          email,
                          style: GoogleFonts.inter(
                              fontSize: 14.sp, // صغرت الخط شوية عشان الايميلات الطويلة
                              fontWeight: FontWeight.w500,
                              color: ColorsManager.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          // === Settings & Logout ===
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  buildDropdown(
                    selectedItemView: langProvider.isEnglish ? "English" : "عربي",
                    labelText: AppLocalizations.of(context)!.language,
                    menueItems: ["English", "عربي"],
                    onChange: (newLanguage) {
                      langProvider.changeAppLang(newLanguage == "English" ? "en" : "ar");
                    },
                  ),
                  SizedBox(height: 16.h),
                  buildDropdown(
                    selectedItemView: themeProvider.isDark
                        ? AppLocalizations.of(context)!.dark
                        : AppLocalizations.of(context)!.light,
                    labelText: AppLocalizations.of(context)!.theme,
                    menueItems: [
                      AppLocalizations.of(context)!.light,
                      AppLocalizations.of(context)!.dark
                    ],
                    onChange: (newTheme) {
                      themeProvider.changeAppTheme(
                          newTheme == AppLocalizations.of(context)!.light
                              ? ThemeMode.light
                              : ThemeMode.dark);
                    },
                  ),

                  const Spacer(),

                  // زرار الخروج
                  ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushNamedAndRemoveUntil(
                          context, RoutesManager.login, (route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.red,
                      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.logout, color: ColorsManager.white),
                        SizedBox(width: 8.w),
                        Text(
                          AppLocalizations.of(context)!.logout,
                          style: GoogleFonts.inter(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            color: ColorsManager.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropdown({
    required String labelText,
    required List<String> menueItems,
    required OnChange? onChange,
    required String selectedItemView,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: Theme.of(context).textTheme.labelMedium),
        SizedBox(height: 16.h),
        Container(
          height: 56.h,
          padding: REdgeInsets.symmetric(horizontal: 16.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: ColorsManager.blue, width: 1.w),
          ),
          child: Row(
            children: [
              Text(selectedItemView, style: Theme.of(context).textTheme.labelSmall),
              const Spacer(),
              DropdownButton<String>(
                style: Theme.of(context).dropdownMenuTheme.textStyle,
                dropdownColor: Theme.of(context).primaryColor,
                underline: Container(),
                icon: Icon(Icons.arrow_drop_down, color: ColorsManager.blue),
                items: menueItems.map((item) {
                  return DropdownMenuItem<String>(value: item, child: Text(item));
                }).toList(),
                onChanged: onChange,
              ),
            ],
          ),
        ),
      ],
    );
  }
}