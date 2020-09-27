import 'package:flutter/material.dart';
import 'package:flutter_os_wear/database/SurahDAO.dart';
import 'package:flutter_os_wear/functions/endspacer.dart';
import 'package:flutter_os_wear/model/SurahModel.dart';
import 'package:flutter_os_wear/wear.dart';

class SurahChooser extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color.fromRGBO(39, 39, 39, 1),
        body: WatchShape(
          builder: (context, shape) {
            var screenSize = MediaQuery.of(context).size;
            var screenHeight = screenSize.height;
            var screenWidth = screenSize.width;
            var surahs = SurahDB();
            return SingleChildScrollView(
              child: Column(
                children: [
                  EndSpacer(
                    elheight: screenHeight / 5.13,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: screenWidth / 130,
                            color: Color.fromRGBO(117, 117, 117, 1)),
                      ),
                    ),
                  ),
                  FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Surah> suras = snapshot.data;
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: suras.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              splashColor: Color.fromRGBO(0, 0, 0, 0.4),
                              highlightColor: Color.fromRGBO(0, 0, 0, 0.2),
                              onTap: () {
                                Navigator.pop(context, suras[index].key);
                              },
                              child: Container(
                                width: screenWidth,
                                height: screenHeight / 5.13,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: screenWidth / 130,
                                        color:
                                            Color.fromRGBO(117, 117, 117, 1)),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    suras[index].name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'OpenSansMain',
                                      fontSize: screenWidth / 19.5,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                    future: surahs.getAllSurahs(),
                  ),
                  EndSpacer(
                    elheight: screenHeight / 5.13,
                  ),
                ],
              ),
            );
          },
        ),
      );
}
