import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_os_wear/database/SurahDAO.dart';
import 'package:flutter_os_wear/functions/single.dart';
import 'package:flutter_os_wear/model/SurahModel.dart';
import 'package:flutter_os_wear/screens/player.dart';
import 'package:just_audio/just_audio.dart';

nav(BuildContext context, int data) async {
  print("Pressed");
  var single = new Singleton();
  bool loop;
  var info = await create(data);
  print(info);
  AudioService.start(
    backgroundTaskEntrypoint: audioPlayerTaskEntrypoint,
    androidNotificationChannelName: 'Al Quran',
    androidNotificationColor: 0xFF2196f3,
    androidNotificationIcon: 'mipmap/ic_launcher',
    androidEnableQueue: true,
  );
  AudioService.pause();
  print("Started");
  loop = single.getLoop();
  AudioService.updateQueue(info);
  if (loop == true) {
    AudioService.setRepeatMode(AudioServiceRepeatMode.all);
  } else {
    AudioService.setRepeatMode(AudioServiceRepeatMode.none);
  }
  print("Looping");
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AudioServiceWidget(
        child: Player(loop, info, data),
      ),
    ),
  );
  Navigator.pop(context);
  print("Finished");
}

Future<List<MediaItem>> create(int data) async {
  int begin;
  String sur;
  int finish;
  String recit;
  int straight;
  String info;
  bool loopover = false;
  String url;
  info = data.toString();
  recit = info[0];
  straight = int.parse(info[1]);
  begin = int.parse(info.substring(2, 5));
  finish = int.parse(info.substring(5));
  var single = new Singleton();
  List<MediaItem> list = [];
  SurahDB db = new SurahDB();
  Surah toparse;
  if (finish < begin) {
    loopover = true;
  }
  while ((begin <= finish && loopover == false) || loopover) {
    sur = begin.toString();
    while (sur.length < 3) {
      sur = '0' + sur;
    }
    url = 'asset:///assets/audio/quran/' + recit + '/' + sur + '.mp3';
    toparse = await db.getbyKey(begin);

    list.add(MediaItem(
      id: url,
      title: toparse.name,
      album: "The Noble Quran",
    ));

    if (begin == 114 && loopover) {
      begin = 78;
      loopover = false;
    } else {
      begin++;
    }
  }

  if (straight == 1) {
    single.setLoop(true);
  } else {
    single.setLoop(false);
  }
  return list;
}
