import 'dart:io';

import 'package:chatty/cubit/appcubit/social_state.dart';
import 'package:chatty/models/comments_model.dart';
import 'package:chatty/models/message_model.dart';
import 'package:chatty/models/post_model.dart';
import 'package:chatty/models/usermodel.dart';
import 'package:chatty/modules/chat_screen.dart';
import 'package:chatty/modules/feedsscreen.dart';

import 'package:chatty/modules/settingsscreen.dart';
import 'package:chatty/modules/usersscreen.dart';
import 'package:chatty/shared/components/components.dart';
import 'package:chatty/shared/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitial());
  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? usermodel;

  void getUserData() {
    emit(UserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      usermodel = UserModel.fromjson(value.data()!);
      emit(UserSuccessState());
    }).catchError((error) {
      emit(UserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Feeds',
    'Chats',
    'Users',
    'Settings',
  ];
  void changeNavBar(index) {
    if (index == 1) {
      getAllusers();
    }
    currentIndex = index;
    emit(BottomNavBarChange());
  }

  // This is the file that will be used to store the image
  File? profileImage;

  // This is the image picker
  final picker = ImagePicker();
  // Implementing the image picker
  Future<void> openImagePicker() async {
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profileImage = File(pickedImage.path);
      emit(EditProfileImageSuccessState());
    } else {
      emit(EditProfileImageErrorState());
    }
  }

  // This is the file that will be used to store the image
  File? coverImage;

  // This is the image picker

  // Implementing the image picker
  Future<void> openCoverPicker() async {
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      coverImage = File(pickedImage.path);
      emit(EditProfileImageSuccessState());
    } else {
      emit(EditProfileImageErrorState());
    }
  }

  uploadProfileImage({
    required name,
    required bio,
    required phone,
  }) {
    emit(UploadProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(name: name, bio: bio, phone: phone, profile: value);
        emit(UploadProfileImageSuccessState());
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  uploadcoverImage({
    required name,
    required bio,
    required phone,
  }) {
    emit(UploadCoverImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(bio: bio, name: name, phone: phone, cover: value);
        emit(UploadCoverImageSuccessState());
      }).catchError((error) {
        emit(UploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(UploadCoverImageErrorState());
    });
  }

  updateUserData({
    required name,
    required bio,
    required phone,
    String? cover,
    String? profile,
  }) {
    emit(UserUpdateLoading());
    UserModel nmodel = UserModel(
        name: name,
        phone: phone,
        bio: bio,
        cover: cover ?? usermodel?.cover,
        email: usermodel?.email,
        image: profile ?? usermodel?.image,
        uId: usermodel?.uId,
        isVerfied: false);
    FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel?.uId)
        .update(nmodel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UserUpdateError());
    });
  }

  // This is the file that will be used to store the image
  File? postImage;

  // This is the image picker

  // Implementing the image picker
  Future<void> openPostPicker() async {
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      postImage = File(pickedImage.path);
      emit(PostImageSuccessState());
    } else {
      emit(PostImageErrorState());
    }
  }

  uploadPostImage({
    required dateTime,
    required text,
  }) {
    emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createNewPost(dateTime: dateTime, text: text, postImage: value);
        emit(CreatePostSuccessState());
      }).catchError((error) {
        emit(CreatePostErrorState());
      });
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  createNewPost({
    required dateTime,
    required text,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());
    PostModel nmodel = PostModel(
        name: usermodel!.name,
        uId: usermodel!.uId,
        image: usermodel!.image,
        text: text,
        dateTime: dateTime,
        postImage: postImage ?? '');
    FirebaseFirestore.instance
        .collection('posts')
        .add(nmodel.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit((CreatePostErrorState()));
    });
  }

  removePostImage() {
    postImage = null;
    emit(RemovePostImage());
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  List comments = [];
  List<int> commentsL = [];
  List userPosts = [];

  getPosts() async {
    try {
      emit(PostsLoadingState());
      posts.clear();
      postsId.clear();
      likes.clear();
      comments.clear();
      commentsL.clear();

      final postsQuerySnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .orderBy('dateTime', descending: true)
          .get();

      final userpostsQuerySnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .where('uId', isEqualTo: usermodel?.uId)
          .get();
      userPosts = userpostsQuerySnapshot.docs
          .map((postDoc) => PostModel.fromjson(postDoc.data()))
          .toList();

      for (final postDoc in postsQuerySnapshot.docs) {
        final commentsRef = postDoc.reference.collection('comments');
        final likesRef = postDoc.reference.collection('likes');

        // Use snapshot listeners for comments
        commentsRef.orderBy('dateTime').snapshots().listen((snapshot) {
          final commentsForPost = snapshot.docs
              .map((commentDoc) => CommentsModel.fromjson(commentDoc.data()))
              .toList();
          final postIndex = postsId.indexOf(postDoc.id);
          if (postIndex != -1) {
            comments[postIndex] = commentsForPost;
            commentsL[postIndex] = commentsForPost.length;
            emit(PostsSuccessState());
          }
        });

        // Use snapshot listeners for likes
        likesRef.snapshots().listen((snapshot) {
          final likesCount = snapshot.docs.length;
          final postIndex = postsId.indexOf(postDoc.id);
          if (postIndex != -1) {
            likes[postIndex] = likesCount;
            emit(PostsSuccessState());
          }
        });

        // Load initial data for likes and posts
        final commentsQuerySnapshot = await commentsRef.get();
        final commentsForPost = commentsQuerySnapshot.docs
            .map((commentDoc) => CommentsModel.fromjson(commentDoc.data()))
            .toList();
        comments.add(commentsForPost);
        commentsL.add(commentsForPost.length);

        final likesQuerySnapshot = await likesRef.get();
        likes.add(likesQuerySnapshot.docs.length);

        postsId.add(postDoc.id);
        posts.add(PostModel.fromjson(postDoc.data()));
      }

      emit(PostsSuccessState());
    } catch (error) {
      emit(PostsErrorState(error.toString()));
    }
  }

  likePost(String postsId) async {
    final likeDoc = await FirebaseFirestore.instance
        .collection('posts')
        .doc(postsId)
        .collection('likes')
        .doc(usermodel!.uId)
        .get();

    if (likeDoc.exists) {
      await likeDoc.reference.delete();
    } else {
      await likeDoc.reference.set({'Like': true});
    }

    emit(PostsLikesSuccessState());
  }

  commentsPost({
    required text,
    required datetime,
    required postsId,
    required userImage,
    required userName,
  }) {
    emit(PostsCommentsLoadingState());

    CommentsModel model = CommentsModel(
      dateTime: datetime,
      postId: postsId,
      userImage: usermodel?.image,
      userName: usermodel?.name,
      text: text,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postsId)
        .collection('comments')
        .add(model.toMap())
        .then((value) {
      emit(PostsCommentsSuccessState());
    }).catchError((error) {
      emit(PostsCommentsErrorState(error.toString()));
    });
  }

  List<UserModel> users = [];
  getAllusers() {
    emit(AllUsersLoadingState());
    users = [];
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        if (element.data()['uId'] != usermodel?.uId) {
          users.add(UserModel.fromjson(element.data()));
        }
      }

      emit(AllUsersSuccessState());
    }).catchError((error) {
      emit(AllUsersErrorState(error.toString()));
    });
  }

  sendMessage({
    required datetime,
    required reseverId,
    required text,
  }) {
    MessageModel model = MessageModel(
      dateTime: datetime,
      reciverId: reseverId,
      text: text,
      senderId: usermodel?.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel?.uId)
        .collection('chats')
        .doc(reseverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState(error.toString()));
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(reseverId)
        .collection('chats')
        .doc(usermodel?.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState(error.toString()));
    });
  }

  List<MessageModel> messages = [];
  Map<String, List<MessageModel>> chatMessages = {};

  getMessage({
    required reseverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel?.uId)
        .collection('chats')
        .doc(reseverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      for (var element in event.docs) {
        messages.add(MessageModel.fromjson(element.data()));
      }
      chatMessages[reseverId] = messages;
      emit(GetMessageSuccessState());
    });
  }

  deletePost(postId, context) async {
    await FirebaseFirestore.instance.collection('posts').doc(postId).delete();

    // Find the index of the deleted post in the postsId list
    final postIndex = SocialCubit.get(context).postsId.indexOf(postId);

    // Remove the post, comments, and likes at that index from their respective lists
    SocialCubit.get(context).posts.removeAt(postIndex);
    SocialCubit.get(context).comments.removeAt(postIndex);
    SocialCubit.get(context).commentsL.removeAt(postIndex);
    SocialCubit.get(context).likes.removeAt(postIndex);
    SocialCubit.get(context).postsId.removeAt(postIndex);

    showToast(msg: 'Post deleted', color: Colors.green);
    emit(PostsDeleteSuccessState());
  }

  deleteComment(postId, commentId) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .delete();
    showToast(msg: 'comment deleted', color: Colors.green);
  }

  File? Photo;

  // This is the image picker
  final photoPicker = ImagePicker();
  // Implementing the image photoPicker
  Future<void> openPhotoPicker() async {
    final XFile? pickedImage =
        await photoPicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Photo = File(pickedImage.path);
      await uploadPhoto();
      emit(EditPhotoSuccessState());
    } else {
      emit(EditPhotoErrorState());
    }
  }

  List photos = [];
  uploadPhoto() {
    emit(UploadPhotoLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            'userPhotos/${usermodel?.uId}/${Uri.file(Photo!.path).pathSegments.last}')
        .putFile(Photo!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        photos.add(value);
        emit(UploadPhotoSuccessState());
      }).catchError((error) {
        emit(UploadPhotoErrorState());
      });
    }).catchError((error) {
      emit(UploadPhotoErrorState());
    });
  }

  deletePhoto(photoName) {
    emit(DeletePhotoLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('userPhotos/${usermodel?.uId}/$photoName')
        .delete()
        .then((value) {
      emit(DeletePhotoSuccess());
    });
  }
}
