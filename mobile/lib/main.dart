import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'utils/routes.dart';

void main() {
  runApp(GerenciadorSenhasApp());
}

class GerenciadorSenhasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerador e Armazenador de Senhas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
