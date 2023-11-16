class ClimaModel {
  final String graus;
  final String municipio;
  final String pais;
  final String tituloPrevisao;
  final String descricaoPrevisao;
  final double temperaturaMinima;
  final double temperaturaMaxima;
  final int temperaturaPrevisao;
  final int temperaturaHumildade;

  ClimaModel(
  {
    required this.graus,
    required this.municipio,
    required this.pais,
    required this.tituloPrevisao,
    required this.descricaoPrevisao,
    required this.temperaturaMinima,
    required this.temperaturaMaxima,
    required this.temperaturaPrevisao,
    required this.temperaturaHumildade,
  }
  );

  Map<String, dynamic> toJson() {
    return {
      'graus': graus,
      'municipio': municipio,
      'pais': pais,
      'tituloPrevisao': tituloPrevisao,
      'descricaoPrevisao': descricaoPrevisao,
      'temperaturaMinima': temperaturaMinima,
      'temperaturaMaxima': temperaturaMaxima,
      'temperaturaPrevisao': temperaturaPrevisao,
      'temperaturaHumildade': temperaturaHumildade,
    };
  }

  factory ClimaModel.fromJson(Map<String, dynamic> json) {
    return ClimaModel(
      graus: json['graus'],
      municipio: json['municipio'],
      pais: json['pais'],
      tituloPrevisao: json['tituloPrevisao'],
      descricaoPrevisao: json['descricaoPrevisao'],
      temperaturaMinima: json['temperaturaMinima'],
      temperaturaMaxima: json['temperaturaMaxima'],
      temperaturaPrevisao: json['temperaturaPrevisao'],
      temperaturaHumildade: json['temperaturaHumildade'],
    );
  }
}
