// import 'package:flutter/material.dart';
// import 'package:untitled10/src/app_root.dart';
// import 'package:untitled10/utils/navigator.dart';
//
// import '../SharedViews/image_screan.dart';
// import '../data/ChatModel.dart';
//
// Widget _buildMyMassage({ChatModel? message, String? time,BuildContext? context}) {
//   return Align(
//     alignment: AlignmentDirectional.centerEnd,
//     child: Container(
//       decoration: BoxDecoration(
//           color: greenColor.withOpacity(0.4),
//           borderRadius: BorderRadiusDirectional.only(
//             topEnd: Radius.circular(10),
//             topStart: Radius.circular(10),
//             bottomStart: Radius.circular(10),
//           )),
//       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Text(
//             message!.message,
//             textAlign: TextAlign.start,
//             style: TextStyle(color: Colors.black),
//           ),
//           if (message.images != null)
//             Wrap(
//               children: [
//                 for (var image in message.images!)
//                   if (image.con)
//               ],
//             ),
//           Text(
//             time!,
//             textAlign: TextAlign.start,
//             style: Theme.of(context!).textTheme.bodySmall,
//           ),
//         ],
//       ),
//     ),
//   );
// }