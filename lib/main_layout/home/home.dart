import 'package:evently_app/core/colors_manager.dart';
import 'package:evently_app/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/custom_tab_bar.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/config_provider.dart';
import '../../providers/lang_provider.dart';
import 'event_items.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    var themeProvider=Provider.of<ThemeProvider>(context);
    var langProvider=Provider.of<LanguageProvider>(context);
    return Column(
      children: [
        Container(
          padding: REdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r),
            )
          ),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                          AppLocalizations.of(context)!.welcome_back,
                            style: Theme.of(context).textTheme.titleSmall,),
                          Text(
                            "Salma Wael",
                            style: Theme.of(context).textTheme.titleMedium,),
                          SizedBox(height: 8.h,),
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined,size: 16.sp,
                              color: ColorsManager.white,
                              ),
                             SizedBox(width: 4.w,),
                              Text(
                                "Cairo, Egypt",
                                style:  Theme.of(context).textTheme.titleSmall,),
                            ],
                          ),
                        ],
                      ),
            
                    ),  Spacer(),
                    InkWell(
                      onTap: () {
                        themeProvider.changeAppTheme(
                            themeProvider.isDark ? ThemeMode.light : ThemeMode.dark
                        );
                      },
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) => ScaleTransition(
                          scale: animation,
                          child: child,
                        ),
                        child: Icon(
                          themeProvider.isDark ? Icons.dark_mode : Icons.light_mode,
                          key: ValueKey<bool>(themeProvider.isDark),
                          size: 32.sp,
                          color: ColorsManager.white,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        langProvider.changeAppLang(langProvider.isEnglish? "ar" : "en");
                      },
                      child: Card(
                        color: Theme.of(context).cardColor,
                         child: Padding(
                            padding: REdgeInsets.all(8.0),
                            child: Text(langProvider.isEnglish? "En" : "Ar",
                              style:
                            Theme.of(context).textTheme.displaySmall,),
                            ),
                          ),
                    ),

                    ],
                ),
                SizedBox(height: 8.h,),
               CustomTabBar(categories: CategoryModel.getCategoriesWithAll(context),
                 selectedBackgroundColor: ColorsManager.lightblue,
                 unselectedBackgroundColor: Colors.transparent,
                 selectedForegroundColor: ColorsManager.blue,
                 unselectedForegroundColor: ColorsManager.lightblue,),


              ],
            ),
          ),
        ),
        Expanded(child: ListView.builder(itemBuilder: (context,index)=>EventItem(),itemCount: 20,))
      ],
    );
  }
}
