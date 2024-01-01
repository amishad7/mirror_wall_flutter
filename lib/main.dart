import 'package:flutter/material.dart';
import 'package:mirror_wall_flutter_project/Modules/views/Homescreen/Proivder/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Modules/views/Homescreen/views/home.dart';
import 'Modules/views/introductionscreens/views/one_time_intro_screen/intro_screen.dart';
import 'Modules/views/introductionscreens/views/splashscreen.dart';

import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();

  bool isVisited = preferences.getBool('isVisited') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ListenableProvider(
          create: (context) => WebProvider(),
        ),
      ],
      builder: (ctx, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'intro',
        routes: {
          'intro': (context) => const SplashScreen_(),
          'visit': (context) => const one_time_intro_screen(),
          'home': (context) => Mybrowser(),
        },
      ),
    ),
  );
}
