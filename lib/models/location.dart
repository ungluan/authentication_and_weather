import 'package:geolocator/geolocator.dart';

class Location{
  double latitude  ;
  double longitude ;

  Future<void> getCurrentPosition() async {
    LocationPermission permission;
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      print('Location services are disabled.');
      return ;
    }
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        print('Location permissions are denied');
        return ;
      }
    }
    if(permission == LocationPermission.deniedForever){
      print('Location permissions are permanently denied, we cannot request permissions.');
      return ;
    }
    Position position = await Geolocator.getCurrentPosition();
    longitude = position.longitude;
    latitude = position.latitude;
  }
}