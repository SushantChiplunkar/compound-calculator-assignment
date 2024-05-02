import 'dart:convert';

import 'package:assignment/providers/app_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String configData = await rootBundle.loadString("assets/config.json");
  Map<String, dynamic> decodeConfig = jsonDecode(configData);
  AppConstants.appConfiguration = decodeConfig;
  runApp(
    const ProviderScope(
      child: HomeApp(),
    ),
  );
}

class HomeApp extends ConsumerStatefulWidget {
  const HomeApp({super.key});

  @override
  ConsumerState<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends ConsumerState<HomeApp> {
  final _formKey = GlobalKey<FormState>();
  late final Future<void> fetchData;

  @override
  void initState() {
    //fetchData = ref.read(appDataProvider.notifier).loadConfig();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(appDataProvider.notifier);
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DropdownButtonFormField<int>(
                value: config.rateOfInterest(),
                items: config.getRateOfInterestDropDown()
                    .map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('$value%'),
                  );
                }).toList(),
                onChanged: (value) {
                  // setState(() {
                  //   rateOfInterest = value!.toDouble();
                  // });
                },
                decoration: InputDecoration(
                    labelText: ref
                        .watch(appDataProvider)
                        .rateOfInterest
                        .labelText),
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
                    labelText: ref
                        .watch(appDataProvider)
                        .principalAmount
                        .labelText,
                  ),
                  validator: (value) {
                    // if (value == null || value.isEmpty) {
                    //   return 'Please enter a value.';
                    // }
                    // //print(rateOfInterest.toInt());
                    //
                    // Map<String, dynamic> principalAmountData =
                    //     ref.watch(appDataProvider).principalAmount.minAmount;
                    // //bool isInTheRange = false;
                    // int minValue = 0;
                    // principalAmountData.forEach((key, value) {
                    //   if (Util.checkRange(key, rateOfInterest.toInt())) {
                    //     minValue = value;
                    //   }
                    // });
                    // minValue = minValue == 0
                    //     ? ref.watch(appDataProvider).principalAmount.minAmount["default"]
                    //     : minValue;
                    //
                    // if (principalAmount.toInt() >= minValue &&
                    //     principalAmount.toInt() <=
                    //         ref
                    //             .watch(appDataProvider)
                    //             .principalAmount
                    //             .maxAmount) {
                    //   return null;
                    // } else {
                    //   return ref
                    //       .watch(appDataProvider)
                    //       .principalAmount
                    //       .errorMessage;
                    // }
                  },
                  onSaved: (newValue) {},
                  onChanged: (value) {
                    // setState(() {
                    //   principalAmount = double.tryParse(value) ?? 0.0;
                    // });
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<int>(
                value: config.timesCompound(),
                items: config.getNoOfTimesDropDown()
                    .map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('$value'),
                  );
                }).toList(),
                onChanged: (value) {
                  // setState(() {
                  //   //config.timesCompound() = value!;
                  // });
                },
                decoration: InputDecoration(
                    labelText:
                    ref.watch(appDataProvider).numberOfTimes.labelText),
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<int>(
                value: config.numberOfYears(),
                items: config.getNoOfYearsDropDown()
                    .map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('$value'),
                  );
                }).toList(),
                onChanged: (value) {
                  // setState(() {
                  //   numberOfYears = value!;
                  // });
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
          )
        ),
      ),
    );
  }
}

double calculateCompoundInterest() {
  return 0.0;
}
