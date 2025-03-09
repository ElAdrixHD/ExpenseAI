import 'package:flutter/material.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear Ticket'),
      ),
      body: const Center(
        child: Text('Aquí implementaremos la captura de imágenes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aquí implementaremos la lógica para tomar una foto
        },
        tooltip: 'Tomar foto',
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}