import 'dart:convert';
import 'dart:math';

import 'package:assignment/constant.dart';
//import 'package:assignment/data/app_data.dart';
import 'package:assignment/data/app_data.dart';
import 'package:assignment/models/calculator.dart';
import 'package:assignment/providers/app_data_provider.dart';
import 'package:assignment/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String configData = await rootBundle.loadString("assets/config.json");
  Map<String, dynamic> decodeConfig = jsonDecode(configData);
  AppConstants.appConfiguration = decodeConfig;

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final principalAmountProvider = StateProvider<double>((ref) {
  return 0.0;
});

final rateOfInterestProvider = StateProvider<int>((ref) {
  return 1;
});

final timesCompoundedProvider = StateProvider<int>((ref) {
  return 1;
});

final numberOfYearsProvider = StateProvider<int>((ref) {
  return 1;
});



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CompoundInterestCalculator(),
    );
  }
}

class CompoundInterestCalculator extends ConsumerStatefulWidget {
  const CompoundInterestCalculator({super.key});

  @override
  ConsumerState<CompoundInterestCalculator> createState() =>
      _CompoundInterestCalculatorState();
}

class _CompoundInterestCalculatorState
    extends ConsumerState<CompoundInterestCalculator> {
  double principalAmount = 0.0;
  double rateOfInterest = 1.0;
  int timesCompounded = 1;
  int numberOfYears = 1;

  List<int> rateValues = [];
  List<int> timesCompoundedValues = [];
  List<int> numberOfYearsValues = [];
  Map<String, int> minAmount = {};
  int MaxAmount = 0;
  String rateOfInterestLabel = "";
  String noOfTimesCompoundLabel = "";
  String numberOfYearsLabel = "";
  String principalAmountLabel = "";
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Calculator calculator = Calculator.fromJson(AppConstants.appConfiguration);
    AppData.calculatorData = calculator;

    // rateValues =
    //     List.from(AppConstants.appConfiguration["rateOfInterest"]["values"]);
    // timesCompoundedValues = List<int>.from(
    //     AppConstants.appConfiguration["numberOfYears"]["values"]);
    // numberOfYearsValues =
    //     List.from(AppConstants.appConfiguration["timesCompounded"]["values"]);
    // rateOfInterestLabel =
    //     AppConstants.appConfiguration["rateOfInterest"]["labelText"];
    // noOfTimesCompoundLabel =
    //     AppConstants.appConfiguration["timesCompounded"]["labelText"];
    // numberOfYearsLabel =
    //     AppConstants.appConfiguration["numberOfYears"]["labelText"];
    // principalAmountLabel =
    //     AppConstants.appConfiguration["principalAmount"]["labelText"];
  }

  // final List<int> rateValues = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  // final List<int> timesCompoundedValues = [1, 2, 4];
  // final List<int> numberOfYearsValues = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30];

  double calculateCompoundInterest() {
    double r = rateOfInterest / 100;
    double n = timesCompounded.toDouble();
    double t = numberOfYears.toDouble();
    return principalAmount * pow((1 + r / n), n * t);
  }

  @override
  Widget build(BuildContext context) {
    // Map<String, dynamic> appConfiguration = AppConstants.appConfiguration;
    // log(0.8);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Compound Interest Calculator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DropdownButtonFormField<int>(
              value: rateOfInterest.toInt(),
              items: ref
                  .watch(appDataProvider)
                  .rateOfInterest
                  .values
                  .map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value%'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  rateOfInterest = value!.toDouble();
                });
              },
              decoration: InputDecoration(
                  labelText:
                      ref.watch(appDataProvider).rateOfInterest.labelText),
            ),
            const SizedBox(height: 16.0),
            Form(
              key: _formKey,
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  labelText:
                      ref.watch(appDataProvider).principalAmount.labelText,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value.';
                  }
                  print(rateOfInterest.toInt());

                  Map<String, dynamic> principalAmountData =
                      ref.watch(appDataProvider).principalAmount.minAmount;
                  //bool isInTheRange = false;
                  int minValue = 0;
                  principalAmountData.forEach((key, value) {
                    if (Util.checkRange(key, rateOfInterest.toInt())) {
                      minValue = value;
                    }
                  });
                  minValue = minValue == 0
                      ? ref.watch(appDataProvider).principalAmount.minAmount["default"]
                      : minValue;

                  if (principalAmount.toInt() >= minValue &&
                      principalAmount.toInt() <=
                          ref
                              .watch(appDataProvider)
                              .principalAmount
                              .maxAmount) {
                    return null;
                  } else {
                    return ref
                        .watch(appDataProvider)
                        .principalAmount
                        .errorMessage;
                  }

                },
                onSaved: (newValue) {},
                onChanged: (value) {
                  setState(() {
                    principalAmount = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<int>(
              value: timesCompounded,
              items: ref
                  .watch(appDataProvider)
                  .numberOfTimes
                  .values
                  .map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  timesCompounded = value!;
                });
              },
              decoration: InputDecoration(
                  labelText:
                      ref.watch(appDataProvider).numberOfTimes.labelText),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<int>(
              value: numberOfYears,
              items: ref
                  .watch(appDataProvider)
                  .numberOfYears
                  .values
                  .map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  numberOfYears = value!;
                });
              },
              decoration: InputDecoration(
                  labelText:
                      ref.watch(appDataProvider).numberOfYears.labelText),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  double result = calculateCompoundInterest();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Compound Interest'),
                        content: Text(
                            'The compound interest is: ${result.toStringAsFixed(2)}'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Calculate'),
            ),
          ],
        ),
      ),
    );
  }
}
