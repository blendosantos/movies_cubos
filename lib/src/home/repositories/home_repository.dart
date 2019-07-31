import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cubos_movie_flutter/src/config/utils.dart';
import 'package:cubos_movie_flutter/src/entity/movie.dart';
import 'package:dio/dio.dart';

class HomeRepository extends Disposable {
  final _dio = Dio();

  Future<List<Movie>> allByGenre(int idGenre, {int page}) async {
    List<Movie> _result = new List<Movie>();
    Response respose = await _dio.get(URL_API +
        "discover/movie" +
        token +
        "&language=pt-BR" +
        "&sort_by=revenue.desc" +
        (page != null ? "&page=" + page.toString() : "") +
        "&with_genres=" +
        idGenre.toString());
    respose.data['results'].forEach((v) {
      _result.add(new Movie.fromJson(v));
    });
    return _result;
  }

  Future<List<Movie>> findbyGenreAndTerm(String query) async {
    List<Movie> _result = new List<Movie>();
    Response respose = await _dio.get(URL_API +
        "search/movie" +
        token +
        "&language=pt-BR" +
        "&query=" +
        query);
    respose.data['results'].forEach((v) {
      _result.add(new Movie.fromJson(v));
    });
    return _result;
  }

  @override
  void dispose() {}
}
