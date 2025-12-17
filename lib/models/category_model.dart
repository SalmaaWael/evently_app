import 'package:flutter/material.dart';
import '../core/assets_manager/assests_manager.dart';
import '../l10n/app_localizations.dart';

class CategoryModel {
 String id;    // ⚠️ تأكدي إن ده موجود
 String name;
 String image; // ⚠️ وده كمان
 IconData icon;

 CategoryModel({
  required this.id,
  required this.name,
  required this.image,
  required this.icon,
 });

 // 1. القائمة الثابتة (Ids لازم تكون حروف صغيرة)
 static List<CategoryModel> categories = [
  CategoryModel(
      id: 'sport',
      name: "Sports",
      image: ImageAssets.sportLight,
      icon: Icons.sports_football_rounded),
  CategoryModel(
      id: 'birthday',
      name: "Birthday",
      image: ImageAssets.birthdayLight,
      icon: Icons.cake),
  CategoryModel(
      id: 'meeting',
      name: "Meeting",
      image: ImageAssets.meetingLight,
      icon: Icons.work),
  CategoryModel(
      id: 'gaming',
      name: "Gaming",
      image: ImageAssets.gamingLight,
      icon: Icons.videogame_asset_sharp),
  CategoryModel(
      id: 'eating',
      name: "Eating",
      image: ImageAssets.eatingLight,
      icon: Icons.local_pizza),
  CategoryModel(
      id: 'holiday',
      name: "Holiday",
      image: ImageAssets.holidayLight,
      icon: Icons.holiday_village),
  CategoryModel(
      id: 'exhibition',
      name: "Exhibition",
      image: ImageAssets.exhibitionLight,
      icon: Icons.water_drop),
  CategoryModel(
      id: 'workshop',
      name: "Workshop",
      image: ImageAssets.workshopLight,
      icon: Icons.laptop_chromebook_rounded),
  CategoryModel(
      id: 'book_club',
      name: "Book Club",
      image: ImageAssets.bookClubLight,
      icon: Icons.menu_book_sharp),
 ];

 // 2. دالة جلب الأقسام مترجمة
 static List<CategoryModel> getCategories(BuildContext context) {
  var appLocalizations = AppLocalizations.of(context)!;

  return [
   CategoryModel(
       id: 'sport',
       name: appLocalizations.sports,
       image: ImageAssets.sportLight,
       icon: Icons.sports_football_rounded),
   CategoryModel(
       id: 'birthday',
       name: appLocalizations.birthday,
       image: ImageAssets.birthdayLight,
       icon: Icons.cake),
   CategoryModel(
       id: 'meeting',
       name: appLocalizations.meeting,
       image: ImageAssets.meetingLight,
       icon: Icons.work),
   CategoryModel(
       id: 'gaming',
       name: appLocalizations.gaming,
       image: ImageAssets.gamingLight,
       icon: Icons.videogame_asset_sharp),
   CategoryModel(
       id: 'eating',
       name: appLocalizations.eating,
       image: ImageAssets.eatingLight,
       icon: Icons.local_pizza),
   CategoryModel(
       id: 'holiday',
       name: appLocalizations.holiday,
       image: ImageAssets.holidayLight,
       icon: Icons.holiday_village),
   CategoryModel(
       id: 'exhibition',
       name: appLocalizations.exhibition,
       image: ImageAssets.exhibitionLight,
       icon: Icons.water_drop),
   CategoryModel(
       id: 'workshop',
       name: appLocalizations.workshop,
       image: ImageAssets.workshopLight,
       icon: Icons.laptop_chromebook_rounded),
   CategoryModel(
       id: 'book_club',
       name: appLocalizations.book_club,
       image: ImageAssets.bookClubLight,
       icon: Icons.menu_book_sharp),
  ];
 }

 // 3. دالة جلب الأقسام مع All
 static List<CategoryModel> getCategoriesWithAll(BuildContext context) {
  var appLocalizations = AppLocalizations.of(context)!;

  return [
   CategoryModel(
       id: 'all',
       name: appLocalizations.all,
       image: '',
       icon: Icons.all_inclusive),
   ...getCategories(context),
  ];
 }
}