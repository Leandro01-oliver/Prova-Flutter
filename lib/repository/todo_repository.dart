import 'package:navegacoes/models/todo_model.dart';
import 'package:navegacoes/repository/interface/todo_interface.dart';

class TodoRepository implements TodoInterface{

   List<TodoModel> todos =  [
      TodoModel(1, 'mercado', 'comida',true),
      TodoModel(2, 'jogos', 'jogar gta 6',false),
      TodoModel(3, 'estudar programação', 'arquitetura bloc',true),
    ];

  @override
  Future<List<TodoModel>> getTodoAll() async{
    return todos;
  }
  
  @override
   Future<List<TodoModel>> getTodoByName(String query) async{
    List<TodoModel> filtroTodos = todos.where((item) => item.title.toLowerCase().contains(query.toLowerCase())).toList();
    return filtroTodos;
  }
  
  @override
  Future<TodoModel> updateTodoStatus({required int id, required bool isCompleted}) async {
    int index = todos.indexWhere((item) => item.id == id);
    if (index != -1) {
      TodoModel updatedTodo = TodoModel(
        todos[index].id,
        todos[index].title,
        todos[index].description,
        isCompleted, 
      );
      todos[index] = updatedTodo;
      return updatedTodo;
    } else {
      throw Exception("Todo não encontrado");
    }
  }

  @override
  Future<TodoModel> postTodo({required TodoModel todo}) async{
    if(todos.length > 0){
      int id = todos.last.id!;
      todos.add(TodoModel(id+1,todo.title, todo.description, todo.isCheck));
      TodoModel todoCreate = todos.lastOrNull!;
      return todoCreate;
    }else{
      int id = 0;
      todos.add(TodoModel(id,todo.title, todo.description, todo.isCheck));
      TodoModel todoCreate = todos.lastOrNull!;
      return todoCreate;
    }

  }

    @override
  Future<TodoModel> editTodo({required TodoModel todo}) async{
    int index = todos.indexWhere((item) => item.id == todo.id);
    if (index != -1) {
      TodoModel updatedTodo = TodoModel(todo.id, todo.title, todo.description,todo.isCheck);
      todos[index] = updatedTodo;
      return updatedTodo;
    } else {
      throw Exception("NADA");
    }
  }
  
  @override
  Future<TodoModel> deleteTodo({required int id}) async{
   List<TodoModel> todos = await getTodoAll();
   TodoModel todoExcluido =  todos.where((item) => item.id == id).first;
   todos.remove(todoExcluido);
   return todoExcluido;
  }

}
