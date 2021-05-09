import 'package:design_community/data/store/remote_store.dart';
import 'package:design_community/model/design.dart';
import 'package:flutter/material.dart';

class Repository {
  const Repository({
    @required this.remoteStore,
  })  : assert(remoteStore != null);
  final RemoteStore remoteStore;

  Future<List<Design>> getDesigns(int pageNumber) => remoteStore.getDesigns(pageNumber);
}