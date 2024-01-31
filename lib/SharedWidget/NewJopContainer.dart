import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:untitled10/src/app_root.dart';


class NewJopContainer extends StatelessWidget {
  String? name;
  String? location;
  int? salary;
  String? experience;
  String? jopType;
  String? companyName;
  String? companyLogo;
  String? jopField;
  String?imageUrl;

   NewJopContainer({
    super.key,
    this.companyLogo,
    this.companyName,
    this.experience,
    this.jopType,
    this.location,
    this.salary,
    this.jopField,
    this.imageUrl,

    this.name, });


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


            backgroundImage: CachedNetworkImageProvider(companyLogo!),
          ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                companyName != null && companyName != 'null'
                    ? Text('$companyName')
                    : Container(),

                Text('$jopType'),
                Text('$jopField'),
                Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('$location'),
                    Text('$salary'),
                    Text('$experience')
                  ],
                ),

              ],
            ),
          title: Text(
              name!,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
      ),

    );
  }
}
