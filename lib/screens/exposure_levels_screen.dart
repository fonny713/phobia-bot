import 'package:flutter/material.dart';
import 'exposure_screen.dart';

class ExposureLevelsScreen extends StatelessWidget {
  const ExposureLevelsScreen({super.key});

  void _navigateToExposure(BuildContext context, int difficulty) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExposureScreen(
          difficulty: difficulty,
          initialLevel: 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final labels = ['Bardzo łatwy', 'Łatwy', 'Średni', 'Trudny', 'Bardzo trudny'];

    return Scaffold(
      appBar: AppBar(title: const Text("Wybierz trudność")),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: labels.length,
        itemBuilder: (context, index) {
          final difficulty = index + 1;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: ElevatedButton(
              onPressed: () => _navigateToExposure(context, difficulty),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                labels[index],
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
