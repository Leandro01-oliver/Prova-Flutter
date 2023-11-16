import 'package:navegacoes/models/todo_model.dart';

abstract class TodoInterface{
  Future<List<TodoModel>> getTodoAll();
  Future<List<TodoModel>> getTodoByName(String query);
  Future<TodoModel> postTodo({required TodoModel todo});
  Future<TodoModel> deleteTodo({required int id});
  Future<TodoModel> editTodo({required TodoModel todo});
}