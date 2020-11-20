import 'package:budgetplanner/localstorage/prefrances.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {


  @override
  void initState() {
    super.initState();



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('User Profile'),),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Container(
                      width: 150.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image:  LocalPreferences.profileUrl !=null ? new NetworkImage(LocalPreferences.profileUrl) : Icons.account_circle,

                          )
                      )
                  ),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text('Logout'),
                    onPressed: () {
                      LocalPreferences.clearPreferances();
                      Navigator.pushReplacementNamed(context,'/login');
                    },
                  ),


                ],
              ),
            ),

          )),
    );
  }
}
