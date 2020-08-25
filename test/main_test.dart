import 'package:riauful_sdk/riauful_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('Destination', () {
    test('Get all destination', () async {
      var riauful = new RiauFul();
      var data = await riauful.destination.getOnPage(1);

      data.forEach((f) {
        expect(f.name, isNotEmpty);
        expect(f.address, isNotEmpty);
        expect(f.category, isNotEmpty);
        expect(f.thumbnail, isNotEmpty);
        expect(f.thumbnail, isNotEmpty);
      });
    });
  });
}
