import 'package:bloc/bloc.dart';
import 'package:navegacoes/repository/clima_repository.dart';
import 'clima_state.dart';

class ClimaCubit extends Cubit<ClimaState> {
  final ClimaRepository repository;

  ClimaCubit({required this.repository}) : super(InitialState()) {
    getClimaByName('');
  }

  void getClimaByName(String query) async {
    try {
      emit(LoadingState());
      final todos = await repository.getClimaByName(query);
      emit(LoadedState(todos));
    } catch (e) {
      emit(ErrorState());
    }
  }

}
