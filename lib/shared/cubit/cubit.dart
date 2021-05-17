import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysocially/models/user_model.dart';
import 'package:mysocially/modules/chats/chats_screen.dart';
import 'package:mysocially/modules/feeds/feeds_screen.dart';
import 'package:mysocially/modules/settings/settings_screen.dart';
import 'package:mysocially/modules/users/users_screen.dart';
import 'package:mysocially/network/local/cache_helper.dart';
import 'package:mysocially/shared/components/constants.dart';
import 'package:mysocially/shared/cubit/states.dart';

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
}