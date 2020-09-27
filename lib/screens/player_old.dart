// import 'package:feather_icons_flutter/feather_icons_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_os_wear/database/ReciterDAO.dart';
// import 'package:flutter_os_wear/database/SurahDAO.dart';
// import 'package:flutter_os_wear/functions/player.dart';
// import 'package:flutter_os_wear/wear.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:audio_service/audio_service.dart';
// import 'package:audio_session/audio_session.dart';

// class Player extends StatefulWidget {
//   final int data;

//   const Player({Key key, @required this.data}) : super(key: key);

//   @override
//   _SetState createState() => _SetState();
// }

// class _SetState extends State<Player> {
//   String start = "An-Naba";
//   String end = "An-Nas";
//   String imaam = "Mishary Alafasy";
//   String loop = "Loop";
//   int begin;
//   int finish;
//   int recit;
//   int straight;
//   String data;
//   var surahs = new SurahDB();
//   var imaams = new ReciterDB();
//   var player = new AudioIslam();

//   @override
//   void initState() {
//     super.initState();
//     data = widget.data.toString();
//     recit = int.parse(data[0]);
//     straight = int.parse(data[1]);
//     begin = int.parse(data.substring(2, 5));
//     finish = int.parse(data.substring(5));
//     player.create(widget.data);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // surahs.getbyKey(begin).then((surah) {
//     //   setState(() {
//     //     start = surah.name;
//     //   });
//     // });
//     // surahs.getbyKey(finish).then((surah) {
//     //   setState(() {
//     //     end = surah.name;
//     //   });
//     // });
//     // imaams.getbyKey(recit).then((ima) {
//     //   setState(() {
//     //     imaam = ima.name;
//     //   });
//     // });
//     if (straight == 1) {
//       loop = "Loop";
//     } else {
//       loop = "No Loop";
//     }
//     player.track().listen((event) {
//       if (event == "completed") {
//         Navigator.pop(context);
//       }
//     });
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(39, 39, 39, 1),
//       body: WatchShape(builder: (context, shape) {
//         var screenSize = MediaQuery.of(context).size;
//         var screenHeight = screenSize.height;
//         var screenWidth = screenSize.width;
//         return Stack(
//           children: <Widget>[
//             Align(
//               alignment: Alignment(0, -0.7),
//               child: Text(
//                 "Al-Ghashiyah",
//                 style: TextStyle(
//                   fontFamily: 'OpenSansMain',
//                   color: Colors.white,
//                   fontSize: screenWidth / 13,
//                 ),
//               ),
//             ),
//             SizedBox(height: (screenHeight / 25)),
//             Center(
//               child: Row(
//                 children: [
//                   InkWell(
//                     splashColor: Color.fromRGBO(0, 0, 0, 0.4),
//                     highlightColor: Color.fromRGBO(0, 0, 0, 0.2),
//                     onTap: () {
//                       print("rewind");
//                     },
//                     child: Container(
//                       width: screenWidth / 3,
//                       height: screenHeight / 3.61,
//                       child: Icon(
//                         FeatherIcons.skipBack,
//                         color: Colors.white,
//                         size: screenHeight / 8,
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     splashColor: Color.fromRGBO(0, 0, 0, 0.4),
//                     highlightColor: Color.fromRGBO(0, 0, 0, 0.2),
//                     onTap: () {
//                       print("Play");
//                     },
//                     child: Container(
//                       width: screenWidth / 3,
//                       height: screenHeight / 3.61,
//                       child: Icon(
//                         FeatherIcons.play,
//                         color: Colors.white,
//                         size: screenHeight / 8,
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     splashColor: Color.fromRGBO(0, 0, 0, 0.4),
//                     highlightColor: Color.fromRGBO(0, 0, 0, 0.2),
//                     onTap: () {
//                       print("forward");
//                     },
//                     child: Container(
//                       width: screenWidth / 3,
//                       height: screenHeight / 3.61,
//                       child: Icon(
//                         FeatherIcons.skipForward,
//                         color: Colors.white,
//                         size: screenHeight / 8,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: (screenHeight / 25)),
//             Align(
//               alignment: Alignment(0, 0.7),
//               child: Row(
//                 children: <Widget>[
//                   InkWell(
//                     splashColor: Color.fromRGBO(0, 0, 0, 0.4),
//                     highlightColor: Color.fromRGBO(0, 0, 0, 0.2),
//                     onTap: () {
//                       player.cancel();
//                       Navigator.pop(context);
//                     },
//                     child: Container(
//                       width: screenWidth / 2,
//                       height: screenHeight / 8,
//                       child: Align(
//                         alignment: Alignment(0.5, 0),
//                         child: Text(
//                           'Cancel',
//                           style: TextStyle(
//                             color: Color.fromRGBO(159, 159, 159, 1),
//                             fontSize: screenWidth / 15.6,
//                             fontFamily: 'OpenSansMain',
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     splashColor: Color.fromRGBO(0, 0, 0, 0.4),
//                     highlightColor: Color.fromRGBO(0, 0, 0, 0.2),
//                     onTap: () {
//                       print("Play");
//                     },
//                     child: Container(
//                       width: screenWidth / 2,
//                       height: screenHeight / 8,
//                       child: Align(
//                         alignment: Alignment(-0.3, 0),
//                         child: Text(
//                           'Save',
//                           style: TextStyle(
//                             color: Color.fromRGBO(101, 255, 142, 1),
//                             fontSize: screenWidth / 13,
//                             fontFamily: 'OpenSansMain',
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }
