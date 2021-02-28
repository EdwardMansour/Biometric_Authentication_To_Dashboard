import 'package:biometric_dashboard/Presentation/widgets/login.dart';
import 'package:flutter/material.dart';
import 'core/constants.dart';
import 'core/injection/dependancy_injection.dart';
import 'core/navigator_service/navigator_service.dart';
import 'core/routes/route_generator.dart';

void main() {
  init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biometric auth nav to home page',
      debugShowCheckedModeBanner: false,
      navigatorKey: sl<NavigationService>().navigatorKey,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        //! set the height of the device screen
        height = constraints.maxHeight;
        //! set the width of the device screen
        width = constraints.maxWidth;
        return LoginPage();
      },
    );
  }
}
