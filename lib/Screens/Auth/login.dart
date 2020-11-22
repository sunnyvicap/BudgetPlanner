import 'package:budgetplanner/localstorage/prefrances.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth _mAuth;

  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  String userName;
  String password;
  ProgressDialog progressDialog;
  var isPasswordVisible = false;
  var isPasswordValid = true;
  var isEmailIsValid = true;

  @override
  void initState() {
    super.initState();

    _mAuth = FirebaseAuth.instance;
    _setProgressDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(40.0, 120.0, 40.0, 0.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorText: isEmailIsValid ? null : "Please Enter Email",
                        prefixIcon: Icon(
                          Icons.email,
                          size: 30.0,
                        ),
                        hintText: 'Enter your username'),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                      controller: passwordController,
                      obscureText: isPasswordVisible,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 30.0,
                        ),
                        errorText:
                        isPasswordValid ? null : "Please Enter Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible
                                  ? isPasswordVisible = false
                                  : isPasswordVisible = true;
                            });
                          },
                        ),
                        hintText: 'Enter your password',
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  FlatButton(
                      onPressed: () {},
                      textColor: Colors.blue,
                      child: Text('Forgot Password ?')),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text('Login'),
                    onPressed: () {
                      logIn();
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Don\t have account?',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                        ),
                        FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            textColor: Colors.blue,
                            child: Text(
                              'Sign Up',
                            )),
                      ],
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }

  void _setProgressDialog() {
    progressDialog = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      textDirection: TextDirection.ltr,
      isDismissible: true,
//      customBody: CircularProgressIndicator(
//        valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
//        backgroundColor: Colors.white,
//      ),
    );

    progressDialog.style(
      message: "Please Wait....",
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      progressWidgetAlignment: Alignment.center,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
  }

  void logIn() async {
    userName = nameController.text;
    password = passwordController.text;


    if (userName.isEmpty) {
      isEmailIsValid = false;
      setState(() {});
    } else if (password.isEmpty) {
      isPasswordValid = false;

      setState(() {});
    } else {
      progressDialog.show();

      _mAuth
          .signInWithEmailAndPassword(email: userName, password: password)
          .then((value) =>
      {
        progressDialog.isShowing() ? progressDialog.hide() : null,
        Toast.show("Log In Successful", context),
        LocalPreferences.setLogin(true),
        _setLoginComplete()

      })
          .catchError((error) =>
      {
      
        progressDialog.isShowing() ? progressDialog.hide() : null,
    
      
      });
    }
  }

  _setLoginComplete() {
    var user = _mAuth.currentUser;

    if(user !=null){
      String name = user.displayName;
      String email = user.email;
      String photoUrl = user.photoURL;

      bool emailVerified = user.emailVerified;
      String phoneNumber = user.phoneNumber;
      // FirebaseUser.getIdToken() instead.
      String uid = user.uid;


      LocalPreferences.setEmail(email);
      LocalPreferences.setName(name);
      LocalPreferences.setProfileUrl(photoUrl);
      LocalPreferences.setUserId(uid);
      LocalPreferences.setEmailVarified(emailVerified);
      LocalPreferences.setPhoneNumber(phoneNumber);

      

      Navigator.pushReplacementNamed(context, '/profile');


    }
  }
}
