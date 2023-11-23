import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import '../models/coin_model.dart';
import '../models/geolocation_model.dart';

class CoinHtpp {
  // ignore: unused_field
  final Dio _dio = Dio();
  final token = "";
  final String _url = "https://api.invertexto.com/v1/currency/";

  Future<List<CoinModel>> getCoinConversion({required String coin, int? price}) async {
    var endpoint = "";
     endpoint = coin == "" ? "${_url}BRL_BRL?$token" : "$_url${coin}_BRL?$token";
    var response = await _dio.get(endpoint);
    if (response.statusCode == 200) {
      // ignore: unused_local_variable
      Map<String, dynamic> data = response.data;
      // ignore: unused_local_variable
      List<CoinModel> listaCoin = [];
      listaCoin.add(CoinModel(
        price_balance: data["${coin}_BRL"]["price"],
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
