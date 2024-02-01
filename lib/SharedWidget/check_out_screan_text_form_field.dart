import 'package:flutter/material.dart';

import '../src/app_root.dart';

class CheckOutScreanTextFormField extends StatelessWidget {
  TextEditingController? controller = TextEditingController();
  String? hint;
  IconData? icon;


   CheckOutScreanTextFormField({
    super.key,
    this.controller,
    this.hint,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: TextFormField(
        controller: controller,
maxLines: hint=='Job Description'? 5:1,
        style: TextStyle(
          color: greenColor,
        ),
        scribbleEnabled: true,
        keyboardType: hint == 'Job Salary' ? TextInputType.number : TextInputType.text,


        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),

          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: greenColor,
            ),
          ),
          isDense: true,




          prefixIcon: Icon(icon),
          prefixIconColor: greenColor,
          label: Text(hint!),
          labelStyle: TextStyle(
            color: greenColor,
          ),

        ),
      ),
    );
  }
}
