import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
      child: CachedNetworkImage(imageUrl: imageUrl!,
      placeholder: (context, url) => LoadingAnimationWidget.twoRotatingArc(
        color: greenColor,
        size: 100,

      ),
      imageBuilder: (context, imageProvider) => CircleAvatar(
        backgroundImage: imageProvider,
        radius: 50,
      ),
      errorWidget: (context, url, error) => Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: greenColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Ionicons.person_outline,
          color: Colors.white,
          size: 50,
        ),
      ),
      ),
    );
  }
}
