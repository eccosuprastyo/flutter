import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'musicservice.dart';
import 'carousel_song_widget.dart';
import 'carousel_album.dart';
import 'album_widget.dart';
import 'home.dart';

class BrowseWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BrowseWidgetState();
  }
}

class _BrowseWidgetState extends State<BrowseWidget> {
  final musicStore = AppleMusicStore.instance;
  Future<Home> _home;

  @override
  void initState() {
    super.initState();
    _home = musicStore.fetchBrowseHome();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Browse'),
        ),
        child: FutureBuilder<Home>(
          future: _home,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final albumChart = snapshot.data.chart.albumChart;

              final List<Widget> list = [];

              if (albumChart != null) {
                list.add(Padding(
                  padding: EdgeInsets.only(top: 16),
                ));
                list.add(CarouselAlbumWidget(
                  title: "Top Albums",
                  albums: albumChart.albums,
                ));
              }

              final songChart = snapshot.data.chart.songChart;

              if (songChart != null) {
                list.add(Padding(
                  padding: EdgeInsets.only(top: 16),
                ));
                list.add(CarouselSongWidget(
                  title: "Top Songs",
                  songs: songChart.songs,
                ));
              }

              snapshot.data.albums.forEach((f) {
                list.add(Padding(
                  padding: EdgeInsets.only(top: 16),
                ));
                list.add(CarouselSongWidget(
                  title: f.title,
                  songs: f.songs,
                  cta: 'See Album',
                  onCtaTapped: () {
                    Navigator.of(context, rootNavigator: true)
                        .push(CupertinoPageRoute(
                            builder: (context) => AlbumWidget(
                                  albumId: f.id,
                                  albumName: f.title,
                                )));
                  },
                ));
              });

              return ListView(
                children: list,
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
