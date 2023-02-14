import 'package:burger_house/route/app_routes.dart';
import 'package:burger_house/theme/provider/theme_provider.dart';
import 'package:burger_house/views/pages/sign_in/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        builder: (context, snapshot) {
          return Consumer<ThemeProvider>(
              builder: (context, themeProvider, snapshot) {
            return MaterialApp(
              onGenerateRoute: AppRoutes.router.generator,
              navigatorKey: AppRoutes.navigatorState,

              title: 'Flutter Demo',
              theme:ThemeData(
                fontFamily: themeProvider.theme.defaultFont
                    .toString()
                    .replaceFirst('FontFamily.', ''),
                primarySwatch: Colors.blue,
                accentColor: themeProvider.theme.accentColor,
                bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.white,
                    modalBackgroundColor: themeProvider.theme.accentColor
                ),
                appBarTheme: const AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle.dark,),
                textTheme: TextTheme(
                  labelLarge: themeProvider.theme.button,
                  labelSmall: themeProvider.theme.overline,
                  titleLarge: themeProvider.theme.headline5,
                  headlineSmall: themeProvider.theme.headline5,
                  headlineMedium: themeProvider.theme.headline4,
                  displaySmall: themeProvider.theme.headline3,
                  displayMedium: themeProvider.theme.headline2,
                  displayLarge: themeProvider.theme.headline1,
                  titleSmall: themeProvider.theme.subtitle2,
                  titleMedium: themeProvider.theme.headline1,
                  bodyMedium: themeProvider.theme.bodyText2,
                  bodyLarge: themeProvider.theme.bodyText1,
                  bodySmall: themeProvider.theme.caption,
                ),
              ),
              home: const LoginView(args: null,),
            );
          }
        );
      }
    );
  }
}
