import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preventia_app/features/login/bloc/login_bloc.dart';
import 'features/Repos/UserReposatiry.dart';
import 'features/Utilities/ui/LoadingIndecator.dart';
import 'features/home/bloc/home_page_bloc.dart';
import 'features/home/view/UserHomePage.dart';
import 'features/login/AuthenticationBloc/authentication_bloc.dart';
import 'features/login/view/LoginMainPage.dart';

void main() {
  runApp(BlocProvider<AuthenticationBloc>(
      create: (_) => AuthenticationBloc(userRepository: UserRepository()),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Preventia App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePagesState createState() => _MyHomePagesState();
}

class _MyHomePagesState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(),
        ),
        BlocProvider<HomePageBloc>(
          create: (BuildContext context) => HomePageBloc(),
        ),
      ],
      child: MaterialApp(
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            print(state);
            if (state is AuthenticationUnauthenticated) {
              return  BlocProvider<LoginBloc>(
                create: (BuildContext context) => LoginBloc(),
                child: LoginMainPage(),
              );
            }
            else if (state is AuthenticationAuthenticated) {
               return BlocProvider<HomePageBloc>(
                create: (BuildContext context) => HomePageBloc(),
                child: UserHomePage(userName: null,),
              );
            }
            // else if (state is AuthenticationInitial) {
            //   return BlocProvider<LoginBloc>(
            //     create: (BuildContext context) => LoginBloc(authenticationBloc: AuthenticationBloc(),userRepository: UserRepository()),
            //     child: LoginMainPage(),
            //   );
            //   // return ApplyReviewMainScreen();
            // }
            return Container();
          },
        ),
        theme: ThemeData(
          primaryColor: Colors.amber,
          accentColor: Colors.white,
          tabBarTheme: TabBarTheme(labelColor: Colors.white),
          textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Colors.black,
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
        ),
        routes: {
          "/welcomePage": (context) => UserHomePage(),
          "/loginPage": (context) => LoginMainPage(),
        },
      ),
    );
  }

  @override
  void initState() {
    // SchedulerBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<AuthenticationBloc>(context).add(AppStarted());
    // });


  }
}
