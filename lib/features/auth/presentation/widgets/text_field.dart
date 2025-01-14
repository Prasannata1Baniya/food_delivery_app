
import 'package:flutter/material.dart';

TextField textField(bool obscureText,controller,String hText){
  return TextField(
    obscureText: obscureText,
   controller: controller,

   decoration: InputDecoration(
     hintText: hText,
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