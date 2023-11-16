import 'package:navegacoes/models/coin_model.dart';

abstract class CoinInterface{
  Future<List<CoinModel>> getCoinConversion({required String coin, required int price});
}