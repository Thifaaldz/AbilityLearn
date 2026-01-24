import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const AkuBisaMerawatDiriku());
}

class AkuBisaMerawatDiriku extends StatelessWidget {
  const AkuBisaMerawatDiriku({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aku Bisa Merawat Diriku',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const HomeScreen(),
    );
  }
}
