import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // ⚠️ لازم نعمل import للـ Auth
import '../models/event_model.dart';

class FirebaseUtils {

  static CollectionReference<EventModel> getEventCollection() {
    return FirebaseFirestore.instance.collection('events').withConverter<EventModel>(
      fromFirestore: (snapshot, options) => EventModel.fromJson(snapshot.data()!),
      toFirestore: (event, options) => event.toJson(),
    );
  }

  // إضافة إيفنت
  static Future<void> addEventToFireStore(EventModel event) {
    var collection = getEventCollection();
    var docRef = collection.doc();
    event.id = docRef.id;
    return docRef.set(event);
  }

  // مسح إيفنت
  static Future<void> deleteEvent(String eventId) {
    return getEventCollection().doc(eventId).delete();
  }

  // تحديث إيفنت كامل
  static Future<void> updateEvent(EventModel event) {
    return getEventCollection().doc(event.id).update(event.toJson());
  }


  static Future<void> updateIsFavorite(String eventId, bool isFavorite) {
    return getEventCollection().doc(eventId).update({"isFavorite": isFavorite});
  }



  // جلب الإيفنتات (الخاصة بالمستخدم فقط)
  static Stream<QuerySnapshot<EventModel>> getEvents(String categoryId) {
    var collection = getEventCollection();
    var userId = FirebaseAuth.instance.currentUser?.uid ?? ""; // بنجيب الـ ID الحالي

    if (categoryId == 'all') {
      return collection
          .where('userId', isEqualTo: userId) // 1. هات حاجتي أنا بس
          .orderBy('date')
          .snapshots();
    } else {
      return collection
          .where('userId', isEqualTo: userId) // 1. هات حاجتي أنا بس
          .where('category', isEqualTo: categoryId) // 2. وهات القسم ده بس
          .orderBy('date')
          .snapshots();
    }
  }

  // جلب المفضلة (الخاصة بالمستخدم فقط)
  static Stream<QuerySnapshot<EventModel>> getFavoriteEvents() {
    var collection = getEventCollection();
    var userId = FirebaseAuth.instance.currentUser?.uid ?? "";

    return collection
        .where('userId', isEqualTo: userId) // 1. هات حاجتي أنا بس
        .where('isFavorite', isEqualTo: true) // 2. وهات المفضل
        .orderBy('date')
        .snapshots();
  }
}