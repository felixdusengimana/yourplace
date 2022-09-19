import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yourplace/helpers/db_helper.dart';

import '../models/place_model.dart';

class PlaceProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      image: pickedImage,
      location: null,
    );
    _items.add(newPlace);
    notifyListeners();

    DBHelper.insert(
      'user_places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
      },
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList =
        DBHelper.getData("user_places") as List<Map<String, dynamic>>;
    _items = dataList
        .map((item) => Place(
            id: item["id"],
            title: item["title"],
            location: null,
            image: File(item["image"])))
        .toList();
    notifyListeners();
  }
}
