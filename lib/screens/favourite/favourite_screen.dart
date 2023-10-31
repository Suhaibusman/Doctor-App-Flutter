import 'package:flutter/material.dart';
import 'package:smithackathon/screens/home/widgets/all_doctors.dart';
import 'package:smithackathon/screens/home/widgets/field_categories.dart';
import 'package:smithackathon/screens/navbar/bottomnavigation.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
          body: Column(
            children: [
              FieldsCategories(),
              AllDoctorData()
            ],
          ),
        bottomNavigationBar: CustomBottomNavigationBar(pageindex: 1),
      ),
    );
  }
}