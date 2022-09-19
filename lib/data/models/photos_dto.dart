import '../../domain/models/photo.dart';

class PhotosDto {
  List<PhotosData>? data;
  PhotosDto({required this.data});

  PhotosDto.fromJson(List<dynamic>? source) {
    if (source != null) {
      data = [];
      for (final element in source) {
        data!.add(PhotosData.fromJson(element));
      }
    }
  }

  List<Photo> mapToDomain(List<PhotosData> photos) {
    return photos
        .map(
          (e) => Photo(
            id: e.id ?? '',
            width: e.width ?? 0,
            height: e.height ?? 0,
            downloadUrl: e.downloadUrl ?? '',
          ),
        )
        .toList();
  }
}

class PhotosData {
  String? id;
  String? author;
  int? width;
  int? height;
  String? url;
  String? downloadUrl;

  PhotosData(
      {this.id,
      this.author,
      this.width,
      this.height,
      this.url,
      this.downloadUrl});

  PhotosData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author = json['author'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    downloadUrl = json['download_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['author'] = author;
    data['width'] = width;
    data['height'] = height;
    data['url'] = url;
    data['download_url'] = downloadUrl;
    return data;
  }
}
