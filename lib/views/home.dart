import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_quiz/services/database.dart';
import 'package:new_quiz/views/create_quiz.dart';
import 'package:new_quiz/views/widgets/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

//stream builder ensures that whatever changes made to firebase
// are directly reflected on the app
Stream? quizStream;
DatabaseServices databaseServices = new DatabaseServices();

class _HomeState extends State<Home> {
  var isPressed = false;
  Widget quizList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
        stream: quizStream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.data == null
              ? Container()
              : ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return QuizTile(
                      title: snapshot.data.docs[index].data()["quizTitle"],
                      description:
                          snapshot.data.docs[index].data()["quizDescription"],
                      imgUrl: snapshot.data.docs[index].data()["quizImageUrl"],
                    );
                  });
        },
      ),
    );
  }

  @override
  void initState() {
    databaseServices.getQuizData().then((value) {
      setState(() {
        quizStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: quizList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        backgroundColor: isPressed ? Colors.amber : Colors.indigo,
        // onPressed: () {},
        onPressed: () {
          setState(() => isPressed = !isPressed);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateQuiz()));
        },
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  late final String title;
  late final String imgUrl;
  late final String description;
  QuizTile(
      {required this.title, required this.description, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 9),
      height: 150,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imgUrl,
              width: MediaQuery.of(context).size.width - 48,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black26,
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  description,
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
