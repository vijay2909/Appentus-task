import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/failure.dart';
import '../models/notifier_state.dart';
import '../models/photo.dart';
import '../repositories/photos_repository.dart';

class GalleryState {
  Either<Failure, List<Photo>>? galleryResult;
  final NotifierState currentState;

  GalleryState({this.currentState = NotifierState.initial, this.galleryResult});

  GalleryState copyWith({
    Either<Failure, List<Photo>>? galleryResult,
    NotifierState? currentState,
  }) {
    return GalleryState(
      galleryResult: galleryResult ?? this.galleryResult,
      currentState: currentState ?? this.currentState,
    );
  }
}

class GalleryController extends StateNotifier<GalleryState> {
  final PhotosRepository photosRepository;

  GalleryController(this.photosRepository) : super(GalleryState()) {
    getPhotos();
  }

  void getPhotos() async {
    state = state.copyWith(currentState: NotifierState.loading);
    await Task(() => photosRepository.getPhotos())
        .attempt()
        .map(
          (either) => either.leftMap(
            (obj) {
              try {
                return obj as Failure;
              } catch (e) {
                throw obj;
              }
            },
          ),
        )
        .run()
        .then(
          (value) => state = state.copyWith(
            galleryResult: value,
            currentState: NotifierState.loaded,
          ),
        );
  }
}
