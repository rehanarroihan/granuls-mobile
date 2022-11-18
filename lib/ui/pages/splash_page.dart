import 'package:flutter/material.dart';
import 'package:granuls/app.dart';
import 'package:granuls/ui/pages/main/main_menu_page.dart';
import 'package:granuls/utils/constant_helper.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(microseconds: 1)).then((_) async {
      bool isLoggedIn =
          App().prefs.getBool(ConstantHelper.PREFS_IS_USER_LOGGED_IN) ?? false;
      if (isLoggedIn) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainMenuPage()),
            (Route<dynamic> route) => false);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
