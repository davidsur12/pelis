

class Utilidades{

static String nameMovie(Map<String , dynamic> movie){
//regresa el nombre de la pelicula

    String result = "";
// movies[index]["title"]!=null?movies[index]["title"]:"Loading"
    if (movie["title"] != null) {
//si el titulo se encuentra
      result = movie["title"];
    } else {
      //si el titulo no se encuentra
      if (movie["name"] != null) {
        //si el nombre de la pelicula se encuntra
        result = movie["name"];
      } else {
        //no se encontro ni el titulo ni el name de la pelicula
        result = "Loading";
      }
    }
    return result;
  
}

}