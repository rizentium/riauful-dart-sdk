import 'dart:math';

import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:riauful_sdk/interfaces/attraction.dart';

class Attraction {
  final _client = new Client();
  final _host = 'https://destinasiriau.travel';
  // Get all destination in Province of Riau
  Future<List<AttractionInterface>> all() async {
    try {
      List<AttractionInterface> data = [];
      data.addAll(await this.findAllByCategory(AttractionCategory.artificial));
      data.addAll(await this.findAllByCategory(AttractionCategory.culture));
      data.addAll(await this.findAllByCategory(AttractionCategory.nature));
      return data;
    } catch (err) {
      return err;
    }
  }

  // Get all destination in Province of Riau using pagination
  Future<List<AttractionInterface>> getOnPage(int page) async {
    try {
      Response response =
          await _client.post('$_host/dataod.php', body: {'page': '$page'});

      var document = parse(response.body);

      List<AttractionInterface> data =
          document.querySelectorAll('.product-box').map((f) {
        var thumbnail = f
            .querySelectorAll('div[style*="background-position: center;"]')
            .first
            .attributes['style']
            .split(';')[0]
            .replaceAll('background-image: url(', '')
            .replaceAll(')', '');
        return AttractionInterface(
          id: '$_host/' +
              f
                  .querySelector('.item-title')
                  .querySelector('a')
                  .attributes['href'],
          name: f.querySelector('.item-title').text.trim(),
          location: f.querySelector('.item-status').text.trim(),
          address: f.querySelector('.contact-info').children[2].text.trim(),
          thumbnail:
              thumbnail != 'imgee/uploads/' ? '$_host/' + thumbnail : null,
          category: f.querySelector('.btn-category').text.trim(),
        );
      }).toList();
      return data;
    } catch (err) {
      return err;
    }
  }

  Future<AttractionInterface> find(String url) async {
    try {
      Response response = await _client.get(url);

      var document = parse(response.body);

      var detail = document
          .getElementById('venue')
          .querySelector('div > table > tbody')
          .children
          .where((data) => data.children.length > 1)
          .toList()
          .map((f) => {
                'title': f.children[0].text.trim(),
                'desc': f.children[1].text
                    .replaceAll(':', '')
                    .replaceAll('•', '')
                    .trim()
              })
          .toList();

      var description = document
          .querySelector('.listing-details-info > table > tbody')
          .children
          .map((f) => {
                'title': f.children[0].text.trim(),
                'desc': f.children[1].text
                    .replaceAll(':', '')
                    .replaceAll('•', '')
                    .trim()
              })
          .toList();

      var thumbnail = document
          .getElementById('layout-content')
          .children
          .where((f) => f.attributes['property'] != null)
          .first
          .attributes['content'];

      return AttractionInterface(
          id: url,
          name: document.querySelector('.item-title').text.trim(),
          location: detail.where((r) => r['title'] == 'Alamat').first['desc'],
          address: detail
              .where((r) => r['title'] == 'Desa' || r['title'] == 'Alamat')
              .map((f) => f['desc'])
              .join(', '),
          thumbnail:
              thumbnail != 'imgee/uploads/' ? '$_host/' + thumbnail : null,
          category: description
              .where((test) => test['title'] == 'Jenis Atraksi')
              .first['desc'],
          description: description,
          detail: detail);
    } catch (err) {
      return err;
    }
  }

  Future<List<AttractionInterface>> findAllByCategory(
      AttractionCategory category) async {
    try {
      Response response;

      switch (category) {
        case AttractionCategory.artificial:
          response = await _client.post('$_host/kategori-Buatan');
          break;
        case AttractionCategory.culture:
          response = await _client.post('$_host/kategori-Budaya');
          break;
        case AttractionCategory.nature:
          response = await _client.post('$_host/kategori-Alam');
          break;
        default:
          break;
      }

      var document = parse(response.body);

      var data = document.querySelectorAll('.product-box').map((f) {
        var thumbnail = f
            .querySelector('div[style*="background-position: center;"]')
            .attributes['style']
            .split(';')[0]
            .replaceAll('background-image: url(', '')
            .replaceAll(')', '');
        var address = f.querySelector('.contact-info').children[2].text.trim();
        return AttractionInterface(
          id: '$_host/' + f.querySelector('.item-title > a').attributes['href'],
          name: f.querySelector('.item-title').text.trim(),
          category: f.querySelector('.btn-category').text.trim(),
          location: f.querySelector('.contact-info').children[1].text.trim(),
          address: address != '-' ? address : null,
          thumbnail:
              thumbnail != 'imgee/uploads/' ? '$_host/' + thumbnail : null,
        );
      }).toList();

      return data;
    } catch (err) {
      return err;
    }
  }

  Future<List<AttractionInterface>> findAllByPlaces(List<String> places) async {
    try {
      var data = (await this.all())
          .where((test) => places.contains(test.location))
          .toList();
      return data;
    } catch (err) {
      return err;
    }
  }

  Future<List<String>> getPlaces() async {
    try {
      Response response = await _client.get(this._host);

      var document = parse(response.body);

      return document
          .querySelectorAll('.dropdown-menu-col-1 > li')
          .map((f) => f.text.trim())
          .toList();
    } catch (err) {
      return err;
    }
  }

  Future<List<AttractionInterface>> getRecommendations(int length) async {
    try {
      var data = await this.all();
      List<AttractionInterface> result = [];

      var randomize = new Random();
      for (var i = 0; i < length; i++) {
        result.add(data[randomize.nextInt(data.length)]);
      }

      return result;
    } catch (err) {
      return err;
    }
  }
}
