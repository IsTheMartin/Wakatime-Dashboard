class Machines {
  String digital;
  int hours;
  String machineNameId;
  int minutes;
  String name;
  double percent;
  int seconds;
  String text;
  double totalSeconds;

  Machines(
      {required this.digital,
      required this.hours,
      required this.machineNameId,
      required this.minutes,
      required this.name,
      required this.percent,
      required this.seconds,
      required this.text,
      required this.totalSeconds});

  Machines.fromJson(Map<String, dynamic> json)
      : digital = json['digital'],
        hours = json['hours'],
        machineNameId = json['machine_name_id'],
        minutes = json['minutes'],
        name = json['name'],
        percent = double.parse(json['percent'].toString()),
        seconds = json['seconds'],
        text = json['text'],
        totalSeconds = double.parse(json['total_seconds'].toString());

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['digital'] = digital;
    data['hours'] = hours;
    data['machine_name_id'] = machineNameId;
    data['minutes'] = minutes;
    data['name'] = name;
    data['percent'] = percent;
    data['seconds'] = seconds;
    data['text'] = text;
    data['total_seconds'] = totalSeconds;
    return data;
  }
}
