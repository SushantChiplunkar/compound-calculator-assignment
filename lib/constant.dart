class AppConstants {
  Map<String, dynamic> configData = {};
  AppConstants(Map<String, dynamic> appConfiguration) {
    configData = appConfiguration;
  }



  static Map<String, dynamic> appConfiguration = {};
  static List<int> rateOfInterestValues = [];
  static List<int> timesCompoundedValues = [];
  static List<int> numberOfYearsValues = [];

  static String rateOfInterestLabel = "";
  static String principalAmountLabel = "";
  static String noOfTimesCompoundLabel = "";
  static String noOfYearLabel = "";
}
