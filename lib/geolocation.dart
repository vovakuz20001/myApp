import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<String> getAddress(data) async {
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    'Authorization': 'Token 41c7fd0af70ce3a9fc3f1355d2abf185fbb31c4d',
  };

  final url = Uri.parse(
      'https://suggestions.dadata.ru/suggestions/api/4_1/rs/geolocate/address');

  final res = await http.post(url, headers: headers, body: json.encode(data));
  final status = res.statusCode;
  if (status != 200) throw Exception('http.post error: statusCode= $status');

  return res.body;
}
