// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:untitled10/src/app_root.dart';
//
// class ResultContainer extends StatelessWidget {
//   String? title;
//   String? companyName;
//   String? location;
//   String? Country;
//   String? salary;
//   String? experience;
//   String? level;
//   String? jobType;
//   String? companyLogo;
//   String? jobShift;
//
//    ResultContainer({Key? key, this.title, this.companyName, this.location, this.Country, this.salary, this.experience, this.level, this.jobType, this.companyLogo, this.jobShift}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 270,
//       height: 200,
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//           width: 2,
//           color: greenColor,
//           // Added null as the last argument
//         ),
//
//       ),
//
//       child: Column(
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   width: 70,
//                   height: 70,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//
//                   ),
//                   child: CachedNetworkImage(
//                     imageUrl: "${companyLogo}",
//                     imageBuilder: (context, imageProvider) => Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         image: DecorationImage(
//                           image: imageProvider,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     placeholder: (context, url) => LoadingAnimationWidget.twoRotatingArc(
//                       color: greenColor,
//                       size: 100,
//
//                     ),
//                     errorWidget: (context, url, error) => Icon(Icons.error),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       "${title}",
//                       style: TextStyle(
//                           color: greenColor,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20),
//                     ),
//                     Text(
//                       "${companyName}",
//                       style: TextStyle(color: grayColor, fontSize: 12),
//                     ),
//                   ],
//                 ),
//               ),
//               Spacer(),
//               if (widget.screenName != 'Applyed Jops'&& isSelected!=null)
//                 IconButton(
//                     isSelected: true,
//                     onPressed: () {
//                       setState(() {
//                         isSelected = !isSelected;
//                         widget.onSave!(isSelected);
//                       });
//                     },
//                     icon: Icon(isSelected ? Ionicons.bookmark : Ionicons.bookmark_outline
//
//                       ,
//                       color: greenColor,
//                     )),
//               if (widget.screenName == 'Applyed Jops')
//                 IconButton(
//                     onPressed: () {},
//                     icon: icon!)
//             ],
//           ),
//           Divider(
//             color: grayColor.withOpacity(0.2),
//             indent: 10,
//             endIndent: 10,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(
//               left: 80,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "${widget.location} - ${widget.Country}",
//                   style: TextStyle(color: grayColor, fontSize: 12),
//                 ),
//                 Text(
//                   "${widget.salary} / month",
//                   style: TextStyle(color: grayColor, fontSize: 12),
//                 ),
//                 Wrap(
//                   runSpacing: 5,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.all(3),
//                       decoration: BoxDecoration(
//                         color: backgroundColor,
//                         border: Border.all(
//                           color: greenColor,
//                           width: 2,
//                         ),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Text(
//                         widget.experience!,
//                         style: TextStyle(fontSize: 12),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Container(
//                       padding: EdgeInsets.all(3),
//                       decoration: BoxDecoration(
//                         color: backgroundColor,
//                         border: Border.all(
//                           color: greenColor,
//                           width: 2,
//                         ),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Text(
//                         widget.level!,
//                         style: TextStyle(fontSize: 12),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Container(
//                       padding: EdgeInsets.all(3),
//                       decoration: BoxDecoration(
//                         color: backgroundColor,
//                         border: Border.all(
//                           color: greenColor,
//                           width: 2,
//                         ),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Text(
//                         widget.jobType!,
//                         style: TextStyle(fontSize: 12),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Container(
//                       padding: EdgeInsets.all(3),
//                       decoration: BoxDecoration(
//                         color: backgroundColor,
//                         border: Border.all(
//                           color: greenColor,
//                           width: 2,
//                         ),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Text(
//                         widget.jobShift!,
//                         style: TextStyle(fontSize: 12),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
