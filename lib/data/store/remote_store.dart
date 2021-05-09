import 'package:design_community/model/design.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RemoteStore {
  RemoteStore({
    @required this.dio,
  }) : assert (dio != null);

  final Dio dio;
  final String url = 'https://api.unsplash.com/photos/';

  Future<List<Design>> getDesigns(int pageNumber) async {
    var response = await dio.get(
    url,
    queryParameters: {
      'client_id': 'DvwRWvkOTYKQhVlGpmforuxZG-fn3LrfJh-oi6RaRgs',
      'page':pageNumber
    }
  );
  return response.data.map<Design>((val) => Design.fromJSON(val)).toList();
}
}