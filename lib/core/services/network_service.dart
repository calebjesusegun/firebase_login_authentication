import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

abstract class NetworkServiceRepository {
  Future getData(
      {required String domain,
      required String subDomain,
      Map<String, String>? queryParameter,
      Map<String, String>? header});
  Future postData(
      {required String domain,
      required String subDomain,
      required var body,
      required bool isJson,
      Map<String, String>? queryParameter,
      Map<String, String>? header});
}

class NetworkServiceRepositoryImpl extends NetworkServiceRepository {
  final client = RetryClient(http.Client());

  //All GET calls both internally and externally goes through this method
  @override
  Future getData(
      {required String domain,
      required String subDomain,
      Map<String, String>? queryParameter,
      Map<String, String>? header}) async {
    var url = Uri.https(domain, '$subDomain/', queryParameter);

    var response = await client.get(url, headers: header);

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);

      return decodedData;
    } else {
      debugPrint('Request failed with status: ${response.statusCode}.');
      //TODO: Implement redirect to error 404 page
    }
  }

  //All POST calls both internally and externally goes through this method
  @override
  Future postData(
      {required String domain,
      required String subDomain,
      required var body,
      required bool isJson,
      Map<String, String>? queryParameter,
      Map<String, String>? header}) async {
    var url = Uri.https(domain, subDomain, queryParameter);

    var response = await client.post(url,
        headers: header, body: isJson ? jsonEncode(body) : body);

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);

      return decodedData;
    } else {
      debugPrint('Request failed with status: ${response.statusCode}.');
      //TODO: Implement redirect to error 404 page
    }
  }
}
