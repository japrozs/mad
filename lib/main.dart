import 'package:flutter/material.dart';

void main() => runApp(const CalculatorApp());

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  // theme toggle feature
  bool _isDark = true;

  // state mgmt
  String _display = '0';
  int? _first;
  String? _operator;
  bool _justEvaluated = false;
  bool _isError = false;

  void _clearAll() {
    setState(() {
      _display = '0';
      _first = null;
      _operator = null;
      _justEvaluated = false;
      _isError = false;
    });
  }

  void _clearEntry() {
    setState(() {
      _display = '0';
      _isError = false;
    });
  }

  bool get _shouldShowAC =>
      _display == '0' && _first == null && _operator == null;

  // err hanfling
  void _setError(String message) {
    setState(() {
      _display = message;
      _isError = true;
      _first = null;
      _operator = null;
      _justEvaluated = false;
    });
  }

  // input logic
  void _appendDigit(String digit) {
    if (_isError) _clearAll();

    setState(() {
      if (_justEvaluated) {
        _display = digit;
        _justEvaluated = false;
      } else if (_display == '0') {
        _display = digit;
      } else {
        _display += digit;
      }
    });
  }

  void _setOperator(String op) {
    if (_isError) return;

    final current = int.tryParse(_display);
    if (current == null) {
      _setError('Error');
      return;
    }

    setState(() {
      _first = current;
      _operator = op;
      _justEvaluated = true;
    });
  }

  int? _calculate(int a, int b, String op) {
    switch (op) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case '×':
        return a * b;
      case '÷':
        if (b == 0) {
          _setError('Cannot divide by 0');
          return null;
        }
        return a ~/ b; // integer division
      default:
        _setError('Error');
        return null;
    }
  }

  void _evaluate() {
    if (_isError) return;

    if (_first == null || _operator == null) {
      _setError('Incomplete input');
      return;
    }

    final second = int.tryParse(_display);
    if (second == null) {
      _setError('Error');
      return;
    }

    final result = _calculate(_first!, second, _operator!);
    if (result == null) return;

    setState(() {
      _display = result.toString();
      _first = null;
      _operator = null;
      _justEvaluated = true;
      _isError = false;
    });
  }

  // ui
  @override
  Widget build(BuildContext context) {
    final lightTheme = ThemeData.light();
    final darkTheme = ThemeData.dark();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Calculator"),
          actions: [
            IconButton(
              icon: Icon(_isDark ? Icons.dark_mode : Icons.light_mode),
              onPressed: () {
                setState(() {
                  _isDark = !_isDark;
                });
              },
            ),
          ],
        ),
        body: Column(
          children: [
            _buildDisplay(),
            Expanded(child: _buildButtons()),
          ],
        ),
      ),
    );
  }

  Widget _buildDisplay() {
    return Container(
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.all(24),
      child: Text(
        _display,
        style: TextStyle(fontSize: 48, color: _isError ? Colors.red : null),
      ),
    );
  }

  Widget _buildButtons() {
    final buttons = [
      _shouldShowAC ? 'AC' : 'C',
      '±',
      ' ',
      '÷',
      '7',
      '8',
      '9',
      '×',
      '4',
      '5',
      '6',
      '-',
      '1',
      '2',
      '3',
      '+',
      '0',
      '=',
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        // total rows = 5 (top row + 3 middle rows + last row)
        // total columns = 4
        return GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(12),
          crossAxisCount: 4,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.25,
          children: buttons.map((label) {
            if (label == ' ') return const SizedBox();

            return ElevatedButton(
              onPressed: () => _handleButton(label),
              child: Text(label, style: const TextStyle(fontSize: 22)),
            );
          }).toList(),
        );
      },
    );
  }

  void _handleButton(String label) {
    if (RegExp(r'^\d$').hasMatch(label)) {
      _appendDigit(label);
      return;
    }

    switch (label) {
      case '+':
      case '-':
      case '×':
      case '÷':
        _setOperator(label);
        break;
      case '=':
        _evaluate();
        break;
      case 'C':
        _clearEntry();
        break;
      case 'AC':
        _clearAll();
        break;
      case '±':
        if (_display != '0') {
          setState(() {
            if (_display.startsWith('-')) {
              _display = _display.substring(1);
            } else {
              _display = '-$_display';
            }
          });
        }
        break;
    }
  }
}
