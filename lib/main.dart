import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabs Demo',
      home: DefaultTabController(length: 4, child: TabsDemo()),
    );
  }
}

class TabsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabs Demo'),
        bottom: TabBar(
          tabs: [
            Tab(text: 'Tab 1'),
            Tab(text: 'Tab 2'),
            Tab(text: 'Tab 3'),
            Tab(text: 'Tab 4'),
          ],
        ),
      ),

      // Bottom App Bar
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Text('Bottom App Bar', textAlign: TextAlign.center),
        ),
      ),

      body: TabBarView(
        children: [
          // TAB 1: Text + Alert Dialog
          Container(
            color: Colors.lightBlue[50],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tab 1: Text Widget',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Hello!'),
                            content: Text('This is an Alert Dialog.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Show Alert'),
                  ),
                ],
              ),
            ),
          ),

          // TAB 2: Image + Text Inputs
          Container(
            color: Colors.green[50],
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeLsMIyoS5GKd4VwGZGcljgow8vEmAYEACGg&s',
                      width: 250,
                      height: 250,
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Enter your name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Enter a message',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // TAB 3: Button + SnackBar
          Container(
            color: Colors.orange[50],
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Button pressed in Tab 3!')),
                  );
                },
                child: Text('Click me'),
              ),
            ),
          ),

          // TAB 4: ListView + Cards
          Container(
            color: Colors.purple[50],
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                Card(
                  child: ListTile(
                    title: Text('Item 1'),
                    subtitle: Text('This is inside a Card'),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Item 2'),
                    subtitle: Text('This is inside a Card'),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Item 3'),
                    subtitle: Text('This is inside a Card'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
