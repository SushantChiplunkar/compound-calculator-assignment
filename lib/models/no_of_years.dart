class NumberOfYears {
  NumberOfYears({
    required this.labelText,
    required this.textColor,
    required this.textSize,
    required this.values,
  });
  late final String labelText;
  late final String textColor;
  late final int textSize;
  late final List<int> values;

  NumberOfYears.fromJson(Map<String, dynamic> json) {
    labelText = json['labelText'];
    textColor = json['textColor'];
    textSize = json['textSize'];
    values = List.castFrom<dynamic, int>(json['values']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['labelText'] = labelText;
    _data['textColor'] = textColor;
    _data['textSize'] = textSize;
    _data['values'] = values;
    return _data;
  }
}
