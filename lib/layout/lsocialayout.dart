import 'package:chatty/cubit/appcubit/social_cubit.dart';
import 'package:chatty/cubit/appcubit/social_state.dart';
import 'package:chatty/modules/new_post.dart';
import 'package:chatty/shared/components/components.dart';
import 'package:chatty/shared/components/constants.dart';
import 'package:chatty/shared/styels/FA5.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is NewPostState) {
          navigatTO(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(FA5.bell),
              ),
              IconButton(
                onPressed: () {
                  signOut(context);
                },
                icon: const Icon(FA5.power_off),
              ),
            ],
          ),
          // body: ConditionalBuilder(
          //   condition: SocialCubit.get(context).model != null,
          //   builder: (context) {

          //     return Column(
          //       children: [
          //         if (!FirebaseAuth.instance.currentUser!.emailVerified)
          //           Container(
          //             color: Colors.amber.withOpacity(.7),
          //             child: Padding(
          //               padding: const EdgeInsets.all(10.0),
          //               child: Row(
          //                 children: [
          //                   Icon(Icons.warning),
          //                   SizedBox(
          //                     width: 10,
          //                   ),
          //                   Expanded(child: Text('please verify your account')),
          //                   Spacer(),
          //                   TextButton(
          //                     onPressed: () {
          //                       FirebaseAuth.instance.currentUser
          //                           ?.sendEmailVerification()
          //                           .then((value) {
          //                         showToast(
          //                             msg: 'Check your mail',
          //                             color: Colors.green);
          //                       }).catchError((error) {});
          //                     },
          //                     child: Text('SEND'),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //       ],
          //     );
          //   },
          //   fallback: (context) => Center(child: CircularProgressIndicator()),
          // ),
          body: cubit.screens[cubit.currentIndex],
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              navigatTO(context, NewPostScreen());
            },
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeNavBar(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(UniconsLine.home),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: Icon(UniconsLine.chat),
                label: 'chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(UniconsLine.users_alt),
                label: 'users',
              ),
              BottomNavigationBarItem(
                icon: Icon(UniconsLine.setting),
                label: 'settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
