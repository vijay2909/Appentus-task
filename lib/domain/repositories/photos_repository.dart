import '../models/photo.dart';

abstract class PhotosRepository {
  Future<List<Photo>> getPhotos();
}
