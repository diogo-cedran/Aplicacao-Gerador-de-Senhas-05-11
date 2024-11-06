import 'package:flutter/material.dart';
import '../models/senha_model.dart';

class SenhaCard extends StatelessWidget {
  final SenhaModel senha;
  final Function() onDelete;
  final Function() onEdit;

  const SenhaCard({
    Key? key,
    required this.senha,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title: Text(senha.descricao),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Usuário: ${senha.usuario}"),
            Text("Senha: ${senha.valor}"),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit, // Chama a função de edição
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete, // Chama a função de exclusão
            ),
          ],
        ),
      ),
    );
  }
}
