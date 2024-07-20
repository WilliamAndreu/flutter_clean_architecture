import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityService {
  Future<bool> isConnected();
  Future<bool> isDisconnected();
  Future<List<ConnectivityResult>> get connectivityResult;
  Stream<List<ConnectivityResult>> get onConnectivityChanged;
}

class ConnectivityServiceImpl implements ConnectivityService {
  Connectivity instance;

  static final ConnectivityServiceImpl _networkInfo = ConnectivityServiceImpl._internal(Connectivity());

  factory ConnectivityServiceImpl() {
    return _networkInfo;
  }

  ConnectivityServiceImpl._internal(this.instance) {
    instance = instance;
  }

  @override
  Future<bool> isConnected() async {
    final result = await instance.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }

  @override
  Future<bool> isDisconnected() async {
    final result = await instance.checkConnectivity();
    return result.contains(ConnectivityResult.none);
  }

  @override
  Future<List<ConnectivityResult>> get connectivityResult async {
    return instance.checkConnectivity();
  }

  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged => instance.onConnectivityChanged;
}
