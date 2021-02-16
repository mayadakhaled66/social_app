import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ErrorDialog extends StatelessWidget{
  String errorMessage;
  BuildContext buildContext;
  ErrorDialog(this.errorMessage,this.buildContext);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.all(40),
                child: Text(
                  "Error :(",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ),
            Container(
              padding: EdgeInsets.all(40),
              child: Text(
                errorMessage,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FlatButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text("Ok"))
          ],
        ),
      ),
    );
  }

}