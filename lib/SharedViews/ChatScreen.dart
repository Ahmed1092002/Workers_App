import 'dart:async';
import 'dart:io';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:untitled10/SharedBloc/ChatCubit/chat_cubit.dart';
import 'package:untitled10/SharedViews/image_screan.dart';
import 'package:untitled10/SharedViews/pdf_viewer.dart';
import 'package:untitled10/SharedWidget/ChatMessage.dart';
import 'package:untitled10/data/company/company_model.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:untitled10/utils/navigator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../company/views/video_file.dart';
import '../data/ChatModel.dart';

class ChatScreen extends StatefulWidget {
  UserModel? userModel;

  ChatScreen({Key? key, this.userModel}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _textController = TextEditingController();
  String? status;

  Widget _buildMassage({ChatModel? message, String? time}) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
            color: grayColor.withOpacity(0.2),
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
              bottomEnd: Radius.circular(10),
            )),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: status == 'Loading....'
            ? LoadingAnimationWidget.staggeredDotsWave(
                color: greenColor, size: 20)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (message!.message.contains('https://') ||
                      message.message.contains('http://'))
                    locaion(location: message.message)
                  else
                    Text(
                      message!.message,
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black),
                    ),
                  if (message.images != null)
                    Wrap(
                      children: [
                        for (var image in message.images!)
                          if (image.toString().contains('.pdf'))
                            Container(
                              height: 80,
                              margin: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: fileIcon(url: image, context: context),
                            )
                          else if (image.toString().contains('.jpg') ||
                              image.toString().contains('.png'))
                            Image(image: image, context: context)
                          else if (image.toString().contains('.mp4'))
                              videoIcon  (image: image, context: context)
                      ],
                    ),
                  Text(
                    time!,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildMyMassage({ChatModel? message, String? time}) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: BoxDecoration(
            color: greenColor.withOpacity(0.4),
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
              bottomStart: Radius.circular(10),
            )),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: status == 'Loading....'
            ? LoadingAnimationWidget.staggeredDotsWave(
                color: greenColor, size: 20)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (message!.message.contains('https://') ||
                      message.message.contains('http://'))
                    locaion(location: message.message)
                  else
                    Text(
                      message!.message,
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black),
                    ),
                  if (message.images != null)
                    Wrap(
                      children: [
                        for (var image in message.images!)
                          if (image.toString().contains('.pdf'))
                            Container(
                              height: 80,
                              margin: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: fileIcon(url: image, context: context),
                            )
                          else if (image.toString().contains('.jpg') ||
                              image.toString().contains('.png'))
                            Image(image: image, context: context)
                          else if (image.toString().contains('.mp4'))
                              videoIcon  (image: image, context: context)
                      ],
                    ),
                  Text(
                    time!,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: Builder(builder: (context) {
        ChatCubit.get(context).getMessages(receiverId: widget.userModel!.id!);

        return BlocConsumer<ChatCubit, ChatState>(
          listener: (context, state) {
            if (state is SendMessageSuccessState) {
              ChatCubit.get(context)
                  .getMessages(receiverId: widget.userModel!.id!);
            }
            if (state is SendMessageLoadingState
                ||
                state is uploadProfileImageLoadingState) {
             CircularProgressIndicator();
            }
            if (state is GetMessagesLoadingState
                || state is SendMessageLoadingState ||
                state is uploadProfileImageLoadingState) {
              status = 'Loading...';
            }
          },
          builder: (context, state) {
            var cubit = ChatCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.userModel!.image!),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      '${widget.userModel!.name}',
                      style: TextStyle(
                          color: greenColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                iconTheme: IconThemeData(
                  color: greenColor, //change your color here
                ),
              ),
              body: ConditionalBuilder(
                condition: ChatCubit.get(context).Masseges.length >= 0,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: ListView.separated(
                              reverse: true,
                              itemBuilder: (context, index) {
                                var message =
                                    ChatCubit.get(context).Masseges[index];
                                DateTime dateTime =
                                    DateTime.parse(message.time);
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(dateTime);
                                String formattedTime =
                                    DateFormat('h:mm a').format(dateTime);

                                if (message.senderId == widget.userModel!.id) {
                                  return _buildMassage(
                                      message: message, time: formattedTime);
                                } else {
                                  return _buildMyMassage(
                                      message: message, time: formattedTime);
                                }
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 8.0,
                                  ),
                              itemCount:
                                  ChatCubit.get(context).Masseges.length),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    decoration: BoxDecoration(
                                      color: backgroundColor,
                                      border: Border.all(color: greenColor),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              if (cubit.images.isNotEmpty)
                                                Container(

                                                  decoration: BoxDecoration(
                                                    color: grayColor.withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                  ),
                                                  child: Wrap(
                                                    children: [
                                                      for (var xfile
                                                      in cubit.images)
                                                        file(file: xfile),

                                                    ],
                                                  ),
                                                ),
                                              if (state is SendMessageLoadingState
                                                  ||
                                                  state is uploadProfileImageLoadingState)
                                                CircularProgressIndicator(),
                                              Container(
                                                width: 200,
                                                decoration: BoxDecoration(
                                                  color: backgroundColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                child: TextFormFieldChat(textController: _textController),
                                              ),

                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all(
                                                EdgeInsets.all(0)),
                                          ),
                                          icon: Icon(
                                            Ionicons.attach_outline,
                                            color: greenColor,
                                          ),
                                          onPressed: () {
                                            // cubit.pickMultipleMediaImage();
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return chosenFile(
                                                      onGallary: () {
                                                    cubit
                                                        .pickMultipleMediaImage();
                                                    Navigator.pop(context);
                                                  }, onFile: () {
                                                    cubit.pickFilePdf();
                                                    Navigator.pop(context);
                                                  }, onLocation: () {
                                                    cubit.getCurrentLocation(
                                                        context);
                                                    cubit
                                                        .shareLocation(context);

                                                    _textController.text =
                                                        cubit.location!;

                                                    Navigator.pop(context);
                                                  });
                                                });
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Ionicons.camera_outline,
                                            color: greenColor,
                                          ),
                                          onPressed: () {
                                            cubit.pickCameraImage();
                                          },
                                        ),
                                      ],
                                    ),
                                  )),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  MaterialButton(
                                      color: greenColor,
                                      height: 40,
                                      minWidth: 40,
                                      animationDuration: Duration(seconds: 1),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Icon(
                                        Ionicons.send,
                                        color: backgroundColor,
                                      ),
                                      onPressed: () async {
                                        print('send');
                                        if (_textController.text.isEmpty &&
                                            cubit.images.isEmpty) {
                                          return;
                                        } else {
                                          if (cubit.images.isNotEmpty) {
                                            bool hasVideos = cubit.images.any((file) => file.path.endsWith('.mp4'));

                                            await cubit
                                                .uploadProfileImage()
                                                .then((value) async {

                                                  if (hasVideos) {

                                                    Future.delayed(Duration(seconds:15 ), () {
                                                      CircularProgressIndicator();
                                                      cubit.sendMessage(
                                                          message:
                                                          _textController.text,
                                                          receiverId:
                                                          widget.userModel!.id!,
                                                          receiverName: widget
                                                              .userModel!.name!,
                                                          fcmTokenDevice: widget
                                                              .userModel!.fcmToken!,
                                                          imagesLink: value,
                                                          time: DateTime.now()
                                                              .toString());
                                                    });
                                                  }
                                             else {
                                                Future.delayed(
                                                    Duration(seconds: 5), () {
                                                  CircularProgressIndicator();
                                                  cubit.sendMessage(
                                                      message:
                                                          _textController.text,
                                                      receiverId:
                                                          widget.userModel!.id!,
                                                      receiverName: widget
                                                          .userModel!.name!,
                                                      fcmTokenDevice: widget
                                                          .userModel!.fcmToken!,
                                                      imagesLink: value,
                                                      time: DateTime.now()
                                                          .toString());
                                                });
                                              }
                                            });
                                          } else {
                                            await ChatCubit.get(context)
                                                .sendMessage(
                                              message: _textController.text,
                                              fcmTokenDevice:
                                                  widget.userModel!.fcmToken!,
                                              imagesLink: [],
                                              receiverName:
                                                  widget.userModel!.name!,
                                              time: DateTime.now().toString(),
                                              receiverId: widget.userModel!.id!,
                                            );
                                          }

                                          cubit.images.clear();
                                          cubit.imagesLink.clear();
                                          _textController.clear();
                                        }
                                      }),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                fallback: (context) => Center(
                    child: LoadingAnimationWidget.twoRotatingArc(
                  color: greenColor,
                  size: 100,
                )),
              ),
            );
          },
        );
      }),
    );
  }
}

