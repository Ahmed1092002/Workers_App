import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
                return  Container(
                  child: state is GetChatLoadingState ?Center(
                    child: LoadingAnimationWidget.twoRotatingArc(
                      color: greenColor,
                      size: 100,
                    ),
                  ): Center(
                    child: Text('No Chats Yet',
                      style: TextStyle(
                        color: greenColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }
              return  ListView.builder(
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
                        contentPadding: EdgeInsets.all(5),
                        leading: CachedNetworkImage(
                          imageUrl: cubit.userModel![index].image.toString(),
                          imageBuilder: (context, imageProvider) => CircleAvatar(
                            backgroundImage: imageProvider,
                            radius: 30,
                          ),
                          placeholder: (context, url) => LoadingAnimationWidget.twoRotatingArc(
                            color: greenColor,
                            size: 100,

                          ),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                        title: Text(cubit.userModel![index].name.toString(),
                          style: TextStyle(
                            color: greenColor,

                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
