import 'package:flutter/material.dart';
import '../models/categoria_model.dart';

class CategoriaSelector extends StatelessWidget {
  final List<CategoriaModel> categorias;
  final Function(CategoriaModel) onCategoriaSelecionada;

  const CategoriaSelector({
    Key? key,
    required this.categorias,
    required this.onCategoriaSelecionada,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<CategoriaModel>(
      isExpanded: true,
      items: categorias.map((categoria) {
        return DropdownMenuItem(
          value: categoria,
          child: Text(categoria.nome),
        );
      }).toList(),
      onChanged: (CategoriaModel? categoria) {
        if (categoria != null) onCategoriaSelecionada(categoria);
      },
      hint: Text("Selecione uma categoria"),
    );
  }
}
