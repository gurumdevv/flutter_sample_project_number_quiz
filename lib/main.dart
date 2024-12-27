import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

/// 홈 페이지
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String quiz = "";

  @override
  void initState() {
    //iniState에서는 직접 async/await를 사용할 수 없음 -> 함수를 만들어서 함수를 호출해야함
    super.initState();
    // StatefulWidget의 라이프사이클 메서드 중 하나로,
    // 위젯이 처음 생성될 때 호출됨.
    // 초기화 작업이 필요한 경우 이 메서드에서 수행됨.
    getQuiz();
  }

  ///퀴즈 가져오기
  void getQuiz() async {
    String trivia = await getNumberTrivia();
    //setState 안에서는 async/await를 사용할 수 없음
    setState(() {
      quiz = trivia;
    });
  }

  Future<String> getNumberTrivia() async {
    Response result = await Dio().get('http://numbersapi.com/random/trivia');
    String trivia = result.data;
    print(trivia);
    return trivia;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.pinkAccent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // quiz
            Expanded(
              child: Center(
                child: Text(
                  quiz,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // New Quiz 버튼
            SizedBox(
              height: 42,
              child: ElevatedButton(
                child: Text(
                  "New Quiz",
                  style: TextStyle(
                    color: Colors.pinkAccent,
                    fontSize: 24,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.white),
                ),
                onPressed: () {
                  // New Quiz 클릭시 퀴즈 가져오기
                  getQuiz();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
