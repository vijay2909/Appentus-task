import '../../../../domain/controllers/login_controller.dart';
import '../../../../domain/providers/controllers_provider.dart';
import '../../home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/extensions.dart';
import 'password_input_field.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  late final LoginController _loginController;

  @override
  void initState() {
    _loginController = ref.read(providerLoginController);
    super.initState();
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
            onSaved: _loginController.setEmail,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          const PasswordInputField(),
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
                  _loginController.login().then((result) {
                    if (result) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                      );
                      Fluttertoast.showToast(
                        msg: "logged in successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green.shade600,
                        textColor: Colors.white,
                        fontSize: 14.0,
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: "Invalid email or password",
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
              child: const Text('Login'),
            ),
          ),
        ],
      ),
    );
  }
}
