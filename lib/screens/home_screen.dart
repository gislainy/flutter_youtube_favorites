import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube_favorites/blocs/video_bloc.dart';
import 'package:flutter_youtube_favorites/delegates/data_search.dart';
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
            child: Text("0"),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {

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
        builder: (context, snapshot) {
            if(snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return VideoTile(snapshot.data[index]);
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
