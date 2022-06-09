import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_quiz/helper/functions.dart';
import 'package:new_quiz/views/home.dart';
import 'package:new_quiz/views/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isloggedIn = false;

  // This widget is the root of your application.
  @override
  void initState() {
    checkUserLoginStatus();
    super.initState();
  }

  checkUserLoginStatus() async {
    HelperFunctions.getUserLoginDetails().then((value) {
      setState(() {
        isloggedIn = value!;
      });
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.ralewayTextTheme()),
      home: isloggedIn ? Home() : SignIn(),
    );
  }
}