class TextFormFieldChat extends StatelessWidget {
  const TextFormFieldChat({
    super.key,
    required TextEditingController textController,
  }) : _textController = textController;

  final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: greenColor,
      style: TextStyle(
          color: greenColor),
      cursorRadius:
          Radius.circular(10),
      controller: _textController,
      decoration: InputDecoration(
        isDense: true,
        hintText:
            'Enter your message',
        hintStyle: TextStyle(
            color: greenColor),
        filled: true,
        fillColor: backgroundColor,
        border: InputBorder.none,
      ),
    );
  }
}

Widget chosenFile({
  Function()? onGallary,
  Function()? onFile,
  Function()? onLocation,
}) =>
    Container(
        width: double.infinity,
        height: 150,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                height: 80,
                width: 70,
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: greenColor.withOpacity(0.2),
                      child: IconButton(
                        onPressed: () {
                          onGallary!();
                        },
                        icon: Icon(
                          Ionicons.image_outline,
                        ),
                        color: greenColor,
                      ),
                    ),
                    Text(
                      'Gallery',
                      style: TextStyle(color: greenColor),
                    ),
                  ],
                )),
            SizedBox(
              width: 10,
            ),
            Container(
                height: 80,
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: greenColor.withOpacity(0.2),

                      radius: 30,
                      child: IconButton(
                        onPressed: () {
                          onFile!();
                        },
                        icon: Icon(
                          Ionicons.file_tray,
                        ),
                        color: greenColor,
                      ),
                    ),
                    Text(
                      'Document',
                      style: TextStyle(color: greenColor),
                    ),
                  ],
                )),
            SizedBox(
              width: 10,
            ),
            Container(
                height: 80,
                width: 70,
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: greenColor.withOpacity(0.2),

                      radius: 30,
                      child: IconButton(
                        onPressed: () {
                          onLocation!();
                        },
                        icon: Icon(
                          Ionicons.location_outline,
                        ),
                        color: greenColor,
                      ),
                    ),
                    Text(
                      'Location',
                      style: TextStyle(color: greenColor),
                    ),
                  ],
                )),
          ],
        ));

