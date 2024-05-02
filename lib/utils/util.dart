

class Util{
  static bool checkRange(String range,inputValue){
    List<String> tempRange = range.contains('-')?range.split('-'):[];
      if(tempRange.isEmpty) {
        return false;
      }else{
        return int.parse(tempRange.first)<=inputValue && int.parse(tempRange.last)>=inputValue;
      }
  }
}