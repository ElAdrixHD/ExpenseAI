// lib/features/scan_ticket/presentation/providers/image_provider.dart
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/image_repository_impl.dart';
import '../../domain/repositories/image_repository.dart';

final imageRepositoryProvider = Provider<ImageRepository>((ref) {
  return ImageRepositoryImpl();
});

class ImageState {
  final File? capturedImage;
  final bool isCapturing;

  ImageState({this.capturedImage, this.isCapturing = false});

  ImageState copyWith({
    File? capturedImage,
    bool? isCapturing,
  }) {
    return ImageState(
      capturedImage: capturedImage ?? this.capturedImage,
      isCapturing: isCapturing ?? this.isCapturing,
    );
  }
}

class ImageNotifier extends StateNotifier<ImageState> {
  final ImageRepository _repository;

  ImageNotifier(this._repository) : super(ImageState());

  Future<void> takePhoto() async {
    state = state.copyWith(isCapturing: true);

    try {
      final image = await _repository.takePhoto();
      state = state.copyWith(capturedImage: image, isCapturing: false);
    } catch (e) {
      state = state.copyWith(isCapturing: false);
      // Aquí podrías manejar el error
    }
  }

  Future<void> pickFromGallery() async {
    state = state.copyWith(isCapturing: true);

    try {
      final image = await _repository.pickImageFromGallery();
      state = state.copyWith(capturedImage: image, isCapturing: false);
    } catch (e) {
      state = state.copyWith(isCapturing: false);
      // Aquí podrías manejar el error
    }
  }

  void clearImage() {
    state = state.copyWith(capturedImage: null);
  }
}

final imageStateProvider = StateNotifierProvider.autoDispose<ImageNotifier, ImageState>((ref) {
  final repository = ref.watch(imageRepositoryProvider);
  return ImageNotifier(repository);
});