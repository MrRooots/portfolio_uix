import 'package:flutter/material.dart';

import 'package:portfolio_uix/core/data/data.dart';
import 'package:portfolio_uix/core/utils/utils.dart';
import 'package:portfolio_uix/core/palette/palette.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _isHidden = false;
  Email _isEmailValid = Email.empty;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            _buildEmailInput(),
            const SizedBox(height: 30.0),
            _buildPasswordInput(),
          ],
        ),
      ),
    );
  }

  TextFormField _buildEmailInput() => TextFormField(
        style: const TextStyle(letterSpacing: 1),
        controller: _emailController,
        focusNode: _emailFocusNode,
        decoration: InputDecoration(
          hintText: 'Enter email...',
          suffixIcon: Icon(
            _isEmailValid == Email.empty
                ? null
                : _isEmailValid == Email.valid
                    ? Icons.check_circle_rounded
                    : Icons.cancel,
            size: 28.0,
            color: _isEmailValid == Email.valid ? Palette.green : Palette.red,
          ),
        ),
        onChanged: (final String text) => setState(
          () => _isEmailValid = Utils.validateEmail(text),
        ),
      );

  TextFormField _buildPasswordInput() => TextFormField(
        controller: _passwordController,
        focusNode: _passwordFocusNode,
        obscureText: _isHidden,
        style: TextStyle(
          letterSpacing:
              _isHidden && _passwordController.text.isNotEmpty ? 10 : 1,
        ),
        decoration: InputDecoration(
          hintText: 'Enter password...',
          suffixIcon: IconButton(
            icon: Icon(
              _isHidden
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              size: 28.0,
              color: Palette.grey,
            ),
            onPressed: () => setState(() => _isHidden = !_isHidden),
          ),
        ),
      );
}
