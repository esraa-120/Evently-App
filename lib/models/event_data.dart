import 'package:evently_app/data_source/category_data.dart';

class EventData {

  static final String collectionName = "EventCollection";
  String? eventId;
  String categoryId;
  String categoryImage;
  String title;
  String description;
  bool isFavorite;
  DateTime selectedDateTime;

  EventData({
    this.eventId,
    required this.categoryId,
    required this.categoryImage,
    required this.title,
    required this.description,
    this.isFavorite = false,
    required this.selectedDateTime,
  });

  factory EventData.fromFireStore(Map<String, dynamic> json){
    return EventData(
      eventId: json["eventId"],
      title: json["title"],
      categoryId: json["categoryId"],
      categoryImage:
      json["categoryImage"] as String? ??
          CategoryList.getCategoryById(json["categoryId"]).imagePath,
      description: json["description"],
      isFavorite: json["isFavorite"],
      selectedDateTime: DateTime.fromMillisecondsSinceEpoch(json["selectedDateTime"]),
    );
     }


  Map<String, dynamic> toFireStore() {
    return {
      "eventId": eventId,
      "title": title,
      "description": description,
      "isFavorite": isFavorite,
      "categoryId": categoryId,
      "categoryImage": categoryImage,
      "selectedDateTime": selectedDateTime.millisecondsSinceEpoch,
    };
  }
}