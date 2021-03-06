import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube_favorites/blocs/favorite_bloc.dart';
import 'package:flutter_youtube_favorites/screens/home_screen.dart';

import 'blocs/video_bloc.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => VideosBloc()),
        Bloc((i) => FavoriteBloc())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
