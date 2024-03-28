import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Used to check internet connectivity
class ConnectivityManager {
  static final ConnectivityManager _singleton = ConnectivityManager._internal();

  factory ConnectivityManager() {
    return _singleton;
  }

  ConnectivityManager._internal();

  final Connectivity _connectivity = Connectivity();

  Future<bool> checkInternet() async {
    try {
      var result = await _connectivity.checkConnectivity();
      return result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile;
    } on PlatformException catch (e) {
      debugPrint('Could not check connectivity status: $e');
      return false;
    }
  }
}
