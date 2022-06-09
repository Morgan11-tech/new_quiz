import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  Future<void> addQuizDataToFirebase(
      Map<String, dynamic> quizData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .set(quizData, SetOptions(merge: true))
        .catchError((e) {
      print(e.toString);
    });
  }

  Future<void> addQuestionDataToFirebase(
      Map<String, dynamic> questionData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection("QuestionsAndAnswers")
        .add(questionData)
        .catchError((e) {
      print(e);
    });
  }

  getQuizData() async {
    return await FirebaseFirestore.instance.collection("Quiz").snapshots();
  }
}
