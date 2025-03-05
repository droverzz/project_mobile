import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/bookmark.dart';

class BookmarkDetailScreen extends StatelessWidget {
  final Bookmark bookmark;

  const BookmarkDetailScreen({Key? key, required this.bookmark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(bookmark.name),
      ),
      body: Scaffold(

      )
    );
  }
}