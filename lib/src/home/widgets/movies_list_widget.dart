import 'package:cubos_movie_flutter/src/entity/movie.dart';
import 'package:cubos_movie_flutter/src/home/home_bloc.dart';
import 'package:cubos_movie_flutter/src/home/widgets/movie_item.dart';
import 'package:flutter/material.dart';

class ListMoviesWidget extends StatelessWidget {
  final ScrollController _scrollController = new ScrollController();

  final HomeBloc _homeBloc;
  final int _indexPage;

  Stream<List<Movie>> _outMovies;
  int _page = 1;

  ListMoviesWidget(this._indexPage, this._homeBloc) {
    switch (this._indexPage) {
      case 0:
        this._outMovies = _homeBloc.outAction;
        break;
      case 1:
        this._outMovies = _homeBloc.outDrama;
        break;
      case 2:
        this._outMovies = _homeBloc.outFantasy;
        break;
      case 3:
        this._outMovies = _homeBloc.outFiction;
        break;
    }

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _page++;
        _loadingSrollView();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: SingleChildScrollView(
        controller: _scrollController,
        child: StreamBuilder<List<Movie>>(
            stream: _outMovies,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Dados não encontrados!",
                        style: TextStyle(color: Colors.red, fontSize: 20),
                      ),
                    ),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 10,
                  runSpacing: 20,
                  children: new ItemMovie().itemMovie(context, snapshot.data),
                ),
              );
            }),
      ),
    );
  }

  void _loadingSrollView() {
    switch (this._indexPage) {
      case 0:
        _homeBloc.listenerAction(page: _page);
        break;
      case 1:
        _homeBloc.listenerDrama(page: _page);
        break;
      case 2:
        _homeBloc.listenerFantasy(page: _page);
        break;
      case 3:
        _homeBloc.listenerFiction(page: _page);
        break;
    }
  }
}
