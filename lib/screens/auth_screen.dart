import 'package:flutter/material.dart';
import 'package:trendbuy/my_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLogin = true;
  var _email = '';
  var _password = '';
  var _fullName = '';

  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    if (isLogin) {
      try {
        await _firebase.signInWithEmailAndPassword(
            email: _email, password: _password);
      } on FirebaseAuthException catch (error) {
        String message = 'Username or password is incorrect!';
        if (error.code == 'user-not-found') {
          message = 'User not found';
        } else if (error.code == 'wrong-password') {
          message = 'Wrong password';
        }
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          content: Text(message),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      try {
        final userCred = await _firebase.createUserWithEmailAndPassword(
            email: _email, password: _password);
        if (_fullName.trim().isNotEmpty) {
          await userCred.user?.updateDisplayName(_fullName.trim());
        }
        setState(() {
          isLogin = true;
        });
      } on FirebaseAuthException catch (error) {
        String message = 'An error occurred, please check your credentials!';
        if (error.code == 'weak-password') {
          message = 'The password is too weak.';
        } else if (error.code == 'email-already-in-use') {
          message = 'Email already exists';
        }
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          content: Text(message),
          backgroundColor: Colors.red,
        ));
      } catch (error) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.toString()),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Expanded(
                flex: 14,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 80),
                        const Text(
                          'N',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          isLogin ? 'LOG IN' : 'SIGN UP',
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 40),
                        if (!isLogin)
                          Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Full name',
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                ),
                                textCapitalization: TextCapitalization.words,
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().length < 3) {
                                    return "Please enter your full name";
                                  }
                                  return null;
                                },
                                onSaved: (value) => _fullName = value!.trim(),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Email address',
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              return "Please enter a valid email address";
                            }
                            return null;
                          },
                          onSaved: (value) => _email = value!,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.grey),
                            hintText:
                                isLogin ? 'Password' : 'create a password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                          ),
                          autocorrect: false,
                          validator: (value) {
                            if (value == null || value.trim().length < 8) {
                              return "The password must be at least 8 characters long";
                            }
                            return null;
                          },
                          onSaved: (value) => _password = value!,
                        ),
                        const SizedBox(height: 12),
                        Align(
                            alignment: Alignment.centerRight,
                            child: isLogin
                                ? TextButton(
                                    child: const Text(
                                      'Forgot password?',
                                      style: TextStyle(
                                          color: LightTheme.secondaryTextColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {},
                                  )
                                : null),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: LightTheme.secondaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              isLogin ? 'LOG IN' : 'SIGN UP',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text('OR'),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            icon: Image.network(
                              'https://cdn.iconscout.com/icon/free/png-256/free-google-icon-download-in-svg-png-gif-file-formats--logo-social-media-1507807.png?f=webp',
                              height: 20,
                              fit: BoxFit.contain,
                            ),
                            label: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Continue with Google',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        isLogin
                            ? "Don't have an account? "
                            : "Already have an account?",
                        style: const TextStyle(
                            color: LightTheme.secondaryTextColor,
                            fontSize: 14)),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: Text(isLogin ? 'Sign up' : 'Log in',
                          style: const TextStyle(
                              color: LightTheme.primaryTextColor,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
