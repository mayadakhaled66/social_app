import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preventia_app/features/Utilities/ui/ErrorDialog.dart';
import 'package:preventia_app/features/Utilities/ui/GenericDialog.dart';
import 'package:preventia_app/features/Utilities/ui/LoadingIndecator.dart';
import 'package:preventia_app/features/home/bloc/home_page_bloc.dart';
import 'package:preventia_app/features/home/model/PastModel.dart';
import 'package:preventia_app/features/home/model/TagModel.dart';
import 'package:preventia_app/features/home/model/UserModel.dart';
import 'package:intl/intl.dart';

import 'HomeScreen.dart';
import 'SettingPage.dart';

class UserHomePage extends StatefulWidget {
  String userName;

  UserHomePage({this.userName});

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  UsersData currentSelectedUser;
String currentSelectedUserFirstName;
int _selectedIndex=0;

  @override
  void initState() {
    _incrementTab(0);
  }

  String _title;
  Widget _currentPage ;
  PageController _pageController= PageController();
  void _incrementTab(index) {
    _selectedIndex = index;
    setState(() {
      // _pageController.animateToPage(index,
      //     duration: Duration(milliseconds: 500), curve: Curves.easeOut);
      switch (_selectedIndex) {
        case 0:
          _title = "Home Page";
          _currentPage = HomeScreen(userName: widget.userName,);
          break;
        case 1:
          _title = "Setting";
          _currentPage = SettingPage();
          break;
        // case 2:
        //   _title = "Doaa Page";
        //   _currentPage = DoaaScreen();
        //   break;
        // case 3:
        //   _title = "About Page";
        //   _currentPage = AboutScreen();
        //   break;
      }
    });
  }

  Widget buildBottomBar(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      currentIndex: _selectedIndex,
      onTap: _incrementTab,
      type: BottomNavigationBarType.shifting,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home,
              color: Color.fromARGB(255, 0, 0, 0)),
          title: new Text(
            'Home',
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Color.fromARGB(255, 0, 0, 0)),
            title: new Text(
              'Setting',
              style: TextStyle(color: Theme.of(context).accentColor),
            )),
      ],

      selectedItemColor: Theme.of(context).accentColor,
      showUnselectedLabels: true,
//          unselectedItemColor: Colors.amber[800],
    );
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("$_title"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      bottomNavigationBar: buildBottomBar(context),
      body:_currentPage,
    );
  }

}
