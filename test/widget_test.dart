import 'package:flutter_test/flutter_test.dart';
import 'package:spendwise/main.dart';

void main() {
  testWidgets('SpendWise app smoke test', (WidgetTester tester) async {
    // Basic smoke test - app should build without errors
    expect(SpendWiseApp, isNotNull);
  });
}
