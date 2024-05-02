

import 'dart:convert';

import 'package:assignment/data/app_data.dart';
import 'package:assignment/models/calculator.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppDataNotifier extends StateNotifier<Calculator>{
  AppDataNotifier(super.state);

  // Future<void> loadConfig() async {
  //   final String jsonString = await rootBundle.loadString("assets/config.json");
  //   state = json.decode(jsonString);
  // }

  List<int> getRateOfInterestDropDown(){
    return state.rateOfInterest.values;
  }

  List<int> getNoOfTimesDropDown(){
    return state.numberOfTimes.values;
  }

  List<int> getNoOfYearsDropDown(){
    return state.numberOfYears.values;
  }

  int rateOfInterest(){
    return 1;
  }

  double principalAmount(){
    return 0.0;
  }
  int timesCompound(){
    return 1;
  }
  int numberOfYears(){
    return 1;
  }

}

final appDataProvider = StateNotifierProvider<AppDataNotifier,Calculator>((ref) {
   return AppDataNotifier(AppData.calculatorData);
});