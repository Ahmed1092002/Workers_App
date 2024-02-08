import 'dart:io';

import 'package:flutter/material.dart';
import 'package:untitled10/src/app_root.dart';

class ImageScrean extends StatelessWidget {
  String image;

   ImageScrean({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: greenColor,
        )
      ),
      body: Container(
        color: Colors.black,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Image.network(image),
      )
    );
  }
}
