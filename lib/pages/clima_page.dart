import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navegacoes/helpers/clima_helper.dart';
import '../cubit/clima_cubit.dart';
import '../cubit/clima_state.dart';
import '../models/clima_model.dart';
import '../repository/clima_repository.dart';

class ClimaPage extends StatefulWidget {
  const ClimaPage({super.key});

  @override
  State<ClimaPage> createState() => _ClimaPageState();
}

class _ClimaPageState extends State<ClimaPage> {
  TextEditingController searchController = TextEditingController();

  bool isSearch = false;

  void _isSearch() {
    setState(() {
      isSearch = !isSearch;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClimaCubit>(
      create: (context) {
        var repository = ClimaRepository();
        var climas = ClimaCubit(repository: repository);
        return climas;
      },
      child: Scaffold(
        body: BlocBuilder<ClimaCubit, ClimaState>(
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
                                        alignment: Alignment
                                            .centerRight, // Alinhar o ícone à direita
                                        children: [
                                          TextField(
                                            controller: searchController,
                                            onEditingComplete: () {
                                              context
                                                  .read<ClimaCubit>()
                                                  .getClimaByName(
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
                                                    .read<ClimaCubit>()
                                                    .getClimaByName(
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
                                  GestureDetector(
                                    onTap: () {
                                      _isSearch();
                                    },
                                    child: const Icon(Icons.search),
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
                          itemCount: state.climas!.length,
                          itemBuilder: (BuildContext context, int index) {
                            // Criar um card para cada Todo na lista
                            ClimaModel clima = state.climas![index];
                            return Column(
                              children: [
                                Card(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                         Text(clima.graus),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(clima.pais),
                                      ],
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(clima.municipio),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(ClimaPageLocalization()
                                            .tradutorClima(
                                                clima.tituloPrevisao)),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(children: [
                                              const Text("Temperatura Máxima"),
                                              Text('${clima.temperaturaMaxima}')
                                            ]),
                                            Column(children: [
                                              const Text(
                                                  "Temperatura Minínima"),
                                              Text('${clima.temperaturaMinima}')
                                            ])
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(children: [
                                              const Text("Previsão"),
                                              Text(
                                                  '${clima.temperaturaPrevisao}')
                                            ]),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
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
                                    width:
                                        MediaQuery.of(context).size.width * .78,
                                    child: Stack(
                                      alignment: Alignment
                                          .centerRight, // Alinhar o ícone à direita
                                      children: [
                                        TextField(
                                          controller: searchController,
                                          onEditingComplete: () {
                                            context
                                                .read<ClimaCubit>()
                                                .getClimaByName(
                                                    searchController.text);
                                          },
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10, 5, 35, 5),
                                          ),
                                        ),
                                        Positioned(
                                          right: 2,
                                          child: GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<ClimaCubit>()
                                                  .getClimaByName(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  child: Text(
                                    "Logo",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _isSearch();
                                  },
                                  child: const Icon(Icons.search),
                                ),
                              ],
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Não foi possível encontrar  ${searchController.text == '' ? 'a sua pesquisa, tente novamente.' : ', a região ${searchController.text} .'}',
                    textAlign: TextAlign.center,
                  )
                ],
              ));
            }
          },
        ),
      ),
    );
  }
}
