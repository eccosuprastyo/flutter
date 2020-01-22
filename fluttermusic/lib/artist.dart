import 'song.dart';
import 'album.dart';

class Artist {
  final int id;
  final String type;
  final String link;
  final String name;

  final List<Song> songs;
  final List<Album> albums;

  Artist({this.id, this.type, this.link, this.name, this.songs, this.albums});

  factory Artist.fromJson(Map<String, dynamic> json,Map<String, dynamic> jsonSong,Map<String, dynamic> jsonAlbum) {
    final List<Song> songs = [];
    final List<Album> albums = [];

    final relationshipJSON = jsonSong != null ? jsonSong['data'] as List : null;
    if (relationshipJSON != null) {
      final songsJSON = relationshipJSON;
      if (songsJSON != null) {
        songs.addAll((songsJSON).map((s) => Song.fromJson(s)));
      }

      final albumJSON = jsonAlbum['data']  as List;
      if (albumJSON != null) {
        albums
            .addAll((albumJSON).map((s) => Album.fromJson(s)));
      }
    }

    return Artist(
        id: json['id'],
        type: json['type'],
        link: json['link'],
        name: json['name'],
        albums: albums,
        songs: songs);
  }
}
