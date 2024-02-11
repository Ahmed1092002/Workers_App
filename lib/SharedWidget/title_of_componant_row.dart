import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:untitled10/user/views/result_search_widget.dart';

import '../data/company/jop_model.dart';
import '../src/app_root.dart';
import '../utils/navigator.dart';

class TitleOfComponantRow extends StatelessWidget {
  String? title;
  List<JopsModel>? jops;
   TitleOfComponantRow({
    super.key,
    this.title,
     this.jops,
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
            style: Theme.of(context).textTheme.bodyLarge
          ),
        ),
        IconButton(
          onPressed: () {
            navigateToScreen(context, ResultSearchWidget(jops:jops!,title:title ,userType: 'users',));
          },
          icon: Icon(Ionicons.chevron_forward_outline, size: MediaQuery.of(context).size.width * 0.07, color: Colors.black),
          color: Colors.black,
        ),
      ],
    );
  }
}
