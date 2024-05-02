
class PrincipalAmount{
  PrincipalAmount({
    required this.hintText,
    required this.labelText,
    required this.textColor,
    required this.textSize,
    required this.minAmount,
    required this.maxAmount,
    required this.errorMessage,
  });
  late final String hintText;
  late final String labelText;
  late final String textColor;
  late final int textSize;
  late final Map<String,dynamic> minAmount;
  late final int maxAmount;
  late final String errorMessage;
  
  PrincipalAmount.fromJson(Map<String, dynamic> json){
    hintText = json['hintText'];
    labelText = json['labelText'];
    textColor = json['textColor'];
    textSize = json['textSize'];
    minAmount = json['minAmount'];
    maxAmount = json['maxAmount'];
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['hintText'] = hintText;
    _data['labelText'] = labelText;
    _data['textColor'] = textColor;
    _data['textSize'] = textSize;
    _data['minAmount'] = minAmount;
    _data['maxAmount'] = maxAmount;
    _data['errorMessage'] = errorMessage;
    return _data;
  }
}