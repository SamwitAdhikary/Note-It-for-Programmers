import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_it/config/palette.dart';

import 'UI/screens/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Palette.scaffold,
          fontFamily: GoogleFonts.poppins().fontFamily),
    );
  }
}
