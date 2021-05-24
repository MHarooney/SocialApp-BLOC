abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppGetUserLoadingState extends AppStates {}

class AppGetUserSuccessState extends AppStates {}

class AppGetUserErrorState extends AppStates {
  final String error;

  AppGetUserErrorState(this.error);
}

class AppChangeBottomNavBarState extends AppStates {}

class AppChangeBottomSheetState extends AppStates {}

class AppChangeModeState extends AppStates {}

class AppHandleReverseHideBottomWidgetState extends AppStates {}

class AppHandleForwardHideBottomWidgetState extends AppStates {}

class AppHideBottomWidgetState extends AppStates {}

class AppShowBottomWidgetState extends AppStates {}

class AppNewPostState extends AppStates {}

class AppProfileImagePickedSuccessState extends AppStates {}

class AppProfileImagePickedErrorState extends AppStates {}

class AppCoverImagePickedSuccessState extends AppStates {}

class AppCoverImagePickedErrorState extends AppStates {}

class AppUploadProfileImageSuccessState extends AppStates {}

class AppUploadProfileImageErrorState extends AppStates {}

class AppUploadCoverImageSuccessState extends AppStates {}

class AppUploadCoverImageErrorState extends AppStates {}

class AppUserUpdateLoadingState extends AppStates {}

class AppUserUpdateErrorState extends AppStates {}