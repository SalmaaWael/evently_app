import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/colors_manager.dart';
import '../../core/firebase_utils.dart';
import '../../l10n/app_localizations.dart';
import '../../models/category_model.dart';
import '../../models/event_model.dart';
import '../../providers/config_provider.dart';
import '../../providers/lang_provider.dart';
import 'event_items.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedCategoryIndex = 0; // 0 معناها All

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var langProvider = Provider.of<LanguageProvider>(context);

    var user = FirebaseAuth.instance.currentUser;
    String displayName = user?.displayName ?? "User";
    String firstName = displayName.split(" ")[0];

    var categories = CategoryModel.getCategories(context);

    return SafeArea(
      child: Column(
        children: [
          // === Header ===
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: ColorsManager.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24.r),
                bottomRight: Radius.circular(24.r),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.welcome_back,
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          firstName,
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        themeProvider.changeAppTheme(themeProvider.isDark
                            ? ThemeMode.light
                            : ThemeMode.dark);
                      },
                      child: Icon(
                        themeProvider.isDark ? Icons.dark_mode : Icons.light_mode,
                        size: 28.sp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    InkWell(
                      onTap: () {
                        langProvider.changeAppLang(
                            langProvider.isEnglish ? "ar" : "en");
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          langProvider.isEnglish ? "En" : "Ar",
                          style: GoogleFonts.inter(
                              color: ColorsManager.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, color: Colors.white, size: 20.sp),
                    SizedBox(width: 4.w),
                    Text(
                      "Cairo, Egypt",
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),

                // === التابات (All + باقي الأقسام) ===
                DefaultTabController(
                    length: categories.length + 1, //  زودنا 1 عشان زرار All
                    child: TabBar(
                      onTap: (index) {
                        setState(() {
                          selectedCategoryIndex = index;
                        });
                      },
                      isScrollable: true,
                      indicatorColor: Colors.transparent,
                      dividerColor: Colors.transparent,
                      tabAlignment: TabAlignment.start,
                      labelPadding: EdgeInsets.symmetric(horizontal: 6.w),
                      tabs: [
                        //  التاب الأول: All
                        Tab(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: selectedCategoryIndex == 0 ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(color: Colors.white, width: 1),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.all_inclusive, // ♾️ أيقونة All
                                    color: selectedCategoryIndex == 0 ? ColorsManager.blue : Colors.white),
                                SizedBox(width: 8.w),
                            Text(
                              AppLocalizations.of(context)!.all,
                              style: GoogleFonts.inter(
                                  color: selectedCategoryIndex == 0 ? ColorsManager.blue : Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500
                              ),)
                              ],
                            ),
                          ),
                        ),
                        //  باقي التابات من الليستة
                        ...categories.map((category) {
                          // لازم نحسب الـ index الحقيقي (لأننا ضفنا واحد في الأول)
                          int categoryIndex = categories.indexOf(category) + 1;
                          bool isSelected = categoryIndex == selectedCategoryIndex;

                          return Tab(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.white : Colors.transparent,
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(color: Colors.white, width: 1),
                              ),
                              child: Row(
                                children: [
                                  Icon(category.icon,
                                      color: isSelected ? ColorsManager.blue : Colors.white),
                                  SizedBox(width: 8.w),
                                  Text(
                                    category.name,
                                    style: GoogleFonts.inter(
                                        color: isSelected ? ColorsManager.blue : Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }).toList() // شيلنا toList القديمة عشان ال spread operator (...) يشتغل
                      ],
                    )),
                SizedBox(height: 10.h),
              ],
            ),
          ),

          // === قائمة الإيفنتات ===
          Expanded(
            child: StreamBuilder<QuerySnapshot<EventModel>>(
              stream: FirebaseUtils.getEvents(
                //  لو مختارين 0 ابعت 'all'، غير كدة ابعت الـ id من الليستة (بعد طرح 1)
                  selectedCategoryIndex == 0
                      ? 'all'
                      : categories[selectedCategoryIndex - 1].id
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text("Something went wrong"));
                }

                var events = snapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];

                if (events.isEmpty) {
                  return const Center(child: Text("No Events Here 📅"));
                }

                return ListView.builder(
                  padding: EdgeInsets.all(16.r),
                  itemCount: events.length,
                  itemBuilder: (context, index) {

                    return Dismissible(
                      // لازم مفتاح مميز عشان فلاتر يعرف هو بيمسح مين بالظبط
                      key: Key(events[index].id),

                      // اتجاه السحب (من الشمال لليمين أو العكس)
                      direction: DismissDirection.startToEnd,

                      // شكل الخلفية لما تسحبي (لون أحمر وسلة مهملات)
                      background: Container(
                        margin: EdgeInsets.symmetric(vertical: 8.h), // عشان يبقى قد الكارت
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        alignment: Alignment.centerLeft, // الأيقونة تظهر على الشمال
                        padding: EdgeInsets.only(left: 20.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.delete, color: Colors.white, size: 30.sp),
                            Text(
                              "Delete",
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),

                      //  هنا اللوجيك اللي بيمسح من الفايربيز فعلياً
                        onDismissed: (direction) {
                          print("Deleting ID: ${events[index].id}");
                          // 1. ناخد نسخة من الايفنت عشان لو حبينا نرجعه
                          var deletedEvent = events[index];

                          // 2. نمسحه من الفايربيز
                          FirebaseUtils.getEventCollection()
                              .doc(deletedEvent.id)
                              .delete();

                          // 3. نظهر رسالة فيها زرار التراجع
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Event deleted successfully"),
                              behavior: SnackBarBehavior.floating, // عشان تبقى عايمة وشكلها شيك
                              action: SnackBarAction(
                                label: 'Undo',
                                textColor: Colors.yellow, // لون مميز للزرار
                                onPressed: () {
                                  // 4. لو داس Undo، نرجع الايفنت تاني بنفس الـ ID
                                  FirebaseFirestore.instance
                                      .collection('Events')
                                      .doc(deletedEvent.id) // بنستخدم نفس الـ ID القديم
                                      .set(deletedEvent.toJson()); // بنرفع الداتا تاني
                                },
                              ),
                            ),
                          );
                        },

                      // ده العنصر الأصلي بتاعنا
                      child: EventItem(event: events[index]),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}