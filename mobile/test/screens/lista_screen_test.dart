import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../lib/screens/lista_screen.dart';
import '../../lib/services/api_service.dart';
import '../../lib/models/senha_model.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  testWidgets('Deve exibir a lista de senhas corretamente', (WidgetTester tester) async {
    // Cria o mock do ApiService
    final mockApiService = MockApiService();
    // Simula a resposta do getSenhas com dados de exemplo
    when(mockApiService.getSenhas()).thenAnswer((_) async => [
      SenhaModel(id: 1, descricao: "Minha conta de email", usuario: "email@example.com", valor: "senha123"),
      SenhaModel(id: 2, descricao: "Conta do banco", usuario: "usuarioBanco", valor: "senha456"),
    ]);

    // Renderiza a ListaScreen usando o MaterialApp para suporte completo de widgets
    await tester.pumpWidget(
      MaterialApp(
        home: ListaScreen(),
      ),
    );

    // Aguarda que o widget se atualize após a resposta simulada
    await tester.pump();

    // Verifica se os itens de senha são exibidos corretamente na tela
    expect(find.text("Minha conta de email"), findsOneWidget);
    expect(find.text("Conta do banco"), findsOneWidget);
    expect(find.text("email@example.com"), findsOneWidget);
    expect(find.text("usuarioBanco"), findsOneWidget);
  });
}
