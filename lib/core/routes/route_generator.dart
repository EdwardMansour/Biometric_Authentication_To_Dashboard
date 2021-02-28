import 'package:biometric_dashboard/Domain/repositories/repository.dart';
import 'package:biometric_dashboard/Presentation/state_management/home_page_bloc/home_bloc.dart';
import 'package:biometric_dashboard/Presentation/state_management/login_page_bloc/biometric_bloc.dart';
import 'package:biometric_dashboard/Presentation/widgets/home_page.dart';
import 'package:biometric_dashboard/core/injection/dependancy_injection.dart';
import 'package:biometric_dashboard/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              BlocProvider<BiometricBloc>(
            create: (context) => BiometricBloc(),
            child: LoginView(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return new RotationTransition(
              turns: secondaryAnimation,
              child: child,
            );
          },
        );

      case '/home':
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              MultiBlocProvider(
            providers: [
              BlocProvider<HomeBloc>(
                create: (context) => HomeBloc(repositories: sl<Repositories>()),
              ),
            ],
            child: HomePage(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return new RotationTransition(
                turns: animation,
                child: new ScaleTransition(
                  scale: animation,
                  child: new FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                ));
          },
        );
      default:
        return _errorRoute();
    }
  }

  //! Routing error
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
