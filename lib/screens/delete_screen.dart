import 'package:flutter/material.dart';
import 'package:flutter_os_wear/model/FavoriteModel.dart';
import 'package:flutter_os_wear/database/Favorite_DAO.dart';
import 'package:flutter_os_wear/wear.dart';

class DeleteScreen extends StatelessWidget {
  final Favorite favorite;
  DeleteScreen({Key key, @required this.favorite}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color.fromRGBO(39, 39, 39, 1),
        body: WatchShape(builder: (context, shape) {
          var screenSize = MediaQuery.of(context).size;
          var screenHeight = screenSize.height;
          var screenWidth = screenSize.width;
          var favorites = FavoriteDao();
          return Center(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment(0, -0.5),
                  child: Text(
                    'Delete?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth / 13,
                      fontFamily: 'OpenSansMain',
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    favorite.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth / 13,
                      fontFamily: 'OpenSansMain',
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0, 0.5),
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
                          height: screenHeight / 5,
                          child: Center(
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
                          favorites
                              .delete(favorite)
                              .then((value) => {Navigator.pop(context)});
                        },
                        child: Container(
                          width: screenWidth / 2,
                          height: screenHeight / 5,
                          child: Center(
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                color: Color.fromRGBO(255, 101, 101, 1),
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
            ),
          );
        }),
      );
}
