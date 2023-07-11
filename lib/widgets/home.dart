import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:peliculas/widgets/text.dart';
import 'package:peliculas/widgets/lista_movies.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  List listaPeliculas = [];
  List peliculass=[];
  final String apiKey = "9f32a872f4cad9ed23f93e9672063656";
  final String token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5ZjMyYTg3MmY0Y2FkOWVkMjNmOTNlOTY3MjA2MzY1NiIsInN1YiI6IjY0YWIzZDEwZDFhODkzMDBhZGJmYWI0MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.l1Jt9Dxnk10XYFa4r4suTABrwqvz0Cgv8IFZI3bpbng";
  
@override
void initState() {
  loadMovies ();
  super.initState();
  
}

loadMovies ()async{

final tmdbWithCustomLogs = TMDB( //TMDB instance
    ApiKeys(apiKey, token),//ApiKeys instance with your keys,
     logConfig: ConfigLogger(
      showLogs: true,//must be true than only all other logs will be shown
      showErrorLogs: true,
    ) 
  );
Map result = await tmdbWithCustomLogs.v3.trending.getTrending();
Map peliculas = await tmdbWithCustomLogs.v3.movies.getPopular();// trending.getTrending();

//print("result" + result.toString());
 //print(await tmdbWithCustomLogs.v3.movies.getPopular());


setState(() {
  listaPeliculas=result["results"];
  peliculass=peliculas["results"];
});
/*
print(listaPeliculas.toString());
print("--------------------");
print(peliculas.toString());
*/
}
 final texto="peliculas";
 //List<String> peliculas=[];
  @override
  Widget build(BuildContext context) {
   return Scaffold(
appBar:AppBar(title: InfoTexto(texto: "Peliculas" , color: Colors.black, size: 15.0,),backgroundColor: Colors.green,) ,
body:   ListView(children: [ListaMovies(movies: listaPeliculas)],)
  
   );
   
}
}