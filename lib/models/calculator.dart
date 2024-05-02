
import 'package:assignment/models/no_of_times.dart';
import 'package:assignment/models/no_of_years.dart';
import 'package:assignment/models/out_put_values.dart';
import 'package:assignment/models/principle_amount.dart';
import 'package:assignment/models/rate_of_interest.dart';

class Calculator{
  //Rate of Interest
  //Principle Amount
  //No. of Times
  //No. of Years
  static late Calculator instance;

  Calculator();
  late final RateOfInterest rateOfInterest;
  late final PrincipalAmount principalAmount;
  late final NumberOfTimes numberOfTimes;
  late final NumberOfYears numberOfYears;
  late final OutputValue outputValue;
  
  Calculator.fromJson(Map<String, dynamic> json){
    rateOfInterest = RateOfInterest.fromJson(json['rateOfInterest']);
    principalAmount = PrincipalAmount.fromJson(json['principalAmount']);
    numberOfTimes = NumberOfTimes.fromJson(json['timesCompounded']);
    numberOfYears = NumberOfYears.fromJson(json['numberOfYears']);
    outputValue = OutputValue.fromJson(json['outputValue']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['rateOfInterest'] = rateOfInterest.toJson();
    _data['principalAmount'] = principalAmount.toJson();
    _data['timesCompounded'] = numberOfTimes.toJson();
    _data['numberOfYears'] = numberOfYears.toJson();
    _data['outputValue'] = outputValue.toJson();
    return _data;
  }
}