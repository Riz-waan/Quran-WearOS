import 'package:sembast/sembast.dart';
import 'package:flutter_os_wear/functions/DatabaseSetup.dart';
import 'package:flutter_os_wear/model/FavoriteModel.dart';

class FavoriteDao {
  static const String folderName = "Favorites";
  final _favoriteFolder = intMapStoreFactory.store(folderName);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insertFavorite(Favorite favorite) async {
    await _favoriteFolder
        .record(favorite.key)
        .put(await _db, favorite.toJson());
  }

  Future delete(Favorite favorite) async {
    await _favoriteFolder.record(favorite.key).delete(await _db);
  }

  Future<List<Favorite>> getAllFavorites() async {
    //final finder = Finder(filter: Filter.byKey(212));
    //print(finder);
    //await _favoriteFolder.delete(await _db, finder: finder);
    final recordSnapshot = await _favoriteFolder.find(await _db);
    return recordSnapshot.map((snapshot) {
      final favorite = Favorite.fromJson(snapshot.value);
      return favorite;
    }).toList();
  }
}
