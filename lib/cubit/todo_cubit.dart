import 'package:bloc/bloc.dart';
import '../models/todo_model.dart';
import '../repository/todo_repository.dart';
import 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository repository;

  TodoCubit({required this.repository}) : super(InitialState()) {
    _getTodoAll();
  }

  void _getTodoAll() async {
    try {
      emit(LoadingState());
      final List<TodoModel> todos = await repository.getTodoAll();
      emit(LoadedState(todos));
    } catch (e) {
      emit(ErrorState());
    }
  }

  void getTodoByName(String query) async {
    try {
      emit(LoadingState());
      final todos = await repository.getTodoByName(query);
      emit(LoadedState(todos));
    } catch (e) {
      emit(ErrorState());
    }
  }

  void postTodo({required TodoModel todoData}) async {
      try {
        emit(LoadingState());
        await repository.postTodo(todo: todoData);
        final List<TodoModel> todos = await repository.getTodoAll();
        emit(LoadedState(todos));
      } catch (e) {
        emit(ErrorState());
      }
    }

      void editarTodo({required TodoModel todoData}) async {
      try {
        emit(LoadingState());
        await repository.editTodo(todo: todoData);
        final List<TodoModel> todos = await repository.getTodoAll();
        emit(LoadedState(todos));
      } catch (e) {
        emit(ErrorState());
      }
    }

      void deleteTodo({required int id}) async {
      try {
        emit(LoadingState());
        await repository.deleteTodo(id: id);
        final List<TodoModel> todos = await repository.getTodoAll();
        emit(LoadedState(todos));
      } catch (e) {
        emit(ErrorState());
      }
    }
}
