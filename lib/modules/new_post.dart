import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatty/cubit/appcubit/social_cubit.dart';
import 'package:chatty/cubit/appcubit/social_state.dart';
import 'package:chatty/shared/components/components.dart';
import 'package:chatty/shared/styels/FA5.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();
  NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is CreatePostSuccessState) {
          Navigator.pop(context);
          showToast(msg: 'Post Created', color: Colors.green);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Create Post'),
            titleSpacing: 0.0,
            actions: [
              TextButton(
                onPressed: () async {
                  if (SocialCubit.get(context).postImage == null) {
                    await SocialCubit.get(context).createNewPost(
                      dateTime: DateTime.now().toString(),
                      text: textController.text,
                    );
                  } else {
                    await SocialCubit.get(context).uploadPostImage(
                      dateTime: DateTime.now().toString(),
                      text: textController.text,
                    );
                  }
                },
                child: Text('Post'),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                if (state is CreatePostLoadingState) LinearProgressIndicator(),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: CachedNetworkImageProvider(
                          '${SocialCubit.get(context).usermodel?.image}'),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            '${SocialCubit.get(context).usermodel?.name}',
                            style: TextStyle(
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'What in your mind ? ',
                      hintStyle: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                if (SocialCubit.get(context).postImage != null)
                  Container(
                    width: 200,
                    height: 200,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              (4.0),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(
                                  SocialCubit.get(context).postImage!),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            SocialCubit.get(context).removePostImage();
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).openPostPicker();
                        },
                        child: Row(
                          children: const [
                            Icon(FA5.image),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'Add photo',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          '# Tag',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
