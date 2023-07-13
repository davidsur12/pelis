import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:peliculas/widgets/text.dart';
import 'package:peliculas/widgets/lista_movies.dart';
import 'package:peliculas/widgets/lista_card.dart';


class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List listaSeries = [];
  List listaPeliculas = [];
  List listaRecomendados = [];
  List listaAdventura = [];
  List listaComedia = [];
  List listaHorror = [];
  List listaContenido = [];

  final String apiKey = "9f32a872f4cad9ed23f93e9672063656";
  final String token =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5ZjMyYTg3MmY0Y2FkOWVkMjNmOTNlOTY3MjA2MzY1NiIsInN1YiI6IjY0YWIzZDEwZDFhODkzMDBhZGJmYWI0MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.l1Jt9Dxnk10XYFa4r4suTABrwqvz0Cgv8IFZI3bpbng";

  final List<String> txtLista = [
    "Peliculas populares",
    "Pelicuas Comedia",
    "Pelicuas de Horror",
    "Peliculas de gerra",
    "Peliculas  romanticas",
    "Documentales",
 
  ];
  @override
  void initState() {
    loadMovies();
    super.initState();
  }

  loadMovies() async {
    final tmdbWithCustomLogs = TMDB(
        //TMDB instance
        ApiKeys(apiKey, token), //ApiKeys instance with your keys,
        /* logConfig: ConfigLogger(
          showLogs: true, //must be true than only all other logs will be shown
          showErrorLogs: true,
        )*/
        defaultLanguage: 'en-ES');

    //Map generos = await tmdbWithCustomLogs.v3.genres.getMovieList(); //Obtén la lista de géneros oficiales para películas.
    /* 
       {genres: [{id: 28, name: Action}, {id: 12, name: Adventure}, {id: 16, name: Animation}, {id: 35, name: Comedy}, 
       {id: 80, name: Crime}, {id: 99, name: Documentary}, {id: 18, name: Drama}, {id: 10751, name: Family},
        {id: 14, name: Fantasy}, {id: 36, name: History}, {id: 27, name: Horror}, {id: 10402, name: Music}, 
        {id: 9648, name: Mystery}, {id: 10749, name: Romance}, {id: 878, name: Science Fiction}, 
       {id: 10770, name: TV Movie}, {id: 53, name: Thriller}, {id: 10752, name: War}, {id: 37, name: Western}]}
       */

   
    //var busqueda = await tmdbWithCustomLogs.v3.search .queryMovies("Drama"); //para buscar peliculas por palabras

    //busqueda por categorias
    var busquedaAdventura = await tmdbWithCustomLogs.v3.discover
        .getMovies(withGenres: "12"); //adventura
    var busquedaComedia = await tmdbWithCustomLogs.v3.discover
        .getMovies(withGenres: "35"); //comedia
    var busquedaHorror = await tmdbWithCustomLogs.v3.discover
        .getMovies(withGenres: "27"); //horror
    var busquedaWar = await tmdbWithCustomLogs.v3.discover
        .getMovies(withGenres: "10752"); //gerra
    var busquedaRomance = await tmdbWithCustomLogs.v3.discover
        .getMovies(withGenres: "10749"); //romance
    var busquedaDocumental = await tmdbWithCustomLogs.v3.discover
        .getMovies(withGenres: "99"); //documental
        
        

    
    //Map movie = await tmdbWithCustomLogs.v3.movies.getDetails(43421); //consulta peliculas con el id
    //print(movie.toString());
    Map recomendados = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map peliculas = await tmdbWithCustomLogs.v3.movies.getPopular();
    Map series = await tmdbWithCustomLogs.v3.tv.getPopular();

    setState(() {
      listaPeliculas = peliculas["results"];
      listaSeries = series["results"];
      listaRecomendados = recomendados["results"];
      listaAdventura = busquedaAdventura["results"];
      listaComedia = busquedaComedia["results"];
      listaHorror = busquedaHorror["results"];

      listaContenido = [
        peliculas["results"],
        busquedaComedia["results"],
        busquedaHorror["results"],
        busquedaWar["results"],
        busquedaRomance["results"],
        busquedaDocumental["results"],
 
      ];
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
                  size: 30.0,
                ),
                backgroundColor: Colors.black,
                expandedHeight: 80,
                pinned: true,
                actions: [ IconButton(
            icon: Icon(Icons.search, color:Colors.white,size:100 ,),
            onPressed: () {
              //startSearchFunction();
              print("btn");//debe ir a una pantalla donde se pueda buscar
            })],
                forceElevated: innerBoxIsScrolled,
              ),
            ],
        // The content of the scroll view
        body: Container(
            color: Colors.black,
            child: ListView(
                padding: const EdgeInsets.all(8),
                children: ListaContenido(listaContenido, txtLista))));
  }

  List<Widget> ListaContenido(List lista, List txt) {
    List<Widget> result = [];
    result.add(Container(
      height: 300,
      color: Colors.black,
      child: ListaCard(movies: listaSeries),
    ));
    for (int index = 0; index < lista.length; index++) {
      result.add(ListaMovies(
        movies: lista[index],
        categoria: txt[index],
      ));
    }

    return result;
  }
}
