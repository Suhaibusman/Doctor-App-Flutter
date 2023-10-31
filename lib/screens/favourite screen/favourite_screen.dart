import 'package:flutter/material.dart';
import 'package:smithackathon/screens/navbar/bottomnavigation.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: const CustomBottomNavigationBar(pageindex: 2),
    );
  }
}