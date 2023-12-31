import 'package:flutter/material.dart';
import 'package:peliculas/widgets/text.dart';
import 'package:peliculas/screen/info_movie.dart';

class ListaMovies extends StatelessWidget {

  final List movies;
  final String categoria;
   ListaMovies({super.key, required this.movies, required this.categoria});
    ScrollController _scrollController = ScrollController();//.addListener();
  




 
 void _onScroll() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels == 0) {
        // Estás en la parte superior del ListView
        print('Estás en la parte superior del ListView');
      } else {
        // Estás en la parte inferior del ListView
        print('Estás en la parte inferior del ListView');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
     _scrollController.addListener(_onScroll);
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoTexto(texto: categoria, color: Colors.white, size: 20),
          SizedBox(height: 7),
          Container(
              color: Colors.black,
              height: 220,
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return Material(
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Info_Movies(movie: movies[index])),
                            );
                           // print(movies[index]);
                          },
                          child:
                              // Image.network('https://image.tmdb.org/t/p/w500' + movies[index]["poster_path"], width: 90, height: 90,)
                              Container(
                                  color: Colors.black,
                                  width: 140,
                                  child: Column(children: [
                                    Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                'https://image.tmdb.org/t/p/w500' +
                                                    movies[index]
                                                        ['poster_path']),
                                          ),
                                        ),
                                        height: 200,
                                        width: 170,
                                        child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            Container(
                                              width: 133,
                                              height: 70,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                              child: Text(
                                                getName(index),
                                                style: TextStyle(
                                                    color: Colors.white),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          ],
                                        )),
                                    SizedBox(height: 5),
                                  ]))));
                },
              )),
        ],
      ),
    );
  }

  getName(int index) {
    String result = "";
// movies[index]["title"]!=null?movies[index]["title"]:"Loading"
    if (movies[index]["title"] != null) {
//si el titulo se encuentra
      result = movies[index]["title"];
    } else {
      //si el titulo no se encuentra
      if (movies[index]["name"] != null) {
        //si el nombre de la pelicula se encuntra
        result = movies[index]["name"];
      } else {
        //no se encontro ni el titulo ni el name de la pelicula
        result = "Loading";
      }
    }
    return result;
  }
}
