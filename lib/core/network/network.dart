import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class Network {
  Future<bool> get isConnected;
}

class NetworkImpl implements Network {
  final InternetConnectionCheckerPlus connectionChecker;

  NetworkImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
