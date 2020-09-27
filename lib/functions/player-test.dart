import 'package:just_audio/just_audio.dart';

class AudioIslam {
  final player = AudioPlayer();
  final queue = ConcatenatingAudioSource(children: []);

  void create(int data) async {
    String url = 'asset:///assets/audio/quran/1/112.mp3';
    queue.add(AudioSource.uri(Uri.parse(url)));
    url = 'asset:///assets/audio/quran/1/113.mp3';
    queue.add(AudioSource.uri(Uri.parse(url)));
    await player.load(queue);
    player.play();
  }
  // void create(int data) async {
  //   await player.setAsset('assets/audio/quran/1/112.mp3');
  //   player.play();
  // }

  void cancel() async {
    await player.pause();
    await player.dispose();
  }
}
