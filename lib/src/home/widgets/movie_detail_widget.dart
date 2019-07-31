import 'package:cached_network_image/cached_network_image.dart';
import 'package:cubos_movie_flutter/src/config/utils.dart';
import 'package:cubos_movie_flutter/src/entity/movie.dart';
import 'package:flutter/material.dart';

class MovieDetailWidget extends StatelessWidget {
  final Movie _movie;

  MovieDetailWidget(this._movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(_movie.originalTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _movie.posterPath != null
                  ? CachedNetworkImage(
                      imageUrl: URL_IMAGE_ORIGINAL + _movie.posterPath,
                      width: MediaQuery.of(context).size.width / 1,
                      height: MediaQuery.of(context).size.width / 1,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Center(child: new CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          Center(child: new Icon(Icons.error)),
                    )
                  : Image.asset(
                      "assets/img/no-image.jpg",
                      width: MediaQuery.of(context).size.width / 1,
                      height: MediaQuery.of(context).size.width / 1,
                      fit: BoxFit.cover,
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Descrição",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Text(
                _movie.overview,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
