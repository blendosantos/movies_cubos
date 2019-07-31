import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cubos_movie_flutter/src/config/utils.dart';
import 'package:cubos_movie_flutter/src/entity/movie.dart';
import 'package:cubos_movie_flutter/src/home/repositories/home_repository.dart';
import 'package:rxdart/rxdart.dart';

import 'home_module.dart';

class HomeBloc extends BlocBase {

  final _homeRepository = HomeModule.to.getDependency<HomeRepository>();

  final _stateController = BehaviorSubject<StatusSimples>();
  Stream<StatusSimples> get outState => _stateController.stream;

  List<Movie> _action = new List<Movie>();
  final _actionController = BehaviorSubject<List<Movie>>();
  Stream<List<Movie>> get outAction => _actionController.stream;

  List<Movie> _drama = new List<Movie>();
  final _dramaController = BehaviorSubject<List<Movie>>();
  Stream<List<Movie>> get outDrama => _dramaController.stream;

  List<Movie> _fantasy = new List<Movie>();
  final _fantasyController = BehaviorSubject<List<Movie>>();
  Stream<List<Movie>> get outFantasy => _fantasyController.stream;

  List<Movie> _fiction = new List<Movie>();
  final _fictionController = BehaviorSubject<List<Movie>>();
  Stream<List<Movie>> get outFiction => _fictionController.stream;

  final _searchMovieController = BehaviorSubject<List<Movie>>();
  Stream<List<Movie>> get outSearchMovie => _searchMovieController.stream;

  HomeBloc(){
    loadingAll();
  }

  void loadingAll() async{
    _stateController.add(StatusSimples.LOADING);
    await listenerAction();
    await listenerDrama();
    await listenerFantasy();
    await listenerFiction();
    _stateController.add(StatusSimples.IDLE);
  }

  Future<void> listenerAction({int page}) async{
    List<Movie> movies = await _homeRepository.allByGenre(28, page: page);
    _action.addAll(movies);
    _actionController.add(_action);
  }

  Future<void> listenerDrama({int page}) async{
    List<Movie> movies = await _homeRepository.allByGenre(18, page: page);
    _drama.addAll(movies);
    _dramaController.add(_drama);
  }

  Future<void> listenerFantasy({int page}) async{
    List<Movie> movies = await _homeRepository.allByGenre(14, page: page);
    _fantasy.addAll(movies);
    _fantasyController.add(_fantasy);
  }

  Future<void> listenerFiction({int page}) async{
    List<Movie> movies = await _homeRepository.allByGenre(878, page: page);
    _fiction.addAll(movies);
    _fictionController.add(_fiction);
  }

  Future<void> listenerSearch(String query) async{
    List<Movie> movies = await _homeRepository.findbyGenreAndTerm(query);
    _searchMovieController.add(movies);
  }

  @override
  void dispose() {
    _stateController.close();
    _homeRepository.dispose();

    _actionController.close();
    _dramaController.close();
    _fantasyController.close();
    _fictionController.close();
    _searchMovieController.close();

    super.dispose();
  }
}