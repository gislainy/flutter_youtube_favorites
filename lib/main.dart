import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube_favorites/screens/home_screen.dart';

import 'api.dart';
import 'blocs/video_bloc.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => VideosBloc())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
