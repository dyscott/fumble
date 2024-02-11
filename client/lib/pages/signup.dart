import 'package:flutter/material.dart';
import 'package:fumble/auth.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:provider/provider.dart';

import '../common.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void signUp() async {
    final nav = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final auth = Provider.of<AuthProvider>(context, listen: false);

    if (_formKey.currentState!.validate()) {
      try {
        await auth.signUpEmail(
          _emailController.text,
          _passwordController.text,
        );
        await auth.signInEmail(
          _emailController.text,
          _passwordController.text,
        );
        nav.popUntil((route) => route.isFirst);
      } on ClientException catch (e) {
        messenger.showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopBackButton(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: signUp,
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
