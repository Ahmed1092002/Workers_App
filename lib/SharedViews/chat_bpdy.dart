import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled10/SharedViews/ChatScreen.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:untitled10/utils/navigator.dart';

import '../SharedBloc/ChatCubit/chat_cubit.dart';




class ChatBody extends StatelessWidget {
  ChatBody({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: Builder(
        builder: (context) {
          ChatCubit.get(context).getChats();
          return BlocConsumer<ChatCubit, ChatState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              var cubit = ChatCubit.get(context);
              if (cubit.userModel == null || cubit.userModel!.isEmpty) {
                return Center(child: Text('No Chats Yet'));
              }
              return ListView.builder(
                itemCount: cubit.userModel!.length ?? 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: greenColor,
                            width: 2,
                          )

                      ),
                      child: ListTile(

                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                              cubit.userModel![index].image.toString()),

                        ),
                        title: Text(cubit.userModel![index].name.toString()),
                        onTap: () {
                          navigateToScreen(context, ChatScreen(
                            userModel: cubit.userModel![index],
                          ));
                        },
                      ),
                    ),
                  );
                },
              );
            },
          );
        }
      ),
    );
  }
}
