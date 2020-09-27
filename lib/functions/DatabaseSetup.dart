import 'dart:async';

import 'package:flutter_os_wear/model/ReciterModel.dart';
import 'package:flutter_os_wear/model/SurahModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';

class AppDatabase {
  static final AppDatabase _singleton = AppDatabase._();

  static AppDatabase get instance => _singleton;

  // Completer is used for transforming synchronous code into asynchronous code.
  Completer<Database> _dbOpenCompleter;

  // A private constructor. Allows us to create instances of AppDatabase
  // only from within the AppDatabase class itself.
  AppDatabase._();

  // Database object accessor
  Future<Database> get database async {
    // If completer is null, AppDatabaseClass is newly instantiated, so database is not yet opened
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      // Calling _openDatabase will also complete the completer with database instance
      _openDatabase();
    }
    // If the database is already opened, awaiting the future will happen instantly.
    // Otherwise, awaiting the returned future will take some time - until complete() is called
    // on the Completer in _openDatabase() below.
    return _dbOpenCompleter.future;
  }

  Future _openDatabase() async {
    // Get a platform-specific directory where persistent app data can be stored
    final appDocumentDir = await getApplicationDocumentsDirectory();
    // Path with the form: /platform-specific-directory/demo.db
    final dbPath = join(appDocumentDir.path, 'database.db');
    var database = await databaseFactoryIo.openDatabase(dbPath, version: 1,
        onVersionChanged: (db, oldVersion, newVersion) async {
      // If the db does not exist, create some data
      if (oldVersion == 0) {
        var store = intMapStoreFactory.store('surah');
        Map map = {
          78: "An-Naba",
          79: "An-Nazi'at",
          80: "'Abasa",
          81: "At-Takwir",
          82: "Al-Infitar",
          83: "Al-Mutaffifin",
          84: "Al-Inshiqaq",
          85: "Al-Buruj",
          86: "At-Tariq",
          87: "Al-A'la",
          88: "Al-Ghashiyah",
          89: "Al-Fajr",
          90: "Al-Balad",
          91: "Ash-Shams",
          92: "Al-Layl",
          93: "Ad-Duhaa",
          94: "Ash-Sharh",
          95: "At-Tin",
          96: "Al-`Alaq",
          97: "Al-Qadr",
          98: "Al-Bayyinah",
          99: "Az-Zalzalah",
          100: "Al-'Adiyat",
          101: "Al-Qari'ah",
          102: "At-Takathur",
          103: "Al-'Asr",
          104: "Al-Humazah",
          105: "Al-Fil",
          106: "Quraysh",
          107: "Al-Maun",
          108: "Al-Kawthar",
          109: "Al-Kafirun",
          110: "An-Nasr",
          111: "Al-Masad",
          112: "Al-Ikhlas",
          113: "Al-Falaq",
          114: "An-Nas",
        };
        for (MapEntry e in map.entries) {
          Surah surah = new Surah();
          surah.key = e.key;
          surah.name = e.value;
          await store.record(surah.key).put(db, surah.toJson());
        }
        var store2 = intMapStoreFactory.store('reciters');
        Map sap = {
          1: "Mishary Alafasy",
          2: "Saad Al Ghamdi",
        };
        for (MapEntry e in sap.entries) {
          Reciter imaam = new Reciter();
          imaam.key = e.key;
          imaam.name = e.value;
          await store2.record(imaam.key).put(db, imaam.toJson());
        }
      }
    });

    // Any code awaiting the Completer's future will now start executing
    _dbOpenCompleter.complete(database);
  }
}
