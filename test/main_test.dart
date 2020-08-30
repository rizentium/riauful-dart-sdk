import 'package:riauful_sdk/interfaces/attraction.dart';
import 'package:riauful_sdk/riauful_sdk.dart';
import 'package:test/test.dart';

void main() {
  var riauful = new RiauFul();
  group('Attraction', () {
    test('Get all attractions using pagination', () async {
      var pages = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

      pages.forEach((f) async {
        var data = await riauful.attraction.getOnPage(f);

        data.forEach((f) async {
          expect(f.name, isNotEmpty);
          expect(f.location, isNotEmpty);
          expect(f.address, isNotEmpty);
          expect(f.category, isNotEmpty);
          expect(f.thumbnail, isNotEmpty);

          var result = await riauful.attraction.find(f.id);
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
    test('Get attractions by categories', () {
      // Artificial
      riauful.attraction
          .findAllByCategory(AttractionCategory.artificial)
          .then((artificail) {
        artificail.forEach((f) async {
          expect(f.name, isNotEmpty);
          expect(f.location, isNotEmpty);
          expect(f.category, isNotEmpty);

          var result = await riauful.attraction.find(f.id);
          expect(result.name, isNotEmpty);
          expect(result.location, isNotEmpty);
          expect(result.address, isNotEmpty);
          expect(result.category, isNotEmpty);
          expect(result.thumbnail, isNotEmpty);
          expect(result.description.length > 0, true);
          expect(result.detail.length > 0, true);
        });
      });
      // Culture
      riauful.attraction
          .findAllByCategory(AttractionCategory.culture)
          .then((artificail) {
        artificail.forEach((f) async {
          expect(f.name, isNotEmpty);
          expect(f.location, isNotEmpty);
          expect(f.category, isNotEmpty);

          var result = await riauful.attraction.find(f.id);
          expect(result.name, isNotEmpty);
          expect(result.location, isNotEmpty);
          expect(result.address, isNotEmpty);
          expect(result.category, isNotEmpty);
          expect(result.thumbnail, isNotEmpty);
          expect(result.description.length > 0, true);
          expect(result.detail.length > 0, true);
        });
      });
      // Nature
      riauful.attraction
          .findAllByCategory(AttractionCategory.nature)
          .then((artificail) {
        artificail.forEach((f) async {
          expect(f.name, isNotEmpty);
          expect(f.location, isNotEmpty);
          expect(f.category, isNotEmpty);

          var result = await riauful.attraction.find(f.id);
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

    test('Get attractions', () {
      riauful.attraction.all().then((artificail) {
        artificail.forEach((f) async {
          expect(f.name, isNotEmpty);
          expect(f.location, isNotEmpty);
          expect(f.category, isNotEmpty);

          var result = await riauful.attraction.find(f.id);
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
    test('Get all places', () {
      riauful.attraction.getPlaces().then((data) {
        data.forEach((f) {
          expect(f, isNotNull);
          expect(f, isNotEmpty);
        });
      });
    });
    test('Get attractions by place', () async {
      riauful.attraction.getPlaces().then((places) {
        places.forEach((f) async {
          var result = await riauful.attraction.findAllByPlaces([f]);

          result.forEach((attraction) {
            expect(f, attraction.location);
          });
        });
      });
    });

    test('Get recommendations', () {
      riauful.attraction.getRecommendations(10).then((artificail) {
        artificail.forEach((f) async {
          expect(f.name, isNotEmpty);
          expect(f.location, isNotEmpty);
          expect(f.category, isNotEmpty);

          var result = await riauful.attraction.find(f.id);
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
