import 'song.dart';

class Album {
  final String id;
  final String type;
  final String link;
  final String title;
  final String artworkRawUrl;
  final String artistName;
  final List<Song> songs;
  final int artistId;

  Album(
      {this.id,
      this.type,
      this.link,
      this.title,
      this.artworkRawUrl,
      this.artistName,
      this.songs,
      this.artistId});

  factory Album.fromJson(Map<String, dynamic> json) {
    final List<Song> songs = [];
    int artistId = 0;

    final relationshipJSON = json['tracks'] != null ? json['tracks']['data'] as List : null;
    if (relationshipJSON != null) {
      final tracksJSON = relationshipJSON;
      songs.addAll(tracksJSON.map((s) => Song.fromJson(s)));

      artistId = tracksJSON[0]['artist']['id'];
    }

    String title = '';
    String artworkRawUrl = '';
    String artistName = '';

    final attributesJSON = json;
    if (attributesJSON != null) {
      title = attributesJSON['title'];
      artworkRawUrl = attributesJSON['cover'];
      artistName = attributesJSON['artist'] != null ? attributesJSON['artist']['name'] : "";
    }

    return Album(
        id: attributesJSON['id'].toString(),
        type: attributesJSON['type'],
        link: attributesJSON['link'],
        title: title,
        artworkRawUrl: artworkRawUrl,
        artistName: artistName,
        songs: songs,
        artistId: artistId);
  }

  String artworkUrl(int size) {
    return this.artworkRawUrl.replaceAll('{w}x{h}', "${size}x$size");
  }
}
