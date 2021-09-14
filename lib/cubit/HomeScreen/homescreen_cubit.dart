import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:haptik_assignment/models/posts_model.dart';
import 'package:haptik_assignment/services/posts_service.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'homescreen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenCubitState> {
  final PostsService _templateService;
  // final AuthcubitCubit _authcubitCubit;

  // StreamSubscription _authcubitStream;

  HomeScreenCubit(
    this._templateService,
  ) : super(HomeScreenCubitInitial()) {
    // hydrate();
  }

  Future<void> listOfTemplates() async {
    emit(HomeScreenCubitLoading());

    try {
      List<PostsModel> list = await _templateService.getPosts();

      if (list.length == 0) {
        emit(HomeScreenCubitError());
      } else {
        emit(HomeScreenCubitLoaded(
          list,
        ));
      }
    } catch (e) {
      emit(HomeScreenCubitError());
    }
  }
}
