import 'package:riauful_sdk/riauful_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('Destination', () {
    test('Get all destination', () async {
      var riauful = new RiauFul();

      var pages = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

      pages.forEach((f) async {
        var data = await riauful.destination.getOnPage(f);

        data.forEach((f) async {
          expect(f.name, isNotEmpty);
          expect(f.location, isNotEmpty);
          expect(f.address, isNotEmpty);
          expect(f.category, isNotEmpty);
          expect(f.thumbnail, isNotEmpty);

          var result = await riauful.destination.find(f.id);
          expect(result.name, isNotEmpty);
          expect(result.location, isNotEmpty);
          expect(result.address, isNotEmpty);
          expect(result.category, isNotEmpty);
          expect(result.thumbnail, isNotEmpty);
          expect(result.description.length > 0, true);
          expect(result.detail.length > 0, true);
        });
      });
    });
  });
}
