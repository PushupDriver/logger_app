import 'package:flutter_bloc/flutter_bloc.dart';

class PresserBloc extends Cubit<int> {
  PresserBloc() : super(0);

  void add(int state) => emit(state);
}
