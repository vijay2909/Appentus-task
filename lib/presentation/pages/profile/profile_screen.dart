import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../domain/providers/controllers_provider.dart';
import '../login/login_screen.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    ref.read(providerSession.notifier).isUserLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(providerSession);

    final size = MediaQuery.of(context).size;
    const imageHeight = 100.0;
    return SizedBox(
      width: size.width,
      child: Column(
        children: [
          const Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(imageHeight / 2),
            child: user!.image.isEmpty
                ? Image.asset(
                    'assets/images/profile-avatar.png',
                    height: imageHeight,
                    width: imageHeight,
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    File(user.image),
                    height: imageHeight,
                    width: imageHeight,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(height: 16),
          Text(
            user.name,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 16,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            user.phone,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 16,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            user.email,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 16,
                ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: size.width * 0.6,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                ref.read(providerSession.notifier).logout().then((result) {
                  if (result) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                    Fluttertoast.showToast(
                      msg: "logout successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.white,
                      textColor: Colors.black87,
                      fontSize: 14.0,
                    );
                  }
                });
              },
              child: const Text('Logout'),
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
