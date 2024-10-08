import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _output = "0";
  String _expression = "";

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _expression = "";
      } else if (buttonText == "=") {
        try {
          final expression = Expression.parse(_expression);
          final evaluator = const ExpressionEvaluator();
          final result = evaluator.eval(expression, {});
          _output = result.toString();
        } catch (e) {
          _output = "Error";
        }
      } else if (buttonText == "x²") {
        try {
          final num = double.parse(_output);
          final result = num * num;
          _output = result.toString();
          _expression = result.toString();
        } catch (e) {
          _output = "Error";
        }
      } else if (buttonText == "√") {
        try {
          final num = double.parse(_output);
          final result = sqrt(num);
          _output = result.toString();
          _expression = result.toString();
        } catch (e) {
          _output = "Error";
        }
      } else {
        if (_output == "0" && buttonText != ".") {
          _output = buttonText;
        } else {
          _output += buttonText;
        }
        _expression += buttonText;
      }
    });
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(24.0),
        ),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () => _buttonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              _output,
              style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              Row(
                children: [
                  _buildButton("7"),
                  _buildButton("8"),
                  _buildButton("9"),
                  _buildButton("/"),
                ],
              ),
              Row(
                children: [
                  _buildButton("4"),
                  _buildButton("5"),
                  _buildButton("6"),
                  _buildButton("*"),
                ],
              ),
              Row(
                children: [
                  _buildButton("1"),
                  _buildButton("2"),
                  _buildButton("3"),
                  _buildButton("-"),
                ],
              ),
              Row(
                children: [
                  _buildButton("."),
                  _buildButton("0"),
                  _buildButton("00"),
                  _buildButton("+"),
                ],
              ),
              Row(
                children: [
                  _buildButton("x²"),
                  _buildButton("√"),
                  _buildButton("C"),
                  _buildButton("="),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
