import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../lib/services/api_service.dart';
import '../../lib/models/senha_model.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('ApiService', () {
    final apiService = ApiService();
    final client = MockClient();

    // Teste para verificar se o método getSenhas retorna uma lista de senhas corretamente
    test('Deve retornar uma lista de senhas no método getSenhas', () async {
      // Mock da resposta HTTP
      when(client.get(Uri.parse('${ApiService.baseUrl}/senhas')))
          .thenAnswer((_) async => http.Response(
            jsonEncode([
              {
                "id": 1,
                "descricao": "Minha conta de email",
                "usuario": "email@example.com",
                "valor": "senha123"
              },
              {
                "id": 2,
                "descricao": "Conta do banco",
                "usuario": "usuarioBanco",
                "valor": "senha456"
              }
            ]), 200));

      // Chama o método
      List<SenhaModel> senhas = await apiService.getSenhas();

      // Verifica se o método retorna a lista correta
      expect(senhas, isA<List<SenhaModel>>());
      expect(senhas.length, 2);
      expect(senhas[0].descricao, "Minha conta de email");
      expect(senhas[1].usuario, "usuarioBanco");
    });

    // Teste para verificar o filtro de senhas com base no atributo descricao
    test('Deve retornar apenas senhas com descrição contendo "Conta"', () async {
      // Mock da resposta HTTP
      when(client.get(Uri.parse('${ApiService.baseUrl}/senhas')))
          .thenAnswer((_) async => http.Response(
            jsonEncode([
              {
                "id": 1,
                "descricao": "Minha conta de email",
                "usuario": "email@example.com",
                "valor": "senha123"
              },
              {
                "id": 2,
                "descricao": "Conta do banco",
                "usuario": "usuarioBanco",
                "valor": "senha456"
              },
              {
                "id": 3,
                "descricao": "Redes sociais",
                "usuario": "socialUser",
                "valor": "senha789"
              }
            ]), 200));

      // Chama o método
      List<SenhaModel> senhas = await apiService.getSenhas();

      // Aplica o filtro
      List<SenhaModel> senhasComConta = senhas.where((s) => s.descricao.contains("Conta")).toList();

      // Verifica se o filtro está funcionando corretamente
      expect(senhasComConta.length, 2);
      expect(senhasComConta[0].descricao, "Minha conta de email");
      expect(senhasComConta[1].descricao, "Conta do banco");
    });
  });
}