Widget fileIcon({String? url, BuildContext? context}) {
  Uri uri = Uri.parse(url!);
  String fileName = uri.pathSegments.last.split('/').last;

  var dio = Dio();
  return Container(


    child: Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: greenColor.withOpacity(0.2),
          child: IconButton(
            onPressed: () async {
              var pdfUrl = url;
              var dir = await getApplicationDocumentsDirectory();
              var filePath = '${dir.path}/file.pdf';
              var dio = Dio();

              // Wrap the download function in a FutureBuilder


              // Delay the navigation until the current widget tree build operation is complete
              // WidgetsBinding.instance!.addPostFrameCallback((_) {
              //   navigateToScreen(context, PdfPage(path: url));
              // });
              // // showDialog(
              // //   context: context!,
              // //   builder: (context) => FutureBuilder(
              // //     future: dio.download(pdfUrl, filePath),
              // //     builder: (context, snapshot) {
              // //       if (snapshot.connectionState == ConnectionState.waiting) {
              // //         return AlertDialog(
              // //           content: Row(
              // //             children: [
              // //               LoadingAnimationWidget.twoRotatingArc(
              // //                 color: greenColor,
              // //                 size: 100,
              // //               ),
              // //               SizedBox(width: 20),
              // //               Text('Downloading PDF...'),
              // //             ],
              // //           ),
              // //         );
              // //       } else if (snapshot.connectionState == ConnectionState.done) {
              // //         // Close the dialog when download is complete
              // //         Navigator.pop(context);
              // //
              // //         // Delay the navigation until the current widget tree build operation is complete
              // //         WidgetsBinding.instance!.addPostFrameCallback((_) {
              // //           navigateToScreen(context, PdfPage(path: url));
              // //         });
              // //       }
              // //       return Container();
              // //     },
              // //   ),
              // // );
              navigateToScreen(context!, PdfPage(path: url));
            },
            icon: Icon(
              Ionicons.file_tray,
            ),
            color: greenColor,
          ),
        ),
        Flexible(
          child: Text(
            fileName,
            style: TextStyle(color: greenColor),
          ),
        ),
      ],
    ),
  );
}

