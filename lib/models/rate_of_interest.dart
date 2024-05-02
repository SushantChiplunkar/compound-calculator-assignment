
class RateOfInterest{
RateOfInterest({
    required this.textColor,
    required this.textSize,
    required this.labelText,
    required this.values,
  });
  late final String textColor;
  late final int textSize;
  late final String labelText;
  late final List<int> values;
  
  RateOfInterest.fromJson(Map<String, dynamic> json){
    textColor = json['textColor'];
    textSize = json['textSize'];
    labelText = json['labelText'];
    values = List.castFrom<dynamic, int>(json['values']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['textColor'] = textColor;
    _data['textSize'] = textSize;
    _data['labelText'] = labelText;
    _data['values'] = values;
    return _data;
  }
}