import 'package:audio_service/audio_service.dart';

class Singleton {
  static final Singleton _instance = Singleton._internal();

  factory Singleton() => _instance;

  Singleton._internal();

  int _id;
  List<MediaItem> _lib = [
    MediaItem(
      id: 'asset:///assets/audio/quran/1/112.mp3',
      title: "Loading",
      album: "The Noble Quran",
    )
  ];
  bool _loop;

  void setLoop(bool loop) {
    _loop = loop;
  }

  void setId(int id) {
    _id = id;
  }

  bool getLoop() {
    return _loop;
  }

  List<MediaItem> getMedia() {
    return _lib;
  }

  int getId() {
    return _id;
  }
}
