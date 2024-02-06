import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:untitled10/src/app_root.dart';

class ProfileListTile extends StatelessWidget {
  String? title;
  IconData? iconData;
  Function()? onTap;
   ProfileListTile({
    super.key,
    this.title,
    this.iconData,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: greenColor,
            width: 2,
          ),
        ),
        child: ListTile(
          dense: true,

          title: Text(
              title!,
            style: TextStyle(
              color: greenColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: Icon(
            iconData!,
            color: greenColor,
          ),
          trailing: Icon(
            Ionicons.arrow_forward_outline,
            color: greenColor,
          ),
          onTap: onTap
        ),
      ),
    );
  }
}
