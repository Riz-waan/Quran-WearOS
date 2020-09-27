import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_os_wear/database/ReciterDAO.dart';
import 'package:flutter_os_wear/database/SurahDAO.dart';
import 'package:flutter_os_wear/screens/imaam_chooser.dart';
import 'package:flutter_os_wear/screens/loop_or_nah.dart';
import 'package:flutter_os_wear/screens/player.dart';
import 'package:flutter_os_wear/screens/playersup.dart';
import 'package:flutter_os_wear/screens/surah_chooser.dart';
import 'package:flutter_os_wear/screens/test.dart';
import 'package:flutter_os_wear/screens/test3.dart';
import 'package:flutter_os_wear/wear.dart';
import 'package:flutter_os_wear/functions/player.dart';

class SetScreen extends StatefulWidget {
  final int data;

  const SetScreen({Key key, this.data = 11078114}) : super(key: key);

  @override
  _SetState createState() => _SetState();
}

class _SetState extends State<SetScreen> {
  String start = "An-Naba";
  String end = "An-Nas";
  String imaam = "Mishary Alafasy";
  String loop = "Loop";
  int begin;
  String sur1;
  String sur2;
  int finish;
  int recit;
  int straight;
  String data;
  int toplay;
  @override
  void initState() {
    super.initState();
    data = widget.data.toString();
    recit = int.parse(data[0]);
    straight = int.parse(data[1]);
    begin = int.parse(data.substring(2, 5));
    finish = int.parse(data.substring(5));
  }

  var surahs = new SurahDB();
  var imaams = new ReciterDB();

  @override
  Widget build(BuildContext context) {
    surahs.getbyKey(begin).then((surah) {
      setState(() {
        start = surah.name;
      });
    });
    surahs.getbyKey(finish).then((surah) {
      setState(() {
        end = surah.name;
      });
    });
    imaams.getbyKey(recit).then((ima) {
      setState(() {
        imaam = ima.name;
      });
    });
    if (straight == 1) {
      loop = "Loop";
    } else {
      loop = "No Loop";
    }
    sur1 = begin.toString();
    while (sur1.length < 3) {
      sur1 = '0' + sur1;
    }
    sur2 = finish.toString();
    while (sur2.length < 3) {
      sur2 = '0' + sur2;
    }
    data = recit.toString() + straight.toString() + sur1 + sur2;
    toplay = int.parse(data);
    var elemHeightFactor = 8;
    return Scaffold(
      backgroundColor: Color.fromRGBO(39, 39, 39, 1),
      body: WatchShape(builder: (context, shape) {
        var screenSize = MediaQuery.of(context).size;
        var screenHeight = screenSize.height;
        var screenWidth = screenSize.width;
        return Column(
          children: <Widget>[
            SizedBox(height: (screenHeight / 12.5)),
            Text(
              "Set Player",
              style: TextStyle(
                fontFamily: 'OpenSansMain',
                color: Colors.white,
                fontSize: screenWidth / 13,
              ),
            ),
            SizedBox(height: (screenHeight / 25)),
            InkWell(
              splashColor: Color.fromRGBO(0, 0, 0, 0.4),
              highlightColor: Color.fromRGBO(0, 0, 0, 0.2),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SurahChooser()),
                ).then(
                  (value) => setState(() {
                    begin = value;
                  }),
                );
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: screenWidth,
                  height: screenHeight / elemHeightFactor,
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: (screenWidth / 4.48)),
                      Text(
                        start,
                        style: TextStyle(
                          fontFamily: 'OpenSansMain',
                          color: Colors.white,
                          fontSize: screenWidth / 15.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              splashColor: Color.fromRGBO(0, 0, 0, 0.4),
              highlightColor: Color.fromRGBO(0, 0, 0, 0.2),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SurahChooser()),
                ).then(
                  (value) => setState(() {
                    finish = value;
                  }),
                );
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: screenWidth,
                  height: screenHeight / elemHeightFactor,
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: (screenWidth / 4.48)),
                      Text(
                        end,
                        style: TextStyle(
                          fontFamily: 'OpenSansMain',
                          color: Colors.white,
                          fontSize: screenWidth / 15.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              splashColor: Color.fromRGBO(0, 0, 0, 0.4),
              highlightColor: Color.fromRGBO(0, 0, 0, 0.2),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ImaamChooser()),
                ).then(
                  (value) => setState(() {
                    recit = value;
                  }),
                );
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: screenWidth,
                  height: screenHeight / elemHeightFactor,
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: (screenWidth / 4.48)),
                      Text(
                        imaam,
                        style: TextStyle(
                          fontFamily: 'OpenSansMain',
                          color: Colors.white,
                          fontSize: screenWidth / 15.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              splashColor: Color.fromRGBO(0, 0, 0, 0.4),
              highlightColor: Color.fromRGBO(0, 0, 0, 0.2),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoopChooser()),
                ).then(
                  (value) => setState(() {
                    straight = value;
                  }),
                );
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: screenWidth,
                  height: screenHeight / elemHeightFactor,
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: (screenWidth / 4.48)),
                      Text(
                        loop,
                        style: TextStyle(
                          fontFamily: 'OpenSansMain',
                          color: Colors.white,
                          fontSize: screenWidth / 15.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: (screenHeight / 25)),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  InkWell(
                    splashColor: Color.fromRGBO(0, 0, 0, 0.4),
                    highlightColor: Color.fromRGBO(0, 0, 0, 0.2),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: screenWidth / 2,
                      height: screenHeight / 8,
                      child: Align(
                        alignment: Alignment(0.5, 0),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Color.fromRGBO(159, 159, 159, 1),
                            fontSize: screenWidth / 15.6,
                            fontFamily: 'OpenSansMain',
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    splashColor: Color.fromRGBO(0, 0, 0, 0.4),
                    highlightColor: Color.fromRGBO(0, 0, 0, 0.2),
                    onTap: () {
                      nav(context, toplay);
                    },
                    child: Container(
                      width: screenWidth / 2,
                      height: screenHeight / 8,
                      child: Align(
                        alignment: Alignment(-0.3, 0),
                        child: Text(
                          'Play',
                          style: TextStyle(
                            color: Color.fromRGBO(101, 255, 142, 1),
                            fontSize: screenWidth / 13,
                            fontFamily: 'OpenSansMain',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
