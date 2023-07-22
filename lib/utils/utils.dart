import 'package:connectivity_plus/connectivity_plus.dart';

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



static Stream<bool> isConnect()async*{


var connectivityResult = await (Connectivity().checkConnectivity());

bool result=false;
if (connectivityResult == ConnectivityResult.mobile) {
  result=true;
} else if (connectivityResult == ConnectivityResult.wifi) {
  result=true;

} else if (connectivityResult == ConnectivityResult.ethernet) {

  result=true;
} else if (connectivityResult == ConnectivityResult.vpn) {
  result=true;
  // I am connected to a vpn network.
  // Note for iOS and macOS:
  // There is no separate network interface type for [vpn].
  // It returns [other] on any device (also simulator)
}  else if (connectivityResult == ConnectivityResult.other) {
  result=true;
  // I am connected to a network which is not in the above mentioned networks.
} else if (connectivityResult == ConnectivityResult.none) {
  // I am not connected to any network.
  print("sin internet");
  connectivityResult = await (Connectivity().checkConnectivity());
  yield false;
}

 yield result;
}
}