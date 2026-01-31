import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'providers/audio_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AudioProvider()),
      ],
      child: const AkuBisaMerawatDiriku(),
    ),
  );
}

class AkuBisaMerawatDiriku extends StatelessWidget {
  const AkuBisaMerawatDiriku({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aku Bisa Merawat Diriku',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const SplashScreen(),
    );
  }
}
