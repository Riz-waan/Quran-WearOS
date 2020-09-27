import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_os_wear/wear.dart';

class EndSpacer extends StatelessWidget {
  EndSpacer({@required this.elheight});
  final elheight;

  @override
  Widget build(BuildContext context) {
    return WatchShape(builder: (context, shape) {
      if (shape == Shape.round) {
        var screenSize = MediaQuery.of(context).size;
        return SizedBox(height: (screenSize.height / 2) - ((elheight) / 2));
      } else {
        return SizedBox(height: 0);
      }
    });
  }
}
