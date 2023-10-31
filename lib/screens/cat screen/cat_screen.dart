import 'package:flutter/material.dart';
import 'package:smithackathon/screens/home/widgets/all_doctors.dart';
import 'package:smithackathon/screens/home/widgets/field_categories.dart';
import 'package:smithackathon/screens/navbar/bottomnavigation.dart';

class CatScreen extends StatefulWidget {
  const CatScreen({super.key});

  @override
  State<CatScreen> createState() => _CatScreenState();
}

class _CatScreenState extends State<CatScreen> {
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