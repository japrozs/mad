import 'package:flutter/material.dart';

void main() {
  runApp(const RunMyApp());
}

class RunMyApp extends StatefulWidget {
  const RunMyApp({super.key});

  @override
  State<RunMyApp> createState() => _RunMyAppState();
}

class _RunMyAppState extends State<RunMyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Theme Demo',

      // LIGHT THEME
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.grey[100],

        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18),
          bodySmall: TextStyle(fontSize: 15),
        ),
      ),

      // DARK THEME
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,

        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18),
          bodySmall: TextStyle(fontSize: 15),
        ),
      ),

      themeMode: _themeMode,

      home: ThemeHomeScreen(themeMode: _themeMode, onToggleTheme: _toggleTheme),
    );
  }
}

class ThemeHomeScreen extends StatelessWidget {
  final ThemeMode themeMode;
  final Function(bool) onToggleTheme;

  const ThemeHomeScreen({
    super.key,
    required this.themeMode,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Theme Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 300,
              height: 180,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? Colors.white : Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '📱 Mobile App Development Testing',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Demonstrating theme switching with smooth animations',
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Choose the Theme:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: isDark ? 0.3 : 1.0,
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 300),
                    scale: isDark ? 1.0 : 1.25,
                    child: Icon(
                      Icons.wb_sunny,
                      size: 28,
                      color: isDark ? Colors.grey : Colors.orange,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Switch(
                  value: isDark,
                  onChanged: (value) => onToggleTheme(value),
                ),

                const SizedBox(width: 12),

                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: isDark ? 1.0 : 0.3,
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 300),
                    scale: isDark ? 1.25 : 1.0,
                    child: Icon(
                      Icons.nightlight_round,
                      size: 28,
                      color: isDark ? Colors.yellow : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => onToggleTheme(false),
                  child: const Text('Light Mode'),
                ),

                const SizedBox(width: 15),

                ElevatedButton(
                  onPressed: () => onToggleTheme(true),
                  child: const Text('Dark Mode'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
