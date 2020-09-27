import 'package:sembast/sembast.dart';
import 'package:flutter_os_wear/functions/DatabaseSetup.dart';
import 'package:flutter_os_wear/model/SurahModel.dart';

class SurahDB {
  static const String folderName = "surah";
  final _surahFolder = intMapStoreFactory.store(folderName);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future getbyKey(int key) async {
    var item = await _surahFolder.record(key).get(await _db);
    Surah surah = new Surah();
    if (item == null) {
      return null;
    } else {
      surah.key = item['key'];
      surah.name = item['name'];
      return surah;
    }
  }
  // Future delete(Favorite favorite) async {
  //   await _favoriteFolder.record(favorite.key).delete(await _db);
  // }

  Future<List<Surah>> getAllSurahs() async {
    final recordSnapshot = await _surahFolder.find(await _db);
    return recordSnapshot.map((snapshot) {
      final surah = Surah.fromJson(snapshot.value);
      print(surah.name);
      return surah;
    }).toList();
  }
}
