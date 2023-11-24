class Languages {
  String digital;
  int hours;
  int minutes;
  String name;
  double percent;
  String text;
  double totalSeconds;

  Languages(
      {required this.digital,
      required this.hours,
      required this.minutes,
      required this.name,
      required this.percent,
      required this.text,
      required this.totalSeconds});

  Languages.fromJson(Map<String, dynamic> json)
      : digital = json['digital'],
        hours = json['hours'],
        minutes = json['minutes'],
        name = json['name'],
        percent = double.parse(json['percent'].toString()),
        text = json['text'],
        totalSeconds = double.parse(json['total_seconds'].toString());

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['digital'] = digital;
    data['hours'] = hours;
    data['minutes'] = minutes;
    data['name'] = name;
    data['percent'] = percent;
    data['text'] = text;
    data['total_seconds'] = totalSeconds;
    return data;
  }
}
