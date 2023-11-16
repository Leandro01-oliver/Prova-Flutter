class GeoLocalizacao{
  double? latitude;
  double? longitude ;

  
  GeoLocalizacao(
  {
    this.latitude,
    this.longitude
  }
  );

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory GeoLocalizacao.fromJson(Map<String, dynamic> json) {
    return GeoLocalizacao(
      latitude: json['latitude'],
      longitude: json['longitude']
    );
  }
}