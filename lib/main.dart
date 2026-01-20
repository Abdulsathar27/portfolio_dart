import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:profitillo/views/home_view.dart';
import 'package:profitillo/providers/theme_provider.dart';
import 'package:profitillo/core/theme/app_theme.dart';
import 'package:profitillo/providers/navigation_provider.dart';
import 'package:profitillo/providers/mouse_provider.dart';
import 'package:profitillo/widgets/custom_cursor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => MouseProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Portfolio',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            builder: (context, child) {
              return MouseRegion(
                onHover: (event) {
                  context.read<MouseProvider>().updatePosition(event.position);
                },
                cursor: SystemMouseCursors.none, // Hide default cursor
                child: Stack(children: [child!, const CustomCursor()]),
              );
            },
            home: HomeView(),
          );
        },
      ),
    );
  }
}
