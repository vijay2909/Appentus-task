import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/extensions.dart';
import '../../../../domain/controllers/users_controller.dart';
import '../../../../domain/providers/controllers_provider.dart';
import 'profile_image_widget.dart';

class SignupForm extends ConsumerStatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  SignupFormState createState() => SignupFormState();
}

class SignupFormState extends ConsumerState<SignupForm> {
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final _formKey = GlobalKey<FormState>();

  late final UsersController _usersController;

  @override
  void initState() {
    _usersController = ref.read(providerUserController.notifier);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _usersController.initGuestUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autoValidate,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProfileImage(),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              hintText: "Name",
              labelText: 'Name',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your name";
              }
              return null;
            },
            onSaved: _usersController.setName,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              hintText: "Phone",
              labelText: 'Phone',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.call_rounded),
              counterText: '',
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            maxLength: 10,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your name";
              } else if (value.length < 10) {
                return "Please enter valid phone number";
              }
              return null;
            },
            onSaved: _usersController.setPhone,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              hintText: "Email",
              labelText: 'Email',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email_rounded),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your email address";
              } else if (!value.isValidEmail()) {
                return "Please enter valid email address";
              }
              return null;
            },
            onSaved: _usersController.setEmail,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Password',
              hintText: "Password",
              prefixIcon: Icon(Icons.lock_outline_rounded),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter password";
              }
              return null;
            },
            onSaved: _usersController.setPassword,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
          ),
          Container(
            margin: const EdgeInsets.only(top: 24),
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                final form = _formKey.currentState!;
                FocusScope.of(context).unfocus();
                if (form.validate()) {
                  form.save();
                  _usersController.insertUser().then((result) {
                    if (result) {
                      Navigator.of(context).pop();
                      Fluttertoast.showToast(
                        msg: "Signup successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.white,
                        textColor: Colors.black87,
                        fontSize: 14.0,
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: "Signup failed!!, Please try again.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 14.0,
                      );
                    }
                  });
                } else {
                  setState(() => _autoValidate = AutovalidateMode.always);
                }
              },
              child: const Text('Signup'),
            ),
          ),
        ],
      ),
    );
  }
}
