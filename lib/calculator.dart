import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = "";
  String result = "0";

  List<String> buttonsList = [
    'C',
    '+/-',
    '%',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'AC',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Flexible(
              flex: 1,
              child: resultWidget(),
            ),
            Flexible(
              flex: 2,
              child: buttonWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget resultWidget() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerRight,
          child: Text(
            userInput,
            style: const TextStyle(fontSize: 32),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerRight,
          child: Text(
            result,
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget buttonWidget() {
    return GridView.builder(
      itemCount: buttonsList.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemBuilder: (BuildContext context, int index) {
        return button(buttonsList[index]);
      },
    );
  }

  Widget button(String text) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: MaterialButton(
        onPressed: () {
          setState(() {
            handleButtonpress(text);
          });
        },
        color: getColor(text),
        textColor: Colors.white,
        shape: const CircleBorder(),
        child: Text(
          text,
          style: const TextStyle(fontSize: 25),
        ),
      ),
    );
  }

  handleButtonpress(String text) {
    if (text == "AC") {
      // Reset all
      userInput = "";
      result = "0";
      return;
    }

    if (text == "C") {
      // Reset all
      userInput = userInput.substring(0, userInput.length - 1);
      return;
    }

    if (text == "=") {
      result = calculate();
      return;
    }

    if (text == "%") {
      userInput += '/100';
      return;
    }

    if (text == "+/-") {
      if (userInput.isNotEmpty) {
        if (userInput[0] == '-') {
          userInput = userInput.substring(1);
        } else {
          userInput = '-' + userInput;
        }
      }
      return;
    }

    userInput = userInput + text;
  }

  String calculate() {
    try {
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "Error";
    }
  }

  getColor(String text) {
    if (text == "/" ||
        text == "*" ||
        text == "+" ||
        text == "-" ||
        text == "=" ||
        text == "+/-" ||
        text == "%") {
      return Colors.orangeAccent;
    }
    if (text == "C" || text == "AC") {
      return const Color.fromARGB(255, 44, 44, 44);
    }
    return const Color.fromARGB(255, 95, 95, 95);
  }
}
