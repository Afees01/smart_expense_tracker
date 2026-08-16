import 'package:flutter_test/flutter_test.dart';
import 'package:smart_expense_tracker/core/network/network_client.dart';
import 'package:smart_expense_tracker/core/network/securetoken.dart';
import 'package:smart_expense_tracker/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(
      WealthFlowApp(
        client: NetworkClient(),
        token: Securetoken(),
      ),
    );

    expect(find.byType(WealthFlowApp), findsOneWidget);
  });
}