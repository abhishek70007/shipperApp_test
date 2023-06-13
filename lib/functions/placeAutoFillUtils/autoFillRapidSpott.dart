import '/models/autoFillMMIModel.dart';
import '../rapidApi.dart';
import 'package:logger/logger.dart';

Future<List<AutoFillMMIModel>> fillCity(String cityName) async{
  var logger = Logger();

  // logger.i("fillcity called");
  if(cityName.length>1) {
    List<AutoFillMMIModel> card = [];
    List<CityModel> citydetails = [];
    citydetails = await APIService().get(cityName);  //spott api of rapid api is used for place autosuggestion.
    for (var i = 0; i < citydetails.length; i++) {
      AutoFillMMIModel locationCardsModal = new AutoFillMMIModel(
        placeName: "${citydetails[i].name}",
          placeCityName: "",
          placeStateName: "${citydetails[i].adminDivision1!.name}");
      card.add(locationCardsModal);
    }
    return card;
  }else{
    List<AutoFillMMIModel> card = [];
    return card;
  }
}