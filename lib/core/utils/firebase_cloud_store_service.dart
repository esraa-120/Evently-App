import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/event_data.dart';

abstract class FirebaseCloudStoreService {

  ///1- Instance from firestore

  static CollectionReference<EventData> _getCollectionRef(){
    return FirebaseFirestore.instance
        .collection(EventData.collectionName)
        .withConverter<EventData>(fromFirestore: (snapshot, options) =>
        EventData.fromFireStore(snapshot.data()!),
        toFirestore: (eventData, options) => eventData.toFireStore(),
    );
  }

  static Future<bool> createNewEvent( EventData eventData) async {
    try {
      var docRef = _getCollectionRef().doc();
      log(docRef.id);
      eventData.eventId = docRef.id;
      await docRef.set(eventData);
      return Future.value(true);
    } catch (error) {
      return Future.value(false);
    }

  }


  static Future<List<EventData>> getEventsData() async {

    final collectionRef = _getCollectionRef();
    final data = await collectionRef.get();

    List<EventData> events = [];

    data.docs.map((data) {
      events.add(data.data());
    }).toList();

    return events;
  }

  static Stream <QuerySnapshot<EventData>> getRealTimeEventsData(String categoryId) {

    final collectionRef = _getCollectionRef().where("categoryId", isEqualTo: categoryId);
    return collectionRef.snapshots();

  }
  static Stream <QuerySnapshot<EventData>> getRealTimeFavoriteEventsData() {
    final collectionRef = _getCollectionRef().where(
        "isFavorite",
        isEqualTo: true
    );
    return collectionRef.snapshots();

  }

  static Future<bool> updateEvent(EventData eventData) async {
    try {
      await _getCollectionRef().doc(eventData.eventId).update(eventData.toFireStore());
      return Future.value(true);
    } catch (error) {
      return Future.value(false);
    }
  }
}





