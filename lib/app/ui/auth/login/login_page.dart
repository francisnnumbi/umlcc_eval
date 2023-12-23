import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umlcc_eval/app/ui/auth/register/register_page.dart';

import '../../../services/auth_service.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  static const String route = "/auth/login";

  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _dialCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
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
                        const SizedBox(height: 10),
                        TextFormField(
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
                        const SizedBox(height: 10),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              _formKey.currentState!.save();
                              Map<String, dynamic> user = {
                                "phone": _phoneController.text,
                                "dial_code": _dialCodeController.text,
                              };
                              AuthService.to.login(user);
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
