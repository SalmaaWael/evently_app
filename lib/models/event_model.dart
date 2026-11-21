import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String id;
  String title;
  String description;
  DateTime date;
  String category;
  double? lat;
  double? long;
  bool isFavorite;
  String userId; //  دي الخانة الجديدة اللي ضفناها

  EventModel({
    this.id = '',
    required this.title,
    required this.description,
    required this.date,
    required this.category,
    this.lat,
    this.long,
    this.isFavorite = false,
    required this.userId, // وبقت مطلوبة هنا
  });

  // تحويل من JSON لـ Object
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: (json['date'] as Timestamp).toDate(),
      category: json['category'],
      lat: json['lat'],
      long: json['long'],
      isFavorite: json['isFavorite'],
      userId: json['userId'] ?? '', //  بنقرأها هنا
    );
  }

  // تحويل من Object لـ JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": Timestamp.fromDate(date),
      "category": category,
      "lat": lat,
      "long": long,
      "isFavorite": isFavorite,
      "userId": userId, //  وبنحفظها هنا
    };
  }
}