import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/senha_model.dart';

class FormularioScreen extends StatefulWidget {
  final SenhaModel? senha; // Parâmetro opcional para editar uma senha existente

  FormularioScreen({Key? key, this.senha}) : super(key: key);

  @override
  _FormularioScreenState createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final ApiService apiService = ApiService();
  late TextEditingController _descricaoController;
  late TextEditingController _usuarioController;
  late TextEditingController _senhaController;
  bool editando = false;

  @override
  void initState() {
    super.initState();
    // Inicializa os controladores com os valores da senha, se estiver editando
    editando = widget.senha != null;
    _descricaoController = TextEditingController(
        text: widget.senha != null ? widget.senha!.descricao : '');
    _usuarioController = TextEditingController(
        text: widget.senha != null ? widget.senha!.usuario : '');
    _senhaController = TextEditingController(
        text: widget.senha != null ? widget.senha!.valor : '');
  }

  void salvarSenha() async {
    if (_descricaoController.text.isNotEmpty &&
        _usuarioController.text.isNotEmpty &&
        _senhaController.text.isNotEmpty) {
      SenhaModel senha = SenhaModel(
        id: widget.senha?.id ?? DateTime.now().millisecondsSinceEpoch,
        descricao: _descricaoController.text,
        usuario: _usuarioController.text,
        valor: _senhaController.text,
      );

      if (editando) {
        await apiService.updateSenha(senha); // Chama a função de atualização
      } else {
        await apiService.addSenha(senha); // Chama a função de adição
      }

      Navigator.pop(context); // Volta para a tela anterior após salvar
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Por favor, preencha todos os campos.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editando ? "Editar Senha" : "Adicionar Senha"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(labelText: "Descrição"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _usuarioController,
              decoration: InputDecoration(labelText: "Usuário"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _senhaController,
              decoration: InputDecoration(labelText: "Senha"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: salvarSenha,
              child: Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}
