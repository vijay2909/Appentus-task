import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../domain/controllers/users_controller.dart';
import '../../../../domain/providers/controllers_provider.dart';

class ProfileImage extends ConsumerStatefulWidget {
  const ProfileImage({Key? key}) : super(key: key);

  @override
  ProfileImageState createState() => ProfileImageState();
}

class ProfileImageState extends ConsumerState<ProfileImage> {
  late final ImagePicker _picker;
  Uint8List? _profileImage;
  late final UsersController _usersController;

  @override
  void initState() {
    _picker = ImagePicker();
    _usersController = ref.read(providerUserController.notifier);
    super.initState();
  }

  void onImageReceived(XFile image) async {
    // Save image to gallery
    await GallerySaver.saveImage(image.path);

    // save image path into database
    _usersController.setPhoto(image.path);

    // get image bytes to show image
    final bytes = await image.readAsBytes();

    setState(() => _profileImage = bytes);
  }

  void handleCamera() {
    _picker.pickImage(source: ImageSource.camera).then((photo) {
      if (photo == null) {
        Fluttertoast.showToast(
          msg: "Something went wrong while capturing picture.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0,
        );
      } else {
        onImageReceived(photo);
      }
    });
  }

  void handleGallery() {
    _picker.pickImage(source: ImageSource.gallery).then((image) {
      if (image == null) {
        Fluttertoast.showToast(
          msg: "Something went wrong while picking up image.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0,
        );
      } else {
        onImageReceived(image);
      }
    });
  }

  void chooseImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  handleCamera();
                },
                child: Row(
                  children: [
                    const Icon(Icons.camera_alt_rounded),
                    Expanded(
                      child: Container(
                        height: 50,
                        margin: const EdgeInsets.only(left: 8),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Camera'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  handleGallery();
                },
                child: Row(
                  children: [
                    const Icon(Icons.image_rounded),
                    Expanded(
                      child: Container(
                        height: 50,
                        margin: const EdgeInsets.only(left: 8),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Gallery'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const imageHeight = 100.0;
    return GestureDetector(
      onTap: () {
        chooseImageDialog(context);
      },
      child: Align(
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(imageHeight / 2),
          child: _profileImage == null
              ? Image.asset(
                  'assets/images/profile-avatar.png',
                  height: imageHeight,
                  width: imageHeight,
                  fit: BoxFit.cover,
                )
              : Image.memory(
                  _profileImage!,
                  height: imageHeight,
                  width: imageHeight,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
