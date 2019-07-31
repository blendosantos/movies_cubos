import 'package:cubos_movie_flutter/src/config/utils.dart';
import 'package:cubos_movie_flutter/src/home/home_bloc.dart';
import 'package:cubos_movie_flutter/src/home/home_module.dart';
import 'package:cubos_movie_flutter/src/home/widgets/movies_search.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import 'package:cubos_movie_flutter/src/home/widgets/movies_list_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _currentIndex = 1;
  TabController _tabController;

  final _homeBloc = HomeModule.to.getBloc<HomeBloc>();

  @override
  void initState() {
    _tabController =
        new TabController(length: _tabsGenres().length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StatusSimples>(
        initialData: StatusSimples.LOADING,
        stream: _homeBloc.outState,
        builder: (context, snapshot) {
          if (snapshot.data == StatusSimples.LOADING) {
            return Scaffold(
              backgroundColor: Colors.deepOrange,
              body: Center(
                child: Container(
                  width: 150,
                  height: 150,
                  child: FlareActor(
                    "assets/cubos.flr",
                    animation: "cubos",
                  ),
                ),
              ),
            );
          }
          return DefaultTabController(
              initialIndex: _currentIndex,
              length: _tabsGenres().length,
              child: Scaffold(
                appBar: AppBar(
                  title: Text("Movies"),
                  actions: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          await showSearch(
                              context: context,
                              delegate: MoviesSearch());
                        })
                  ],
                  bottom: TabBar(
                    controller: _tabController,
                    tabs: _tabsGenres(),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: Colors.yellow,
                    indicatorWeight: 2,
                    indicatorPadding: EdgeInsets.symmetric(vertical: 4),
                    labelStyle:
                        TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                    unselectedLabelStyle:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
                  ),
                  bottomOpacity: 1,
                ),
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    ListMoviesWidget(0, _homeBloc),
                    ListMoviesWidget(1, _homeBloc),
                    ListMoviesWidget(2, _homeBloc),
                    ListMoviesWidget(3, _homeBloc),
                  ],
                ),
              ));
        });
  }

  List<Tab> _tabsGenres() {
    return [
      Tab(
        text: "Ação",
      ),
      Tab(
        text: "Drama",
      ),
      Tab(
        text: "Fantasia",
      ),
      Tab(
        text: "Ficção",
      )
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    _homeBloc.dispose();
    super.dispose();
  }
}
