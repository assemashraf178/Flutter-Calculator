import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Jannah',
        scaffoldBackgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Jannah',
            fontSize: 40.0,
            color: Colors.black,
          ),
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backwardsCompatibility: false,
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontFamily: 'Jannah',
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          bodyText2: TextStyle(
            fontFamily: 'Jannah',
            color: Colors.black,
          ),
          button: TextStyle(
            fontFamily: 'Jannah',
            color: Colors.black,
          ),
          headline1: TextStyle(
            fontFamily: 'Jannah',
            color: Colors.black,
          ),
          caption: TextStyle(
            fontFamily: 'Jannah',
            color: Colors.black,
          ),
          overline: TextStyle(
            fontFamily: 'Jannah',
            color: Colors.black,
          ),
          headline2: TextStyle(
            fontFamily: 'Jannah',
            color: Colors.black,
          ),
          headline3: TextStyle(
            fontFamily: 'Jannah',
            color: Colors.black,
          ),
          headline4: TextStyle(
            fontFamily: 'Jannah',
            color: Colors.black,
          ),
          headline5: TextStyle(
            fontFamily: 'Jannah',
            color: Colors.black,
          ),
          headline6: TextStyle(
            fontFamily: 'Jannah',
            color: Colors.black,
          ),
          subtitle1: TextStyle(
            fontFamily: 'Jannah',
            color: Colors.black,
          ),
          subtitle2: TextStyle(
            fontFamily: 'Jannah',
            color: Colors.black,
          ),
        ),
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = '0';

  String expression = '';

  String result = '0';

  bool isOperation = false;

  bool isPoint = false;

  bool isNumber = false;

  double equationFontSize = 15.0;

  double resultFontSize = 18.0;

  Color equationColor = Colors.black;

  Color resultColor = Colors.grey;

  Widget buildButton({
    required BuildContext context,
    required String text,
    Color color = Colors.black,
    double? fontSize,
  }) =>
      Container(
        child: MaterialButton(
          onPressed: () {
            setState(() {
              if (text == '⌫') {
                if (equation != '0')
                  equation = equation.substring(0, equation.length - 1);
                if (isOperation) isOperation = false;
                if (isPoint && !isNumber) isPoint = false;
                if (equation == '') {
                  isPoint = false;
                  isOperation = false;
                  isNumber = false;
                }
                equationFontSize = 15.0;
                resultFontSize = 18.0;
                equationColor = Colors.black;
                resultColor = Colors.grey;
              } else if (text == 'C') {
                equationFontSize = 15.0;
                resultFontSize = 18.0;
                equation = '0';
                result = '0';
                equationColor = Colors.black;
                resultColor = Colors.grey;
              } else if (text == '=') {
                expression = equation;
                isPoint = true;
                isOperation = false;
                equationFontSize = 18.0;
                resultFontSize = 15.0;
                equationColor = Colors.grey;
                resultColor = Colors.black;
                expression = expression.replaceAll('×', '*');
                expression = expression.replaceAll('÷', '/');
                expression = expression.replaceAll('−', '-');
                try {
                  Parser p = Parser();
                  Expression exp = p.parse(expression);
                  ContextModel cm = ContextModel();
                  result = '${exp.evaluate(EvaluationType.REAL, cm)}';
                  equation = result;
                } catch (e) {
                  print(e.toString());
                  result = 'Error';
                }
              } else {
                if (equation == '0') {
                  equation = '';
                }
                if ((text == '+' ||
                        text == '÷' ||
                        text == '×' ||
                        text == '%' ||
                        text == '−') &&
                    equation != '0' &&
                    equation != '') {
                  if (!isOperation) {
                    print(isOperation);
                    isOperation = true;
                    isPoint = false;
                    isNumber = false;
                    equation += text;
                    equationFontSize = 15.0;
                    resultFontSize = 18.0;
                    equationColor = Colors.black;
                    resultColor = Colors.grey;
                  }
                } else if (text == '.') {
                  if (!isPoint) {
                    isPoint = true;
                    isNumber = false;
                    equation += text;
                  } else if (equation == '') isPoint = false;
                } else {
                  isOperation = false;
                  isNumber = true;
                  equation += text;
                  equationFontSize = 15.0;
                  resultFontSize = 18.0;
                  equationColor = Colors.black;
                  resultColor = Colors.grey;
                }
              }
            });
          },
          height: double.infinity,
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: color,
                  fontSize:
                      fontSize ?? MediaQuery.of(context).size.height / 25.0,
                ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black,
          size: MediaQuery.of(context).size.height / 27.0,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.white,
        titleSpacing: 0.0,
        titleTextStyle: TextStyle(
          fontFamily: 'Jannah',
          fontSize: MediaQuery.of(context).size.height / 27.0,
          color: Colors.black,
        ),
        title: Row(
          children: [
            Spacer(),
            Icon(
              Icons.calculate_rounded,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 30.0,
            ),
            Text(
              'Calculator',
            ),
            Spacer(),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: (MediaQuery.of(context).size.width) / 40),
                    alignment: Alignment.bottomRight,
                    child: AutoSizeText(
                      equation,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height /
                            equationFontSize,
                        color: equationColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: (MediaQuery.of(context).size.width) / 40),
                    alignment: Alignment.topRight,
                    child: AutoSizeText(
                      result,
                      style: TextStyle(
                        fontSize:
                            MediaQuery.of(context).size.height / resultFontSize,
                        color: resultColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.teal.withOpacity(0.05),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: buildButton(
                            text: 'C',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '%',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '⌫',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '÷',
                            context: context,
                            color: Colors.lightBlueAccent,
                            fontSize: MediaQuery.of(context).size.height / 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: buildButton(
                            text: '7',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '8',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '9',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '×',
                            context: context,
                            fontSize: MediaQuery.of(context).size.height / 16.0,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: buildButton(
                            text: '4',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '5',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '6',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '−',
                            context: context,
                            fontSize: MediaQuery.of(context).size.height / 16.0,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: buildButton(
                            text: '1',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '2',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '3',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '+',
                            context: context,
                            fontSize: MediaQuery.of(context).size.height / 16.0,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: buildButton(
                            text: '00',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '0',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '.',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '=',
                            context: context,
                            fontSize: MediaQuery.of(context).size.height / 16.0,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
