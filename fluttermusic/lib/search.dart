import 'album.dart';
import 'song.dart';
import 'artist.dart';

class Search {
  final String term;
  final List<Album> albums;
  final List<Song> songs;
  final List<Artist> artists;

  Search({this.albums, this.songs, this.artists, this.term});

  int get totalCount => albums.length + songs.length + artists.length;
  bool get isEmpty => totalCount == 0;
}
