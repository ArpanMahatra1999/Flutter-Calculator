import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '';
  var userAnswer = '';
  final List<String> buttons= [
    'C','DEL','%','/',
    '9','8','7','*',
    '6','5','4','-',
    '3','2','1','+',
    '0','.','ANS','='
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0.0,16.0,0.0,0.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft:  Radius.circular(20.0)),
                  child: Container(
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0,0.0,8.0,0.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(userQuestion, style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                              child: Text(userAnswer, style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 16,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Color.fromRGBO(255, 255, 255, 0.75),
                  child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index){
                      if (index == 0){
                        return MyButton(
                          buttonTapped: (){
                            setState(() {
                              userQuestion = '';
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.green,
                          textColor: Colors.white,
                        );
                      }
                      else if(index == 1){
                        return MyButton(
                          buttonTapped: (){
                            setState(() {
                              userQuestion = userQuestion.substring(0,userQuestion.length - 1);
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.deepOrangeAccent,
                          textColor: Colors.white,
                        );
                      }
                      else if(index == buttons.length -2){
                        return MyButton(
                          buttonTapped:  (){
                            setState(() {
                              userQuestion = userAnswer;
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.black,
                          textColor: Colors.white,
                        );
                      }
                      else if(index == buttons.length-1){
                        return MyButton(
                          buttonTapped: (){
                            setState(() {
                              equalPressed();
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.deepPurple,
                          textColor: Colors.white,
                        );
                      }
                      else{
                        return MyButton(
                          buttonTapped: (){
                            setState(() {
                              userQuestion += buttons[index];
                            });
                          },
                          buttonText: buttons[index],
                          color: isOperator(buttons[index]) ? Colors.deepPurple : Colors.black,
                          textColor: Colors.white,
                        );
                      }
                    },
                    ),
                  ),
              ),
              ),
          ],
        ),
      ),
    );
  }
  bool isOperator(String x){
    if (x == '%' || x == '/' || x == '*' || x == '+' || x == '-' || x == '='){
      return true;
    }
    else{
      return false;
    }
  }

  void equalPressed(){
    String finalQuestion = userQuestion;
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    // Bind variables:
    ContextModel cm = ContextModel();

    // Evaluate expression:
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}
