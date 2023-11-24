class Range {
  String date;
  String end;
  String start;
  String text;
  String timezone;

  Range(
      {required this.date,
      required this.end,
      required this.start,
      required this.text,
      required this.timezone});

  Range.fromJson(Map<String, dynamic> json)
      : date = json['date'],
        end = json['end'],
        start = json['start'],
        text = json['text'],
        timezone = json['timezone'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['end'] = end;
    data['start'] = start;
    data['text'] = text;
    data['timezone'] = timezone;
    return data;
  }
}
