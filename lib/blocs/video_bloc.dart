import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_youtube_favorites/api.dart';
import 'package:flutter_youtube_favorites/models/video.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class VideosBloc implements BlocBase {

  Api api;

  List<Video> videos;

  Map<String, Video> _favorites = {};

  bool alreadySearch = false;


  final StreamController<List<Video>> _videosController = StreamController<List<Video>>();

  Stream get outVideos => _videosController.stream;

  final StreamController<String> _searchController = StreamController<String>();

  Sink get inSearch => _searchController.sink;


  VideosBloc() {

    api = Api();

    _searchController.stream.listen(_search);

    SharedPreferences.getInstance().then((prefs) {
      if(prefs.getKeys().contains("favorites")) {
        _favorites = json.decode(prefs.getString("favorites")).map(
                (key, value) {
              return MapEntry(key, Video.fromJson(value));
            }).cast<String, Video>();
        videos = _favorites.values.toList();
        _videosController.sink.add(_favorites.values.toList());
      }
    });
  }

  void _search(String search) async {
    if(search != null ) {
      alreadySearch = true;
      _videosController.sink.add([]);
      videos = await api.search(search);
    } else if(alreadySearch){
      videos += await api.nextPage();
    }
    _videosController.sink.add(videos);

  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }

  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => null;

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }



}