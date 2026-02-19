// lib/main.dart
// In-Class Activity #5: Digital Pet App
// Name: Japroz Singh (jsaini, #002753343)

import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: DigitalPetApp()));
}

class DigitalPetApp extends StatefulWidget {
  @override
  _DigitalPetAppState createState() => _DigitalPetAppState();
}

class _DigitalPetAppState extends State<DigitalPetApp> {
  String petName = "Your Pet";
  int happinessLevel = 50;
  int hungerLevel = 50;

  TextEditingController nameController = TextEditingController();

  // auto hunger timer
  Timer? hungerTimer;
  // win timer tracking
  Timer? winCheckTimer;
  int happySeconds = 0;

  @override
  void initState() {
    super.initState();

    // auto increase hunger
    hungerTimer = Timer.periodic(Duration(seconds: 30), (timer) {
      setState(() {
        hungerLevel += 5;

        if (hungerLevel > 100) hungerLevel = 100;

        // if super hungry, decrement happiness
        if (hungerLevel == 100) {
          happinessLevel -= 10;
          if (happinessLevel < 0) happinessLevel = 0;
        }
      });

      _checkWinLoss();
    });

    // check win condition every 1 second
    winCheckTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (happinessLevel > 80) {
        happySeconds++;
      } else {
        happySeconds = 0;
      }

      // 3 minutes = 180 seconds
      if (happySeconds >= 180) {
        _showWinDialog();
        happySeconds = 0;
      }
    });
  }

  @override
  void dispose() {
    hungerTimer?.cancel();
    winCheckTimer?.cancel();
    nameController.dispose();
    super.dispose();
  }

  // color change
  Color _moodColor(int happiness) {
    if (happiness > 70) {
      return Colors.green;
    } else if (happiness >= 30) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }

  String _moodText(int happiness) {
    if (happiness > 70) return "Happy 😄";
    if (happiness >= 30) return "Neutral 😐";
    return "Unhappy 😢";
  }

  void _playWithPet() {
    setState(() {
      happinessLevel += 10;
      if (happinessLevel > 100) happinessLevel = 100;

      _updateHunger();
    });

    _checkWinLoss();
  }

  void _feedPet() {
    setState(() {
      hungerLevel -= 10;
      if (hungerLevel < 0) hungerLevel = 0;

      _updateHappiness();
    });

    _checkWinLoss();
  }

  void _updateHappiness() {
    if (hungerLevel < 30) {
      happinessLevel -= 20;
    } else {
      happinessLevel += 10;
    }

    if (happinessLevel > 100) happinessLevel = 100;
    if (happinessLevel < 0) happinessLevel = 0;
  }

  void _updateHunger() {
    setState(() {
      hungerLevel += 5;
      if (hungerLevel > 100) {
        hungerLevel = 100;
        happinessLevel -= 20;
        if (happinessLevel < 0) happinessLevel = 0;
      }
    });
  }

  void _setName() {
    setState(() {
      if (nameController.text.trim().isNotEmpty) {
        petName = nameController.text.trim();
      }
    });
  }

  void _checkWinLoss() {
    if (hungerLevel >= 100 && happinessLevel <= 10) {
      _showGameOverDialog();
    }
  }

  void _showGameOverDialog() {
    hungerTimer?.cancel();
    winCheckTimer?.cancel();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Game Over"),
          content: Text(
            "Your pet is too hungry and unhappy! 😭\n\n"
            "Hunger: $hungerLevel\nHappiness: $happinessLevel",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showWinDialog() {
    hungerTimer?.cancel();
    winCheckTimer?.cancel();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("You Win! 🎉"),
          content: Text(
            "You kept happiness above 80 for 3 minutes!\n\n"
            "Great job taking care of $petName!",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  int energyLevel = 100;

  void _useEnergy(int amount) {
    setState(() {
      energyLevel -= amount;
      if (energyLevel < 0) energyLevel = 0;
    });
  }

  void _gainEnergy(int amount) {
    setState(() {
      energyLevel += amount;
      if (energyLevel > 100) energyLevel = 100;
    });
  }

  void _playWithEnergy() {
    _useEnergy(10);
    _playWithPet();
  }

  void _feedWithEnergy() {
    _gainEnergy(5);
    _feedPet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Digital Pet')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Enter Pet Name",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(onPressed: _setName, child: Text("Set Name")),

              SizedBox(height: 20),

              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _moodColor(happinessLevel),
                  BlendMode.modulate,
                ),
                child: Image.asset('assets/pet_image.png', height: 200),
              ),

              SizedBox(height: 10),

              Text(
                "Mood: ${_moodText(happinessLevel)}",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 16.0),
              Text('Name: $petName', style: TextStyle(fontSize: 20.0)),
              SizedBox(height: 16.0),
              Text(
                'Happiness Level: $happinessLevel',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Hunger Level: $hungerLevel',
                style: TextStyle(fontSize: 20.0),
              ),

              SizedBox(height: 20),

              Text(
                'Energy Level: $energyLevel',
                style: TextStyle(fontSize: 20.0),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: LinearProgressIndicator(
                  value: energyLevel / 100,
                  minHeight: 12,
                ),
              ),

              SizedBox(height: 32.0),

              ElevatedButton(
                onPressed: _playWithEnergy,
                child: Text('Play with Your Pet'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _feedWithEnergy,
                child: Text('Feed Your Pet'),
              ),

              SizedBox(height: 16),

              Text(
                "Win: Happiness > 80 for 3 minutes\nLoss: Hunger = 100 and Happiness <= 10",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
