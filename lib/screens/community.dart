
import 'package:book_bytes/models/user.dart';
import 'package:flutter/material.dart';

class Community extends StatefulWidget {
  final User user;
  const Community({super.key, required this.user});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  String maintitle = "Community";

  @override
  void initState() {
    super.initState();
    print("Comunity");
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