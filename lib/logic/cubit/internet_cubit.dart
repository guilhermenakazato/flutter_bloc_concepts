import 'dart:async';

import 'package:basic_bloc_concepts/constants/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  StreamSubscription? connectivityStreamSubscription;

  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    monitorInternetConnection();
  }

  void monitorInternetConnection() {
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult.first == ConnectivityResult.wifi) {
        internetConnected(ConnectionType.Wifi);
      } else if (connectivityResult.first == ConnectivityResult.mobile) {
        internetConnected(ConnectionType.Mobile);
      } else {
        internetDisconnected();
      }
    });
  }

  void internetConnected(ConnectionType connectionType) =>
      emit(InternetConnected(connectionType: connectionType));

  void internetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connectivityStreamSubscription?.cancel();
    return super.close();
  }
}
