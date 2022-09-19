import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/notifier_state.dart';
import '../../../domain/providers/controllers_provider.dart';

class GalleryViewScreen extends ConsumerStatefulWidget {
  const GalleryViewScreen({Key? key}) : super(key: key);

  @override
  GalleryViewScreenState createState() => GalleryViewScreenState();
}

class GalleryViewScreenState extends ConsumerState<GalleryViewScreen> {
  @override
  Widget build(BuildContext context) {
    final galleryController = ref.watch(providerGalleryController);
    const imageHeight = 250.0;
    return galleryController.currentState == NotifierState.loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : galleryController.galleryResult?.fold(
              (failure) => Center(child: Text(failure.msg)),
              (photos) {
                return GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: photos.length,
                  itemBuilder: (BuildContext context, int index) {
                    final photo = photos[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(imageHeight / 16),
                      child: CachedNetworkImage(
                        height: imageHeight,
                        width: imageHeight,
                        fit: BoxFit.cover,
                        imageUrl: photo.downloadUrl,
                      ),
                    );
                  },
                );
              },
            ) ??
            const SizedBox.shrink();
  }
}
