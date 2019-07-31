import 'package:cubos_movie_flutter/src/entity/movie.dart';
import 'package:cubos_movie_flutter/src/home/widgets/movie_item.dart';
import 'package:flutter/material.dart';

import '../home_bloc.dart';
import '../home_module.dart';

class MoviesSearch extends SearchDelegate {

  final _homeBloc = HomeModule.to.getBloc<HomeBloc>();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "A pesquisa deve ter mais de duas letras.",
            ),
          )
        ],
      );
    }
    _homeBloc.listenerSearch(query);
    return SingleChildScrollView(
      child: Container(
        color: Colors.grey[300],
        child: StreamBuilder<List<Movie>>(
            stream: _homeBloc.outSearchMovie,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Container();
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

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

}