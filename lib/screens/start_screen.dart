import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_os_wear/functions/favorites.dart';
import 'package:flutter_os_wear/screens/set_screen.dart';
import 'package:flutter_os_wear/wear.dart';
import 'package:flutter_os_wear/functions/endspacer.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(39, 39, 39, 1),
      body: WatchShape(
        builder: (context, shape) {
          var screenSize = MediaQuery.of(context).size;
          var screenHeight = screenSize.height;
          var screenWidth = screenSize.width;

          return Center(
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/quran.jpg',
                      width: screenWidth,
                      height: screenHeight / 2,
                    ),
                    InkWell(
                      splashColor: Color.fromRGBO(0, 0, 0, 0.4),
                      highlightColor: Color.fromRGBO(0, 0, 0, 0.2),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SetScreen()),
                        ).then((value) => setState(() {}));
                      },
                      child: Container(
                        width: screenWidth,
                        height: screenHeight / 5.13,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: screenWidth / 130,
                                color: Color.fromRGBO(117, 117, 117, 1)),
                          ),
                        ),
                        child: Center(
                          child: Stack(
                            children: <Widget>[
                              Align(
                                  alignment: Alignment(0.83, 0),
                                  child: Icon(
                                    FeatherIcons.play,
                                    color: Colors.white,
                                    size: screenHeight / 16.5,
                                  )),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "New Player",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'OpenSansMain',
                                    fontSize: screenWidth / 19.5,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Favorites(),
                    EndSpacer(
                      elheight: screenHeight / 5.13,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
