import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:peliculas/screen/info_movie.dart';


class ListaCard extends StatelessWidget {

 final  List movies;
  const ListaCard({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return 
    (  Swiper(
      
        itemBuilder: (BuildContext context,int index){
          return  
          
          
          /*movies[index]['poster_path'] != null ? Image.network('https://image.tmdb.org/t/p/w500' + movies[index]['poster_path'],
          height:200,) :Image.asset("assets/img/fondo.png", height:200);*/

           getBackdrop(index);//:getPoster(index);
        },
        itemCount: movies.length,
        pagination: SwiperPagination(
          margin: EdgeInsets.all(0)
        ),
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
  //containerWidth: 150,
  itemWidth: 400.0,
  itemHeight: 300.0,

  onTap: (n){
 
     Navigator.push(context,MaterialPageRoute(builder: (context) => Info_Movies(movie: movies[n])),
                            );
  },

      ))
    ;
    
    
    //https://pub.dev/packages/card_swiper
  }

  Widget getBackdrop(int index){

//movies[index]

if(this.movies[index]['backdrop_path'] != null){
return Image.network(
          'https://image.tmdb.org/t/p/w500' + movies[index]['backdrop_path'], height: 200  );
  
}
  return Image.asset("assets/img/fondo.png" , height: 200 );


}

Widget getPoster(int index){


 if(this.movies[index]["poster_path"]!= null){

return Image.network(
          'https://image.tmdb.org/t/p/w500' + this.movies[index]["poster_path"], height: 200 );



}
else{
  return Image.asset("aseets/img/fondo.png" , height: 200);
}

}
}