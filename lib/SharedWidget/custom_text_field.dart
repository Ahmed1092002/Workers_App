import 'package:flutter/material.dart';
import 'package:untitled10/src/app_root.dart';


class CustomTextField extends StatefulWidget {
  String? hint;
  IconData? icon;
  TextEditingController? controller;



  CustomTextField({Key? key,this.hint ='',this.icon,this.controller}) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool passwordVisible=false;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
          controller: widget.controller,
          showCursor: true,
          enabled: true,

          toolbarOptions: ToolbarOptions(
            copy: true,
            cut: true,
            paste: true,
            selectAll: true,
          ),
          cursorColor: greenColor,






          validator: (value)
          {
            if(value!.isEmpty){
              return 'this field must not be empty';
            }
            if (widget.hint == 'email') {
              if(!value.contains('@')){
                return 'this field must be a valid email';
              }
            }
            return null;
          },


          obscureText: passwordVisible,
          decoration: InputDecoration(

              prefixIcon:Icon(widget.icon,color: greenColor,) ,


              suffixIcon: widget.hint == 'password' ? IconButton(

                icon: Icon(passwordVisible
                    ? Icons.visibility
                    : Icons.visibility_off),
                onPressed: () {
                  setState(
                        () {
                      passwordVisible = !passwordVisible;
                    },
                  );
                },

              ):null,
              prefixIconColor: Colors.black,
              suffixIconColor: Colors.black,
              isCollapsed: true,
              isDense: true,
              contentPadding: EdgeInsets.all(15),


              hintText: widget.hint,
              label: Text(widget.hint!),
              labelStyle: Theme.of(context).textTheme.labelSmall,

              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: greenColor
                  )
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Colors.grey
                  )
              ),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Colors.red
                  )
              ),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Colors.red
                  )
              )
          )
      ),
    );
  }
}