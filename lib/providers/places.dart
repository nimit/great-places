import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';

class Places with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(DateTime.now().toString(), title, image, null);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert({
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData();
    _items = dataList
        .map(
          (item) => Place(
            item['id'],
            item['title'],
            File(item['image']),
            null,
          ),
        )
        .toList();
    notifyListeners();
  }
}
