import 'package:budgetplanner/Screens/Auth/signup.dart';
import 'package:budgetplanner/Screens/Auth/userprofile.dart';
import 'package:budgetplanner/Screens/Auth/login.dart';
import 'package:budgetplanner/Screens/Base/index.dart';
import 'package:budgetplanner/Screens/addexpence.dart';
import 'package:budgetplanner/Screens/splash.dart';
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
    super.initState();

    initializeDefault();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
         brightness: Brightness.light,
        primaryColor: Colors.pink,
        accentColor: Colors.pinkAccent,
     
     
      ),
     
     
      initialRoute: '/',
      routes: {
        '/' : (context) => Splash(),
        '/login': (context) => Login(),
        '/signup': (context) => SignUp(),
        '/profile': (context) => UserProfile(),
        '/home': (context) => Index(),
        '/addexpense' :(context) => AddExpense()
      
      },
    );
  }
}
