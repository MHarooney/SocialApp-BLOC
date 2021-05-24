import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mysocially/models/user_model.dart';
import 'package:mysocially/modules/chats/chats_screen.dart';
import 'package:mysocially/modules/feeds/feeds_screen.dart';
import 'package:mysocially/modules/settings/settings_screen.dart';
import 'package:mysocially/modules/users/users_screen.dart';
import 'package:mysocially/network/local/cache_helper.dart';
import 'package:mysocially/shared/components/constants.dart';
import 'package:mysocially/shared/cubit/states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  UserModel userModel;

  void getUserData() {
    emit(AppGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      // print(value.data());
      userModel = UserModel.fromJson(value.data());
      emit(
        AppGetUserSuccessState(),
      );
    }).catchError((error) {
      print(error.toString());
      emit(
        AppGetUserErrorState(
          error.toString(),
        ),
      );
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Users',
    'Settings',
  ];

  ScrollController scrollController =
      ScrollController(); // set controller on scrolling
  bool show = true;

  void hideBottomWidget() {
    show = false;
    emit(AppHideBottomWidgetState());
  }

  void showBottomWidget() {
    show = true;
    emit(AppShowBottomWidgetState());
  }

  void handleScroll() async {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideBottomWidget();
        emit(AppHandleReverseHideBottomWidgetState());
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        showBottomWidget();
        emit(AppHandleForwardHideBottomWidgetState());
      }
    });
  }

  void changeBottomNavIndex(int index) {
    currentIndex = index;
    if (index == 2) emit(state);
    emit(AppChangeBottomNavBarState());
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    @required bool isShow,
    @required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;

    emit(AppChangeBottomSheetState());
  }

  bool isDark = false;

  void changeAppMode({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  File profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(AppProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(AppProfileImagePickedErrorState());
    }
  }

  File coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(AppCoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(AppCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    @required String name,
    @required String phone,
    @required String bio,
  }) {
    emit(AppUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(AppUploadProfileImageSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        emit(AppUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(AppUploadProfileImageErrorState());
    });
  }

  void uploadCoverImages({
    @required String name,
    @required String phone,
    @required String bio,
  }) {
    emit(AppUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(AppUploadCoverImageSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        emit(AppUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(AppUploadCoverImageErrorState());
    });
  }

  // void updateUserImage({
  //   @required String name,
  //   @required String phone,
  //   @required String bio,
  // }) {
  //   emit(AppUserUpdateLoadingState());
  //   if (coverImage != null) {
  //     uploadCoverImages();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (coverImage != null && profileImage != null) {
  //   } else {
  //     updateUser(
  //       name: name,
  //       phone: phone,
  //       bio: bio,
  //     );
  //   }
  // }

  void updateUser({
    @required String name,
    @required String phone,
    @required String bio,
    String cover,
    String image,
  }) {
    UserModel model = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel.email,
      cover: cover ?? userModel.cover,
      image: image ?? userModel.image,
      uId: userModel.uId,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(AppUserUpdateErrorState());
    });
  }
}

//image_picker741202348134153624.jpg