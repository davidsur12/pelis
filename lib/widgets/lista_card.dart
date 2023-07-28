import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:peliculas/screen/info_movie.dart';


class ListaCard extends StatelessWidget {

  final List movies;
  const ListaCard({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return 
    
     Swiper(
      
        itemBuilder: (BuildContext context,int index){
          return  movies[index]['poster_path'] != null ? Image.network('https://image.tmdb.org/t/p/w500' + movies[index]['poster_path'],
          height:200,) :Image.asset("assets/img/fondo.png");
        },
        itemCount: movies.length,
        pagination: SwiperPagination(),
       /* pagination: SwiperPagination(),
        control: SwiperControl(),
        */

      
 layout: SwiperLayout.CUSTOM,
  customLayoutOption: CustomLayoutOption(
    startIndex: -1,
    stateCount: 3
  )..addRotate([
    -45.0/180,
    0.0,
    45.0/180
  ])..addTranslate([
    Offset(-370.0, -40.0),
    Offset(0.0, 0.0),
    Offset(370.0, -40.0)
  ]),
  itemWidth: 200.0,
  itemHeight: 500.0,

  onTap: (n){
 
     Navigator.push(context,MaterialPageRoute(builder: (context) => Info_Movies(movie: movies[n])),
                            );
  },

      );
    
    
    //https://pub.dev/packages/card_swiper
  }
}