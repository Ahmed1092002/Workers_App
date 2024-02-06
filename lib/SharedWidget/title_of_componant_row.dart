import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../src/app_root.dart';

class TitleOfComponantRow extends StatelessWidget {
  String? title;
   TitleOfComponantRow({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            title!,
            style: TextStyle(
              fontSize: 20,
              color: greenColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Ionicons.chevron_forward_outline),
          color: Colors.black,
        ),
      ],
    );
  }
}
