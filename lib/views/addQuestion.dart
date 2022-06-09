import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_quiz/services/database.dart';
import 'package:new_quiz/views/widgets/widgets.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;

  const AddQuestion({Key? key, required this.quizId}) : super(key: key);

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final form_key = GlobalKey<FormState>();
  late String question, option1, option2, option3, option4;
  bool isLoading = false;

  DatabaseServices databaseServices = new DatabaseServices();

  uploadQuestionData() async {
    if (form_key.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      Map<String, String> questionMap = {
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4,
      };
      await databaseServices
          .addQuestionDataToFirebase(questionMap, widget.quizId)
          .then((value) {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) =>
                            value!.isEmpty ? "Enter Question" : null,
                        decoration: InputDecoration(hintText: "Question"),
                        onChanged: (value) {
                          question = value;
                        },
                      ),
                      SizedBox(height: 6),
                      TextFormField(
                        validator: (value) =>
                            value!.isEmpty ? "Enter Option 1" : null,
                        decoration: InputDecoration(
                            hintText: "Option 1(correct answer)"),
                        onChanged: (value) {
                          option1 = value;
                        },
                      ),
                      SizedBox(height: 6),
                      TextFormField(
                        validator: (value) =>
                            value!.isEmpty ? "Enter Option 2" : null,
                        decoration: InputDecoration(hintText: "Option 2"),
                        onChanged: (value) {
                          option2 = value;
                        },
                      ),
                      SizedBox(height: 6),
                      TextFormField(
                        validator: (value) =>
                            value!.isEmpty ? "Enter Option 3" : null,
                        decoration: InputDecoration(hintText: "Option 3"),
                        onChanged: (value) {
                          option3 = value;
                        },
                      ),
                      SizedBox(height: 6),
                      TextFormField(
                        validator: (value) =>
                            value!.isEmpty ? "Enter Option 4" : null,
                        decoration: InputDecoration(hintText: "Option 4"),
                        onChanged: (value) {
                          option4 = value;
                        },
                      ),
                      Spacer(),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              uploadQuestionData();
                            },
                            child: myButton(
                                context: context,
                                label: "Add Question",
                                buttonWidth:
                                    MediaQuery.of(context).size.width / 2 - 36,
                                buttonColor: Colors.amber[700]),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: myButton(
                                context: context,
                                label: "Submit",
                                buttonWidth:
                                    MediaQuery.of(context).size.width / 2 - 36,
                                buttonColor: Colors.deepPurple),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 60,
                      )
                    ],
                  ),
                ),
              ));
  }
}
