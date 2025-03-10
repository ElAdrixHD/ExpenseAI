import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../../domain/repositories/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<File?> takePhoto() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      // Aquí podrías implementar logging o manejo de errores
      print('Error al tomar foto: $e');
      return null;
    }
  }

  @override
  Future<File?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      print('Error al seleccionar imagen: $e');
      return null;
    }
  }

  @override
  Future<void> saveImage(File image, String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = path.join(directory.path, fileName);
      await image.copy(filePath);
    } catch (e) {
      print('Error al guardar imagen: $e');
      rethrow; // Propaga el error para que pueda ser manejado en capas superiores
    }
  }
}