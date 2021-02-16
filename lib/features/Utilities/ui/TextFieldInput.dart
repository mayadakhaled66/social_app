import 'package:flutter/material.dart';

class TextFormFiledInputClass extends StatelessWidget {
  String hint;
  Function validation;
  Function onSave;

  TextFormFiledInputClass({this.hint, this.validation, this.onSave});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        width: MediaQuery.of(context).size.width,
//      height: MediaQuery.of(context).size.height*(1/14),
//      padding: const EdgeInsets.only(top: 20,bottom: 5,left: 20,right: 20),
//      decoration: BoxDecoration(
//        color: Theme.of(context).accentColor,
//        borderRadius: BorderRadius.all(Radius.circular(5)),
//      ),
        child: TextFormField(
//        autovalidate: false,

          maxLines: 1,
          autofocus: false,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            // this for the position of the content in input
            errorMaxLines: 1,
//                        errorText: 'Null',
//                        errorStyle: TextStyle(
//                          color: Colors.transparent,
//                          fontSize: 0,
//                        ),
//          border: InputBorder.none,
            errorBorder: OutlineInputBorder(
//          gapPadding: 20,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                color: Theme.of(context).accentColor,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
//          gapPadding: 100,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                color: Theme.of(context).accentColor,
              ),
            ),
            disabledBorder: OutlineInputBorder(
//          gapPadding: 20,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                color: Theme.of(context).accentColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
//          gapPadding: 20,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                color: Theme.of(context).accentColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
//            gapPadding: 20,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                color: Theme.of(context).accentColor,
              ),
            ),
            border: OutlineInputBorder(
//            gapPadding: 20,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                color: Theme.of(context).accentColor,
                width: 2,
              ),
            ),
//                        errorStyle: TextStyle(height: 0),
            hintText: hint,
          ),
          onSaved: onSave,
          validator: validation,
        ));
  }
}
