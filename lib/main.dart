import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/database/app_database.dart';
import 'domain/providers/controllers_provider.dart';
import 'domain/providers/core_provider.dart';
import 'presentation/pages/home/home_screen.dart';
import 'presentation/pages/login/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final AppDatabase appDatabase = AppDatabase();

  runApp(
    ProviderScope(
      overrides: [providerAppDatabase.overrideWithValue(appDatabase)],
      child: const AppentusInterviewTask(),
    ),
  );
}

class AppentusInterviewTask extends ConsumerStatefulWidget {
  const AppentusInterviewTask({Key? key}) : super(key: key);

  @override
  AppentusInterviewTaskState createState() => AppentusInterviewTaskState();
}

class AppentusInterviewTaskState extends ConsumerState<AppentusInterviewTask> {
  BottomNavigationBarThemeData bottomNavigationBarThemeData() {
    return BottomNavigationBarThemeData(
      backgroundColor: Colors.blue,
      selectedLabelStyle: const TextStyle(fontSize: 12),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
      selectedItemColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.white.withOpacity(.60),
    );
  }

  @override
  void initState() {
    ref.read(providerSession.notifier).isUserLoggedIn();
    super.initState();
  }

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(providerSession);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Appentus Interview Task',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
        bottomNavigationBarTheme: bottomNavigationBarThemeData(),
      ),
      home: user == null ? const LoginScreen() : const HomeScreen(),
    );
  }
}
