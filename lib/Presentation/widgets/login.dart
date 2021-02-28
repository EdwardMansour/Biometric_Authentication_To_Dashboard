import 'dart:async';
import 'package:biometric_dashboard/Presentation/state_management/login_page_bloc/biometric_bloc.dart';
import 'package:biometric_dashboard/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'subPageWidgets/button_Widget.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  BiometricBloc bloc;

  //! Animation
  bool animationStart = false;
  @override
  void initState() {
    super.initState();

    Timer(Duration(milliseconds: 800), () {
      setState(() {
        animationStart = true;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => getMethodes());
  }

  getMethodes() {
    bloc.add(
      AuthenticationsMethodesFoundEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<BiometricBloc>(context, listen: false);
    return Scaffold(
      key: scaffholdKey,
      backgroundColor: Colors.white,
      body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: BlocBuilder<BiometricBloc, BiometricState>(
            builder: (context, state) {
              return Container(
                color: Colors.lightBlue[300],
                child: state is ErrorLoadingState
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //! error message
                          Padding(
                            padding: EdgeInsets.all(width * 0.05),
                            child: Text(
                              state.message,
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          //! Spacing
                          spacing(0.07, 0),

                          //! Error retry button
                          ButtonWidget(
                            heightIn: height * 0.08,
                            widthIn: width * 0.3,
                            backGroundColor: Colors.white,
                            buttonName: 'Retry',
                            nameAndBoarderColor: Colors.lightBlue[300],
                            function: () {
                              bloc.add(InitializeEvent());
                              bloc.add(AuthenticationsMethodesFoundEvent());
                            },
                          ),
                        ],
                      )
                    : Stack(
                        children: [
                          //! title with animated opacity and style
                          Positioned(
                            top: height * 0.2,
                            right: width * 0.3,
                            left: width * 0.3,
                            child: AnimatedOpacity(
                              duration: Duration(seconds: 1),
                              opacity: animationStart ? 1 : 0,
                              child: AnimatedDefaultTextStyle(
                                duration: Duration(seconds: 1),
                                child: Text(
                                  'Login with biomatric',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                                style: TextStyle(
                                  color: animationStart
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: animationStart
                                      ? width * 0.05
                                      : width * 0.09,
                                ),
                              ),
                            ),
                          ),

                          //! icon of biometric
                          Center(
                            child: AnimatedContainer(
                              duration: Duration(seconds: 1),
                              height:
                                  animationStart ? height * 0.2 : height * 0.7,
                              width:
                                  animationStart ? width * 0.2 : width * 0.65,
                              child: state is LoadingState && state.isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : SvgPicture.asset(
                                      'assets/icon_biometric.svg',
                                      color: Colors.white,
                                      matchTextDirection: true,
                                    ),
                            ),
                          ),

                          //! card decoration
                          Padding(
                            padding: EdgeInsets.all(width * 0.1),
                            child: Container(
                              height: height,
                              width: width,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),

                          //! button of the authentication
                          AnimatedPositioned(
                            duration: Duration(seconds: 1),
                            bottom: animationStart ? height * 0.2 : -height,
                            right: width * 0.3,
                            left: width * 0.3,
                            child: ButtonWidget(
                              backGroundColor: Colors.white,
                              buttonName: !bloc.canCheckBiometrics
                                  ? 'No auth available'
                                  : 'Auth button',
                              function: () => bloc.canCheckBiometrics
                                  ? bloc.add(
                                      AuthenticationBiometricEvent(),
                                    )
                                  : null,
                              heightIn: height * 0.07,
                              widthIn: width * 0.04,
                              loading: !bloc.canCheckBiometrics,
                              nameAndBoarderColor: Colors.lightBlue[300],
                            ),
                          ),
                        ],
                      ),
              );
            },
          )),
    );
  }
}
