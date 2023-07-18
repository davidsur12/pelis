import 'package:flutter/material.dart';
import 'package:peliculas/utils/utils.dart';
import 'package:peliculas/consultas/consultas_tmbd.dart';
import 'package:peliculas/widgets/text.dart';

class Info_Movies extends StatelessWidget {
  final Map<String, dynamic> movie; //info de la pelicula
  const Info_Movies({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
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
                actions: [
                  IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        //startSearchFunction();

                        // showSearch(context: context, delegate: SearchMovieDelegate() );
                      })
                ],
                forceElevated: innerBoxIsScrolled,
              ),
            ],
        body: info());
  }

  Widget info() {
    return StreamBuilder(
      stream: Stream.fromFuture(ConsultaTmbd.searchMovie(movie["id"])),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
//obtengo los resultados
          print(snapshot.data.toString());
          return Container(
            color: Colors.amber,
            child: Column(
              children: [
                loadImage(snapshot.data),
              ],
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget loadImage(Map<String, dynamic> result) {
//devuelve una imagen en caso de que la encuentre  de lo contraio devuelve una imagen de not found
    if (result["video"] != null && result["video"] != false) {
      return Text(result["video"]);
    } else if (result["backdrop_path"] != null) {
      return Container(
        height: 370,
        color: Colors.white,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Image.network(
                'https://image.tmdb.org/t/p/w500' + result['backdrop_path']),
            Container(
              color: Colors.black.withOpacity(0.2),
              height: 370,
              width: 500,
              child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    //alignment: Alignment.bottomLeft,
                    children: [
                      Image.network(
                          'https://image.tmdb.org/t/p/w500' +
                              result['poster_path'],
                          height: 150),
                          Row(children: [Text("release_date")],)
                    ],
                  )),
            )
          ],
        ),
      );
    }

// Image.network('https://image.tmdb.org/t/p/w500' + result['backdrop_path']),
//Image.network('https://image.tmdb.org/t/p/w500' + result['poster_path'],height: 100),
/*
else if(result["poster_path"]!= null){
return Image.network('https://image.tmdb.org/t/p/w500' + result['poster_path'], );
}
else if(result["logo_path"]!= null){
return Image.network('https://image.tmdb.org/t/p/w500' + result['logo_path'], );
}*/

    return Image.asset("assets/img/fondo.png", height: 200);
  }
}
