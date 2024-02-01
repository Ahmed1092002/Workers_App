import 'package:flutter/material.dart';
import 'package:untitled10/data/company/company_model.dart';
import 'package:untitled10/src/app_root.dart';

class CircleAvatarImage extends StatelessWidget {
  String? imageUrl;
   CircleAvatarImage({
    super.key,
    required this.imageUrl,
  });



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: greenColor,
          width: 2,
        ),
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: 45,
        backgroundImage: NetworkImage(imageUrl!),
      ),
    );
  }
}
