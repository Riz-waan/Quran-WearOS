import 'package:flutter_os_wear/model/ReciterModel.dart';
import 'package:sembast/sembast.dart';
import 'package:flutter_os_wear/functions/DatabaseSetup.dart';

class ReciterDB {
  static const String folderName = "reciters";
  final _reciterFolder = intMapStoreFactory.store(folderName);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future getbyKey(int key) async {
    var item = await _reciterFolder.record(key).get(await _db);
    Reciter imaam = new Reciter();
    if (item == null) {
      return null;
    } else {
      imaam.key = item['key'];
      imaam.name = item['name'];
      return imaam;
    }
  }
  // Future delete(Favorite favorite) async {
  //   await _favoriteFolder.record(favorite.key).delete(await _db);
  // }

  Future<List<Reciter>> getAllReciters() async {
    final recordSnapshot = await _reciterFolder.find(await _db);
    return recordSnapshot.map((snapshot) {
      final imaam = Reciter.fromJson(snapshot.value);
      return imaam;
    }).toList();
  }
}
