import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty_challenge/core/core.dart';

class HiveBoxes {
  HiveBoxes();

  late final Box<String> favoritesBox;

  Future<void> initBoxes() async {
    favoritesBox = await Hive.openBox<String>(favoritesKey);
  }

  Future<void> clearBoxes() async {
    await favoritesBox.clear();
  }
}
