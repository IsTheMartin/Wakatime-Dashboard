import 'package:flutter/material.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({super.key, required this.apiKeyRegisterController});

  final TextEditingController apiKeyRegisterController;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      TextField(
        controller: apiKeyRegisterController,
        decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(borderSide: BorderSide()),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide()),
            labelText: "Please Enter Your ApiKey"),
      ),
      const SizedBox(
        height: 25,
      )
    ]);
  }
}