Widget Image({String? image, BuildContext? context}) {
  return GestureDetector(
    onTap: () {
      navigateToScreen(context!, ImageScrean(image: image!));
    },
    child: Container(
      height: 50,
      width: 50,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: CachedNetworkImage(
        imageUrl: image!, // Use the image string directly as the imageUrl
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        fit: BoxFit.cover,
        placeholder: (context, url) => LoadingAnimationWidget.twoRotatingArc(
          color: greenColor,
          size: 100,
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    ),
  );
}

Widget locaion({String? location}) {
  RegExp regExp = RegExp(r'(https?://[^\s]+)');
  String? url = regExp.firstMatch(location!)?.group(0);
  String? othertext = location.replaceAll(regExp, '');

  Uri _url = Uri.parse(url!);

  return InkWell(
    child: Column(
      children: [
        Text(
          othertext!,
          textAlign: TextAlign.start,
        ),
        Text(
          url,
          textAlign: TextAlign.start,
          style: TextStyle(color: greenColor),
        ),
      ],
    ),
    onTap: () async {
      if (!await launchUrl(_url)) {
        throw Exception('Could not launch $_url');
      }
    },
  );
}

Widget file({
  File? file,
}) {
  if (file!.path.contains('pdf')) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          child: Icon(
            Ionicons.file_tray,
            color: greenColor,
          ),
        ),
        Text(
          file.path.split('/').last,
          style: TextStyle(color: greenColor),
        ),
      ],
    );
  }
  if (file.path.contains('.mp4')) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            child: Icon(
              Ionicons.videocam,
              color: greenColor,
            ),
          ),
          Text(
            file.path.split('/').last,
            style: TextStyle(color: greenColor),
          ),
        ],
      ),
    );
  }
  else {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: FileImage(file),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


Widget videoIcon  ({ String? image, BuildContext? context}){
  Uri uri = Uri.parse(image!);
  String fileName = uri.pathSegments.last.split('/').last;

return GestureDetector(

onTap: (){
navigateToScreen(context!, VideoFile(urlVideo: image));

},child: Container(

margin: EdgeInsets.all(8.0),
decoration: BoxDecoration(

borderRadius: BorderRadius.circular(10),
),
child: Container(
  padding: EdgeInsets.all(8.0),
  decoration: BoxDecoration(
    color: greenColor.withOpacity(0.2),

    borderRadius: BorderRadius.circular(10),
border: Border.all(
  color: greenColor,
  width: 2,
),
  ),
  child: Column(
    children: [
      Icon(
      Ionicons.videocam,
      color: greenColor,
      ),
      Text(
        fileName,
        style: TextStyle(color: greenColor),
      ),
    ],
  ),
),
) );
}
