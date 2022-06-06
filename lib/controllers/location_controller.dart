import 'package:food_delivery/data/repository/location_repo.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class LocationController extends GetxController implements GetxService{

  final LocationRepo locationRepo;

  LocationController({required this.locationRepo});

  bool _loading = false;
  late Position _position;
}