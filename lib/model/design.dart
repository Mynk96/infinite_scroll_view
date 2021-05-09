import 'package:flutter/material.dart';

class Design {
  final String id;
  final String title;
  final String imageUrl;
  final DateTime publishedTime;
  final String designPageUrl;

  Design({@required this.id, @required this.title, @required this.imageUrl, @required this.publishedTime, @required this.designPageUrl});

  factory Design.fromJSON(Map<String, dynamic> data) => Design(
      id: data['id'],
      title: data['alt_description'],
      imageUrl: data['urls']['regular'],
      publishedTime: DateTime.parse(data['created_at']),
      designPageUrl: data['links']['html']
  );
}