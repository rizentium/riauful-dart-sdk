import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:riauful_sdk/interfaces/destination.dart';

class Destination {
  final _client = new Client();
  final _host = 'https://destinasiriau.travel';
  // Get all destination in Province of Riau
  Future<List<RiauDestination>> getOnPage(int page) async {
    try {
      Response response = await _client.get('$_host/dataod.php');

      var document = parse(response.body);

      List<RiauDestination> data =
          document.querySelectorAll('.product-box').map((f) {
        return RiauDestination(
          id: '$_host/' +
              f
                  .querySelector('.item-title')
                  .querySelector('a')
                  .attributes['href'],
          name: f.querySelector('.item-title').text.trim(),
          location: f.querySelector('.item-status').text.trim(),
          address: f.querySelector('.contact-info').children[2].text.trim(),
          thumbnail: '$_host/' +
              f
                  .querySelectorAll(
                      'div[style*="background-position: center;"]')
                  .first
                  .attributes['style']
                  .split(';')[0]
                  .replaceAll('background-image: url(', '')
                  .replaceAll(')', ''),
          category: f.querySelector('.btn-category').text.trim(),
        );
      }).toList();
      return data;
    } catch (err) {
      return err;
    }
  }

  Future<RiauDestination> find(String url) async {
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

      return RiauDestination(
          id: url,
          name: document.querySelector('.item-title').text.trim(),
          location: detail.where((r) => r['title'] == 'Alamat').first['desc'],
          address: detail
              .where((r) => r['title'] == 'Desa' || r['title'] == 'Alamat')
              .map((f) => f['desc'])
              .join(', '),
          thumbnail: '$_host/' +
              document
                  .getElementById('layout-content')
                  .children
                  .where((f) => f.attributes['property'] != null)
                  .first
                  .attributes['content'],
          category: description
              .where((test) => test['title'] == 'Jenis Atraksi')
              .first['desc'],
          description: description,
          detail: detail);
    } catch (err) {
      return err;
    }
  }
}
