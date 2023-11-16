import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import '../models/coin_model.dart';
import '../models/geolocation_model.dart';

class CoinHtpp {
  // ignore: unused_field
  final Dio _dio = Dio();
  final String _url = "https://economia.awesomeapi.com.br/json/last";

  Future<List<CoinModel>> getCoinConversion({required String coin, int? price}) async {
    var endpoint = "";
     endpoint = "$_url/$coin";
    var response = await _dio.get(endpoint);
    if (response.statusCode == 200) {
      // ignore: unused_local_variable
      Map<String, dynamic> data = response.data;
      // ignore: unused_local_variable
      List<CoinModel> listaCoin = [];
      listaCoin.add(CoinModel(
        type_balance: data["${coin}BRL"]["code"],
        price_balance: data["${coin}BRL"]["bid"],
        value_changer: '',
      ));
      return listaCoin;
    } else {
      throw Exception("nada encontrado");
    }
  }

  Future<GeoLocalizacao> getLocalizationDivice() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    double latitude = position.latitude;
    double longitude = position.longitude;

    return GeoLocalizacao(latitude: latitude, longitude: longitude);
  }
}
