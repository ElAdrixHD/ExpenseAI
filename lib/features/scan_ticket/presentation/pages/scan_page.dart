import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/image_provider.dart';

class ScanPage extends ConsumerWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageState = ref.watch(imageStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear Ticket'),
        actions: [
          if (imageState.capturedImage != null)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                // Aquí implementaremos la lógica para continuar al análisis
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Imagen guardada correctamente')),
                );
                // Navegar a la siguiente pantalla (la crearemos más adelante)
                // context.goNamed('analyze', extra: imageState.capturedImage);
              },
            ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: imageState.isCapturing
                  ? const CircularProgressIndicator()
                  : imageState.capturedImage != null
                  ? Image.file(imageState.capturedImage!)
                  : const Text('Toma una foto del ticket para comenzar'),
            ),
          ),
          if (imageState.capturedImage != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => ref.read(imageStateProvider.notifier).takePhoto(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Volver a capturar'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => ref.read(imageStateProvider.notifier).pickFromGallery(),
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Galería'),
                  ),
                ],
              ),
            ),
        ],
      ),
      floatingActionButton: imageState.capturedImage == null
          ? Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'gallery',
            onPressed: () => ref.read(imageStateProvider.notifier).pickFromGallery(),
            tooltip: 'Galería',
            child: const Icon(Icons.photo_library),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'camera',
            onPressed: () => ref.read(imageStateProvider.notifier).takePhoto(),
            tooltip: 'Cámara',
            child: const Icon(Icons.camera_alt),
          ),
        ],
      )
          : null,
    );
  }
}