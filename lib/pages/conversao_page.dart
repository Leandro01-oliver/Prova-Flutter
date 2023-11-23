import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/coin_cubit.dart';
import '../cubit/coin_state.dart';
import '../repository/coin_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class ConversaoPage extends StatefulWidget {
  const ConversaoPage({super.key});

  @override
  State<ConversaoPage> createState() => _ConversaoPageState();
}

class _ConversaoPageState extends State<ConversaoPage> {
  TextEditingController valueController = TextEditingController();

  String? _selectedCoinOne;

  List<String> coinOne = [
                          'USD - dólar', 
                          'EUR - euro',
                          'GBP - libra esterlina',
                          'JPY - iene',
                          'ARS - peso argentino',
                          'MXN - peso mexicano'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CoinCubit>(
      create: (context) {
        var repository = CoinRepository();
        var climas = CoinCubit(repository: repository);
        return climas;
      },
      child: Scaffold(
        body: BlocBuilder<CoinCubit, CoinState>(
          builder: (context, state) {
            // Verificar o estado atual
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LoadedState) {
              // Exibir a lista de Todos
              var valorCalculado = state.coins[0].price_balance *
                  double.parse(valueController.text);
              return SafeArea(
                child: Column(
                  children: [
                    _buildFormCoin(coinCubit: context.read<CoinCubit>()),
                    SizedBox(height: 20,),
                    Container(
                        child: Text(
                          NumberFormat("#,##0.00", "pt_BR")
                              .format(valorCalculado.abs()),
                      style: TextStyle(fontSize: 20),
                    )),
                  ],
                ),
              );
            } else {
              return SafeArea(
                child: Column(
                  children: [
                    _buildFormCoin(coinCubit: context.read<CoinCubit>())
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildFormCoin({required CoinCubit coinCubit}) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          DropdownButton<String>(
            isExpanded: true,
            value: _selectedCoinOne,
            hint: const Text('Selecione uma primeira cotação'),
            onChanged: (String? newValue) {
              setState(() {
                _selectedCoinOne = newValue!;
              });
            },
            items: coinOne.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(
            height: 20,
          ),
          _selectedCoinOne != null ?
          TextField(
            keyboardType: TextInputType.number,
            controller: valueController,
            inputFormatters: [
              FilteringTextInputFormatter(RegExp("[0-9]"), allow: true)
            ],
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1)),
              floatingLabelAlignment: FloatingLabelAlignment.center,
              labelText: 'Valor da conversão para Real',
              alignLabelWithHint: true,
              hintStyle: TextStyle(color: Colors.black),
              labelStyle: TextStyle(fontSize: 14.0, color: Colors.black),
            ),
          )
          :
          const SizedBox(),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                var valor = int.parse(valueController.text);
                coinCubit.getCoinConversion(
                    coin: _selectedCoinOne!.substring(0,3), price: valor);
              },
              child: const Text("Converter"))
        ],
      ),
    );
  }
}
