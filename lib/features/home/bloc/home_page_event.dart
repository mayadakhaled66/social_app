part of 'home_page_bloc.dart';

class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props =>[];
}
class UserDataHomePageEvent extends HomePageEvent {
  const UserDataHomePageEvent();

  @override
  List<Object> get props =>[];
}
class TagDataHomePageEvent extends HomePageEvent {
  const TagDataHomePageEvent();

  @override
  List<Object> get props =>[];
}
class PostDataPageEvent extends HomePageEvent {
  const PostDataPageEvent();

  @override
  List<Object> get props =>[];
}
class PostDataByUserIdPageEvent extends HomePageEvent {
  String userId;
   PostDataByUserIdPageEvent(this.userId);

  @override
  List<Object> get props =>[this.userId];
}