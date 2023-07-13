import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';


class ListaCard extends StatelessWidget {

  final List movies;
  const ListaCard({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return 
    
     Swiper(
      
        itemBuilder: (BuildContext context,int index){
          return Image.network('https://image.tmdb.org/t/p/w500' +movies[index]['poster_path'],
          height:200,);
        },
        itemCount: movies.length,
        pagination: SwiperPagination(),
        control: SwiperControl(),
      );
    
    
    //https://pub.dev/packages/card_swiper
  }
}