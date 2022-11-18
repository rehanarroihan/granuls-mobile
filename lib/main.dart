import 'package:flutter/material.dart';
import 'package:granuls/app.dart';
import 'package:granuls/main_app.dart';
import 'package:granuls/utils/url_constant_halper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  App.configure(
      apiBaseURL: UrlConstantHelper.SERVER_ADDRESS,
      appTitle: 'Granuls'
  );

  await App().init();

  runApp(const MainApp());
}
