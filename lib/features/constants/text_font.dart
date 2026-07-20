import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarTitleText{
  static var poppins=GoogleFonts.poppins(
    textStyle:const TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  );
}
class BoldTextStyle {
  static var poppins=GoogleFonts.poppins(
   textStyle:const TextStyle(
     color: Colors.black,
     fontSize: 22,
   ),
  );
}
class SemiBoldTextStyle {
  static var poppins=GoogleFonts.poppins(
    textStyle:const TextStyle(
      color: Colors.black,
      fontSize: 25,
    ),
  );
}
class LightTextStyle {
  static var poppins=GoogleFonts.poppins(
    textStyle:TextStyle(
      color: Colors.grey.shade400,
      fontSize: 25,
    ),
  );
}