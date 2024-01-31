import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled10/SharedBloc/ChatCubit/chat_cubit.dart';
import 'package:untitled10/SharedWidget/ChatMessage.dart';
import 'package:untitled10/data/company/company_model.dart';
import 'package:untitled10/src/app_root.dart';

import '../data/ChatModel.dart';


class ChatScreen extends StatefulWidget {
  UserModel? userModel;

  ChatScreen({Key? key, this.userModel}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _textController = TextEditingController();



  Widget _buildMassage({ChatModel? message,String?time}) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
      decoration: BoxDecoration(
        color:grayColor.withOpacity(0.2),
        borderRadius: BorderRadiusDirectional.only(
      topEnd: Radius.circular(10),
      topStart: Radius.circular(10),
      bottomEnd: Radius.circular(10),
        )
      ),
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Column(
          children: [
            Text(message!.message, textAlign: TextAlign.start,style: TextStyle(color: Colors.black), ),
            Text(time!, textAlign: TextAlign.start,style: TextStyle(color: Colors.black), ),


          ],
        ),
      ),
    );
  }
  Widget _buildMyMassage({ChatModel? message, String? time }) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
      decoration: BoxDecoration(
        color: greenColor.withOpacity(0.4),
        borderRadius: BorderRadiusDirectional.only(
      topEnd: Radius.circular(10),
      topStart: Radius.circular(10),
      bottomStart: Radius.circular(10),
        )
      ),
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Column(
          children: [
            Text(message!.message, textAlign: TextAlign.start,style: TextStyle(color: Colors.black), ),
            Text(time!, textAlign: TextAlign.start,style: TextStyle(color: Colors.black), ),
          ],
        ),
      ),

    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => ChatCubit(),
  
  child: Builder(
    builder: (context) {
      ChatCubit.get(context).getMessages(receiverId: widget.userModel!.id!);
      return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Row(

            children: [

              CircleAvatar(
                backgroundImage: NetworkImage(widget.userModel!.image!),
              ),
              SizedBox(width: 12,),
              Text('${widget.userModel!.name}'),
            ],
          ),

          ),
          body: ConditionalBuilder(condition: ChatCubit.get(context).Masseges.length >= 0,
              builder:(context) {
                return    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          // _buildMassage(),
                          // _buildMyMassage(),

                          Expanded(
                            child: ListView.separated(
                              reverse: true,
                                itemBuilder: (context, index) {
                              var message = ChatCubit.get(context).Masseges[index];
                              DateTime dateTime = DateTime.parse(message.time);
                              String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
                              String formattedTime = DateFormat('h:mm a').format(dateTime);



                              if (message.senderId == widget.userModel!.id) {
                                return   _buildMassage(message: message,time: formattedTime);
                              } else {
                                return  _buildMyMassage( message: message,time: formattedTime);
                              }

                            },
                                separatorBuilder: (context, index) => SizedBox(
                                      height: 8.0,
                                    ),
                                itemCount: ChatCubit.get(context).Masseges.length),
                          ),
                          Divider(height: 1.0),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: TextFormField(
                                  controller: _textController,
                                  decoration: InputDecoration.collapsed(
                                      hintText: 'Send a message',
                                      border: InputBorder.none),
                                )),
                                MaterialButton(
                                    color: greenColor,
                                    height: 40,
                                    minWidth: 40,
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      print(widget.userModel!.name!);
                                      ChatCubit.get(context).sendMessage(
                                        message: _textController.text,
                                        fcmTokenDevice: widget.userModel!.fcmToken!,
                                        receiverName: widget.userModel!.name!,
                                        time: DateTime.now().toString(),
                                        receiverId: widget.userModel!.id!,
                                      );
                                      _textController.clear();
                                    }),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },

              fallback: (context) => Center(child: CircularProgressIndicator( ))),
        );
      },
      );
    }
  ),
);
  }
}