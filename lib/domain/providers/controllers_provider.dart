import 'package:appentus_interview_task/domain/controllers/session_controller.dart';

import '../../data/repositories/photos_repository_impl.dart';
import '../controllers/gallery_controller.dart';
import '../controllers/login_controller.dart';
import '../controllers/users_controller.dart';
import '../models/user.dart';
import 'core_provider.dart';
import '../repositories/photos_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerUserController =
    StateNotifierProvider<UsersController, UserState>((ref) {
  final queryExecutor = ref.read(providerQueryExecutor);
  return UsersController(queryExecutor);
});

final providerLoginController = Provider((ref) {
  final queryExecutor = ref.read(providerQueryExecutor);
  return LoginController(queryExecutor);
}, dependencies: [providerQueryExecutor]);

final providerGalleryController =
    StateNotifierProvider<GalleryController, GalleryState>((ref) {
  final repository = ref.read(providerPhotosRepository);
  return GalleryController(repository);
}, dependencies: [providerPhotosRepository]);

final providerPhotosRepository = Provider<PhotosRepository>((ref) {
  return PhotosRepositoryImpl();
});

final providerSession = StateNotifierProvider<SessionController, User?>((ref) {
  final queryExecutor = ref.read(providerQueryExecutor);
  return SessionController(queryExecutor);
}, dependencies: [providerQueryExecutor]);

/* final providerLoggedInUser = FutureProvider<User?>((ref) async {
  final queryExecutor = ref.read(providerQueryExecutor);
  return await queryExecutor.getLoggedInUser();
});

final providerSession = StateProvider<User?>((ref) {
  final asyncUser = ref.watch(providerLoggedInUser);
  User? user = asyncUser.value;
  return user;
}); */
