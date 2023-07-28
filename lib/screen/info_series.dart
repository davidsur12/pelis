import 'package:flutter/material.dart';
import 'package:peliculas/widgets/lista_movies.dart';
import 'package:peliculas/widgets/text.dart';
import 'package:peliculas/consultas/consultas_tmbd.dart';

class InfoSeries extends StatefulWidget {
  final Map<String, dynamic> serie;
   InfoSeries({super.key , required this.serie});

  @override
  State<InfoSeries> createState() => _InfoSeriesState();
}

class _InfoSeriesState extends State<InfoSeries> {

   var height;
var width;
var contexto;



  @override
  Widget build(BuildContext context) {

    contexto=context;
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;

    return Container(
child: info()
     
    );
  }

  Widget info(){

return Column(children: [
  loadImage2(),
  SizedBox(height: 90,),
  relacionados()
 
],);


//loadImage2();

  }

  String getname(){

    if(widget.serie["name"] == null || widget.serie["name"].toString().isEmpty){

return "Cargando";
    }
    return widget.serie["name"] .toString();
  }
Widget getPoster(){


 if(widget.serie["poster_path"]!= null){

return Image.network(
          'https://image.tmdb.org/t/p/w500' + widget.serie["poster_path"], height: 170 );



}
else{
  return Image.asset("aseets/img/fondo.png" , height: 170);
}

}
Widget getBackdrop(){

if(widget.serie["backdrop_path"]!= null){
return Image.network(
          'https://image.tmdb.org/t/p/w500' + widget.serie["backdrop_path"] );
  
}
  return Image.asset("aseets/img/fondo.png");


}

String getFech(){

  if(widget.serie["first_air_date"]!=null){
    return widget.serie["first_air_date"];
  }
  return "";
}

Widget loadImage2() {
//devuelve una imagen en caso de que la encuentre  de lo contraio devuelve una imagen de not found
    Widget img;
    img= getBackdrop();
//print(width);
    return  Column(children: [

      Stack(
          alignment: Alignment.topLeft,
        
        children: [
        Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Column(children: [
            
           
            img,
       

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
                                      texto: getFech(),
                                      color: Colors.white,
                                      size: 15),),
                                      Container(
    margin: const EdgeInsets.only(left: 10.0, right: 25 ),
    child: InfoTexto(
                                      texto: getname(),
                                      color: Colors.white,
                                      size: 20),),
                                      SizedBox(height: 10,),
  ],)
                                      
                                      ,),),
         ],),
          
          getPoster(),
            /*result['poster_path'] != null
                        ? Image.network(
                            'https://image.tmdb.org/t/p/w500' +
                                result['poster_path'],
                            height: 170)
                        : Image.asset("assets/img/fondo.png"),
         
          */

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

  atras(){
Navigator.of(contexto).pop();

}
  Widget relacionados() {
//var genero= ConsultaTmbd.relacionados(result);

    return StreamBuilder(
      stream: Stream.fromFuture(ConsultaTmbd.relacionadosPeliculas("35")),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var lista = [snapshot.data["results"]];
          return ListaMovies(movies: lista[0], categoria: "Peliculas");
        } else if (snapshot.hasError) {
          Text("");
        }
        return CircularProgressIndicator();
      },
    );
  }
}