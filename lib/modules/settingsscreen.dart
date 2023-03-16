import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatty/cubit/appcubit/social_cubit.dart';
import 'package:chatty/cubit/appcubit/social_state.dart';
import 'package:chatty/modules/edit_screen.dart';
import 'package:chatty/shared/components/components.dart';
import 'package:chatty/shared/styels/FA5.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is EditPhotoSuccessState) {
          showToast(msg: 'Uploading Photo...', color: Colors.green);
        }
        if (state is DeletePhotoLoading) {
          LinearProgressIndicator();
        }
      },
      builder: (context, state) {
        var userModel = SocialCubit.get(context).usermodel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 200,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: double.infinity,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(4.0),
                            topEnd: Radius.circular(4.0),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage('${userModel?.cover}'),
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                          radius: 48,
                          backgroundImage: NetworkImage('${userModel?.image}')),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '${userModel?.name}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '${userModel?.bio}',
                style: Theme.of(context).textTheme.caption,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text(
                            '${SocialCubit.get(context).userPosts.length}',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            'posts',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text(
                            '100',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            'Followers',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text(
                            '100',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            'Following',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text(
                            '${SocialCubit.get(context).photos.length}',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            'pho',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        SocialCubit.get(context).openPhotoPicker();
                      },
                      child: const Text(
                        'Add Photos',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      navigatTO(context, EditScreen());
                    },
                    child: const Icon(FA5.edit),
                  ),
                ],
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: SocialCubit.get(context).photos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onLongPress: () {
                        showPopupMenu(context, index);
                      },
                      child: GestureDetector(
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: InteractiveViewer(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      '${SocialCubit.get(context).photos[index]}',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            );
                          },
                        ),
                        child: Container(
                          width: 100,
                          height: 200,
                          child: CachedNetworkImage(
                              imageUrl:
                                  '${SocialCubit.get(context).photos[index]}'),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showPopupMenu(BuildContext context, index) async {
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;

    await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromPoints(
          overlay.localToGlobal(Offset.zero),
          overlay.localToGlobal(overlay.size.bottomRight(Offset.zero)),
        ),
        Offset.zero & overlay.size,
      ),
      items: <PopupMenuEntry>[
        PopupMenuItem(
          child: Text('Delete'),
          value: 2,
          onTap: () {
            String url = '${SocialCubit.get(context).photos[index]}';
            List<String> parts = url.split('%2F');
            String lastPart = parts[parts.length - 1];
            String photoName = Uri.decodeFull(lastPart.split('?')[0]);
            SocialCubit.get(context).deletePhoto(photoName);
          },
        ),
      ],
    );
  }
}
