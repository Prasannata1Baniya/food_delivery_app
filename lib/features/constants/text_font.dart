import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class AppBarTitleText{
  static var poppins=GoogleFonts.poppins(
    textStyle:const TextStyle(
      color: Colors.white,
      fontSize: 50,
      fontWeight: FontWeight.bold,
    ),
  );
}
class BoldTextStyle {
  static var poppins=GoogleFonts.poppins(
   textStyle:const TextStyle(
     color: Colors.black,
     fontSize: 50,
   ),
  );
}
class SemiBoldTextStyle {
  static var poppins=GoogleFonts.poppins(
    textStyle:const TextStyle(
      color: Colors.black,
      fontSize: 40,
    ),
  );
}
class LightTextStyle {
  static var poppins=GoogleFonts.poppins(
    textStyle:TextStyle(
      color: Colors.grey.shade400,
      fontSize: 40,
    ),
  );
}