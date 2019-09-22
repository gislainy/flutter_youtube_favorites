import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_youtube_favorites/blocs/favorite_bloc.dart';
import 'package:flutter_youtube_favorites/models/video.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:flutter_youtube_favorites/api.dart';

class FavoritesScreen extends StatelessWidget {
  final bloc = BlocProvider.getBloc<FavoriteBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Video>>(stream: bloc.outFav, builder: (context, snapshot) {
        if(snapshot.hasData) {
          return ListView(
            children: snapshot.data.values.map((value) {
              return InkWell(
                onTap: () {
                  FlutterYoutube.playYoutubeVideoById(
                      apiKey: API_KEY,
                      videoId: value.id,
                      autoPlay: true, //default falase
                      fullScreen: true
                  );
                },
                onLongPress: () {
                  bloc.toggleFavorite(value);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 50,
                      child: Image.network(value.thumb),
                    ),
                    Expanded(
                      child: Text(
                        value.title,
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
