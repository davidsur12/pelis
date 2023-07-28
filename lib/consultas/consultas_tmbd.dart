import 'dart:convert';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:restart_app/restart_app.dart';
import 'package:http/http.dart' as http;

class ConsultaTmbd {
  static const String apiKey = "9f32a872f4cad9ed23f93e9672063656";
  static const String token =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5ZjMyYTg3MmY0Y2FkOWVkMjNmOTNlOTY3MjA2MzY1NiIsInN1YiI6IjY0YWIzZDEwZDFhODkzMDBhZGJmYWI0MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.l1Jt9Dxnk10XYFa4r4suTABrwqvz0Cgv8IFZI3bpbng";

  static final tmdbWithCustomLogs = TMDB(
      //TMDB instance
      ApiKeys(apiKey, token),
      logConfig: const ConfigLogger(
        showLogs: false, //must be true than only all other logs will be shown
        showErrorLogs: false,
      ),
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

    var busqueda = await tmdbWithCustomLogs.v3.search
        .queryMovies(movie); //para buscar peliculas por palabras
    return busqueda;
    //busqueda por categorias
  }

  static listapeliculas2(String genero, int page) async {
/*
curl --request GET \
     --url 'https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=esp&page=1&without_genres=35' \
     --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5ZjMyYTg3MmY0Y2FkOWVkMjNmOTNlOTY3MjA2MzY1NiIsInN1YiI6IjY0YWIzZDEwZDFhODkzMDBhZGJmYWI0MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.l1Jt9Dxnk10XYFa4r4suTABrwqvz0Cgv8IFZI3bpbng' \
     --header 'accept: application/json'
 */

//final String baseUrl = 'https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=esp&page=1&without_genres=35';
//final String url = '$baseUrl?api_key=$apiKey';
    var result = await (Connectivity().checkConnectivity());
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.ethernet ||
        result == ConnectivityResult.vpn ||
        result == ConnectivityResult.other) {

    http.Response response;

try{
 const String baseUrl = 'https://api.themoviedb.org/3';
         response= await http.get(
          Uri.parse('$baseUrl/discover/movie?api_key=$apiKey&with_genres=$genero&language=es&page=$page'));
           
}catch(e){
 print("error al conectarse  con el servidor");
  throw Exception();
}

 if (response.statusCode!= 200) {
  print("error en response codigo diferente a 200 ");
      throw HttpRequestException();
    }

     try {
     // body = jsonDecode(response.body)['data'] as List;
      var r = json.decode(response.body);
       return r;
    } on Exception {
       print("error al leer el json ");
      throw JsonDecodeException();
      //return null;
    }

   
/*

      try {
        // final String url = 'https://api.themoviedb.org/3/discover/movie?include_adult=false&language=esp&page=1&without_genres=35?api_key=$apiKey';
        const String baseUrl = 'https://api.themoviedb.org/3';
         final response= await http.get(
          Uri.parse('$baseUrl/discover/movie?api_key=$apiKey&with_genres=$genero&language=es&page=$page'));

       // final url ='https://api.themoviedb.org/3/movie/popular?api_key=$apiKey';

       // final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          var r = json.decode(response.body);
          //  print(r.toString());
          return r;
        } else {
          // throw Exception('Error al obtener detalles de la película');
          print("else " +response.statusCode.toString());
          return null;
        }
      } catch (e) {
        print("catch");
        return null;
      }*/
    } else {
      print("sin internet");
      return null;
    }
  }

  static listaPeliculas(String genero, int page) async {
    var result = await (Connectivity().checkConnectivity());
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.ethernet ||
        result == ConnectivityResult.vpn ||
        result == ConnectivityResult.other) {
      print("yes internet");
      try {
        var r = await tmdbWithCustomLogs.v3.discover
            .getMovies(
              withGenres: genero,
              includeVideo: true,
              page: page,
            )
            .timeout(Duration(seconds: 2))
            .catchError((Error) {
          print("error catch ");
          Restart.restartApp();
          return null;
        }).whenComplete(() {
          print("error en oncomplete");
          //Restart.restartApp();
          return null;
        });

        return r;

       
      } catch (e) {
        print("error 123 $e");
        return null;
      }
    }

    return null;
  }

  static listaSeries() async {
//regresa las series de tv mas populares page 1
    return await tmdbWithCustomLogs.v3.tv.getPopular();
  }

  static searchMovie(int id) async {
    Map movieinfo = await tmdbWithCustomLogs.v3.movies.getDetails(id);
    //print("info = " + movieinfo.toString());
    return movieinfo;
  }

  static String nameMovie(Map<String, dynamic> movie) {
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

  static String year(Map<String, dynamic> movie) {
    return movie["release_date"] != null ? movie["release_date"] : "none";
  }

  static String descripcion(Map<String, dynamic> movie) {
    return movie["overview"] != null ? movie["overview"] : "none";
  }

  static String paguina(Map<String, dynamic> movie) {
    return movie["homepage"] != null ? movie["homepage"] : "";
  }

  static relacionados(Map<String, dynamic> movie) async {
//Future<Map<dynamic, dynamic>>
    Map lista = movie["genres"][0];

    var peliculas = await tmdbWithCustomLogs.v3.discover
        .getMovies(withGenres: lista["id"].toString());

    return peliculas; //["genres"]["id"];
  }

  static relacionadosPeliculas(String id) async {
//Future<Map<dynamic, dynamic>>
    //Map lista = movie["genres"][0];

    var peliculas = await tmdbWithCustomLogs.v3.discover
        .getMovies(withGenres: id);

    return peliculas; //["genres"]["id"];
  }

static seatchSerie(int id)async{

 Map serieinfo = await tmdbWithCustomLogs.v3.tv.getDetails(id);//  movies.getDetails(id);
    //print("info = " + movieinfo.toString());
    return serieinfo;
}

}
class HttpRequestException implements Exception {}

class JsonDecodeException implements Exception {}