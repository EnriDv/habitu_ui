import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:habitu_ui/habitu_ui.dart';

void main() {
  testWidgets('HabituButton renders label', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: HabituTheme.lightTheme,
        home: const Scaffold(
          body: HabituButton(label: 'Guardar', onPressed: null),
        ),
      ),
    );

    expect(find.text('Guardar'), findsOneWidget);
  });

  testWidgets('AccessModeSwitch renders labels', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: HabituTheme.lightTheme,
        home: Scaffold(
          body: AccessModeSwitch(
            selectedIndex: 0,
            labels: const ['Entrar', 'Crear cuenta'],
            onChanged: (_) {},
          ),
        ),
      ),
    );

    expect(find.text('Entrar'), findsOneWidget);
    expect(find.text('Crear cuenta'), findsOneWidget);
  });
}
