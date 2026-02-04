// lib/main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(TeamApp());
}

class TeamApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Team App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

/// HomePage: Starter for customization tasks
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Task 2: Counter placeholder
  int _counter = 0;

  // Task 3: Text Input Controller placeholder
  final TextEditingController _textController = TextEditingController();

  // Task 4: Theme switching placeholder
  bool _isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Starter App - Customize Me'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Task 1: Profile Card
              Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.person, size: 50, color: Colors.blue),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Student Name',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('Major: Computer Science',
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16),

              // Task 2: Counter Widget
              Text('Counter: $_counter', style: TextStyle(fontSize: 24)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => setState(() => _counter--),
                    child: Icon(Icons.remove),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () => setState(() => _counter++),
                    child: Icon(Icons.add),
                  ),
                ],
              ),

              SizedBox(height: 16),

              // Task 3: Text Input
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Enter some text',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              Text('You typed: ${_textController.text}'),

              SizedBox(height: 16),

              // Task 4: Theme Toggle
              Row(
                children: [
                  Text('Dark Theme'),
                  Switch(
                    value: _isDarkTheme,
                    onChanged: (value) {
                      setState(() {
                        _isDarkTheme = value;
                      });
                    },
                  ),
                ],
              ),

              SizedBox(height: 16),

              // Task 5: Placeholder for Motivational Quotes
              Container(
                height: 50,
                color: Colors.grey[200],
                child: Center(child: Text('Motivational Quote Placeholder')),
              ),

              SizedBox(height: 16),

              // Task 6: Placeholder for Icon Gallery
