import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'song.dart';
import 'divider_widget.dart';
import 'player_widget.dart';

class CarouselSongWidget extends StatelessWidget {
  final String title;
  final List<Song> songs;
  final String cta;
  final dynamic onCtaTapped;

  CarouselSongWidget({this.title, this.songs, this.cta, this.onCtaTapped});

  @override
  Widget build(BuildContext context) {
    final List<Widget> songsItemWidget = songs
        .map((s) => CarouselSongItemWidget(
              song: s,
            ))
        .toList();

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Text(
                title,
                style: Theme.of(context).textTheme.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
              this.cta != null
                  ? Material(
                      color: Colors.white,
                      child: InkWell(
                          onTap: () {
                            this.onCtaTapped();
                          },
                          child: Text(
                            this.cta,
                            style: Theme.of(context)
                                .textTheme
                                .subhead
                                .apply(color: Colors.red),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          )))
                  : Container()
            ],
          ),
        ),
        DividerWidget(
          margin: const EdgeInsets.only(top: 8.0, left: 20.0, right: 20.0),
        ),
        Container(
          height: 260,
          child: GridView.count(
            // physics: const PageScrollPhysics(),
            scrollDirection: Axis.horizontal,
            primary: false,
            childAspectRatio: 1 / 7.25,
            padding:
                const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 10.0,
            crossAxisCount: 4,
            children: songsItemWidget,
          ),
        )
      ],
    );
  }
}

class CarouselSongItemWidget extends StatelessWidget {
  final Song song;

  CarouselSongItemWidget({this.song});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (context) => PlayerWidget(
                      song: song,
                    )));
          },
          child: Container(
              child: Column(
            children: <Widget>[
              Expanded(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(right: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.network(
                              song.artworkUrl(256),
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            )),
                      )),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          song.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                        Padding(padding: EdgeInsets.only(top: 4.0)),
                        Text(song.artistName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.caption)
                      ],
                    ),
                  ),
                  Icon(
                    Icons.play_arrow,
                    color: Colors.red,
                  )
                ],
              )),
              Padding(
                padding: EdgeInsets.only(top: 4.0),
              ),
              DividerWidget(
                margin: EdgeInsets.only(left: 50),
              )
            ],
          )),
        ));
  }
}
