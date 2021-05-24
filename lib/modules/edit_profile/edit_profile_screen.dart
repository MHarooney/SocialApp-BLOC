import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mysocially/shared/components/components.dart';
import 'package:mysocially/shared/cubit/cubit.dart';
import 'package:mysocially/shared/cubit/states.dart';
import 'package:mysocially/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = AppCubit
            .get(context)
            .userModel;
        var profileImage = AppCubit
            .get(context)
            .profileImage;
        var coverImage = AppCubit
            .get(context)
            .coverImage;

        nameController.text = userModel.name;
        phoneController.text = userModel.phone;
        bioController.text = userModel.bio;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              defaultTextButton(
                function: () {
                  AppCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                },
                text: 'Update',
              ),
              SizedBox(
                width: 15.0,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is AppUserUpdateLoadingState)
                    LinearProgressIndicator(),
                  if (state is AppUserUpdateLoadingState)
                    SizedBox(
                      height: 10.0,
                    ),
                  Container(
                    height: 190.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 140.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage == null
                                        ? NetworkImage(
                                      '${userModel.cover}',
                                    )
                                        : FileImage(coverImage),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                radius: 20,
                                child: IconButton(
                                  onPressed: () {
                                    AppCubit.get(context).getCoverImage();
                                  },
                                  icon: Icon(
                                    IconBroken.Camera,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 51.0,
                              backgroundColor:
                              Theme
                                  .of(context)
                                  .scaffoldBackgroundColor,
                              child: CircleAvatar(
                                // radius: responsive.height * 0.025,
                                radius: 50.0,
                                backgroundImage: profileImage == null
                                    ? NetworkImage(
                                  '${userModel.image}',
                                )
                                    : FileImage(profileImage),
                              ),
                            ),
                            CircleAvatar(
                              radius: 20,
                              child: IconButton(
                                onPressed: () {
                                  AppCubit.get(context).getProfileImage();
                                },
                                icon: Icon(
                                  IconBroken.Camera,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if (AppCubit
                      .get(context)
                      .profileImage != null ||
                      AppCubit
                          .get(context)
                          .coverImage != null)
                    Row(
                      children: [
                        if (AppCubit
                            .get(context)
                            .profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  function: () {
                                    AppCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,);
                                  },
                                  text: 'upload profile image',
                                ),
                                if (state is AppUserUpdateLoadingState)
                                  SizedBox(height: 5.0,),
                                if (state is AppUserUpdateLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        if (AppCubit
                            .get(context)
                            .profileImage != null ||
                            AppCubit
                                .get(context)
                                .coverImage != null)
                          SizedBox(
                            width: 5.0,
                          ),
                        if (AppCubit
                            .get(context)
                            .coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  function: () {
                                    AppCubit.get(context).uploadCoverImages(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,);
                                  },
                                  text: 'upload cover image',
                                ),
                                if (state is AppUserUpdateLoadingState)
                                  SizedBox(height: 5.0,),
                                if (state is AppUserUpdateLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'name must not be empty';
                      }

                      return null;
                    },
                    label: 'Name',
                    prefix: IconBroken.User,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'bio must not be empty';
                      }

                      return null;
                    },
                    label: 'Bio',
                    prefix: IconBroken.Info_Circle,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'phone must not be empty';
                      }

                      return null;
                    },
                    label: 'Phone',
                    prefix: IconBroken.Call,
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