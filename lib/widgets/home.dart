import 'package:flutter/material.dart';
import 'package:peliculas/widgets/text.dart';
import 'package:peliculas/widgets/lista_card.dart';
import 'package:peliculas/delegates/search_movie_delegate.dart';
import 'package:peliculas/widgets/lista_infinita.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:peliculas/consultas/consultas_tmbd.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';


class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List listaSeries = [];
  

  
  final List<String> txtLista = [
   
    "Peliculas de Comedia",
    "Peliculas de Horror",
    "Peliculas de Gerra",
    "Peliculas  Romanticas",
    "Documentales",
  ];
  List generos = [ "35", "27", "10752", "10749", "99"];

  late StreamSubscription<ConnectivityResult> connectivitySubscription;
  bool conection=false;

    GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
 // late AdmobInterstitial interstitialAd;
  @override
  void initState() {
   // loadMovies();
    super.initState();

    connectivitySubscription= Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
   
    if(result == ConnectivityResult.mobile || result== ConnectivityResult.wifi || result == ConnectivityResult.ethernet ||
    result == ConnectivityResult.vpn || result == ConnectivityResult.other){


   //loadMovies();
   series();
   setState(() {
   // series();
     conection=true;
   });
  
}else{

  setState(() {
    conection=false;
  });
  
}
  });


     
  }

  final texto = "peliculas";

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        // This builds the scrollable content above the body
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
                        print(
                            "btn"); //debe ir a una pantalla donde se pueda buscar

                        showSearch(
                            context: context, delegate: SearchMovieDelegate());
                      })
                ],
                forceElevated: innerBoxIsScrolled,
              ),
            ],
        // The content of the scroll view
        body:  
        //prueba2()
        info2()
        //prueba() 


        
        
        );
        
  }
prueba2(){
try{

if(conection){
return ListaInfinita(genero: generos[1], titulo: txtLista[1]);

}else{

 return  Center(child:CircularProgressIndicator());
}

  }catch(e){
    return Text("error en la app");
  }

  
}
 prueba(){
return FutureBuilder(
        future: ConsultaTmbd.listapeliculas2("35" , 1), //.getMovieDetails(movieId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar los detalles'),
            );
          } else if(snapshot.hasData){
           
            if(snapshot.data !=null){
           var resultado=snapshot.data! as Map<dynamic , dynamic>;
           print("total pelis " +resultado["results"].length.toString());
            String n =  resultado["results"].toString();
               return Center(child:Text(n));
            }
         
          
            /*
            final movieDetails = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    'https://image.tmdb.org/t/p/w500${movieDetails['poster_path']}',
                    height: 300,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      movieDetails['title'],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      movieDetails['overview'],
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            );*/
          }
          return Text("error en la consulta");
   },
      );

 }
Widget info2(){
  try{

if(conection){
return Container(
                  color: Colors.black,
                  child:SingleChildScrollView (child: Column(//ListView(
                      //padding: const EdgeInsets.all(8),
                      children: ListaContenido2())));

}else{

 return  Center(child:Lottie.asset('assets/animations/sin_internet.json'),);
}

  }catch(e){
    return Center(child:Lottie.asset('assets/animations/error.json'),);
  }


}
 
  List<Widget> ListaContenido2() {

  
    List<Widget> result = [];

if(listaSeries.length >0){

result.add(
  
  Container(
      height: 300,
      color: Colors.black,
  
      child: ListaCard(movies:listaSeries )
    )
    );
}

//result.add(admod());
    for (int index = 0; index < generos.length; index++) {
      result
          .add(ListaInfinita(genero: generos[index], titulo: txtLista[index]));
    }
    return result;
  }


  series() async{

 var lista=await ConsultaTmbd.relacionadosPeliculas("12");

 setState(() {
   listaSeries=lista["results"];
 });

  }



}
