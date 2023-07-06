import 'package:exercise_counter/blocs/blocs.dart';
import 'package:flutter/material.dart';

export 'package:exercise_counter/blocs/connect_bloc.dart';
export 'package:exercise_counter/blocs/presser_bloc.dart';

class Blocs {
  PresserBloc presserBloc = PresserBloc();
  ConnectBloc connectBloc = ConnectBloc(ConnectionState.none);
}
