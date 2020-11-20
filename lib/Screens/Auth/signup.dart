import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var isPasswordVisible = false;
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  FirebaseAuth _mAuth;
  String userName;
  String password;
  String email;
  String confirmPassword;
  ProgressDialog progressDialog;

  var isPasswordValid = true;
  var isUserNameIsValid = true;
  var isConPasswordValid = true;
  var isEmailIsValid = true;

  @override
  void initState() {
    // TODO: implement initState
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
                        errorText: isUserNameIsValid
                            ? null
                            : "Please Enter Valid Username",
                        prefixIcon: Icon(
                          Icons.supervisor_account,
                          size: 30.0,
                        ),
                        hintText: 'Enter your First And Last Name'),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorText:
                            isEmailIsValid ? null : "Please Enter Valid Email",
                        prefixIcon: Icon(
                          Icons.email,
                          size: 30.0,
                        ),
                        hintText: 'Enter your Email'),
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
                        errorText: isPasswordValid
                            ? null
                            : "Please Enter Valid Password",
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
                    height: 10.0,
                  ),
                  TextFormField(
                      controller: confirmPasswordController,
                      obscureText: isPasswordVisible,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorText: isConPasswordValid
                            ? null
                            : "Please Enter Valid Password",
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 30.0,
                        ),
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
                        hintText: 'Confirm  your password',
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text('Register'),
                    onPressed: () {
                      _registerUser();
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
                          'Dont have account?',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                        ),
                        FlatButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            textColor: Colors.blue,
                            child: Text(
                              'Login',
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

  Future<void> _registerUser() async {
    userName = nameController.text;
    password = passwordController.text;
    confirmPassword = confirmPasswordController.text;
    email = emailController.text;

    if (userName.isEmpty) {
      isUserNameIsValid = false;
      setState(() {});
    } else if (email.isEmpty) {
      isEmailIsValid = false;
      setState(() {});
    }

    if (password.isEmpty) {
      isPasswordValid = false;
      setState(() {});
    } else if (confirmPassword.isEmpty && !password.contains(confirmPassword)) {
      isConPasswordValid = false;
      setState(() {});
    } else {
      progressDialog.show();

      _mAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                progressDialog.isShowing() ? progressDialog.hide() : null,
                Toast.show("Register User Successful", context, duration: 4),
                Navigator.pushReplacementNamed(context, '/profile')
              })
          .catchError((error) => {
                progressDialog.isShowing() ? progressDialog.hide() : null,
                Toast.show(error, context, duration: 4)
              });
    }
  }
}
