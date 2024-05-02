
class OutputValue{
  OutputValue({
    required this.textColor,
    required this.labelText,
    required this.textSize,
    required this.modeOfDisplay,
  });
  late final String textColor;
  late final String labelText;
  late final int textSize;
  late final String modeOfDisplay;
  
  OutputValue.fromJson(Map<String, dynamic> json){
    textColor = json['textColor'];
    labelText = json['labelText'];
    textSize = json['textSize'];
    modeOfDisplay = json['modeOfDisplay'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['textColor'] = textColor;
    _data['labelText'] = labelText;
    _data['textSize'] = textSize;
    _data['modeOfDisplay'] = modeOfDisplay;
    return _data;
  }
}