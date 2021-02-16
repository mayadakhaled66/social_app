
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preventia_app/features/Utilities/ui/ErrorDialog.dart';
import 'package:preventia_app/features/Utilities/ui/LoadingIndecator.dart';
import 'package:preventia_app/features/login/AuthenticationBloc/authentication_bloc.dart';
import 'package:preventia_app/features/login/bloc/login_bloc.dart';
import 'package:preventia_app/features/login/view/LoginMainPage.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  BuildContext _dialogContexts,dialogLoadingBuildContext;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationFail) {
              if(dialogLoadingBuildContext!=null){
                Navigator.pop(dialogLoadingBuildContext);
                dialogLoadingBuildContext=null;
              }
              return showDialog<void>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext dialogContext) {
                  _dialogContexts =dialogContext;
                  return ErrorDialog(
                    state.error,
                    context,
                  );
                },
              );
            } else if (state is AuthenticationUnauthenticated) {
              if(dialogLoadingBuildContext!=null){
                Navigator.pop(dialogLoadingBuildContext);
              }
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginMainPage()));
            }
          },
          child: Container(
            height: MediaQuery.of(context).size.height * (1 / 4),
            width: MediaQuery.of(context).size.width,
            child: GestureDetector(onTap: (){
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
            },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "LogOut",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.logout),
                ],
              ),
            ),
          ),
        );
      },
    );









  }
}
