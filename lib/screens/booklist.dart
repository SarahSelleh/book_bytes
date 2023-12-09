
import 'package:book_bytes/models/user.dart';
import 'package:flutter/material.dart';

class BookList extends StatefulWidget {
  final User user;
  const BookList({super.key, required this.user});

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  String maintitle = "Book List";

  @override
  void initState() {
    super.initState();
    print("Book List");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }
  
  @override
  Widget build(BuildContext context) {
    return Center();
  }
}