import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatty/cubit/appcubit/social_cubit.dart';
import 'package:chatty/cubit/appcubit/social_state.dart';
import 'package:chatty/models/usermodel.dart';
import 'package:chatty/modules/chat.dart';
import 'package:chatty/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.isNotEmpty,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView.separated(
                itemCount: SocialCubit.get(context).users.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    color: Colors.grey,
                    height: 1,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return buildlistitem(
                      SocialCubit.get(context).users[index], context);
                },
              ),
            );
          },
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  buildlistitem(UserModel model, context) => InkWell(
        onTap: () {
          navigatTO(
              context,
              UserChat(
                model: model,
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: CachedNetworkImageProvider('${model.image}'),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.name}',
                      style: const TextStyle(
                        height: 1.3,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      '${SocialCubit.get(context).chatMessages[model.uId]?.isNotEmpty == true ? SocialCubit.get(context).chatMessages[model.uId]!.last.text : ""}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
