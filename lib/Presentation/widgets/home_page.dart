import 'package:biometric_dashboard/Presentation/state_management/home_page_bloc/home_bloc.dart';
import 'package:biometric_dashboard/Presentation/widgets/subPageWidgets/button_Widget.dart';
import 'package:biometric_dashboard/core/constants.dart';
import 'package:biometric_dashboard/core/injection/dependancy_injection.dart';
import 'package:biometric_dashboard/core/navigator_service/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc bloc;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => getMethodes());
  }

  getMethodes() {
    bloc.add(
      FetchDataEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<HomeBloc>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[300],
      ),
      drawer: Container(
        color: Colors.white,
        height: double.infinity,
        width: width * 0.68,
        alignment: Alignment.center,
        child: SizedBox(
          height: height * 0.07,
          width: width * 0.3,
          child: ButtonWidget(
            backGroundColor: Colors.white,
            buttonName: 'Logout',
            function: () => sl<NavigationService>().navigateTo('/'),
            heightIn: height * 0.07,
            widthIn: width * 0.04,
            nameAndBoarderColor: Colors.lightBlue[300],
          ),
        ),
      ),
      body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return state is ErrorLoadingState
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
                              color: Colors.lightBlue[300],
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
                            bloc.add(FetchDataEvent());
                          },
                        ),
                      ],
                    )
                  : state is LoadingState && state.isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.lightBlue[300],
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //! title quote of today
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Quote of today',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: textStyle(
                                  Colors.black,
                                  width * 0.055,
                                ),
                              ),
                            ),
                            //! Quote section
                            SizedBox(
                              height: height * 0.2,
                              width: double.infinity,
                              child: Container(
                                alignment: Alignment.center,
                                color: Colors.lightBlue[100],
                                child: Text(
                                  bloc.quoteFirst != null
                                      ? bloc.quoteFirst.q
                                      : 'empty',
                                  textAlign: TextAlign.center,
                                  style: textStyle(
                                    Colors.white,
                                    width * 0.04,
                                  ),
                                ),
                              ),
                            ),
                            //! title NEWS
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'News',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: textStyle(
                                  Colors.black,
                                  width * 0.055,
                                ),
                              ),
                            ),
                            //! list builder
                            Expanded(
                              child: bloc.newsMostPopularData().isNotEmpty
                                  ? ListView.builder(
                                      itemCount:
                                          bloc.newsMostPopularData().length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  '${bloc.newsMostPopularData()[index].resultAbstract}',
                                                  style: textStyle(
                                                    Colors.lightBlue[300],
                                                    width * 0.035,
                                                  ),
                                                ),
                                                index ==
                                                        bloc
                                                                .newsMostPopularData()
                                                                .length -
                                                            1
                                                    ? Container()
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 8.0),
                                                        child: SizedBox(
                                                          height: 2,
                                                          width:
                                                              double.infinity,
                                                          child: Container(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    )

                                  //! if list is empty
                                  : Center(
                                      child: Text(
                                        'Empty list',
                                        style: textStyle(
                                          Colors.lightBlue[300],
                                          width * 0.055,
                                        ),
                                      ),
                                    ),
                            )
                          ],
                        );
            },
          )),
    );
  }
}
