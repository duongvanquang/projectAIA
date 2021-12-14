import 'package:http/http.dart' as http;

class HttpClient {
  final String? baseUrl;
  HttpClient({this.baseUrl});
  Future<String> getData(String path, Map<String, dynamic> params) async {
    final uri = Uri(
      scheme: 'https',
      host: baseUrl,
      path: path,
      queryParameters: params,
    );
    final getData = await http.get(uri);
    if (getData.statusCode == 200) {
      return getData.body;
    } else {
      return '';
    }
  }
}
