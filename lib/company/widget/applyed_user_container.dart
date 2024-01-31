import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:untitled10/data/company/company_model.dart';
import 'package:untitled10/src/app_root.dart';

class ApplyedUserContainer extends StatelessWidget {
  UserModel? userModel;

   ApplyedUserContainer({Key? key, this.userModel}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:  Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: backgroundColor,
            border: Border.all(
              color: greenColor,
              width: 2,
            )
        ),
        child: ListTile(
          leading:CircleAvatar(
            radius: 30,


            backgroundImage: NetworkImage(userModel!.image!),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('email'),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(userModel!.address!),


                ],
              ),

            ],
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                userModel!.name!,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              IconButton(onPressed: (){},
                  icon: Icon(Icons.chat,
                    color: greenColor,))
            ],
          ),
        ),
      ),

    );
  }
}
