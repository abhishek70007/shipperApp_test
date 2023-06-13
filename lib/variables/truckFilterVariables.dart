import 'package:get/get.dart';

class TruckFilterVariables {
  List truckTypeTextList = [
    // 'Open Half Body',
    // 'Open Body',
    'openbody'.tr,
    'flatbed'.tr,
    // 'Flatbed',
    // 'Open Full Body',
    'trailerbody'.tr,
    // 'Trailer Body',
    // 'Full Body Trailer',
    // 'Half Body Trailer',
    // 'Standard Container',
    'standardcontainer'.tr,
    // 'High Cube Container'
    'highcontainer'.tr
  ];

  List truckTypeValueList = [
    // 'OPEN_HALF_BODY',
    'OPEN_BODY',
    'FLATBED',
    // 'OPEN_FULL_BODY',
    // 'FULL_BODY_TRAILER',
    // 'HALF_BODY_TRAILER',
    'TRAILER_BODY',
    'STANDARD_CONTAINER',
    'HIGH_CUBE_CONTAINER'
  ];

  Map<String, List<int>> passingWeightList = {
    // 'OPEN_HALF_BODY': [7, 8, 9, 15, 16, 18, 19, 20, 21, 24, 25, 30],
    'OPEN_BODY': [7, 8, 9, 15, 16, 18, 19, 20, 21, 24, 25, 30,0],
    'FLATBED': [16, 21, 24, 30, 32, 33, 34, 40,0],
    // 'OPEN_FULL_BODY': [7, 8, 9, 15, 16, 18, 19, 20, 21, 24, 25, 30],
    // 'FULL_BODY_TRAILER': [
    //   27,
    //   28,
    //   29,
    //   30,
    //   31,
    //   32,
    //   33,
    //   34,
    //   35,
    //   36,
    //   37,
    //   38,
    //   39,
    //   40,
    //   41,
    //   42
    // ],
    'TRAILER_BODY': [
      27,
      28,
      29,
      30,
      31,
      32,
      33,
      34,
      35,
      36,
      37,
      38,
      39,
      40,
      41,
      42,0
    ],
    // 'HALF_BODY_TRAILER': [
    //   27,
    //   28,
    //   29,
    //   30,
    //   31,
    //   32,
    //   33,
    //   34,
    //   35,
    //   36,
    //   37,
    //   38,
    //   39,
    //   40,
    //   41,
    //   42
    // ],
    'STANDARD_CONTAINER': [6, 7, 9, 15, 18,0],
    'HIGH_CUBE_CONTAINER': [6, 7, 9, 15, 18,0],
  };

  Map<String, List<int>> totalTyresList = {
    // 'OPEN_HALF_BODY': [6, 8, 10, 12, 14, 16, 18, 20, 22],
    'OPEN_BODY': [6, 8, 10, 12, 14, 16, 18, 20, 22,],
    'FLATBED': [6, 8, 10, 12, 14, 16, 18, 20, 22,],
    // 'OPEN_FULL_BODY': [6, 8, 10, 12, 14, 16, 18, 20, 22],
    // 'FULL_BODY_TRAILER': [6, 8, 10, 12, 14, 16, 18, 20, 22],
    // 'HALF_BODY_TRAILER': [6, 8, 10, 12, 14, 16, 18, 20, 22],
    'TRAILER_BODY': [6, 8, 10, 12, 14, 16, 18, 20, 22,],
    'STANDARD_CONTAINER': [6, 8, 10, 12, 14, 16, 18, 20, 22,],
    'HIGH_CUBE_CONTAINER': [6, 8, 10, 12, 14, 16, 18, 20, 22,],
  };
  // chaged this-----------------------
  // Map<String, List<int>> truckLengthList = {
  //   'OPEN_HALF_BODY': [40, 10],
  //   'FLATBED': [10, 20, 50],
  //   'OPEN_FULL_BODY': [60],
  //   'FULL_BODY_TRAILER': [20, 40],
  //   'HALF_BODY_TRAILER': [20, 40, 50],
  //   'STANDARD_CONTAINER': [10, 60],
  //   'HIGH_CUBE_CONTAINER': [40, 50, 60],
  // };
}
