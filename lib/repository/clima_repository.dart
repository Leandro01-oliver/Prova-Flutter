import 'package:navegacoes/models/clima_model.dart';
import '../http/clima_http.dart';
import 'interface/clima_interface.dart';
class ClimaRepository implements ClimaInterface{
  final ClimaHtpp _climaHttp = ClimaHtpp();
  @override
  Future<List<ClimaModel>> getClimaByName(String query) async{
    List<ClimaModel> climaModel = await _climaHttp.getClima(localidade: query);
    return climaModel;
  }

}
