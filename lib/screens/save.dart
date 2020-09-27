import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_os_wear/database/ReciterDAO.dart';
import 'package:flutter_os_wear/database/SurahDAO.dart';
import 'package:flutter_os_wear/screens/imaam_chooser.dart';
import 'package:flutter_os_wear/screens/loop_or_nah.dart';
import 'package:flutter_os_wear/screens/player.dart';
import 'package:flutter_os_wear/screens/playersup.dart';
import 'package:flutter_os_wear/screens/surah_chooser.dart';
import 'package:flutter_os_wear/wear.dart';
import 'package:flutter_os_wear/functions/player.dart';

class Save extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(39, 39, 39, 1),
      body: WatchShape(builder: (context, shape) {
        var screenSize = MediaQuery.of(context).size;
        var screenHeight = screenSize.height;
        var screenWidth = screenSize.width;
        return TextField(
          cursorColor: Colors.white,
          autofocus: true,
          maxLength: 11,
          maxLengthEnforced: true,
          onSubmitted: (value) {
            print("submitted");
            print(value);
            Navigator.pop(context, value);
          },
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSansMain',
            fontSize: screenWidth / 19.5,
          ),
          decoration: InputDecoration(
            labelText: "Save As",
            labelStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSansMain',
              fontSize: screenWidth / 25,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: screenWidth / 130,
                color: Color.fromRGBO(117, 117, 117, 1),
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: screenWidth / 130,
                color: Color.fromRGBO(117, 117, 117, 1),
              ),
            ),
            counterStyle: TextStyle(
              fontSize: 0,
            ),
          ),
        );
      }),
    );
  }
}
