import '../../../../domain/controllers/login_controller.dart';
import '../../../../domain/providers/controllers_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordInputField extends ConsumerStatefulWidget {
  const PasswordInputField({Key? key}) : super(key: key);

  @override
  PasswordInputFieldState createState() => PasswordInputFieldState();
}

class PasswordInputFieldState extends ConsumerState<PasswordInputField> {
  bool _visible = false;

  late final LoginController _loginController;

  @override
  void initState() {
    _loginController = ref.read(providerLoginController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: "Password",
        prefixIcon: const Icon(Icons.lock_outline_rounded),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() => _visible = !_visible);
          },
          icon: _visible
              ? const Icon(Icons.visibility_off_rounded)
              : const Icon(Icons.visibility_rounded),
        ),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter password";
        }
        return null;
      },
      onSaved: _loginController.setPassword,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      obscureText: !_visible,
    );
  }
}
