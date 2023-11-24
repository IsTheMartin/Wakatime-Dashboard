import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakatime_dashboard/presentation/widgets/login_card.dart';

import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final apiKeyRegisterController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('widget.title'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              margin: const EdgeInsets.all(15.0),
              elevation: 10,
              child: Column(children: [
                LoginCard(apiKeyRegisterController: apiKeyRegisterController),
                ElevatedButton(
                    onPressed: () {
                      login(apiKeyRegisterController.text);
                    },
                    child: const Text("Login"))
              ]),
            )
          ],
        ),
      ),
    );
  }

  login(String apiKey) async {
    await SharedPreferences.getInstance()
      ..setString("apiKey", apiKey)
      ..setBool("isLoggedIn", true);
    if (context.mounted) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => const DashboardScreen())));
    }
  }
}
