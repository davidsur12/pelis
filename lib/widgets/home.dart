import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:peliculas/widgets/text.dart';
import 'package:peliculas/widgets/lista_movies.dart';
import 'package:peliculas/widgets/lista_card.dart';
import 'package:card_swiper/card_swiper.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List listaSeries = [];
  List listaPeliculas = [];
  List listaRecomendados = [];

  final String apiKey = "9f32a872f4cad9ed23f93e9672063656";
  final String token =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5ZjMyYTg3MmY0Y2FkOWVkMjNmOTNlOTY3MjA2MzY1NiIsInN1YiI6IjY0YWIzZDEwZDFhODkzMDBhZGJmYWI0MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.l1Jt9Dxnk10XYFa4r4suTABrwqvz0Cgv8IFZI3bpbng";

  final String txtPeliculas = "Peliculas populares";
  final String txtSeries = "Series populares";
  @override
  void initState() {
    loadMovies();
    super.initState();
  }

  loadMovies() async {
    final tmdbWithCustomLogs = TMDB(
        //TMDB instance
        ApiKeys(apiKey, token), //ApiKeys instance with your keys,
        logConfig: ConfigLogger(
          showLogs: true, //must be true than only all other logs will be shown
          showErrorLogs: true,
        ));
    Map recomendados = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map peliculas = await tmdbWithCustomLogs.v3.movies.getPopular();
    Map series = await tmdbWithCustomLogs.v3.tv.getPopular();

    setState(() {
      listaPeliculas = peliculas["results"];
      listaSeries = series["results"];
      listaRecomendados = recomendados["results"];
    });
  }

  final texto = "peliculas";

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        // This builds the scrollable content above the body
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                title: InfoTexto(
                  texto: "Peliculas",
                  color: Colors.white,
                  size: 9.0,
                ),
                backgroundColor: Colors.black,
                expandedHeight: 80,
                pinned: true,
                forceElevated: innerBoxIsScrolled,
              ),
            ],
        // The content of the scroll view
        body: Container(
            color: Colors.black,
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                Container(
                  height: 300,
                  color: Colors.black,
                  child: ListaCard(movies: listaSeries),
                ),
                ListaMovies(
                  movies: listaPeliculas,
                  categoria: txtPeliculas,
                ),
                ListaMovies(
                  movies: listaSeries,
                  categoria: txtSeries,
                )
              ],
            )));
  }
}
