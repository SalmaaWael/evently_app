import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/core/colors_manager.dart';
import 'package:flutter/material.dart';

import '../../core/firebase_utils.dart';
import '../../models/event_model.dart';
import '../../core/widgets/custom_text_form_feild.dart';
import '../../l10n/app_localizations.dart';
import '../home/event_items.dart'; // تأكدي إن ده اسم الملف الصح

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  // 👇 1. متغير عشان نمسك الكلام اللي في السيرش
  String searchText = "";
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();

    // 👇 2. بنضيف مستمع (Listener) عشان كل حرف يتكتب يحدث الشاشة
    searchController.addListener(() {
      setState(() {
        searchText = searchController.text;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // 👇 3. ربطنا الكنترولر بحقل الكتابة
            CustomTextFormFeild(
              controller: searchController,
              hint: AppLocalizations.of(context)!.search, // تأكدي إن الكلمة دي موجودة في ملفات اللغة
              prefixIcon: Icons.search,
            ),

            const SizedBox(height: 16),

            Expanded(
              child: StreamBuilder<QuerySnapshot<EventModel>>(
                stream: FirebaseUtils.getFavoriteEvents(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text("Error loading favorites"));
                  }

                  // بنجيب الليستة الأصلية
                  var eventsList = snapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];

                  // 👇 4. اللوجيك المهم: لو في كلام بحث، فلتر الليستة
                  if (searchText.isNotEmpty) {
                    eventsList = eventsList.where((event) {
                      return event.title.toLowerCase().contains(searchText.toLowerCase());
                    }).toList();
                  }

                  // لو الليستة فاضية (سواء مفيش مفضلة أصلاً أو مفيش نتايج بحث)
                  if (eventsList.isEmpty) {
                    return const Center(child: Text("No favorite events found 🤍"));
                  }

                  return ListView.builder(
                    itemCount: eventsList.length,
                    itemBuilder: (context, index) => EventItem(
                      event: eventsList[index],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}