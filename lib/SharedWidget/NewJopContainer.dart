import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:untitled10/src/app_root.dart';

class NewJopContainer extends StatelessWidget {
  String? name;
  String? location;
  String? salary;
  String? experience;
  String? jopType;
  String? companyName;
  String? companyLogo;
  String? jopField;

  NewJopContainer({
    super.key,
    this.companyLogo,
    this.companyName,
    this.experience,
    this.jopType,
    this.location,
    this.salary,
    this.jopField,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: backgroundColor,
            border: Border.all(
              color: greenColor,
              width: 2,
            )),
        child: ListTile(
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              companyName != null && companyName != 'null'
                  ? Text(
                      '$companyName',
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  : Container(),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 5,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            border: Border.all(color: greenColor)),
                        child: Text('$jopType')),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            border: Border.all(color: greenColor)),
                        child: Text('$jopField')),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            border: Border.all(color: greenColor)),
                        child: Text('$location')),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            border: Border.all(color: greenColor)),
                        child: Text('$salary')),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            border: Border.all(color: greenColor)),
                        child: Text('$experience')),
                  ),
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
