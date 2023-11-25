import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wakatime_dashboard/infrastructure/models/languages.dart';
import 'package:wakatime_dashboard/infrastructure/models/summary_data.dart';
import 'package:wakatime_dashboard/infrastructure/models/user_data.dart';

import 'indicator.dart';

class LanguageChart extends StatefulWidget {
  final UserData userData;

  const LanguageChart({super.key, required this.userData});

  @override
  State<LanguageChart> createState() => LanguageChartState();
}

class LanguageChartState extends State<LanguageChart> {
  List<PieChartSectionData> pieChartRawSections = [];
  List<PieChartSectionData> showingSections = [];
  List<String> languageNames = [];
  List<double> totalSeconds = [];
  double sum = 0.0;
  late StreamController<PieTouchResponse> pieTouchedResultStreamController;
  late int touchedIndex;

  List<MaterialColor> colorList = [
    Colors.lime,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.pink,
    Colors.yellow,
    Colors.lightBlue,
    Colors.purple,
    Colors.indigo,
    Colors.lightGreen,
    Colors.amber,
    Colors.grey,
    Colors.brown,
    Colors.cyan,
    Colors.deepPurple,
    Colors.teal,
    Colors.indigo,
    Colors.deepOrange
  ];

  @override
  void initState() {
    buildChart(widget.userData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          child: SingleChildScrollView(
              child: AspectRatio(
                  aspectRatio: 4,
                  child: PieChart(PieChartData(
                    pieTouchData:
                        PieTouchData(touchCallback: (p0, pieTouchResponse) {
                      if (pieTouchResponse == null) return;
                      if (!showingSections.contains(
                          pieTouchResponse.touchedSection!.touchedSection))
                        return;
                      if (pieTouchResponse.touchedSection?.touchedSection !=
                          null) {
                        touchedIndex = showingSections.indexOf(
                            pieTouchResponse.touchedSection!.touchedSection!);
                      }
                      print(touchedIndex);
                      setState(() {
                        showingSections = List.of(pieChartRawSections);

                        double x = totalSeconds[touchedIndex] / 3600;
                        int hrs = x.floor();
                        int mins = ((x - hrs) * 60).floor();
                        final TextStyle? style =
                            showingSections[touchedIndex].titleStyle;
                        showingSections[touchedIndex] =
                            showingSections[touchedIndex].copyWith(
                                title: hrs > 0
                                    ? "$hrs hrs ${mins.toString()} mins"
                                    : "${mins.toString()} mins",
                                color: showingSections[touchedIndex]
                                    .color
                                    .withOpacity(1),
                                titleStyle: style?.copyWith(
                                    fontSize: 14, color: Colors.black),
                                radius: 120);
                      });
                    }),
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,
                    sections: showingSections,
                  ))))),
    );
  }

  @override
  void dispose() {
    super.dispose();
    pieTouchedResultStreamController.close();
  }

  buildChart(UserData userData) {
    pieChartRawSections = [];
    languageNames = [];
    totalSeconds = [];
    sum = 0.0;

    for (SummaryData summaryData in userData.summaryData) {
      for (Languages languages in summaryData.languages) {
        if (!languageNames.contains(languages.name)) {
          languageNames.add(languages.name);
        }
      }
    }

    for (int i = 0; i < languageNames.length; i++) {
      totalSeconds.add(0.0);
    }

    for (int i = 0; i < languageNames.length; i++) {
      for (int j = 0; j < userData.summaryData.length; j++) {
        for (int k = 0; k < userData.summaryData[j].languages.length; k++) {
          if (userData.summaryData[j].languages[k].name == languageNames[i]) {
            totalSeconds[i] +=
                userData.summaryData[j].languages[k].totalSeconds;
          }
        }
      }
      sum += totalSeconds[i];
    }

    for (int i = 0; i < languageNames.length - 1; i++) {
      for (int j = i + 1; j < languageNames.length; j++) {
        if (totalSeconds[i] < totalSeconds[j]) {
          double tmpS = totalSeconds[i];
          totalSeconds[i] = totalSeconds[j];
          totalSeconds[j] = tmpS;

          String tmpN = languageNames[i];
          languageNames[i] = languageNames[j];
          languageNames[j] = tmpN;
        }
      }
    }

    for (int i = 0; i < totalSeconds.length; i++) {
      pieChartRawSections.add(
        PieChartSectionData(
          color: colorList[i].withOpacity(0.8),
          value: totalSeconds[i] / sum,
          title: languageNames[i],
          radius: 100,
          titleStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xffffffff),
          ),
        ),
      );
    }

    showingSections = pieChartRawSections;

    pieTouchedResultStreamController = StreamController();
    pieTouchedResultStreamController.stream.distinct().listen((details) {
      if (details == null) return;
      if (!showingSections.contains(details.touchedSection)) return;

      if (details.touchedSection != null) {
        touchedIndex = showingSections
            .indexOf(details.touchedSection as PieChartSectionData);
      }
      print(touchedIndex);
      setState(() {
        showingSections = List.of(pieChartRawSections);

        double x = totalSeconds[touchedIndex] / 3600;
        int hrs = x.floor();
        int mins = ((x - hrs) * 60).floor();
        final TextStyle? style = showingSections[touchedIndex].titleStyle;
        showingSections[touchedIndex] = showingSections[touchedIndex].copyWith(
          title: hrs > 0
              ? "$hrs hrs ${mins.toString()} mins"
              : "${mins.toString()} mins",
          color: showingSections[touchedIndex].color.withOpacity(1),
          titleStyle: style?.copyWith(fontSize: 14, color: Colors.black),
          radius: 60,
        );
      });
    });

    List<Widget> _indicators() {
      List<Widget> indicators = [];
      indicators.add(const SizedBox(height: 10));
      for (int i = 0; i < languageNames.length; i++) {
        indicators.add(
          Indicator(
            color: touchedIndex == i
                ? colorList[i]
                : colorList[i].withOpacity(0.8),
            text: languageNames[i],
            isSquare: false,
            size: touchedIndex == i ? 18 : 14,
            textColor: touchedIndex == i ? Colors.black : Colors.grey,
          ),
        );
        indicators.add(const SizedBox(height: 5));
      }
      indicators.add(const SizedBox(height: 10));
      return indicators;
    }
  }
}
