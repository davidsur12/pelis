import 'package:flutter/material.dart';
import 'package:peliculas/consultas/consultas_tmbd.dart';
import 'package:more_loading_gif/more_loading_gif.dart';
import 'package:peliculas/screen/info_movie.dart';

class SearchMovieDelegate extends SearchDelegate {
  TextStyle st = TextStyle(color: Colors.white);

  SearchMovieDelegate()
      : super(
          searchFieldLabel: "Busca peliculas",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          titleTextStyle: st,
        ),
        scaffoldBackgroundColor: Colors.black,
        hintColor: Colors.white,
        textTheme: TextTheme(headline6: st));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // btn borrar
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // retorna a la pantalla anterior
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("result");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return StreamBuilder(
      stream: Stream.fromFuture(ConsultaTmbd().loadMovies(query)),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          //no se obtienen datos aun
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(child: CircularProgressIndicator()),
            ],
          );
        } else {
          //resultados
          var result = snapshot.data["results"];
          if (result.length > 0) {
            //se encontro peliculas con la busqueda
            return ListView.builder(
              itemCount: result.length,
              itemBuilder: (context, index) {
                var img = result[index]['poster_path'] != null
                    ? Image.network(
                        'https://image.tmdb.org/t/p/w500' +
                            result[index]['poster_path'],
                        height: 200,
                      )
                    : Image.asset("assets/img/fondo.png", height: 130);

                var resul = getName(result[
                    index]); // obtengo el nombre de las peliculas encontradas

                return 
                
                InkWell(
                  child:   Row(
                  children: [
                    img,
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.all(15),
                      child: Text(resul, style: st, textAlign: TextAlign.center,),
                    ))
                  ],
                  // title: Text(resul,style:st),
                ),
                onTap: (){

  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Info_Movies(movie: result[index])),
                            );
                },
                )
              ;
              },
            );
          } else {
            // return Text("poner animacion");
            return Center(
                child: MoreLoadingGif(type: MoreLoadingGifType.magnify));
          }
        }
      },
    );
  }

//https://medium.com/codechai/implementing-search-in-flutter-17dc5aa72018

  getName(Map<String, dynamic> movie) {
    String result = "";
// movies[index]["title"]!=null?movies[index]["title"]:"Loading"
    if (movie["title"] != null) {
//si el titulo se encuentra
      result = movie["title"];
    } else {
      //si el titulo no se encuentra
      if (movie["original_title"] != null) {
        //si el nombre de la pelicula se encontro
        result = movie["original_title"];
      } else {
        //no se encontro ni el titulo ni el name de la pelicula
        result = "Loading";
      }
    }
    return result;
  }
}
