import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: non_constant_identifier_names
Widget appBar(BuildContext context) {
  return Container(
    alignment: Alignment.topCenter,
    child: RichText(
      text: TextSpan(
        style: GoogleFonts.raleway(fontSize: 22),
        children: const <TextSpan>[
          TextSpan(
              text: 'C&M',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 30.0,
                  color: Colors.deepPurple)),
          TextSpan(
              text: 'Quiz',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30.0,
                  color: Colors.amber)),
        ],
      ),
    ),
  );
}

Widget myButton(
    {required BuildContext context,
    required String label,
    buttonWidth,
    buttonColor}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 15),
    decoration: BoxDecoration(
        color: buttonColor, borderRadius: BorderRadius.circular(9)),
    height: 50,
    width: MediaQuery.of(context).size.width - 40,
    alignment: Alignment.center,
    child: Text(
      label,
      style: GoogleFonts.raleway(color: Colors.white, fontSize: 17),
    ),
  );
}
