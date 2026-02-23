/*
  Author: Japroz Singh Saini
*/

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rocket Launch Controller',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LaunchController(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LaunchController extends StatefulWidget {
  const LaunchController({super.key});

  @override
  State<LaunchController> createState() => _LaunchControllerState();
}

class _LaunchControllerState extends State<LaunchController> {
  int _counter = 0;
  bool _didShowLiftoffPopupForThisReach = false;

  int _clampCounter(int value) {
    if (value < 0) return 0;
    if (value > 100) return 100;
    return value;
  }

  Color _statusColorFor(int value) {
    if (value == 0) return Colors.red;
    if (value <= 50) return Colors.orange;
    return Colors.green;
  }

  Future<void> _showLiftoffDialog() async {
    if (!mounted) return;

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('🚀 Launch Successful!'),
        content: const Text('LIFTOFF! The rocket has reached full fuel (100).'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _setCounter(int newValue) {
    final int clamped = _clampCounter(newValue);
    if (clamped != 100 && _didShowLiftoffPopupForThisReach) {
      _didShowLiftoffPopupForThisReach = false;
    }

    setState(() {
      _counter = clamped;
    });

    if (_counter == 100 && !_didShowLiftoffPopupForThisReach) {
      _didShowLiftoffPopupForThisReach = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLiftoffDialog();
      });
    }
  }

  void _ignite() => _setCounter(_counter + 1);

  void _decrement() => _setCounter(_counter - 1);

  void _reset() => _setCounter(0);

  @override
  Widget build(BuildContext context) {
    final Color statusColor = _statusColorFor(_counter);

    return Scaffold(
      appBar: AppBar(title: const Text('Rocket Launch Controller')),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display panel
            Center(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 28),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Center(
                  child: Text(
                    _counter == 100 ? 'LIFTOFF!' : '$_counter',
                    style: TextStyle(
                      fontSize: _counter == 100 ? 44 : 56,
                      fontWeight: FontWeight.w800,
                      color: statusColor,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Slider(
              min: 0,
              max: 100,
              divisions: 100,
              value: _counter.toDouble(),
              onChanged: (double value) {
                _setCounter(value.toInt());
              },
              activeColor: Colors.blue,
              inactiveColor: Colors.red,
            ),

            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _decrement,
                  child: const Text('Decrement'),
                ),
                ElevatedButton(onPressed: _ignite, child: const Text('Ignite')),
                ElevatedButton(
                  onPressed: _reset,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade700,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Reset'),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Text(
              'Status: ${_counter == 0
                  ? "RED (0)"
                  : _counter <= 50
                  ? "ORANGE (1–50)"
                  : _counter < 100
                  ? "GREEN (51–99)"
                  : "LIFTOFF (100)"}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
