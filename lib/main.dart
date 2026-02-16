import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stateful Lab',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CounterWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  final TextEditingController _controller = TextEditingController();

  final List<int> _history = [];

  void _saveHistory() {
    _history.add(_counter);
  }

  void _increment() {
    _saveHistory();
    setState(() {
      if (_counter < 100) _counter++;
    });
  }

  void _decrement() {
    if (_counter == 0) return;
    _saveHistory();
    setState(() {
      _counter--;
    });
  }

  void _reset() {
    _saveHistory();
    setState(() {
      _counter = 0;
    });
  }

  void _undo() {
    if (_history.isEmpty) return;
    setState(() {
      _counter = _history.removeLast();
    });
  }

  void _setValueFromInput() {
    final String text = _controller.text.trim();
    final int? value = int.tryParse(text);

    if (value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid number.')),
      );
      return;
    }

    if (value > 100) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Limit Reached!')));
      return;
    }

    if (value < 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Value cannot be below 0.')));
      return;
    }

    _saveHistory();
    setState(() {
      _counter = value;
    });
  }

  Color _counterColor() {
    if (_counter == 0) return Colors.red;
    if (_counter > 50) return Colors.green;
    return Colors.black;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Interactive Counter')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                color: Colors.blue.shade100,
                padding: const EdgeInsets.all(20),
                child: Text(
                  '$_counter',
                  style: TextStyle(fontSize: 50.0, color: _counterColor()),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Slider(
              min: 0,
              max: 100,
              value: _counter.toDouble(),
              onChanged: (double value) {
                _saveHistory();
                setState(() {
                  _counter = value.toInt();
                });
              },
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: _decrement, child: const Text('-1')),
                const SizedBox(width: 12),
                ElevatedButton(onPressed: _increment, child: const Text('+1')),
                const SizedBox(width: 12),
                ElevatedButton(onPressed: _reset, child: const Text('Reset')),
              ],
            ),

            const SizedBox(height: 24),

            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter a number (0 - 100)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _setValueFromInput,
              child: const Text('Set Value'),
            ),

            const SizedBox(height: 16),

            ElevatedButton(onPressed: _undo, child: const Text('Undo')),
          ],
        ),
      ),
    );
  }
}
