import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectBloc extends Cubit<int> {
  ConnectBloc(super.initialState);

  void add(int state) => emit(state);
}
