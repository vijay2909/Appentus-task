import '../../domain/models/failure.dart';
import '../../domain/models/photo.dart';
import '../../domain/repositories/photos_repository.dart';
import '../dio/dio_client.dart';
import '../dio/end_points.dart';
import '../models/photos_dto.dart';

class PhotosRepositoryImpl implements PhotosRepository {
  @override
  Future<List<Photo>> getPhotos() async {
    try {
      final response = await DioClient.get(endPoint: EndPoints.apiImgesList);

      final photosDto = PhotosDto.fromJson(response);
      if (photosDto.data == null) return [];
      return photosDto.mapToDomain(photosDto.data!);
    } catch (e) {
      throw Failure(msg: DioClient.handleError(e));
    }
  }
}
