import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_quiz/services/auth.dart';
import 'package:new_quiz/views/home.dart';
import 'package:new_quiz/views/sign_in.dart';
import 'package:new_quiz/views/widgets/widgets.dart';

import '../helper/functions.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final form_key = GlobalKey<FormState>();
  late String name, email, password;
  AuthServices authServices = new AuthServices();
  bool isLoading = false;

  signUp() async {
    if (form_key.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      authServices.signUpEmailPassword(email, password).then((value) {
        if (value != null) {
          setState(() {
            isLoading = false;
          });
          HelperFunctions.saveUserLoginDetails(isloggedIn: true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: form_key,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Spacer(),
                    Image.asset(
                      'assets/Quizzes that make you think.png',
                      alignment: Alignment.center,
                    ),
                    Spacer(),
                    TextFormField(
                      // to validator to ensure user fills in all text fields
                      validator: (value) {
                        return value!.isEmpty ? "Enter your Name" : null;
                      },
                      decoration: InputDecoration(hintText: "Name"),
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                    TextFormField(
                      // to validator to ensure user fills in all text fields
                      validator: (value) {
                        return value!.isEmpty ? "Enter your emailID" : null;
                      },
                      decoration: InputDecoration(hintText: "Email"),
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      // to validator to ensure user fills in all text fields
                      validator: (value) {
                        return value!.isEmpty ? "Enter a password" : null;
                      },
                      decoration: InputDecoration(hintText: "Password"),
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: () {
                        signUp();
                      },
                      child: myButton(
                          context: context,
                          label: "Sign Up",
                          buttonColor: Colors.indigo),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account ",
                          style: GoogleFonts.raleway(),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()));
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.indigo,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
