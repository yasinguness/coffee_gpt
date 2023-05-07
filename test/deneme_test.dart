import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "Login Gruplandırma",
    () {
      testWidgets(
        "Elevated Button",
        (widgetTester) async {
          await widgetTester.pumpWidget(MaterialApp(
            home: ElevatedButton(onPressed: () {}, child: const Text("Button")),
          ));

          final button = find.byType(ElevatedButton);
          expect(button, findsOneWidget);
        },
      );

      testWidgets(
        "Icon Button",
        (widgetTester) async {
          await widgetTester.pumpWidget(const MaterialApp(
            home: Icon(Icons.abc),
          ));

          final icon = find.byIcon(Icons.abc);
          expect(icon, findsOneWidget);
        },
      );
    },
  );
}
