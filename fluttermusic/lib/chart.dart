import 'song.dart';
import 'album.dart';

class Chart {
  final AlbumChart albumChart;
  final SongChart songChart;

  Chart({this.albumChart, this.songChart});
}

class AlbumChart {
  final int position;
  final String link;
  final String title;
  final List<Album> albums;

  AlbumChart({this.position, this.link, this.title, this.albums});

  factory AlbumChart.fromJson(Map<String, dynamic> json) {
    final albumJson = json['data'] as List;
    final albums = albumJson.map((s) => Album.fromJson(s)).toList();

    return AlbumChart(
        position: albumJson[0]['position'],
        link: albumJson[0]['link'],
        title: albumJson[0]['title'],
        albums: albums);
  }
}

class SongChart {
  final int rank;
  final String link;
  final String title;
  final List<Song> songs;

  SongChart({this.rank, this.link, this.title, this.songs});

  factory SongChart.fromJson(Map<String, dynamic> json) {
    final songJson = json['data'] as List;
    final songs = songJson.map((s) => Song.fromJson(s)).toList();

    return SongChart(
        rank: songJson[0]['rank'],
        link: songJson[0]['link'],
        title: songJson[0]['title'],
        songs: songs);
  }
}
