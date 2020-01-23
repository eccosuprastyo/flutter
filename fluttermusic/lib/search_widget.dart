import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttermusic/album.dart';
import 'cupertino_search_bar.dart';
import 'search.dart';
import 'musicservice.dart';
import 'carousel_song_widget.dart';
import 'carousel_album.dart';
import 'divider_widget.dart';
import 'artist_widget.dart';
import 'artist.dart';
import 'song.dart';

class SearchWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchWidgetState();
  }
}

class SearchWidgetState extends State<SearchWidget>
    with SingleTickerProviderStateMixin {
  TextEditingController _searchTextController = TextEditingController();
  FocusNode _searchFocusNode = FocusNode();
  Animation _animation;
  AnimationController _animationController;
  Future<Search> _search;
  AppleMusicStore musicStore = AppleMusicStore.instance;
  String _searchTextInProgress;

  @override
  initState() {
    super.initState();

    _animationController = new AnimationController(
      duration: new Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
    _searchFocusNode.addListener(() {
      if (!_animationController.isAnimating) {
        _animationController.forward();
      }
    });

    _searchTextController.addListener(_performSearch);
  }

  _performSearch() {
    final text = _searchTextController.text;
    if (_search != null && text == _searchTextInProgress) {
      return;
    }

    if (text.isEmpty) {
      this.setState(() {
        _search = null;
        _searchTextInProgress = null;
      });
      return;
    }

    this.setState(() {
      _search = musicStore.search(text);
      _searchTextInProgress = text;
    });
  }

  _cancelSearch() {
    _searchTextController.clear();
    _searchFocusNode.unfocus();
    _animationController.reverse();
    this.setState(() {
      _search = null;
      _searchTextInProgress = null;
    });
  }

  _clearSearch() {
    _searchTextController.clear();
    this.setState(() {
      _search = null;
      _searchTextInProgress = null;
    });
  }

  @override
  dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          middle: IOSSearchBar(
        controller: _searchTextController,
        focusNode: _searchFocusNode,
        animation: _animation,
        onCancel: _cancelSearch,
        onClear: _clearSearch,
      )),
      child: GestureDetector(
        onTapUp: (TapUpDetails _) {
          _searchFocusNode.unfocus();
          if (_searchTextController.text == '') {
            _animationController.reverse();
          }
        },
        child: _search != null
            ? FutureBuilder<Search>(
                future: _search,
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState != ConnectionState.waiting) {
                    final searchResult = snapshot.data;

                    List<Song> songs = searchResult.songs;
                    if (songs.length >= 5) {
                      songs = songs.sublist(0, 5);
                    }

                    if (songs.length > 0 && songs.length < 5) {
                      songs = songs.sublist(0, songs.length);
                    }

                    List<Album>  albums = searchResult.albums;
                    if (albums.length >= 5) {
                      albums = albums.sublist(0, 5);
                    }

                    if (albums.length > 0 && albums.length < 5) {
                      albums = albums.sublist(0, albums.length);
                    }

                    List<Artist> artists = searchResult.artists;
                    if (artists.length > 3) {
                      artists = artists.sublist(0, 3);
                    }

                    final List<Widget> list = [];

                    if (artists != null && artists.isNotEmpty) {
                      list.add(Padding(
                          padding:
                              EdgeInsets.only(top: 16, left: 20, right: 20),
                          child: Text(
                            'Artists',
                            style: Theme.of(context).textTheme.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )));
                      list.add(
                        DividerWidget(
                          margin: const EdgeInsets.only(
                              top: 8.0, left: 20.0, right: 20.0),
                        ),
                      );

                      artists.forEach((a) {
                        list.add(
                          Padding(
                              padding: EdgeInsets.only(
                                  top: 16, left: 20, right: 20, bottom: 16),
                              child: Material(
                                color: Colors.white,
                                child: InkWell(
                                    onTap: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .push(CupertinoPageRoute(
                                              builder: (context) =>
                                                  ArtistWidget(
                                                      artistId: a.id,
                                                      artistName: a.name)));
                                    },
                                    child: Text(
                                      a.name,
                                      style: Theme.of(context).textTheme.body1,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    )),
                              )),
                        );
                        list.add(
                          DividerWidget(
                            margin: const EdgeInsets.only(
                                top: 0.0, left: 36.0, right: 20.0),
                          ),
                        );
                      });
                    }

                    if (albums != null && albums.isNotEmpty) {
                      list.add(Padding(
                        padding: EdgeInsets.only(top: 16),
                      ));
                      list.add(CarouselAlbumWidget(
                        title: 'Albums',
                        albums: albums,
                      ));
                    }

                    if (songs != null && songs.isNotEmpty) {
                      list.add(Padding(
                        padding: EdgeInsets.only(top: 16),
                      ));
                      list.add(CarouselSongWidget(
                        title: 'Songs',
                        songs: songs,
                      ));
                    }

                    return ListView(
                      children: list,
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text("${snapshot.error}"));
                  }

                  return Center(child: CircularProgressIndicator());
                },
              )
            : Center(
                child: Text(
                    'Type on search bar to begin')), // Add search body here
      ),
    );
  }
}
