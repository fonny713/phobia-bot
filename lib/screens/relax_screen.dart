import 'package:flutter/material.dart';

class RelaxScreen extends StatelessWidget {
  const RelaxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("relax")),
      body: const Center(child: Text("Tutaj będzie relax")),
    );
  }
}
