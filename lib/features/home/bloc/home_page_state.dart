part of 'home_page_bloc.dart';

class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class HomePageInitial extends HomePageState {
  @override
  List<Object> get props => [];
}
class HomePageLoading extends HomePageState {
  @override
  List<Object> get props => [];
}
class UserDataHomePageSuccessState extends HomePageState {
  UserModel userInfo;
  UserDataHomePageSuccessState(this.userInfo);
  @override
  List<Object> get props => [this.userInfo];
}
class TagDataHomePageSuccessState extends HomePageState {
  TagModel tagModel;
  TagDataHomePageSuccessState(this.tagModel);
  @override
  List<Object> get props => [this.tagModel];
}
class PostDataHomePageSuccessState extends HomePageState {
  PostModel postModel;
  PostDataHomePageSuccessState(this.postModel);
  @override
  List<Object> get props => [this.postModel];
}
class PostDataByUserIDHomePageSuccessState extends HomePageState {
  PostModel postModel;
  PostDataByUserIDHomePageSuccessState(this.postModel);
  @override
  List<Object> get props => [this.postModel];
}
class HomePageFail extends HomePageState {
  final String error;
  HomePageFail({this.error});
  @override
  List<Object> get props => [this.error];
}