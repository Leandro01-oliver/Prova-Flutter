import 'package:equatable/equatable.dart';

import '../models/coin_model.dart';

abstract class CoinState extends Equatable {}

class InitialState extends CoinState {
  @override
  List<Object> get props => [];
}

class LoadingState extends CoinState {
  @override
  List<Object> get props => [];
}

class LoadedState extends CoinState {
  LoadedState(this.coins);
  final List<CoinModel> coins;
  @override
  List<Object> get props => [coins];
}

class ErrorState extends CoinState {
  @override
  List<Object> get props => [];
}