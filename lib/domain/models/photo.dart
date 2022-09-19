class Photo {
  final String id;
  final int width;
  final int height;
  final String downloadUrl;

  Photo({
    required this.id,
    required this.width,
    required this.height,
    required this.downloadUrl,
  });

  Photo copyWith({
    String? id,
    int? width,
    int? height,
    String? downloadUrl,
  }) {
    return Photo(
      id: id ?? this.id,
      width: width ?? this.width,
      height: height ?? this.height,
      downloadUrl: downloadUrl ?? this.downloadUrl,
    );
  }
}
