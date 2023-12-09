
import 'package:book_bytes/models/user.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  final User user;
  const Cart({super.key, required this.user});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  String maintitle = "Cart";

  @override
  void initState() {
    super.initState();
    print("Cart");
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