import 'package:equatable/equatable.dart';

import '../models/todo_model.dart';

abstract class TodoState extends Equatable {}

class InitialState extends TodoState {
  @override
  List<Object> get props => [];
}

class LoadingState extends TodoState {
  @override
  List<Object> get props => [];
}

class LoadedState extends TodoState {
  LoadedState(this.todos);
  final List<TodoModel>? todos;
  @override
  List<Object> get props => [todos!];
}

class ErrorState extends TodoState {
  @override
  List<Object> get props => [];
}