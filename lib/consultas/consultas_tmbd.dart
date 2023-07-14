
import 'package:tmdb_api/tmdb_api.dart';



class ConsultaTmbd{
 final String apiKey = "9f32a872f4cad9ed23f93e9672063656";
  final String token =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5ZjMyYTg3MmY0Y2FkOWVkMjNmOTNlOTY3MjA2MzY1NiIsInN1YiI6IjY0YWIzZDEwZDFhODkzMDBhZGJmYWI0MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.l1Jt9Dxnk10XYFa4r4suTABrwqvz0Cgv8IFZI3bpbng";


loadMovies(String movie) async {
    final tmdbWithCustomLogs = TMDB(
        //TMDB instance
        ApiKeys(apiKey, token), //ApiKeys instance with your keys,
        /* logConfig: ConfigLogger(
          showLogs: true, //must be true than only all other logs will be shown
          showErrorLogs: true,
        )*/
        defaultLanguage: 'en-ES');

    var busqueda = await tmdbWithCustomLogs.v3.search .queryMovies(movie); //para buscar peliculas por palabras
    return busqueda;
    //busqueda por categorias
 

    
  }


}