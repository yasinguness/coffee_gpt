import 'package:coffe_app/ui/coffe_detail/view_model/coffee_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    final cf = CoffeeDetailViewModel();
    cf.incrementCounter();

    expect(cf.counter, 2);
  });
}
