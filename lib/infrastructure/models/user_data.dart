import 'summary_data.dart';

class UserData {
  List<SummaryData> summaryData = List.empty();
  String startDate = "";
  String endDate = "";

  UserData(
      {required this.summaryData,
      required this.startDate,
      required this.endDate});

  UserData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      summaryData = <SummaryData>[];
      json['data'].forEach((v) {
        summaryData.add(SummaryData.fromJson(v));
      });
    }
    endDate = json['end'];
    startDate = json['start'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (summaryData != null) {
      data['data'] = summaryData.map((v) => v.toJson()).toList();
    }
    data['end'] = endDate;
    data['start'] = startDate;
    return data;
  }
}
