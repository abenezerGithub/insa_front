import 'dart:async';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insa_report/models/http_exception.dart';
import 'package:insa_report/models/user.dart';
import 'package:insa_report/providers/user_provider.dart';
import 'package:insa_report/services/connection.dart';
import 'package:insa_report/services/http.dart';
import 'package:insa_report/services/securestore.dart';
import 'package:insa_report/widgets/logo.dart';
import 'package:insa_report/widgets/text_field.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscureText = true;
  bool _obscureConfirmPassword = true;
  void _submitSignup() async {
    if (_formKey.currentState!.validate()) {

      final isConnected = await Connection.isConnected();
      if(!isConnected) {
        if (mounted) {

        showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.error(
                message: "Please check you internet connection.",
                messagePadding: EdgeInsets.symmetric(horizontal: 20),
                textScaleFactor: 0.88,
              ),
            );
        }
        return;
      }

      final name = _nameController.value.text;
      final username = _emailController.value.text;
      final password = _passwordController.value.text;
      setState(() {
        loading = true;
      });
      try {
        final resp = await HTTPServices.post(
            path: "api/users/register/",
            data: {"name": name, "username": username, "password": password});

        if (resp.statusCode != 200 && resp.statusCode != 201) {
          final message = jsonDecode(resp.body)["detail"];
          throw HttpStatusException(message, resp.statusCode);
        }

        final jsonUser = jsonDecode(resp.body)["user"];
        final user = User.fromMap(jsonUser);
        final isSaved = await SecureStore.setUser(user);
        ref.invalidate(userProvider);

        if (!isSaved) {
          throw Exception("Something went wrong please try again later.");
        }
        setState(() {
          loading = false;
        });
        if (mounted) {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed("/home");
        }
      }on TimeoutException catch (err) {
       if (mounted) {

        showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(
                message: err.message ?? "Connection timeout please try again.",
                messagePadding: const EdgeInsets.symmetric(horizontal: 20),
                textScaleFactor: 0.88,
              ),
            );
        }
      }
       on HttpStatusException catch (err) {
        print(err);
        setState(() {
          loading = false;
        });

        if (mounted) {
          if (err.statusCode == 403 || err.statusCode == 400) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(
                message: err.message,
                messagePadding: const EdgeInsets.symmetric(horizontal: 20),
                textScaleFactor: 0.88,
              ),
            );
          } else {
            showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.error(
                message:
                    "Something went wrong. Please check your credentials and try again",
              ),
            );
          }
        }
      } catch (err) {
        print(err);
        setState(() {
          loading = false;
        });
        if (mounted) {
          showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.error(
              message:
                  "Something went wrong. Please check your credentials and try again",
            ),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign Up",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Center(
                    child:
                        Logo(width: MediaQuery.of(context).size.width * 0.28)),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                  child: Text(
                    "Register Here",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        fontFamily: "Poppins",
                        color: Theme.of(context).colorScheme.primary),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomTextField(
                              label: "Name",
                              icon: Icons.person,
                              keyboardType: TextInputType.emailAddress,
                              controller: _nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter name";
                                }
                                if (value.length < 4) {
                                  return "Name must be at least 4 characters";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomTextField(
                              label: "Email",
                              icon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter email address";
                                }
                                if (value.length < 6 ||
                                    !value.contains("@") ||
                                    !value.contains(".")) {
                                  return "Please enter a valid email address";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomTextField(
                              label: "Password",
                              icon: Icons.password,
                              keyboardType: TextInputType.visiblePassword,
                              controller: _passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter password";
                                }
                                if (value.length < 6) {
                                  return "Password must be at least 6 characters";
                                }
                                return null;
                              },
                              obscureText: _obscureText,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(.5),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomTextField(
                              label: "Confirm Password ",
                              icon: Icons.password,
                              keyboardType: TextInputType.visiblePassword,
                              controller: _confirmPasswordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter password";
                                }
                                if (value.length < 6) {
                                  return "Password must be at least 6 characters";
                                }
                                if (value != _passwordController.value.text) {
                                  return "The password must be same.";
                                }

                                return null;
                              },
                              obscureText: _obscureConfirmPassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureConfirmPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(.5),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureConfirmPassword =
                                        !_obscureConfirmPassword;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton.icon(
                              onPressed: _submitSignup,
                              style: ButtonStyle(
                                backgroundColor: loading
                                    ? MaterialStateProperty.all(
                                        Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(.4))
                                    : MaterialStateProperty.all(
                                        Theme.of(context).colorScheme.primary),
                                overlayColor: MaterialStateProperty.all<Color?>(
                                  Colors.white.withOpacity(0.18),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                              icon: loading
                                  ? LoadingAnimationWidget.staggeredDotsWave(
                                      color: Colors.white,
                                      size: 20,
                                    )
                                  : const Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                      child: Icon(
                                        Icons.app_registration,
                                        color: Colors.white,
                                      ),
                                    ),
                              label: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.0),
                                child: Text(
                                  "Signup",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 15),
                                children: [
                                  const TextSpan(
                                      text: 'Already have an account? '),
                                  TextSpan(
                                    text: ' Login ',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 0, 58, 105),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacementNamed(
                                            context, '/login');
                                      },
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
