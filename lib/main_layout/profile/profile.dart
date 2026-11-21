import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/assets_manager/assests_manager.dart';
import '../../core/colors_manager.dart';
import '../../core/routes_manager/routes_manager.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/config_provider.dart';
import '../../providers/lang_provider.dart';

typedef OnChange = void Function(String?);

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // دالة لتحديد صورة الحرف بناءً على الاسم
  String _getProfileImage(String? userName) {
    if (userName == null || userName.isEmpty) {
      return ImageAssets.profile;
    }
    String firstLetter = userName[0].toUpperCase();
    return "assets/images/$firstLetter.png";
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var langProvider = Provider.of<LanguageProvider>(context);

    var user = FirebaseAuth.instance.currentUser;
    String displayName = user?.displayName ?? "User";
    String email = user?.email ?? "No Email";

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
                  bottomLeft: Radius.circular(60.r),
                )),
            child: Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    _getProfileImage(displayName),
                    width: 120.w,
                    height: 120.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(ImageAssets.profile,
                          width: 120.w, height: 120.h, fit: BoxFit.cover);
                    },
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        displayName,
                        style: GoogleFonts.inter(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        email,
                        style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: ColorsManager.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          // === Settings & Logout ===
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),

                    // Language
                    Text(AppLocalizations.of(context)!.language,
                        style: Theme.of(context).textTheme.labelMedium),
                    SizedBox(height: 16.h),
                    buildDropdown(
                      context: context,
                      selectedItemView: langProvider.isEnglish ? "English" : "عربي",
                      menueItems: ["English", "عربي"],
                      onChange: (newLanguage) {
                        langProvider
                            .changeAppLang(newLanguage == "English" ? "en" : "ar");
                      },
                    ),

                    SizedBox(height: 20.h),

                    // Theme
                    Text(AppLocalizations.of(context)!.theme,
                        style: Theme.of(context).textTheme.labelMedium),
                    SizedBox(height: 16.h),
                    buildDropdown(
                      context: context,
                      selectedItemView: themeProvider.isDark
                          ? AppLocalizations.of(context)!.dark
                          : AppLocalizations.of(context)!.light,
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

                    SizedBox(height: 250.h),

                    // رجعنا الزرار القديم زي ما كان بالظبط
                    ElevatedButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushNamedAndRemoveUntil(
                            context, RoutesManager.login, (route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.red,
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 16.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r), // كان 16
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start, // كان Start
                        children: [
                          Icon(Icons.logout, color: ColorsManager.white),
                          SizedBox(width: 8.w),
                          Text(
                            AppLocalizations.of(context)!.logout,
                            style: GoogleFonts.inter(
                              fontSize: 20.sp, // ورجعنا الخط كبير 20
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
          ),
        ],
      ),
    );
  }

  Widget buildDropdown({
    required BuildContext context,
    required String selectedItemView,
    required List<String> menueItems,
    required OnChange? onChange,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorsManager.blue, width: 2.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            selectedItemView,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              icon: Icon(Icons.arrow_drop_down, color: ColorsManager.blue),
              dropdownColor: Theme.of(context).primaryColor,
              style: Theme.of(context).dropdownMenuTheme.textStyle,
              items: menueItems.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: onChange,
            ),
          ),
        ],
      ),
    );
  }
}