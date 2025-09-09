import 'package:evently_app/core/assets_manager/assests_manager.dart';
import 'package:evently_app/core/colors_manager.dart';
import 'package:evently_app/providers/lang_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/config_provider.dart';
typedef OnChange=void Function(String?);
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String selectedTheme= "Light";
  String selectedLanguage= "English";

  @override
  Widget build(BuildContext context) {
    var themeProvider=Provider.of<ThemeProvider>(context);
    var langProvider=Provider.of<LanguageProvider>(context);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: REdgeInsets.all(15.r),
            decoration: BoxDecoration(
              color: ColorsManager.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.r),

              )
            ),
            child: Row(
         children: [
           ClipOval(
             child: Image.asset(ImageAssets.profile,
               width: 100,
               height: 100,
               fit: BoxFit.cover,
             ),
           ),
           Padding(
             padding:  REdgeInsets.all(16.0.r),
             child: Column(
               children: [
                 Text("Salma Wael",style:GoogleFonts.inter(fontSize: 24.sp,fontWeight: FontWeight.bold,color: ColorsManager.white),),
                 SizedBox(height: 8,),
                 Text("salmawael@gmail.com",style:GoogleFonts.inter(fontSize: 16.sp,fontWeight: FontWeight.w500,color: ColorsManager.white))
               ],
             ),
           )
         ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                SizedBox(height: 16.h,),
    buildDropdown(
    selectedItemView: themeProvider.isDark
        ? AppLocalizations.of(context)!.dark
        : AppLocalizations.of(context)!.light,
    labelText: AppLocalizations.of(context)!.theme,
    menueItems: [ AppLocalizations.of(context)!.light,
      AppLocalizations.of(context)!.dark],
    onChange: (newTheme) {
    themeProvider.changeAppTheme(newTheme ==  AppLocalizations.of(context)!.light? ThemeMode.light : ThemeMode.dark);
    },
    ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget buildDropdown({required String labelText,required List <String> menueItems,
  required OnChange? onChange,
    required String selectedItemView,
  }){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(labelText,style: Theme.of(context).textTheme.labelMedium,),
    SizedBox(height: 16.h,),
    SizedBox(
    height: 65.h,
    child: Container(
    padding: REdgeInsets.all(16.r),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(16.r),
    border: Border.all(color: ColorsManager.blue,width:  1.w),
    ),
    child: Row(
    children: [
    Text(
      selectedItemView,
      style: Theme.of(context).textTheme.labelSmall,),
    Spacer(),
    DropdownButton<String>(
      style: Theme.of(context).dropdownMenuTheme.textStyle,
      dropdownColor: Theme.of(context).primaryColor,
    underline: Container(),
    items: menueItems.map((item) {
    return DropdownMenuItem<String>(

    value: item,
    child: Text(item,

    ),
    );
    }).toList(),
    onChanged: onChange,
    ),
    ],
    ),
    ),
    ),
    ],
    );
  }
}
