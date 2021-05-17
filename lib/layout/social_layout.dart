import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysocially/modules/new_post/new_post_screen.dart';
import 'package:mysocially/shared/components/components.dart';
import 'package:mysocially/shared/cubit/cubit.dart';
import 'package:mysocially/shared/cubit/states.dart';
import 'package:mysocially/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(IconBroken.Notification),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(IconBroken.Search),
              ),
            ],
          ),
          // body: ConditionalBuilder(
          //   condition: cubit.model != null,
          //   builder: (context) {
          //     var model = AppCubit.get(context).model;
          //     return Column(
          //       children: [
          //         if (!FirebaseAuth.instance.currentUser.emailVerified)
          //           Container(
          //             color: Colors.amber.withOpacity(0.6),
          //             child: LayoutBuilder(builder: (context, constraints) {
          //               return Row(
          //                 children: [
          //                   Expanded(
          //                     child: Icon(
          //                       Icons.info_outline,
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     width: constraints.maxWidth * 0.01,
          //                   ),
          //                   Container(
          //                     width: constraints.maxWidth * 0.45,
          //                     child: Text(
          //                       'Please verify your email',
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     width: constraints.maxWidth * 0.19,
          //                   ),
          //                   Container(
          //                     width: constraints.maxWidth * 0.25,
          //                     child: defaultTextButton(
          //                       function: () {
          //                         FirebaseAuth.instance.currentUser
          //                             .sendEmailVerification()
          //                             .then((value) {
          //                           showToast(
          //                             text: 'check your mail',
          //                             state: ToastStates.SUCCESS,
          //                           );
          //                         }).catchError((error) {});
          //                       },
          //                       text: 'Send',
          //                     ),
          //                   ),
          //                 ],
          //               );
          //             }),
          //           ),
          //
          //       ],
          //     );
          //   },
          //   fallback: (context) => Center(
          //     child: CircularProgressIndicator(),
          //   ),
          // ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: AnimatedOpacity(
            opacity: cubit.show ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Chat), label: 'Chat'),
                // BottomNavigationBarItem(
                //     icon: Icon(IconBroken.Paper_Upload,), label: 'Post'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Location), label: 'Location'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Setting), label: 'Settings'),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: AnimatedOpacity(
            opacity: cubit.show ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child: FloatingActionButton(
              onPressed: () {
                navigateTo(
                  context,
                  NewPostScreen(),
                );
              },
              tooltip: 'Post',
              child: Icon(
                IconBroken.Paper_Upload,
                color: Colors.white,
              ),
              elevation: 2.0,
            ),
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () { },
          //   tooltip: 'Post',
          //   child: Icon(IconBroken.Paper_Upload, color: Colors.white,),
          //   elevation: 2.0,
          // ),
        );
      },
    );
  }
}