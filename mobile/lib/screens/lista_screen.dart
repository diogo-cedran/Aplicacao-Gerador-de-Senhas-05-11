import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../components/senha_card.dart';
import '../models/senha_model.dart';
import 'formulario_screen.dart';

class ListaScreen extends StatefulWidget {
  @override
  _ListaScreenState createState() => _ListaScreenState();
}

class _ListaScreenState extends State<ListaScreen> {
  final ApiService apiService = ApiService();
  List<SenhaModel> senhas = [];
  bool carregando = true;
  String mensagemErro = "";

  @override
  void initState() {
    super.initState();
    carregarSenhas();
  }

  void carregarSenhas() async {
    setState(() {
      carregando = true;
      mensagemErro = "";
    });
    try {
      senhas = await apiService.getSenhas();
      setState(() {}); // Atualiza o estado após carregar as senhas
    } catch (e) {
      setState(() {
        mensagemErro = "Não foi possível carregar as senhas.";
      });
    } finally {
      setState(() {
        carregando = false;
      });
    }
  }

  void deletarSenha(int id) async {
    try {
      await apiService.deleteSenha(id);
      carregarSenhas(); // Recarrega a lista após exclusão
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao deletar a senha.")),
      );
    }
  }

  void editarSenha(SenhaModel senha) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormularioScreen(senha: senha),
      ),
    );
    carregarSenhas(); // Recarrega a lista após edição
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas Senhas"),
        backgroundColor: Colors.blueAccent,
      ),
      body: carregando
          ? Center(child: CircularProgressIndicator())
          : mensagemErro.isNotEmpty
              ? Center(child: Text(mensagemErro))
              : senhas.isEmpty
                  ? Center(child: Text("Nenhuma senha salva."))
                  : ListView.builder(
                      itemCount: senhas.length,
                      itemBuilder: (context, index) {
                        return SenhaCard(
                          senha: senhas[index],
                          onDelete: () => deletarSenha(senhas[index].id),
                          onEdit: () => editarSenha(senhas[index]),
                        );
                      },
                    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FormularioScreen()),
        ).then((_) => carregarSenhas()), // Recarrega a lista após adicionar nova senha
        child: Icon(Icons.add),
      ),
    );
  }
}
