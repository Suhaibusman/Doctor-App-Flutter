import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'package:smithackathon/data.dart';
import 'package:smithackathon/firebase_options.dart';
import 'package:smithackathon/provider/theme/theme_provider.dart';
import 'package:smithackathon/screens/home/home_screen.dart';
import 'package:smithackathon/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, child) {
        final provider = Provider.of<ThemeProvider>(context);
        return GetMaterialApp(
          theme: provider.themeMode,
          debugShowCheckedModeBanner: false,
          home: (FirebaseAuth.instance.currentUser != null)
              ? HomeScreen(userName: box.read("currentloginedName"))
              : const LoginScreen(),
        );
      },
    );
  }
}
