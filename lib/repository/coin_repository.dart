import 'package:navegacoes/models/coin_model.dart';

import '../http/coin_http.dart';
import 'interface/coin_interface.dart';
class CoinRepository implements CoinInterface{
  final CoinHtpp _coinHttp = CoinHtpp();

  @override
  Future<List<CoinModel>> getCoinConversion({required String coin,  int? price}) async{
    List<CoinModel> coinModel = await _coinHttp.getCoinConversion(coin: coin,price: price);
    return coinModel;
  }


}
