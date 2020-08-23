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
}
