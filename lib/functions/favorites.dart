import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_os_wear/model/FavoriteModel.dart';
import 'package:flutter_os_wear/database/Favorite_DAO.dart';
import 'package:flutter_os_wear/screens/delete_screen.dart';
import 'package:flutter_os_wear/screens/set_screen.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    var favorites = FavoriteDao();
    return FutureBuilder(
      builder: (context, snapshot) {
        var screenSize = MediaQuery.of(context).size;
        var screenHeight = screenSize.height;
        var screenWidth = screenSize.width;
        if (snapshot.hasData) {
          List<Favorite> favs = snapshot.data;
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: favs.length,
            itemBuilder: (context, index) {
              return Container(
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
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: screenWidth / 4.5,
                          height: screenHeight / 10.83,
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                  width: screenWidth / 165,
                                  color: Color.fromRGBO(117, 117, 117, 1)),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          favs[index].name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSansMain',
                            fontSize: screenWidth / 19.5,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          splashColor: Color.fromRGBO(0, 0, 0, 0.4),
                          highlightColor: Color.fromRGBO(0, 0, 0, 0.2),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DeleteScreen(favorite: favs[index])),
                            ).then((value) => setState(() {}));
                          },
                          child: Container(
                            width: screenWidth / 4.5,
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(
                                FeatherIcons.trash,
                                color: Colors.white,
                                size: screenHeight / 16.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          splashColor: Color.fromRGBO(0, 0, 0, 0.4),
                          highlightColor: Color.fromRGBO(0, 0, 0, 0.2),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SetScreen(
                                        data: favs[index].key,
                                      )),
                            ).then((value) => setState(() {}));
                          },
                          child: Container(
                            width: screenWidth - (screenWidth / 4.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
      future: favorites.getAllFavorites(),
    );
  }
}
