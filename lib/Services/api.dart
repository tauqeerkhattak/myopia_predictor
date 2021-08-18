import 'package:http/http.dart' as http;

Future <String> getData (url) async {
  http.Response response = await http.get(url);
  return response.body;
}
