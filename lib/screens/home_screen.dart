import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube_favorites/blocs/favorite_bloc.dart';
import 'package:flutter_youtube_favorites/blocs/video_bloc.dart';
import 'package:flutter_youtube_favorites/delegates/data_search.dart';
import 'package:flutter_youtube_favorites/models/video.dart';
import 'package:flutter_youtube_favorites/screens/favorites_screen.dart';
import 'package:flutter_youtube_favorites/widgets/video_tile.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset("images/logo.png"),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
                stream:  BlocProvider.getBloc<FavoriteBloc>().outFav,
                initialData: {},
                builder: (context, snapshot) {
                   return Text("${snapshot.data.length}");
                }
            ),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (content) => FavoritesScreen()));
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String search = await showSearch(context: context, delegate: DataSearch());
              if(search != null) {

                final VideosBloc bloc = BlocProvider.getBloc<VideosBloc>();
                bloc.inSearch.add(search);
              }
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: BlocProvider.getBloc<VideosBloc>().outVideos,
        initialData: [],
        builder: (context, snapshot) {
            if(snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length + 1,
                  itemBuilder: (context, index) {
                    if(index < snapshot.data.length ) {
                      return VideoTile(snapshot.data[index]);
                    } else if(index > 1) {
                      final VideosBloc bloc = BlocProvider.getBloc<VideosBloc>();
                      bloc.inSearch.add(null);
                      return Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),),
                      );
                    }
                    return Container();
                  }
              );
            } else {
              return Container();
            }
        },
      ),
    );
  }
}
