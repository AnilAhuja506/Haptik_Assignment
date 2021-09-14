import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/HomeScreen/homescreen_cubit.dart';
import 'services/posts_service.dart';

class ParentBlocsProvider extends StatelessWidget {
  final Widget child;

  ParentBlocsProvider({@required this.child});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeScreenCubit(PostsService()),
        ),
      
      ],
      child: child,
    );
  }
}
