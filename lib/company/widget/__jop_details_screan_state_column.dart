import 'package:flutter/material.dart';
import '../../src/app_root.dart';


class JopDetailsScreanStateColumn extends StatelessWidget {
  String ?Title;
  String ?Description;
   JopDetailsScreanStateColumn({
    super.key,
    this.Title,
    this.Description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Title!,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(

decoration: BoxDecoration(

  color: Colors.white,
  borderRadius: BorderRadius.circular(10),
  border: Border.all(
    color: greenColor,
    width: 2,
  )

),


            child: Padding(
              padding: const EdgeInsets.all(8.0),


              child: Text(
                '$Description',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
