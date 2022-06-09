import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_quiz/models/user.dart';

class AuthServices {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Usser? _userFromFirebaseUser(User user) {
    // ignore: unnecessary_null_comparison
    return user != null ? Usser(uId: user.uid) : null;
  }

  Future signInEmailPassword(String email, String password) async {
    try {
      UserCredential userCred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? fUser = userCred.user;
      return _userFromFirebaseUser(fUser!);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? fUser = userCredential.user;
      return _userFromFirebaseUser(fUser!);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
//   // for signing up
//   Future<String?> signUp(
//       {required String email, required String password}) async {
//     try {
//       await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       return "Account created";
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         return 'The password provided is too weak.';
//       } else if (e.code == 'email-already-in-use') {
//         return 'The account already exists for that email.';
//       }
//     }
//   }
//
//   // for signing in
//   Future<String?> signIn(
//       {required String email, required String password}) async {
//     try {
//       await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       return "Welcome";
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         return 'No user was found for that email';
//       } else if (e.code == 'wrong-password') {
//         return 'Wrong password';
//       }
//     }
//   }
//
//   // reset password
//   Future<String> resetPassword({required String email}) async {
//     try {
//       await _auth.sendPasswordResetEmail(
//         email: email,
//       );
//       return "Email sent";
//     } catch (e) {
//       return "Error occurred";
//     }
//   }
//
// // sign out user
//   void signOut() {
//     _auth.signOut();
//   }
// }
