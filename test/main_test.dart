import 'package:riauful_sdk/riauful_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('Destination', () {
    test('Get all destination', () {
      var riauful = new RiauFul();

      expect(riauful.destination.all(), []);
    });
  });
}
