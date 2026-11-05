import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/zalo_theme.dart';
import 'features/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: LocketDioApp(),
    ),
  );
}

class LocketDioApp extends StatelessWidget {
  const LocketDioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Locket Dio',
      debugShowCheckedModeBanner: false,
      theme: ZaloTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
