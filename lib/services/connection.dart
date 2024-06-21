import 'package:connectivity_plus/connectivity_plus.dart';
class Connection {
  static Future<bool> isConnected() async {
    

final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult == ConnectivityResult.none) {
      return false;
    }

    return true;
  }
}