import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class CategoryModel{
 final String name;
 final IconData icon;
  CategoryModel({required this.name,required this.icon});
  static List<CategoryModel> categoriesWithAll= [
 CategoryModel(name: "All", icon: Icons.all_inclusive),
 CategoryModel(name: "Sports", icon: Icons.sports_football_rounded),
 CategoryModel(name: "Birthday", icon: Icons.cake),
 CategoryModel(name: "Meeting", icon: Icons.work),
 CategoryModel(name: "Gaming", icon: Icons.videogame_asset_sharp),
 CategoryModel(name: "Eating", icon: Icons.local_pizza),
 CategoryModel(name: "Holiday", icon: Icons.holiday_village),
 CategoryModel(name: "Exhibition", icon: Icons.water_drop),
 CategoryModel(name: "Workshop", icon: Icons.laptop_chromebook_rounded),
 CategoryModel(name: "Book Club", icon: Icons.menu_book_sharp),
 ];

 static List<CategoryModel> categories= [
  CategoryModel(name: "Sports", icon: Icons.sports_football_rounded),
  CategoryModel(name: "Birthday", icon: Icons.cake),
  CategoryModel(name: "Meeting", icon: Icons.work),
  CategoryModel(name: "Gaming", icon: Icons.videogame_asset_sharp),
  CategoryModel(name: "Eating", icon: Icons.local_pizza),
  CategoryModel(name: "Holiday", icon: Icons.holiday_village),
  CategoryModel(name: "Exhibition", icon: Icons.water_drop),
  CategoryModel(name: "Workshop", icon: Icons.laptop_chromebook_rounded),
  CategoryModel(name: "Book Club", icon: Icons.menu_book_sharp),
 ];


static List<CategoryModel> getCategoriesWithAll(BuildContext context){

 AppLocalizations appLocalizations= AppLocalizations.of(context)!;
  return [
   CategoryModel(name: appLocalizations.all, icon: Icons.all_inclusive),
   CategoryModel(name: appLocalizations.sports, icon: Icons.sports_football_rounded),
   CategoryModel(name: appLocalizations.birthday, icon: Icons.cake),
   CategoryModel(name: appLocalizations.meeting, icon: Icons.work),
   CategoryModel(name: appLocalizations.gaming, icon: Icons.videogame_asset_sharp),
   CategoryModel(name: appLocalizations.eating, icon: Icons.local_pizza),
   CategoryModel(name: appLocalizations.holiday, icon: Icons.holiday_village),
   CategoryModel(name: appLocalizations.exhibition, icon: Icons.water_drop),
   CategoryModel(name: appLocalizations.workshop, icon: Icons.laptop_chromebook_rounded),
   CategoryModel(name: appLocalizations.book_club, icon: Icons.menu_book_sharp),
  ];
 }
 static List<CategoryModel> getCategories(BuildContext context){

  AppLocalizations appLocalizations= AppLocalizations.of(context)!;
  return [

   CategoryModel(name: appLocalizations.sports, icon: Icons.sports_football_rounded),
   CategoryModel(name: appLocalizations.birthday, icon: Icons.cake),
   CategoryModel(name: appLocalizations.meeting, icon: Icons.work),
   CategoryModel(name: appLocalizations.gaming, icon: Icons.videogame_asset_sharp),
   CategoryModel(name: appLocalizations.eating, icon: Icons.local_pizza),
   CategoryModel(name: appLocalizations.holiday, icon: Icons.holiday_village),
   CategoryModel(name: appLocalizations.exhibition, icon: Icons.water_drop),
   CategoryModel(name: appLocalizations.workshop, icon: Icons.laptop_chromebook_rounded),
   CategoryModel(name: appLocalizations.book_club, icon: Icons.menu_book_sharp),
  ];
 }
}