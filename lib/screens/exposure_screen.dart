import 'package:flutter/material.dart';

class ExposureScreen extends StatefulWidget {
  const ExposureScreen({Key? key}) : super(key: key);

  @override
  State<ExposureScreen> createState() => _ExposureScreenState();
}

class _ExposureScreenState extends State<ExposureScreen> {
  int _currentLevel = 1;

  final List<String> _imagePaths = [
    'assets/images/cartoon_spider.jpg',
    'assets/images/cartoon_spider2.jpg',
    'assets/images/cartoon_spider3.jpg',
    'assets/images/small_spider.jpg',
    'assets/images/cartoon_spider_5.jpg',
  ];

  void _nextLevel() {
    setState(() {
      if (_currentLevel < _imagePaths.length) {
        _currentLevel++;
      }
    });
  }

  void _previousLevel() {
    setState(() {
      if (_currentLevel > 1) {
        _currentLevel--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ekspozycja"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Poziom $_currentLevel",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                _imagePaths[_currentLevel - 1],
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _previousLevel,
                child: const Text("Poprzedni poziom"),
              ),
              ElevatedButton(
                onPressed: _nextLevel,
                child: const Text("Następny poziom"),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
