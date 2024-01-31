import 'package:flutter/material.dart';
import 'package:untitled10/src/app_root.dart';

class CheckBox extends StatefulWidget {
  Function(bool)? onPressed;
   CheckBox({Key? key,this.onPressed}) : super(key: key);

  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return         Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isChecked = !isChecked;
              });
            },
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(

                 color: isChecked ? greenColor :null,

              ),
              child: Checkbox(
                value: isChecked,
                splashRadius: 0.1,

                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                    widget.onPressed!(isChecked);
                  });
                },

                activeColor: Colors.transparent,
                checkColor: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 10,),
          Text('Remember me', style: TextStyle(color: grayColor),),


        ]
    );
  }
}
