
import 'package:flutter/material.dart';

TextField textField(bool obscureText,controller){
  return TextField(
    obscureText: obscureText,
   controller: controller,
   decoration: InputDecoration(
     enabledBorder: OutlineInputBorder(
       borderSide:const  BorderSide(
         color: Colors.black,
       ),
       borderRadius: BorderRadius.circular(12),
     ),

     focusedBorder: OutlineInputBorder(
       borderSide:const  BorderSide(
         color: Colors.black,
       ),
       borderRadius: BorderRadius.circular(12),
     ),
   ),
  );
}