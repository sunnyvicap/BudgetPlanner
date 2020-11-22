
import 'package:budgetplanner/localstorage/prefrances.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
   


  var isLogin;

  @override
  void initState() {
    super.initState();

    fetchLoginActive();

  }

  fetchLoginActive() async {
    isLogin = await LocalPreferences.checkLogin();

   
 if(isLogin) {
      Navigator.pushReplacementNamed(context, '/home');
    }else{
      Navigator.pushReplacementNamed(context, '/login');

    }

    

   
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
