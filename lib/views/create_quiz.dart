import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_quiz/services/database.dart';
import 'package:new_quiz/views/addQuestion.dart';
import 'package:new_quiz/views/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({Key? key}) : super(key: key);

  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final form_key = GlobalKey<FormState>();
  late String quizImageURL, quizTitle, quizDescription, quizId;
  DatabaseServices databaseServices = new DatabaseServices();

  bool isLoading = false;

  createOnlineQuiz() async {
    if (form_key.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      quizId = randomAlphaNumeric(16);
      Map<String, String> quizMap = {
        "quizid": quizId,
        "quizImageUrl": quizImageURL,
        "quizTitle": quizTitle,
        "quizDescription": quizDescription
      };
      await databaseServices
          .addQuizDataToFirebase(quizMap, quizId)
          .then((value) {
        setState(() {
          isLoading = false;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => AddQuestion(quizId: quizId)));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //scaffold but issue of straightness
    return Scaffold(
      appBar: AppBar(
          title: appBar(context),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.deepPurple),
          systemOverlayStyle: SystemUiOverlayStyle.light),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: form_key,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? "Enter Image URL" : null,
                      decoration: InputDecoration(
                          hintText: "Quiz Image or URL (optional)"),
                      onChanged: (value) {
                        quizImageURL = value;
                      },
                    ),
                    SizedBox(height: 6),
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? "Enter Quiz Title" : null,
                      decoration: InputDecoration(hintText: "Quiz Title"),
                      onChanged: (value) {
                        quizTitle = value;
                      },
                    ),
                    SizedBox(height: 6),
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? "Enter Quiz Description" : null,
                      decoration: InputDecoration(hintText: "Quiz Description"),
                      onChanged: (value) {
                        quizDescription = value;
                      },
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        createOnlineQuiz();
                      },
                      child: myButton(
                          context: context,
                          label: "Create Quiz",
                          buttonColor: Colors.deepPurple),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
