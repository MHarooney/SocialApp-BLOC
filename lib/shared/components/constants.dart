import 'package:mysocially/modules/login/login_screen.dart';
import 'package:mysocially/network/local/cache_helper.dart';

import 'components.dart';

void signOut(context)
{
  CacheHelper.removeData(
    key: 'token',
  ).then((value)
  {
    if (value)
    {
      navigateAndFinish(
        context,
        LoginScreen(),
      );
    }
  });
}


String token = '';

String uId = '';