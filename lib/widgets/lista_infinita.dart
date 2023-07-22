import 'package:flutter/material.dart';
import 'package:peliculas/widgets/text.dart';
import 'package:peliculas/screen/info_movie.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:peliculas/consultas/consultas_tmbd.dart';

class ListaInfinita extends StatefulWidget {

  final String genero;
  final String titulo;
ListaInfinita({super.key, required this.genero, required this.titulo});

  @override
  State<ListaInfinita> createState() => _ListaInfinitaState();
}

class _ListaInfinitaState extends State<ListaInfinita> {
  
   List? movies;
   List? movies2;
   ScrollController _scrollController = ScrollController();//.addListener();
   int page=1;
   int aumento=1;
   var l;
  
@override
  void initState() {
    listain();
      _scrollController.addListener(_onScroll);
    

    super.initState();
  }
  @override
void dispose() {
  
  super.dispose();
}
 listain()async{

    l=await ConsultaTmbd.listaPeliculas(widget.genero, page);
 
  setState(() {
   
   if(movies != null){
 //print("movies " + movies!.length.toString());
 
if(page>1){
 // page++;
// print( "nuevos valres " + l["results"].length.toString());
        movies!.addAll(l["results"]);
   //  print("movies" +movies!.length.toString());
     }
      
   }else{

     movies=l["results"];
     // print( l);
     
     }
     
     

  });
       

 }
 void _onScroll() async{
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels == 0) {
        // Estás en la parte superior del ListView
       
      } else {
        // Estás en la parte inferior del ListView
       // print('Estás en la parte inferior del ListView');
       // print("page $page  and aumento $aumento  " );
        
        
        if(page<100){
          page++;
listain();

        }
        
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    widget.genero;
  try{ return  lista();}
  catch(e){
    setState(() {
      page=1;
      
    });
    return  lista();}
   
    
  }


  getName(int index) {
    String result = "";
// movies[index]["title"]!=null?movies[index]["title"]:"Loading"
    if (movies![index]["title"] != null) {
//si el titulo se encuentra
      result = movies![index]["title"];
    } else {
      //si el titulo no se encuentra
      if (movies![index]["name"] != null) {
        //si el nombre de la pelicula se encuntra
        result = movies![index]["name"];
      } else {
        //no se encontro ni el titulo ni el name de la pelicula
        result = "Loading";
      }
    }
    return result;
  }

Widget lista(){
return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoTexto(texto: widget.titulo, color: Colors.white, size: 20),
          SizedBox(height: 7),
          Container(
              color: Colors.black,
              height: 220,
              child: ListView.builder(
                  
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount:     movies!=null? movies!.length:0,
                itemBuilder: (context, index) {
                  return Material(
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Info_Movies(movie: movies![index])),
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
                                          image: getPoster(index),
                                          
                                         /* DecorationImage(
                                            image: 
                                            
                                            NetworkImage(
                                                'https://image.tmdb.org/t/p/w500' +
                                                    movies![index]['poster_path']),
                                          ),*/
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

 getPoster(int index) {
var result ;
// movies[index]["title"]!=null?movies[index]["title"]:"Loading"

    if (movies![index]["poster_path"] != null) {
//si el titulo se encuentra
      result = DecorationImage(image:  NetworkImage('https://image.tmdb.org/t/p/w500' + movies![index]['poster_path']),);
    } else {
      print("pelicula sin caratula");
    result =  new DecorationImage(
      image: new AssetImage('assets/img/fondo.png'),
      fit: BoxFit.cover,
    );
 //aqui deberia ir una imagen en caso de no encontrar  nada
    //result=Image.asset("");
    }
    return result;
  }

  getposter2(int index){

 
 return FadeInImage(
    image:NetworkImage( 'https://image.tmdb.org/t/p/w500' + movies![index]['poster_path']),
    placeholder: const AssetImage("assets/img/fondo.png"),
    imageErrorBuilder:(context, error, stackTrace) {
       return Image.asset('assets/img/fondo.png',
           fit: BoxFit.fitWidth
       );
    },
    fit: BoxFit.fitWidth,
 
  );


 }
}