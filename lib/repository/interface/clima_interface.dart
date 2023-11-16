import 'package:navegacoes/models/clima_model.dart';

abstract class ClimaInterface{
  Future<List<ClimaModel>> getClimaByName(String query);
}