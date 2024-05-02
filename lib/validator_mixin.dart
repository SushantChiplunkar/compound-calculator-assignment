
import 'package:assignment/data/app_data.dart';
import 'package:assignment/models/principle_amount.dart';

class Validator{

  static String? customValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a value.';
    }
    Map<String,dynamic> principalAmountData = AppData.calculatorData.principalAmount.minAmount;
    for(String key in principalAmountData.keys){
      
    }

    // Add your custom validation logic here
    // For example, check if the value is a valid email address
    if (!value.contains('@')) {
      return 'Please enter a valid email address.';
    }
    return null; // Return null if the input is valid
  }

  
}