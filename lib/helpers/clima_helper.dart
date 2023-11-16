class ClimaPageLocalization {
  String tradutorClima(String str) {
    var traducao = '';
    switch (str) {
      case 'Clouds':
        traducao = 'Nuvens';
        break;
      case 'Clear':
        traducao = 'Tempo Limpo';
        break;
      case 'Rain':
        traducao = 'Chuva';
        break;
      default:
    }

    return traducao;
  }
}
