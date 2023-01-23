import 'package:pa_market_client/objects/farm.dart';
import 'package:pa_market_client/persistence/database_manager.dart';

class Farms {
  static List<Farm> farms = [];
  static Future getFarms() async {
    return DatabaseManager.getFarms();
  }

  static void setSearchFarms(List<Farm> list) {
    farms.clear();
    farms.addAll(list);
  }

  static List<Farm> getSearchFarms() {
    return farms;
  }
}