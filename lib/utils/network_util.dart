import 'package:connectivity/connectivity.dart';

Future<bool> isNetworkConnected() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    return false;
  } else
    return true;
}
