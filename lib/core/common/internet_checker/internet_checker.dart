// import 'package:connectivity_plus/connectivity_plus.dart';

// class NetworkInfo {
//   Future<bool> get isConnected async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     return connectivityResult != ConnectivityResult.none;
//   }
// }

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:shikshyadwar_mobile_application_project/core/service/network.dart';

// class NetworkInfoImpl implements NetworkInfo {
//   final Connectivity _connectivity;
//   final InternetConnectionChecker _internetConnectionChecker;

//   NetworkInfoImpl(this._connectivity, this._internetConnectionChecker);

//   @override
//   Future<bool> get isConnected async {
//     final connectivityResult = await _connectivity.checkConnectivity();

//     if (connectivityResult == ConnectivityResult.mobile ||
//         connectivityResult == ConnectivityResult.wifi ||
//         connectivityResult == ConnectivityResult.ethernet) {
//       return await _internetConnectionChecker.hasConnection;
//     }

//     return false;
//   }
// }

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shikshyadwar_mobile_application_project/core/service/network.dart';

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;
  final InternetConnectionChecker _internetConnectionChecker;

  NetworkInfoImpl(this._connectivity, this._internetConnectionChecker);

  @override
  Future<bool> get isConnected async {
    return true; // Force network status to always be true
  }
}
