import 'package:flutter/material.dart';

import '../../../constants/text_font.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Page',style:AppBarTitleText.poppins),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
              child:const Icon(Icons.arrow_back_ios,size: 70,color:Colors.black)),
        ],
      ),
    );
  }
}
