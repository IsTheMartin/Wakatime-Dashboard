import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakatime_dashboard/infrastructure/models/user_data.dart';
import 'package:wakatime_dashboard/infrastructure/sources/remote/api_services.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  UserData? userData;
  bool is7Day = true;

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      String apiKey = prefs.getString("apiKey") ?? "";
      if (apiKey.isEmpty) {
        print("ApiKey empty");
        return;
      }

      String start = is7Day
          ? DateFormat('yyy-MM-dd')
              .format(DateTime.now().subtract(Duration(days: 6)))
          : DateFormat('yyy-MM-dd')
              .format(DateTime.now().subtract(Duration(days: 13)));
      String end = DateFormat('yyy-MM-dd').format(DateTime.now());
      getUserSummary(apiKey, start, end);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("WakaTime")),
      body: Column(
        children: [Text(userData?.summaryData.toString() ?? "No data")],
      ),
    );
  }

  getUserSummary(String apiKey, String startDate, String endDate) {
    getUserSummaryService(apiKey, startDate, endDate).then((response) {
      setState(() {
        userData = response;
        print("Hello");
        print(userData?.summaryData.length);
      });
    });
  }
}
