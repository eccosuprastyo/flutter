import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'song.dart';
import 'chart.dart';
import 'album.dart';
import 'home.dart';
import 'artist.dart';
import 'search.dart';

class AppleMusicStore {
  AppleMusicStore._privateConstructor();

  static final AppleMusicStore instance = AppleMusicStore._privateConstructor();
  static const BASE_URL = 'https://api.deezer.com';
  static const GENRE_URL = "$BASE_URL/genres";
  static const _SONG_URL = "$BASE_URL/songs";
  static const _ALBUM_URL = "$BASE_URL/album";
  static const _CHART_URL = "$BASE_URL/chart";
  static const _ARTIST_URL = "$BASE_URL/artist";
  static const _SEARCH_URL = "$BASE_URL/search";
  static const JWT_KEY = 'fraHqOefFZ2zYgsfC1nRPcNBONGxaehnNR5RGwv3wiWOxG5vUqB';

  Future<dynamic> _fetchJSON(String url) async {
    final response =
        await http.get(url, headers: {'Authorization': "Bearer $JWT_KEY"});
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<Song> fetchSongById(String id) async {
    final json = await _fetchJSON("$_SONG_URL/$id");
    return Song.fromJson(json['data'][0]);
  }

  Future<Album> fetchAlbumById(String id) async {
    final json = await _fetchJSON("$_ALBUM_URL/$id");
    return Album.fromJson(json);
  }

  Future<Artist> fetchArtistById(int id) async {
    final jsonArtist = await _fetchJSON("$_ARTIST_URL/$id");
    final trackLink = jsonArtist['tracklist'];
    final jsonAlbum = await _fetchJSON("$_ARTIST_URL/$id/albums");
    final jsonSong = await _fetchJSON("$trackLink");
    return Artist.fromJson(jsonArtist,jsonSong,jsonAlbum);
  }

  Future<Chart> fetchAlbumsAndSongsTopChart() async {
    final url = "$_CHART_URL";
    final json = await _fetchJSON(url);
    final songChartJSON = json['tracks'];
    final songChart = SongChart.fromJson(songChartJSON);

    final albumChartJSON = json['albums'];

    final albumChart = AlbumChart.fromJson(albumChartJSON);

    final chart = Chart(albumChart: albumChart, songChart: songChart);
    return chart;
  }

  Future<Search> search(String query) async {
    final urlArtist = "$_SEARCH_URL/artist?q=$query";
    final urlAlbum = "$_SEARCH_URL/album?q=$query";
    final urlTrack = "$_SEARCH_URL/track?q=$query";

    final encodedArtist = Uri.encodeFull(urlArtist);
    final encodedAlbum = Uri.encodeFull(urlAlbum);
    final encodedTrack = Uri.encodeFull(urlTrack);

    final jsonArtist = await _fetchJSON(encodedArtist);
    final jsonAlbum = await _fetchJSON(encodedAlbum);
    final jsonTrack = await _fetchJSON(encodedTrack);

    final List<Album> albums = [];
    final List<Song> songs = [];
    final List<Artist> artists = [];

    final artistJSON = jsonArtist['data'] as List;
    if (artistJSON != null) {
      artists
          .addAll((artistJSON).map((a) => Artist.fromJson(a,null,null)));
    }

    final albumsJSON = jsonAlbum['data'] as List;
    if (albumsJSON != null) {
      albums.addAll((albumsJSON).map((a) => Album.fromJson(a)));
    }

    final songJSON = jsonTrack['data'] as List;
    if (songJSON != null) {
      songs.addAll((songJSON).map((a) => Song.fromJson(a)));
    }

    return Search(albums: albums, songs: songs, artists: artists, term: query);
  }

  Future<Home> fetchBrowseHome() async {
    final chart = await fetchAlbumsAndSongsTopChart();
    final List<Album> albums = [];

    final album3 = await fetchAlbumById(chart.albumChart.albums[0].id);

    albums.add(album3);

    return Home(chart: chart, albums: albums);
  }
}
