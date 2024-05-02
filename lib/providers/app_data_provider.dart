

import 'package:assignment/data/app_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appDataProvider = Provider((ref) {
   return AppData.calculatorData;
});