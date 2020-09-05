// Import the test package and Counter class
import 'package:freelancer/demo.dart';
// ignore: deprecated_member_use
import 'package:test_api/test_api.dart';

void main() {
  test('Counter value should be incremented', () {
    final counter = Counter();

    counter.increment();

    expect(counter.value, 1);
  });
}
