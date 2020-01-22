import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'song.dart';
import 'album.dart';
import 'divider_widget.dart';
import 'player_widget.dart';
import 'album_widget.dart';

class CarouselAlbumWidget extends StatelessWidget {
  final String title;
  final List<Album> albums;

  CarouselAlbumWidget({this.title, this.albums});

  @override
  Widget build(BuildContext context) {
    final List<Widget> albumItemWidget = albums
        .map((s) => CarouselAlbumItemWidget(
              album: s,
            ))
        .toList();

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Text(
                title,
                style: Theme.of(context).textTheme.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ))
            ],
          ),
        ),
        DividerWidget(
          margin: const EdgeInsets.only(top: 8.0, left: 20.0, right: 20.0),
        ),
        Container(
          height: 410,
          child: GridView.count(
            // physics: const PageScrollPhysics(),
            scrollDirection: Axis.horizontal,
            primary: false,
            childAspectRatio: 1.25,
            padding:
                const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 0),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            crossAxisCount: 2,
            children: albumItemWidget,
          ),
        )
      ],
    );
  }
}

class CarouselAlbumItemWidget extends StatelessWidget {
  final Album album;
  CarouselAlbumItemWidget({this.album});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true)
                  .push(CupertinoPageRoute(
                      builder: (context) => AlbumWidget(
                            albumId: album.id,
                            albumName: album.title,
                          )));
            },
            child: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(right: 8.0),
                    height: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.network(
                            album.artworkUrl(512),
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          )),
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 4.0),
                ),
                Text(album.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.subtitle),
                Padding(
                  padding: EdgeInsets.only(top: 4.0),
                ),
                Text(album.artistName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.caption)
              ],
            ))));
  }
}
