import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatty/cubit/appcubit/social_cubit.dart';
import 'package:chatty/cubit/appcubit/social_state.dart';
import 'package:chatty/models/message_model.dart';
import 'package:chatty/models/usermodel.dart';
import 'package:chatty/shared/components/components.dart';
import 'package:chatty/shared/styels/FA5.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserChat extends StatelessWidget {
  UserModel? model;
  var textController = TextEditingController();
  UserChat({
    super.key,
    this.model,
  });
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessage(reseverId: model?.uId);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage:
                        CachedNetworkImageProvider('${model?.image}'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${model?.name}',
                    style: const TextStyle(
                      height: 1.3,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: SocialCubit.get(context).messages.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 8,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        var message = SocialCubit.get(context).messages[index];
                        if (SocialCubit.get(context).usermodel?.uId ==
                            message.senderId) return buildMyMessage(message);
                        return buildMessage(message);
                      },
                    ),
                  ),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: textController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Message..',
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.blue,
                          height: 50,
                          child: MaterialButton(
                            minWidth: 1,
                            onPressed: () {
                              SocialCubit.get(context).sendMessage(
                                datetime: DateTime.now().toString(),
                                reseverId: model?.uId,
                                text: textController.text,
                              );
                              textController.clear();
                            },
                            child: const Icon(
                              Icons.send,
                              size: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 10,
          ),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: const BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10),
                topEnd: Radius.circular(10),
                topStart: Radius.circular(10),
              )),
          child: Text('${model.text}'),
        ),
      );

  buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 10,
          ),
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.2),
              borderRadius: const BorderRadiusDirectional.only(
                bottomStart: Radius.circular(5),
                topEnd: Radius.circular(5),
                topStart: Radius.circular(5),
              )),
          child: Text('${model.text}'),
        ),
      );
}
