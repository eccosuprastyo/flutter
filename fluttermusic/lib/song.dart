class Song {
  final int id;
  final String type;
  final String link;
  final String title;
  final String previewUrl;
  final String artworkRawUrl;
  final String artistName;
  final String albumName;

  Song(
      {this.id,
      this.type,
      this.link,
      this.title,
      this.previewUrl,
      this.artworkRawUrl,
      this.artistName,
      this.albumName});

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
        id: json['id'],
        type: json['type'],
        link: json['link'],
        title: json['title'],
        previewUrl: json['preview'],
        artworkRawUrl: json['album'] != null ? json['album']['cover'] : "",
        artistName: json['artist']['name'],
        albumName: json['album']!= null ? json['album']['title'] : "");
  }

  String artworkUrl(int size) {
    return this.artworkRawUrl.replaceAll('{w}x{h}', "${size}x$size");
  }
}
