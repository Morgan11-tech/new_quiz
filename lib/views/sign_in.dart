import 'package:flutter/material.dart';
import 'package:new_quiz/helper/functions.dart';
import 'package:new_quiz/services/auth.dart';
import 'package:new_quiz/views/sign_up.dart';
import 'package:new_quiz/views/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final form_key = GlobalKey<FormState>();
  late String email, password;
  bool isLoading = false;
  AuthServices authServices = new AuthServices();

  signIn() async {
    if (form_key.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await authServices.signInEmailPassword(email, password).then((value) {
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
        brightness: Brightness.light,
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
                    SizedBox(
                      height: 50,
                    ),
                    //temporary network image
                    Image.asset(
                      'assets/Quizzes that make you think.png',
                      alignment: Alignment.center,
                    ),

                    // Spacer(),
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
                        signIn();
                      },
                      child: myButton(
                          context: context,
                          label: "Sign In",
                          buttonColor: Colors.deepPurple),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: GoogleFonts.raleway(),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          child: Text(
                            "Sign Up",
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
