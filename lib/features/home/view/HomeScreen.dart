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

class HomeScreen extends StatefulWidget {
  String userName,title;

  HomeScreen({this.userName,this.title});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BuildContext _dialogContexts;
  UserModel _userModel;
  PostModel _postModel;
  TagModel _tagModel;
  UsersData currentSelectedUser;
  String currentSelectedUserFirstName;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        return BlocListener<HomePageBloc, HomePageState>(
          listener: (context, state) {
            if (state is HomePageLoading) {
              return showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext dialogContext) {
                  _dialogContexts = dialogContext;
                  return LoadingProgressDialog();
                },
              );
            } else if (state is HomePageFail) {
              if(_dialogContexts!=null){
                Navigator.pop(_dialogContexts);
                _dialogContexts = null;
              }

              return showDialog<void>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext dialogContext) {
                  return ErrorDialog(
                    state.error,
                    context,
                  );
                },
              );
            } else if (state is UserDataHomePageSuccessState) {
              if(_dialogContexts!=null){
                Navigator.pop(_dialogContexts);
                _dialogContexts = null;
              }
              if (state.userInfo != null) {
                _userModel = state.userInfo;
                currentSelectedUser = _userModel.data[0];

              } else {
                _userModel = UserModel();
              }
            } else if (state is TagDataHomePageSuccessState) {
              if(_dialogContexts!=null){
                Navigator.pop(_dialogContexts);
                _dialogContexts = null;
              }
              if (state.tagModel != null) {
                _tagModel = state.tagModel;
              } else {
                _tagModel = TagModel();
              }
            } else if (state is PostDataHomePageSuccessState) {
              if(_dialogContexts!=null){
                Navigator.pop(_dialogContexts);
                _dialogContexts = null;
              }
              if (state.postModel != null) {
                _postModel = state.postModel;
              } else {
                _postModel = PostModel();
              }
            }else if (state is PostDataByUserIDHomePageSuccessState){
              if(_dialogContexts!=null){
                Navigator.pop(_dialogContexts);
                _dialogContexts = null;
              }
              if (state.postModel != null) {
                _postModel = state.postModel;
              } else {
                _postModel = PostModel();
              }
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              _tagModel != null
                  ? Container(
                width: width,
                height: height * (1 / 11),
                child: ListView.builder(
                  itemCount: _tagModel.data.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return (_tagModel != null &&
                        _tagModel.data[index] != null &&
                        _tagModel.data.length > 0)
                        ? Container(
                      height: 10,
                      margin: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color:
                              Theme.of(context).primaryColor,
                              spreadRadius: 2),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {},
                        child: Center(
                          child: Wrap(
                            children: [
                              Text(
                                _tagModel.data[index].toString(),
                                style: TextStyle(
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                        : Container(
                      child: Center(child: Text("No tags :(")),
                    );
                  },
                ),
              )
                  : Container(
                child: Center(child: Text("No tags")),
              ),
              _userModel != null
                  ? Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: buildDropDownMenuWidget(_userModel.data),
                width: width,
                height: height * (1 / 15),
              )
                  : Container(
                child: Center(child: Text("No active users")),
              ),
              _postModel != null
                  ? Expanded(
                child: Container(
                  width: width,
                  // height: height,
                  child: ListView.builder(
                    itemCount: _postModel.data.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return (_postModel != null &&
                          _postModel.data[index] != null &&
                          _postModel.data.length > 0)
                          ? Container(
                        height: height *(1.7/3)+(_postModel.data[index].text.length/5),
                        margin: EdgeInsets.symmetric(
                            horizontal: 35, vertical: 10),
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context)
                                    .primaryColor,
                                spreadRadius: 1),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "${_postModel.data[index].owner.firstName} ${_postModel.data[index].owner.lastName}",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight:
                                        FontWeight.w600),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "Date : ${DateFormat("yyyy-MM-dd hh:mm:ss").parse(_postModel.data[index].publishDate.toString())}",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight:
                                        FontWeight.w600),
                                  ),
                                ],
                              ),
                              Divider(thickness: 2,),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Image.network(
                                      _postModel
                                          .data[index].image,
                                      height: 150,
                                      width: 200,
                                    ),
                                  ],
                                ),
                              ),
                              Wrap(
                                children: [
                                  Text(
                                    "${_postModel.data[index].text}",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight:
                                        FontWeight.w600),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(
                                    vertical: 5),
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  mainAxisSize:
                                  MainAxisSize.max,
                                  children: [
                                    Icon(
                                        Icons.whatshot_rounded),
                                    Text(
                                      " ${_postModel.data[index].likes}",
                                      textAlign:
                                      TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight:
                                          FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              buildTagsInPost(
                                  _postModel.data[index].tags),
                            ],
                          ),
                        ),
                      )
                          : Container(
                        child:
                        Center(child: Text("No Posts :(")),
                      );
                    },
                  ),
                ),
              )
                  : Container(
                child: Center(child: Text("No Posts :(")),
              ),
            ],
          ),
        );
      },
    );
  }

  buildTagsInPost(List<String> tags) {
    String allTags = '';
    tags.forEach((element) {
      allTags += element + " ,";
    });
    return Wrap(
      children: [
        Text(
          " ${allTags}",
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Colors.amber, fontSize: 15, fontWeight: FontWeight.w600),
        )
      ],
    );
  }

  buildDropDownMenuWidget(List<UsersData> usersList) {
    // currentSelectedUser = usersList[0];
    return DropdownButtonFormField(
      dropdownColor: Colors.white,
      isExpanded: true,
      hint: Text("Select User"),
      isDense: true,
      style: TextStyle(color: Colors.black),
      items: usersList.map((UsersData value) {
        return  DropdownMenuItem<String>(
          value: value.firstName,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  value.picture,
                  height: 35.0,
                  width: 35.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text("${value.firstName} ${value.lastName}"),
              ),
            ],
          ),
        );
      },).toList(),
      onChanged: (current) {
        setState(() {
          currentSelectedUser = usersList.where((element) => element.firstName==current).toList()[0] ;
        });
        BlocProvider.of<HomePageBloc>(context).add(PostDataByUserIdPageEvent(currentSelectedUser.id));
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.userName != null) {
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext dialogContext) {
            return GenericDialog(
                buildContext: dialogContext,
                title: "Hi",
                message: "Welcome ${widget.userName}");
          },
        );
      }
      BlocProvider.of<HomePageBloc>(context).add(PostDataPageEvent());
      BlocProvider.of<HomePageBloc>(context).add(TagDataHomePageEvent());
      BlocProvider.of<HomePageBloc>(context).add(UserDataHomePageEvent());
    });

  }
}
