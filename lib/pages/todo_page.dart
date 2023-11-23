import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navegacoes/models/todo_model.dart';
import 'package:navegacoes/repository/todo_repository.dart';
import '../cubit/todo_cubit.dart';
import '../cubit/todo_state.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TextEditingController searchController = TextEditingController();

  bool isSearch = false;

  void _isSearch() {
    setState(() {
      isSearch = !isSearch;
    });
  }
  
  void _showAddTodoDialog({required TodoCubit todoCubit}) {
    TextEditingController controllerTitle = TextEditingController();
    TextEditingController controllerDescricao = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controllerTitle,
                decoration: const InputDecoration(
                  labelText: 'Título',
                ),
              ),
              TextField(
                controller: controllerDescricao,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                todoCubit.postTodo(
                  todoData: TodoModel(
                      null, controllerTitle.text, controllerDescricao.text,false),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  void _showEditeTodoDialog(
      {required TodoCubit todoCubit, required TodoModel todoModel}) {
    TextEditingController controllerTitle = TextEditingController();
    TextEditingController controllerDescricao = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        controllerTitle.text = todoModel.title;
        controllerDescricao.text = todoModel.description;

        return AlertDialog(
          title: const Text('Editar Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controllerTitle,
                decoration: const InputDecoration(
                  labelText: 'Título',
                ),
              ),
              TextField(
                controller: controllerDescricao,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                todoCubit.editarTodo(
                  todoData: TodoModel(todoModel.id, controllerTitle.text,
                      controllerDescricao.text,todoModel.isCheck),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Editar'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoCubit>(
      create: (context) {
        var repository = TodoRepository();
        var todos = TodoCubit(repository: repository);
        return todos;
      },
      child: Scaffold(
        body: BlocBuilder<TodoCubit, TodoState>(
          builder: (context, state) {
            // Verificar o estado atual
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LoadedState) {
              // Exibir a lista de Todos
              return SafeArea(
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(108, 0, 0, 0),
                            blurRadius: 5.0,
                            offset: Offset(0, .15),
                          ),
                        ],
                      ),
                      child: isSearch == true
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _isSearch();
                                        searchController.clear();
                                      },
                                      child: const Icon(Icons.arrow_back),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .78,
                                      child: Stack(
                                        alignment: Alignment.centerRight,
                                        children: [
                                          TextField(
                                            controller: searchController,
                                            onEditingComplete: () {
                                              context
                                                  .read<TodoCubit>()
                                                  .getTodoByName(
                                                      searchController.text);
                                            },
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      10, 5, 35, 5),
                                            ),
                                          ),
                                          Positioned(
                                            right: 2,
                                            child: GestureDetector(
                                              onTap: () {
                                                context
                                                    .read<TodoCubit>()
                                                    .getTodoByName(
                                                        searchController.text);
                                              },
                                              child: const Icon(Icons.search),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        searchController.clear();
                                      },
                                      child: const Icon(Icons.clear),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(
                                    child: Text(
                                      "Logo",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _showAddTodoDialog(
                                              todoCubit:
                                                  context.read<TodoCubit>());
                                        },
                                        child: const Icon(Icons.add),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _isSearch();
                                        },
                                        child: const Icon(Icons.search),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ListView.builder(
                            itemCount: state.todos!.length,
                            itemBuilder: (BuildContext context, int index) {
                              TodoModel todo = state.todos![index];
                              return Dismissible(
                                key: ObjectKey(todo),
                                onDismissed: (DismissDirection direction) {
                                  if (direction == DismissDirection.endToStart) {
                                       _showEditeTodoDialog(
                                                        todoCubit: context
                                                            .read<TodoCubit>(),
                                                        todoModel: TodoModel(
                                                            todo.id,
                                                            todo.title,
                                                            todo.description,
                                                            todo.isCheck
                                                            ));
                                  }else{
                                       context.read<TodoCubit>().deleteTodo(id: todo.id!);
                                  }
                                },
                                child: Column(
                                  children: [
                                    Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(children: [
                                              // crie um checkbox aqui chatgpt que interaja com a lista de todoList
                                            ListTile(
                                                leading: Checkbox(
                                                value: todo.isCheck,
                                                onChanged: (bool? value) { 
                                                  context.read<TodoCubit>().updateTodoStatus(
                                                        todo.id!,
                                                        value ?? false,
                                                      );
                                                },
                                              ),
                                                title: Text(todo.title),
                                                subtitle: Text(todo.description),
                                              ),
                                          ],)
                                          ),
                                        ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const Center(child: Text('Erro ao carregar os Todos.'));
            }
          },
        ),
      ),
    );
  }
}
