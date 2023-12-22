import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umlcc_eval/app/ui/auth/register/register_page.dart';

import '../../../controllers/auth_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key}) {
    if (kDebugMode && AuthController.to.user.value != null) {
      _identityController.text = AuthController.to.user.value!.identity;
      _phoneController.text = AuthController.to.user.value!.phone;
      _dialCodeController.text = AuthController.to.user.value!.dialCode;
    }
  }

  static const String route = "/auth/login";

  final _formKey = GlobalKey<FormState>();
  final _identityController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dialCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade400,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const Spacer(),

              Expanded(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: ListView(
                      children: [
                        const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: _identityController,
                          decoration: const InputDecoration(
                            labelText: 'Identity',
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your identity';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                controller: _dialCodeController,
                                decoration: const InputDecoration(
                                  labelText: 'Dial Code',
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your dial code';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                controller: _phoneController,
                                decoration: const InputDecoration(
                                  labelText: 'Phone',
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your phone';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              _formKey.currentState!.save();
                              Map<String, dynamic> user = {
                                "identity": _identityController.text,
                                "phone": _phoneController.text,
                                "dial_code": _dialCodeController.text,
                              };
                              AuthController.to.login(user);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade900,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text('Login'),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("You have no account yet?"),
                            TextButton(
                              onPressed: () {
                                Get.offNamed(RegisterPage.route);
                              },
                              child: const Text("Register"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
              //  const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
