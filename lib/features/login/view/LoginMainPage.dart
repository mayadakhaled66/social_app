import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preventia_app/features/Repos/UserReposatiry.dart';
import 'package:preventia_app/features/Utilities/UserInfo.dart';
import 'package:preventia_app/features/Utilities/ui/ErrorDialog.dart';
import 'package:preventia_app/features/Utilities/ui/LoadingIndecator.dart';
import 'package:preventia_app/features/Utilities/ui/TextFieldInput.dart';
import 'package:preventia_app/features/home/view/UserHomePage.dart';
import 'package:preventia_app/features/login/AuthenticationBloc/authentication_bloc.dart';
import 'package:preventia_app/features/login/bloc/login_bloc.dart';

class LoginMainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginMainPageState();
}

class LoginMainPageState extends State<LoginMainPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthenticationBloc _authenticationBloc;
  LoginBloc loginBloc;

  UserRepository userRepository = UserRepository();
  UserInfo _userInfo = UserInfo();
  BuildContext dialogBuildContext,dialogLoadingBuildContext;
  AutovalidateMode validationMode = AutovalidateMode.disabled;
  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    loginBloc = LoginBloc(
      userRepository: UserRepository(),
      authenticationBloc: _authenticationBloc,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<LoginBloc,LoginState>(
      builder: (context, state) {
        return BlocListener<LoginBloc,LoginState>(
          listener: (context, state) {
            print("state is : $state");
            if(state is LoginSuccessState){
              if(dialogLoadingBuildContext!=null){
                Navigator.pop(dialogLoadingBuildContext);
              }
              if(dialogBuildContext!=null){
                Navigator.pop(dialogBuildContext);
              }
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => UserHomePage(userName: state.userInfo.firstName,)));
            }
            if(state is LoginLoading){
              return showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext dialogContext) {
                  dialogLoadingBuildContext = dialogContext;
                  return LoadingProgressDialog();
                },
              );
            }
             if(state is LoginFail){
               if(dialogLoadingBuildContext!=null){
                 Navigator.pop(dialogLoadingBuildContext);
                 dialogLoadingBuildContext=null;
               }
              return showDialog<void>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext dialogContext) {
                  dialogBuildContext = dialogContext;
                  return ErrorDialog(state.error,context,);
                },
              );
            }




          },
          child: Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: Container(
              width: width,
              height: height,
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 200.0, left: 30, right: 30),
                  child: Form(
                    key: _formKey,autovalidateMode:  validationMode,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Text(
                              "Welcome in our app !",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            )),
                        Container(
                          height: height * (1 / 9),
                          child: TextFormFiledInputClass(
                              hint: "Email",
                              onSave: (String value) {
                                _userInfo.firstName = value;
                              },
                              validation: (String value) {
                                if (value.isEmpty ||
                                    value == '' ||
                                    value == " ") {
                                  return "please enter you email address";
                                }
                                else if(isEmail(value)==false){
                                  return "please enter valid email";
                                }
                                return null;
                              }),
                        ),
                        Container(
                          height: height * (1 / 9),
                          child: TextFormFiledInputClass(
                            hint: 'Password',
                            onSave: (String value) {
                              print("the value is $value");
                              _userInfo.password = value;
                            },
                            validation: (String value) {
                              if (value.isEmpty) {
                                return "please enter your password";
                              } else if (value.isNotEmpty&&value.length < 8) {
                                return "Password must be at least 8 characters ";
                              }
                              return null;
                            },
                          ),
                        ),
                        Center(
                          child: Container(
                            height: height * (2 / 9),
                            width: width * (3 / 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FlatButton(
                                  color: (_formKey.currentState != null &&
                                          !_formKey.currentState.validate())
                                      ? Colors.grey
                                      : Colors.black,
                                  minWidth: width * (2 / 6),
                                  onPressed: (_formKey.currentState != null &&
                                          !_formKey.currentState.validate())
                                      ? () {
                                    setState(() {
                                      validationMode = AutovalidateMode.always;
                                    });
                                  }
                                      : () {
                                          _formKey.currentState.save();
                                          print(
                                              'pass is ${_userInfo.password}');
                                          BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
                                              userName: _userInfo.firstName,
                                              password: _userInfo.password));
                                        },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Login",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Icon(
                                        Icons.login,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  bool isEmail(String value) {

    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(value);
  }
}
