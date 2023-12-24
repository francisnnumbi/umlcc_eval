import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umlcc_eval/app/ui/auth/register/register_page.dart';
import 'package:umlcc_eval/configs/constants.dart';

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
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade900),
                      ),
                    ),
                    const SizedBox(height: 60),
                    TextFormField(
                      controller: _dialCodeController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        labelText: 'Dial Code',
                        filled: true,
                        focusColor: Colors.green.shade900,
                        floatingLabelStyle:
                            TextStyle(color: Colors.green.shade900),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green.shade900),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
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
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        labelText: 'Phone',
                        filled: true,
                        focusColor: Colors.green.shade900,
                        floatingLabelStyle:
                            TextStyle(color: Colors.green.shade900),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green.shade900),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
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
                        const Text(
                          "You have no account yet?",
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.offNamed(RegisterPage.route);
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.orange.shade900,
                          ),
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
        ),
      ),
    );
  }
}
