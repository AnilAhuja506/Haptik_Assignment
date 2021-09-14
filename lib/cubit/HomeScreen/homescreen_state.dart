part of 'homescreen_cubit.dart';

@immutable
abstract class HomeScreenCubitState {
  const HomeScreenCubitState();
}

class HomeScreenCubitInitial extends HomeScreenCubitState {
  const HomeScreenCubitInitial();
}

class HomeScreenCubitLoading extends HomeScreenCubitState {
  const HomeScreenCubitLoading();
}

class HomeScreenCubitLoaded extends HomeScreenCubitState {
  final List<PostsModel> list;

  HomeScreenCubitLoaded(
    this.list,
  );
}

class HomeScreenCubitError extends HomeScreenCubitState {
  const HomeScreenCubitError();
}
