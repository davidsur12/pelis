import 'package:flutter/material.dart';
import 'package:peliculas/utils/utils.dart';
import 'package:peliculas/consultas/consultas_tmbd.dart';
import 'package:peliculas/widgets/text.dart';
import 'package:peliculas/widgets/lista_movies.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:link_text/link_text.dart';

class Info_Movies extends StatelessWidget {
  final Map<String, dynamic> movie; //info de la pelicula
   Info_Movies({super.key, required this.movie});
var width;
var contexto;

  @override
  Widget build(BuildContext context) {
   contexto=context;
    width=MediaQuery.of(context).size.width;
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
              /*  SliverAppBar(
               /* title: InfoTexto(
                  texto: "Peliculas",
                  color: Colors.white,
                  size: 30.0,
                ),*/
                backgroundColor: Colors.green.withOpacity(0.1),
                expandedHeight: 1,
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
           */
            ],
        body: SingleChildScrollView(
          child: info(),
        ));
  }

  Widget info() {
    return StreamBuilder(
      stream: Stream.fromFuture(ConsultaTmbd.searchMovie(movie["id"])),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
//obtengo los resultados
          // print(snapshot.data.toString());
          return Container(
            color:Colors.black,
            child:
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                loadImage2(snapshot.data),
                description(snapshot.data),
                paguina(snapshot.data),
                relacionados(snapshot.data)
              ],
            ))
          ;
        }
        return 
        Center(child:   CircularProgressIndicator(),);
      
      },
    );
  }

  
  Widget loadImage2(Map<String, dynamic> result) {
//devuelve una imagen en caso de que la encuentre  de lo contraio devuelve una imagen de not found
    Widget img;
    if (result["video"] != null && result["video"] != false) {
      img = Text(result["video"]);
    } else if (result["backdrop_path"] != null) {
      img =  (Image.network(
          'https://image.tmdb.org/t/p/w500' + result['backdrop_path'] , ) );
      
    } else {
      img = Image.asset("assets/img/fondo.png", width: 600);
    }


print(width);
    return  Column(children: [

      Stack(
          alignment: Alignment.topLeft,
        
        children: [
        Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Column(children: [
            
           
            img,
        /*  Container(
                            height: 90,
                            padding: EdgeInsets.only(left: 10),
                           
                            color: Color.fromARGB(255, 211, 16, 16).withOpacity(0.8),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InfoTexto(
                                      texto: ConsultaTmbd.year(movie),
                                      color: Colors.white,
                                      size: 15),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  InfoTexto(
                                      texto: ConsultaTmbd.nameMovie(movie),
                                      color: Colors.white,
                                      size: 20)
                                ],
                              ),
                            )
                            )

                            */



SizedBox(width: width
,child: Container(
  margin: const EdgeInsets.only(left: 112.0, ),
  color: const Color.fromARGB(255, 133, 19, 11),child: 
  
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 10,),
    Container(
    margin: const EdgeInsets.only(left: 10.0, right: 25 ),
    child:  InfoTexto(
                                      texto: ConsultaTmbd.year(movie),
                                      color: Colors.white,
                                      size: 15),),
                                      Container(
    margin: const EdgeInsets.only(left: 10.0, right: 25 ),
    child: InfoTexto(
                                      texto: ConsultaTmbd.nameMovie(movie),
                                      color: Colors.white,
                                      size: 20),),
                                      SizedBox(height: 10,),
  ],)
                                      
                                      ,),),
         ],),
          
          
            result['poster_path'] != null
                        ? Image.network(
                            'https://image.tmdb.org/t/p/w500' +
                                result['poster_path'],
                            height: 170)
                        : Image.asset("assets/img/fondo.png"),
         
          
/*
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.flag_circle_sharp, color: Colors.white)),*/
        ],
      ),
      Column(children: [SizedBox(height: 25,) , 
        IconButton(
              onPressed: () {
                atras();
              },
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 40,))],)
      
      ],)
      ]);
    
  }
  Widget description(Map<String, dynamic> result) {
    String overview = ConsultaTmbd.descripcion(result);
    if (overview.isEmpty) {
      return Text("");
    }

    return Padding(
        padding: EdgeInsets.all(30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 15),
          InfoTexto(
              texto: "Descripcion",
              color: Colors.white70,
              size: 18,
              fontFamily: "rancho"),
          SizedBox(height: 10),
          InfoTexto(
            texto: overview,
            color: Colors.white,
            size: 15,
          )
        ]));
  }

  Widget paguina(Map<String, dynamic> result) {
    String pagina = ConsultaTmbd.paguina(result); //homepage
    if (pagina.isEmpty) {
      return Text("");
    }
    return Padding(
        padding: EdgeInsets.only(left: 30, bottom: 30),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              InfoTexto(
                  texto: "Paguina",
                  color: Colors.white70,
                  size: 18,
                  fontFamily: "rancho"),
              SizedBox(height: 10),
              
            TextButton(onPressed: (){launchUrll(pagina);}, child: Text(pagina)),
          
            /*  InfoTexto(
                texto: pagina,
                color: Colors.white,
                size: 15,
              )*/
            ]));
  }

  Widget relacionados(Map<String, dynamic> result) {
//var genero= ConsultaTmbd.relacionados(result);

    return StreamBuilder(
      stream: Stream.fromFuture(ConsultaTmbd.relacionados(result)),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var lista = [snapshot.data["results"]];
          return ListaMovies(movies: lista[0], categoria: "Similares");
        } else if (snapshot.hasError) {
          Text("");
        }
        return CircularProgressIndicator();
      },
    );
  }

Future<void> launchUrll(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}

atras(){
Navigator.of(contexto).pop();

}


}