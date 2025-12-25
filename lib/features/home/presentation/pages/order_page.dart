import 'package:flutter/material.dart';

import '../../../constants/text_font.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Page",style:AppBarTitleText.poppins),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(),
    );
  }
}
