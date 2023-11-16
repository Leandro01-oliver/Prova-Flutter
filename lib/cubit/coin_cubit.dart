import 'package:bloc/bloc.dart';
import '../repository/coin_repository.dart';
import 'coin_state.dart';

class CoinCubit extends Cubit<CoinState> {
  final CoinRepository repository;

  CoinCubit({required this.repository}) : super(InitialState()) {
    getCoinConversion(coin:'');
  }

  void getCoinConversion({required String coin, int? price}) async {
    try {
      emit(LoadingState());
      final coins = await repository.getCoinConversion(coin: coin,price: price);
      emit(LoadedState(coins));
    } catch (e) {
      emit(ErrorState());
    }
  }

}
