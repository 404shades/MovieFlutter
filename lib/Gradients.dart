import 'package:flutter/material.dart';


var bluePinkGradient = new LinearGradient(
  colors: [const Color(0xFFCC0099),const Color(0xFF6600FF)],
  tileMode: TileMode.clamp,
  begin: Alignment.topLeft,
  end:Alignment.bottomRight,
  stops: [0.0,1.0]
);

var blueGreenGradient = new LinearGradient(
  colors: [const Color(0xFF0099CC),const Color(0xFF99FF66)],
  tileMode: TileMode.clamp,
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: [0.0,1.0],

);
var yellowOrangeGradient = new LinearGradient(
  colors: [const Color(0xFFFFFF00),const Color(0xFFFF6600)],
  tileMode: TileMode.clamp,
  begin: Alignment.topLeft,
  end:Alignment.bottomRight,
  stops: [0.0,1.0],
);
var pinkRedGradient = new LinearGradient(
  colors: [const Color(0xFFFF3399),const Color(0xFFFF0000)],
  tileMode: TileMode.clamp,
  begin: Alignment.topLeft,
  end:Alignment.bottomRight,
  stops:[0.0,1.0]
);

var blackBlueGradient = new LinearGradient(
  colors: [Colors.blueGrey.shade800,Colors.black87],
  tileMode: TileMode.clamp,
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: [0.0,1.0]
);