class GrandTotal {
  String digital;
  int hours;
  int minutes;
  String text;
  double totalSeconds;

  GrandTotal(
      {required this.digital,
      required this.hours,
      required this.minutes,
      required this.text,
      required this.totalSeconds});

  GrandTotal.fromJson(Map<String, dynamic> json)
      : digital = json['digital'],
        hours = json['hours'],
        minutes = json['minutes'],
        text = json['text'],
        totalSeconds = double.parse(json['total_seconds'].toString());

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['digital'] = digital;
    data['hours'] = hours;
    data['minutes'] = minutes;
    data['text'] = text;
    data['total_seconds'] = totalSeconds;
    return data;
  }
}
