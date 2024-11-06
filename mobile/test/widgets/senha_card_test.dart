import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../lib/models/senha_model.dart';
import '../../lib/components/senha_card.dart';

void main() {
  testWidgets('Deve exibir as informações da senha e responder aos botões de ação', (WidgetTester tester) async {
    // Cria um exemplo de senha
    final senha = SenhaModel(
      id: 1,
      descricao: "Minha conta de email",
      usuario: "email@example.com",
      valor: "senha123",
    );

    // Cria callbacks simulados para os botões de edição e exclusão
    bool editPressed = false;
    bool deletePressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SenhaCard(
            senha: senha,
            onEdit: () {
              editPressed = true;
            },
            onDelete: () {
              deletePressed = true;
            },
          ),
        ),
      ),
    );

    // Verifica se as informações da senha estão sendo exibidas corretamente
    expect(find.text("Minha conta de email"), findsOneWidget);
    expect(find.text("email@example.com"), findsOneWidget);
    expect(find.text("senha123"), findsOneWidget);

    // Simula um toque no botão de edição e verifica se o callback foi chamado
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pump();
    expect(editPressed, isTrue);

    // Simula um toque no botão de exclusão e verifica se o callback foi chamado
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();
    expect(deletePressed, isTrue);
  });
}
