import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatty/cubit/appcubit/social_cubit.dart';
import 'package:chatty/cubit/appcubit/social_state.dart';
import 'package:chatty/models/post_model.dart';
import 'package:chatty/modules/comment.dart';
import 'package:chatty/shared/components/components.dart';
import 'package:chatty/shared/styels/FA5.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';

class FeedsScreen extends StatelessWidget {
  var commentcontrorller = TextEditingController();
  var commentState;
  FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (BuildContext context, state) {
          commentState = state;
          if (state is CreatePostSuccessState) {
            SocialCubit.get(context).getPosts();
          }
        },
        builder: (BuildContext context, state) {
          return ConditionalBuilder(
            condition: state is! PostsLoadingState,
            fallback: (BuildContext context) =>
                const Center(child: CircularProgressIndicator()),
            builder: (BuildContext context) => SocialCubit.get(context)
                    .posts
                    .isEmpty
                ? const Center(child: Text('No posts'))
                : RefreshIndicator(
                    onRefresh: () async {
                      await SocialCubit.get(context).getPosts();
                    },
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 9,
                              ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: SocialCubit.get(context).posts.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  buildPostItem(
                                      SocialCubit.get(context).posts[index],
                                      context,
                                      index),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        },
      );
    });
  }

  Widget buildPostItem(PostModel model, context, postindex) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10.0,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        CachedNetworkImageProvider('${model.image}'),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: const TextStyle(
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Icon(
                              Icons.check_circle,
                              size: 15,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        Text(
                          '${model.dateTime}',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text('delete'),
                        enabled:
                            SocialCubit.get(context).usermodel?.uId == model.uId
                                ? true
                                : false,
                        onTap: () {
                          SocialCubit.get(context).deletePost(
                              SocialCubit.get(context).postsId[postindex],
                              context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${model.text}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 5),
                        child: SizedBox(
                          height: 25,
                          child: MaterialButton(
                            minWidth: 1.0,
                            height: 25.0,
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: Text(
                              '',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: Colors.blue, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (model.postImage != '')
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider('${model.postImage}'),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              const Icon(
                                UniconsLine.heart,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                '${SocialCubit.get(context).likes[postindex]}',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                UniconsLine.comment,
                                color: Colors.amber,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                '${SocialCubit.get(context).commentsL[postindex]}',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(color: Colors.grey[300]),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ListView.separated(
                                    itemCount: SocialCubit.get(context)
                                        .commentsL[postindex],
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        height: 8,
                                      );
                                    },
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var comments =
                                          SocialCubit.get(context).comments;

                                      return commentState
                                              is PostsCommentsLoadingState
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : bulidCommentsList(
                                              comments, postindex, index);
                                    },
                                  ),
                                ),
                                Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: commentcontrorller,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'comment here',
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          SocialCubit.get(context).commentsPost(
                                            postsId: SocialCubit.get(context)
                                                .postsId[postindex],
                                            datetime: DateTime.now().toString(),
                                            text: commentcontrorller.text,
                                            userImage: SocialCubit.get(context)
                                                .usermodel
                                                ?.image,
                                            userName: SocialCubit.get(context)
                                                .usermodel
                                                ?.name,
                                          );
                                          commentcontrorller.clear();
                                        },
                                        icon: Icon(Icons.send),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundImage: CachedNetworkImageProvider(
                                  '${SocialCubit.get(context).usermodel?.image}'),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'write a comment...',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(height: 1.4),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context).likePost(
                          SocialCubit.get(context).postsId[postindex]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            UniconsLine.heart,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            'Like',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      debugPrint('${SocialCubit.get(context).commentsL}');
                      debugPrint(
                          '${SocialCubit.get(context).comments[postindex]}');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            UniconsLine.share,
                            color: Colors.green,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            'Share',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  bulidCommentsList(comments, postindex, index) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage:
                  NetworkImage('${comments[postindex][index].userImage}'),
            ),
            const SizedBox(
              width: 5,
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.all(10),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[300],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${comments[postindex][index].userName}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('${comments[postindex][index].text}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
