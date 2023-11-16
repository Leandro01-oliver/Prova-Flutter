import 'package:equatable/equatable.dart';
import 'package:navegacoes/models/clima_model.dart';

abstract class ClimaState extends Equatable {}

class InitialState extends ClimaState {
  @override
  List<Object> get props => [];
}

class LoadingState extends ClimaState {
  @override
  List<Object> get props => [];
}

class LoadedState extends ClimaState {
  LoadedState(this.climas);
  final List<ClimaModel>? climas;
  @override
  List<Object> get props => [climas!];
}

class ErrorState extends ClimaState {
  @override
  List<Object> get props => [];
}