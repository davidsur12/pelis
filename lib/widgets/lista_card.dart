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
          return Image.network('https://image.tmdb.org/t/p/w500' + movies[index]['poster_path'],
          height:200,);
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

      );
    
    
    //https://pub.dev/packages/card_swiper
  }
}