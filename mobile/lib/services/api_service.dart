import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/senha_model.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:3001';

Future<List<SenhaModel>> getSenhas() async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/senhas'));
    print("Código de resposta: ${response.statusCode}");
    print("Corpo da resposta: ${response.body}"); // Adiciona o corpo da resposta para depuração

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      print("Dados decodificados: $data"); // Adiciona os dados decodificados para verificação
      return data.map((e) => SenhaModel.fromJson(e)).toList();
    } else {
      print("Erro ao carregar senhas: Código de status ${response.statusCode}");
      throw Exception("Erro ao carregar senhas");
    }
  } catch (e) {
    print("Erro ao tentar carregar as senhas: $e");
    throw Exception("Erro ao carregar senhas");
  }
}


  Future<void> addSenha(SenhaModel senha) async {
    final response = await http.post(
      Uri.parse('$baseUrl/senhas'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(senha.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception("Erro ao salvar a senha");
    }
  }

  Future<void> updateSenha(SenhaModel senha) async {
    final response = await http.put(
      Uri.parse('$baseUrl/senhas/${senha.id}'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(senha.toJson()),
    );
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Erro ao atualizar a senha");
    }
  }

  Future<void> deleteSenha(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/senhas/$id'));
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Erro ao deletar a senha");
    }
  }
}
