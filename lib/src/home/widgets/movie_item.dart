import 'package:cached_network_image/cached_network_image.dart';
import 'package:cubos_movie_flutter/src/config/utils.dart';
import 'package:cubos_movie_flutter/src/entity/movie.dart';
import 'package:cubos_movie_flutter/src/home/widgets/movie_detail_widget.dart';
import 'package:flutter/material.dart';

class ItemMovie {

  List<Widget> itemMovie(BuildContext context, List<Movie> movies) {
    List<Widget> widgets = new List<Widget>();
    movies.forEach((m) {
      Widget item = new Container(
        width: MediaQuery.of(context).size.width / 2.2,
        color: Colors.white,
        child: GestureDetector(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              m.posterPath != null
                  ? CachedNetworkImage(
                imageUrl: URL_IMAGE_W200 + m.posterPath,
                placeholder: (context, url) =>
                    Center(child: new CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Center(child: new Icon(Icons.error)),
              )
                  : Image.asset("assets/img/no-image.jpg"),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  m.originalTitle,
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => MovieDetailWidget(m)));
          },
        ),
      );
      widgets.add(item);
    });
    return widgets;
  }

}