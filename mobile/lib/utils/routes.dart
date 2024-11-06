import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/lista_screen.dart';
import '../screens/formulario_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/lista':
        return MaterialPageRoute(builder: (_) => ListaScreen());
      case '/formulario':
        return MaterialPageRoute(builder: (_) => FormularioScreen());
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}
