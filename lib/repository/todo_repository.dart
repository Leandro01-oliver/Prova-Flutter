import 'package:navegacoes/models/todo_model.dart';
import 'package:navegacoes/repository/interface/todo_interface.dart';

class TodoRepository implements TodoInterface{

   List<TodoModel> todos =  [
      TodoModel(1, 'mercado', 'comida'),
      TodoModel(2, 'jogos', 'jogar gta 6'),
      TodoModel(3, 'estudar programação', 'arquitetura bloc'),
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
  Future<TodoModel> postTodo({required TodoModel todo}) async{
    if(todos.length > 0){
      int id = todos.last.id!;
      todos.add(TodoModel(id+1,todo.title, todo.description));
      TodoModel todoCreate = todos.lastOrNull!;
      return todoCreate;
    }else{
      int id = 0;
      todos.add(TodoModel(id,todo.title, todo.description));
      TodoModel todoCreate = todos.lastOrNull!;
      return todoCreate;
    }

  }

    @override
  Future<TodoModel> editTodo({required TodoModel todo}) async{
    int index = todos.indexWhere((item) => item.id == todo.id);
    if (index != -1) {
      TodoModel updatedTodo = TodoModel(todo.id, todo.title, todo.description);
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
