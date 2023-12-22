import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umlcc_eval/app/ui/auth/register/register_page.dart';

import '../../../controllers/auth_controller.dart';

class VerifyPage extends StatelessWidget {
  VerifyPage({super.key}) {
    if (kDebugMode) {
      _identityController.text = AuthController.to.user.value!.identity;
      _phoneController.text = AuthController.to.user.value!.phone;
      _otpController.text = AuthController.to.otp.value;
    }
  }

  static const String route = "/auth/verify";

  final _formKey = GlobalKey<FormState>();
  final _identityController = TextEditingController();
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade400,
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
                            "Verify",
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        const SizedBox(height: 30),
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
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
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
                        TextFormField(
                          controller: _otpController,
                          decoration: const InputDecoration(
                            labelText: 'OTP',
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the OTP';
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
                                "identity": _identityController.text,
                                "otp": _otpController.text,
                              };
                              AuthController.to.verify(user);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown.shade900,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text('Verify'),
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
