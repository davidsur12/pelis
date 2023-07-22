
import 'package:tmdb_api/tmdb_api.dart';



class ConsultaTmbd{
 static   const String apiKey = "9f32a872f4cad9ed23f93e9672063656";
  static const String token =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5ZjMyYTg3MmY0Y2FkOWVkMjNmOTNlOTY3MjA2MzY1NiIsInN1YiI6IjY0YWIzZDEwZDFhODkzMDBhZGJmYWI0MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.l1Jt9Dxnk10XYFa4r4suTABrwqvz0Cgv8IFZI3bpbng";

static final tmdbWithCustomLogs = TMDB(
        //TMDB instance
        ApiKeys(apiKey, token), 
        defaultLanguage: 'es-CO');


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



static listaPeliculas(String genero , int page)async{

return  await tmdbWithCustomLogs.v3.discover
        .getMovies(withGenres: genero, includeVideo:true, page: page, ); 

}

static listaSeries()async{
//regresa las series de tv mas populares page 1
return  await tmdbWithCustomLogs.v3.tv.getPopular();

}
  static searchMovie(int id)async{

   Map movieinfo = await tmdbWithCustomLogs.v3.movies.getDetails(id); 
    //print("info = " + movieinfo.toString());
return movieinfo;
  }

static String nameMovie(Map<String , dynamic> movie){
//regresa el nombre de la pelicula

    String result = "";
// movies[index]["title"]!=null?movies[index]["title"]:"Loading"
    if (movie["title"] != null) {
//si el titulo se encuentra
      result = movie["title"];
    } else {
      //si el titulo no se encuentra
      if (movie["name"] != null) {
        //si el nombre de la pelicula se encuntra
        result = movie["name"];
      } else {
        //no se encontro ni el titulo ni el name de la pelicula
        result = "Loading";
      }
    }
    return result;
  
}
static String year(Map<String , dynamic> movie){

return  movie["release_date"]!=null ? movie["release_date"] : "none";

}

static String descripcion(Map<String , dynamic> movie){


return  movie["overview"]!=null ? movie["overview"] : "none";

}
static String paguina(Map<String , dynamic> movie){


return  movie["homepage"]!=null ? movie["homepage"] : "";

}

static relacionados(Map<String , dynamic> movie)async{

//Future<Map<dynamic, dynamic>> 
  Map lista=movie["genres"][0];

var peliculas = await tmdbWithCustomLogs.v3.discover.getMovies(withGenres: lista["id"].toString());

return peliculas ; //["genres"]["id"];





}


}