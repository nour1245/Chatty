import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatty/cubit/appcubit/social_cubit.dart';
import 'package:chatty/cubit/appcubit/social_state.dart';
import 'package:chatty/models/usermodel.dart';
import 'package:chatty/modules/chat.dart';
import 'package:chatty/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
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

  buildlistitem(UserModel model, context) => Padding(
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
            Text(
              '${model.name}',
              style: const TextStyle(
                height: 1.3,
              ),
            ),
          ],
        ),
      );
}
