import 'package:chatty/cubit/appcubit/social_cubit.dart';
import 'package:chatty/cubit/appcubit/social_state.dart';
import 'package:chatty/shared/components/components.dart';
import 'package:chatty/shared/styels/FA5.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditScreen extends StatelessWidget {
  EditScreen({super.key});
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, Object? state) {
        var userModel = SocialCubit.get(context).usermodel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;
        return Scaffold(
          appBar: AppBar(
            title: Text('Edit Profile'),
            titleSpacing: 5.0,
            actions: [
              TextButton(
                onPressed: () {
                  SocialCubit.get(context).updateUserData(
                    name: nameController.text,
                    bio: bioController.text,
                    phone: phoneController.text,
                  );
                },
                child: Text('Update'),
              )
            ],
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(FA5.arrow_left),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is UserUpdateLoading ||
                      state is UploadProfileImageLoadingState ||
                      state is UploadCoverImageLoadingState)
                    LinearProgressIndicator(),
                  Container(
                    height: 200,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 160,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadiusDirectional.only(
                                    topStart: Radius.circular(4.0),
                                    topEnd: Radius.circular(4.0),
                                  ),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: coverImage == null
                                        ? NetworkImage('${userModel.cover}')
                                        : FileImage(coverImage)
                                            as ImageProvider,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).openCoverPicker();
                                },
                                icon: Icon(FA5.camera),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 48,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${userModel.image}')
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                SocialCubit.get(context).openImagePicker();
                              },
                              icon: Icon(FA5.camera),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  if (SocialCubit.get(context).coverImage != null ||
                      SocialCubit.get(context).profileImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                SocialCubit.get(context).uploadProfileImage(
                                    name: nameController.text,
                                    bio: bioController.text,
                                    phone: phoneController.text);
                              },
                              child: Text('Upload Profile Image'),
                            ),
                          ),
                        const SizedBox(
                          width: 5,
                        ),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                SocialCubit.get(context).uploadcoverImage(
                                    name: nameController.text,
                                    bio: bioController.text,
                                    phone: phoneController.text);
                              },
                              child: Text('Upload Cover Image'),
                            ),
                          ),
                      ],
                    ),
                  const SizedBox(
                    height: 8,
                  ),
                  DefultTFF(
                    controrller: nameController,
                    label: 'Name',
                    prefix: FA5.user,
                    keyboardtype: TextInputType.name,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Cant be Empty';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DefultTFF(
                    controrller: bioController,
                    label: 'Bio',
                    prefix: FA5.sketch,
                    keyboardtype: TextInputType.text,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Cant be Empty';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DefultTFF(
                    controrller: phoneController,
                    label: 'Phone',
                    prefix: FA5.mobile,
                    keyboardtype: TextInputType.phone,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Cant be Empty';
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
