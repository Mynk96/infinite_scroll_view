import 'dart:async';

import 'package:design_community/data/repository.dart';
import 'package:design_community/design_card.dart';
import 'package:design_community/model/design.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PagedDesignListView extends StatefulWidget {
  final Repository repository;

  const PagedDesignListView({Key key, this.repository}) : super(key: key);

  @override
  _PagedDesignListViewState createState() => _PagedDesignListViewState();
}

class _PagedDesignListViewState extends State<PagedDesignListView> {

  final int _pageSize = 10;
  final _pagingController = PagingController<int, Design>(
    firstPageKey: 1,
  );

  @override
  Widget build(BuildContext context) {
   return RefreshIndicator(
     onRefresh: () => Future.sync(() => _pagingController.refresh()),
     child: PagedListView.separated(
      pagingController: _pagingController,
      separatorBuilder: (context, int) => SizedBox(height: 5,),
      builderDelegate: PagedChildBuilderDelegate<Design>(
        itemBuilder: (context, design, index) => DesignCard(design: design),
        firstPageErrorIndicatorBuilder: (context) => Container(child: Center(child: Text('Error retriving first page')),),
        noItemsFoundIndicatorBuilder: (context) => Container(child: Center(child: Text('No images found')),)
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<Design> newPage = await widget.repository.getDesigns(pageKey) ;
      final isLastPage = newPage.length < _pageSize;

      if (isLastPage) {
        _pagingController.appendLastPage(newPage);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newPage, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }
    
}