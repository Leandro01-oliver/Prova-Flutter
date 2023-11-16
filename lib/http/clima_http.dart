import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

import '../models/clima_model.dart';
import '../models/geolocation_model.dart';

class ClimaHtpp {
  // ignore: unused_field
  final Dio _dio = Dio();
  final String _key = "";
  final String _url = "https://api.openweathermap.org/data/2.5/";

  Future<List<ClimaModel>> getClima({required String localidade}) async {
    // GeoLocalizacao geo =  GeoLocalizacao();
    if (localidade == "") {
      localidade = "Porto Velho";
    }
    var endpoint = "${_url}weather?q=$localidade&appid=$_key";
    var response = await _dio.get(endpoint);
    if (response.statusCode == 200) {
      // ignore: unused_local_variable
      Map<String, dynamic> data = response.data;
      List<ClimaModel> listaClima = [];
      var validateDeg;
      if('${data["wind"]["deg"]}'.length > 4){
        validateDeg = '${'${data["wind"]["deg"]}'[0]}${'${data["wind"]["deg"]}'[1]}.${'${data["wind"]["deg"]}'[2]}${'${data["wind"]["deg"]}'[3]}';
      }else if ('${data["wind"]["deg"]}'.length > 3){
         validateDeg = '${'${data["wind"]["deg"]}'[0]}${'${data["wind"]["deg"]}'[1]}.${'${data["wind"]["deg"]}'[2]}';
      }else if ('${data["wind"]["deg"]}'.length > 2){
            validateDeg = '${data["wind"]["deg"]}'[0]+'${data["wind"]["deg"]}'[1];
      }else{
          validateDeg = '${data["wind"]["deg"]}'[0];
      }

      listaClima.add(ClimaModel(
        graus: '$validateDeg°',
        municipio: data["name"],
        pais: data["sys"]["country"],
        tituloPrevisao: data["weather"][0]["main"],
        descricaoPrevisao: data["weather"][0]["description"],
        temperaturaMinima: data["main"]["temp_min"],
        temperaturaMaxima: data["main"]["temp_max"],
        temperaturaPrevisao: data["main"]["pressure"],
        temperaturaHumildade: data["main"]["humidity"],
      ));

      return listaClima;
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
