import 'package:flutter/material.dart';
import 'package:navegacoes/pages/clima_page.dart';
import 'package:navegacoes/pages/conversao_page.dart';
import 'pages/todo_page.dart';

class Initialize extends StatefulWidget {
  const Initialize({super.key});

  @override
  State<Initialize> createState() => _InitializeState();
}

class _InitializeState extends State<Initialize> {

  static const int _cardIndex = 0;

  final List<Widget> _pages = [
    const ClimaPage(),
    const ConversaoPage(),
    const TodoPage()
  ];

  int _currentIndex = _cardIndex;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
           body: IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),
     bottomNavigationBar: BottomNavigationBar(
            fixedColor: Colors.blue,
            currentIndex: _currentIndex,
            onTap: _onItemTapped,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'HOME',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.control_point),
                label: 'Conversao',
              ),
                   BottomNavigationBarItem(
                icon: Icon(Icons.task),
                label: 'Todo',
              ),
            ],
          ),
      ),
    );
  }
}