import 'package:budgetplanner/Screens/Auth/signup.dart';
import 'package:budgetplanner/Screens/Auth/userprofile.dart';
import 'package:budgetplanner/Screens/home.dart';
import 'package:budgetplanner/Screens/Auth/login.dart';
import 'package:budgetplanner/Screens/newhome.dart';
import 'package:budgetplanner/Screens/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDefault();

  runApp(MyApp());
}

Future<void> initializeDefault() async {
  FirebaseApp app = await Firebase.initializeApp();
  assert(app != null);
}



class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initializeDefault();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/' : (context) => Splash(),
        '/login': (context) => Login(),
        '/signup': (context) => SignUp(),
        '/profile': (context) => UserProfile(),
        '/home': (context) => Home(),
        '/newhome': (context) => NewHome(),
      },
    );
  }
}
