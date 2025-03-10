import 'dart:io';

abstract class ImageRepository {
  Future<File?> takePhoto();
  Future<File?> pickImageFromGallery();
  Future<void> saveImage(File image, String path);
}