import 'package:flutter/material.dart';
import 'package:untitled10/src/app_root.dart';


class CategoriesContainer extends StatelessWidget {
  String? name;
  CategoriesContainer({
    super.key,
    this.name, });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),

        ),
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: greenColor,

            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            name!,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
