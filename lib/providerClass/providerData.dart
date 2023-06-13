import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/controller/postLoadVariablesController.dart';
import '/translations/l10n.dart';
import 'package:google_sign_in/google_sign_in.dart';

//In provider data class variables that will be required across different screens are declared . These variables are updated by defining respective function for them.
//Right now variable declaration and function definition are writing without any specific order but later on change this , there are two options
// 1 Either declare the variables and its functions one below another so that developers immediately know which function updates what variable
// 2 First declare all variables and then declare all functions
//This is effective way for maintenance of code for long term.
//P.S Care should be taken that provider should only be used for updating variables and not processing their values.

// enum class for language selection
enum LanguageItem { English, Hindi }

class ProviderData extends ChangeNotifier {
  bool bidButtonSendRequestState = false;

  void updateBidButtonSendRequest(newValue) {
    bidButtonSendRequestState = newValue;
    notifyListeners();
  }

  bool editLoad = false;
  String? transporterLoadId;
  void updateEditLoad(bool value, String transporterloadId) {
    editLoad = value;
    transporterLoadId = transporterloadId;
    notifyListeners();
  }

  String? rate1;
  String? unitValue1;

  void updateRate(rate, unitValue) {
    rate1 = rate;
    print('rate in provider : $rate1');
    unitValue1 = unitValue;
    print('unit value in provider $unitValue1');
    notifyListeners();
  }

  List truckNoList = [
    "Add Truck",
  ];

  void updateTruckNoList({required String newValue}) {
    for (int i = 0; i < truckNoList.length; i++) {
      if (truckNoList[i].toString() == newValue.toString()) {
        print("hi truck already added");
        break;
      } else if (i == truckNoList.length - 1) {
        truckNoList.add(newValue);
        break;
      }
    }
    notifyListeners();
  }

  List driverNameList = [
    "Add New Driver",
  ];

  void updateDriverNameList({required String newValue}) {
    for (int i = 0; i < driverNameList.length; i++) {
      if (driverNameList[i].toString() == newValue.toString()) {
        print("hi driver already added");
        break;
      } else if (i == driverNameList.length - 1) {
        driverNameList.add(newValue);
        break;
      }
    }
    notifyListeners();
  }

  var selectedTruck;
  var selectedDriver;

  void updateSelectedTruck(String? newValue) {
    selectedTruck = newValue;
    notifyListeners();
  }

  void updateSelectedDriver(String? newValue) {
    selectedDriver = newValue;
    notifyListeners();
  }

  String loadingPointCityFindLoad = "";
  String loadingPointStateFindLoad = "";

  String unloadingPointCityFindLoad = "";
  String unloadingPointStateFindLoad = "";

  String loadingPointCityPostLoad = "";
  String loadingPointStatePostLoad = "";
  String loadingPointPostLoad = "";
  String loadingPointCityPostLoad2 = "";
  String loadingPointStatePostLoad2 = "";
  String loadingPointPostLoad2="";

  String unloadingPointCityPostLoad = "";
  String unloadingPointStatePostLoad = "";
  String unloadingPointPostLoad = "";
  String unloadingPointCityPostLoad2 = "";
  String unloadingPointStatePostLoad2 = "";
  String unloadingPointPostLoad2 = "";
//

  String bookingDate = "";
  String completedDate = "";

  // variables for accountVerification
  File? profilePhotoFile;
  File? addressProofFrontPhotoFile;
  File? addressProofBackPhotoFile;
  File? panFrontPhotoFile;
  File? companyIdProofPhotoFile;

  String? profilePhoto64;
  String? addressProofFrontPhoto64;
  String? addressProofBackPhoto64;
  String? panFrontPhoto64;
  String? companyIdProofPhoto64;

  // variables for login pages

  bool inputControllerLengthCheck = false;
  dynamic buttonColor = MaterialStateProperty.all<Color>(Colors.grey);
  String smsCode = '';
  String phoneController = '';

  //-------------------------------------

  // variables for add truck pages

  String truckTypeValue = '';
  int passingWeightValue = 0;
  int totalTyresValue = 0;
  int truckLengthValue = 0;
  String driverIdValue = '';
  String truckNumberValue = '';
  String productType = "Choose Product Type";
  int truckNumber = 0;
  int price = 0;
  String unitValue = "";
  String controller = "";
  String controller1 = "";
  String controller2 = "";
  bool PER_TRUCK = false;
  bool PER_TON = false;
  bool otpIsValid = true;
  String hintText = "enter price";
  Color borderColor = darkBlueColor;

  String truckId = '';

  //variables related to reset button
  bool resetActive = false;

  //variables related to driverApi
  List driverList = [];

  //variables related to orders page
  int upperNavigatorIndex = 0;
  int upperNavigatorIndex2 = 0;

  dynamic dropDownValue;

  // int rate = 0;
  //
  // void updateRate(value) {
  //   rate = value;
  //   notifyListeners();
  // }

  // bool isAddNewDriver = false;
  // updateIsAddNewDriver(value){
  //   isAddNewDriver = value;
  //   notifyListeners();
  // }
  String postLoadError = "";
  bool loadWidget = true;

  String bidLoadingPoint = '';
  String bidUnloadingPoint = '';

  updateBidEndpoints(loadingPoint, unLoadingPoint) {
    bidLoadingPoint = loadingPoint;
    bidUnloadingPoint = unLoadingPoint;
    notifyListeners();
  }

  void updateUpperNavigatorIndex(int value) {
    upperNavigatorIndex = value;
    notifyListeners();
  }
  void updateUpperNavigatorIndex2(int value){
    upperNavigatorIndex2 = value;
    notifyListeners();
  }

  updateLowerAndUpperNavigationIndex(lowerValue, upperValue) {
    upperNavigatorIndex = upperValue;
    notifyListeners();
  }

  updateProfilePhoto(File? newFile) {
    profilePhotoFile = newFile;
    notifyListeners();
  }

  updateProfilePhotoStr(String? newStr) {
    profilePhoto64 = newStr;
    notifyListeners();
  }

  updateAddressProofFrontPhoto(File? newFile) {
    addressProofFrontPhotoFile = newFile;
    notifyListeners();
  }

  updateAddressProofFrontPhotoStr(String? newStr) {
    addressProofFrontPhoto64 = newStr;
    notifyListeners();
  }

  updateAddressProofBackPhoto(File? newFile) {
    addressProofBackPhotoFile = newFile;
    notifyListeners();
  }

  updateAddressProofBackPhotoStr(String? newStr) {
    addressProofBackPhoto64 = newStr;
    notifyListeners();
  }

  updatePanFrontPhoto(File? newFile) {
    panFrontPhotoFile = newFile;
    notifyListeners();
  }

  updatePanFrontPhotoStr(String? newStr) {
    panFrontPhoto64 = newStr;
    notifyListeners();
  }

  updateCompanyIdProofPhoto(File? newFile) {
    companyIdProofPhotoFile = newFile;
    notifyListeners();
  }

  updateCompanyIdProofPhotoStr(String? newStr) {
    companyIdProofPhoto64 = newStr;
    notifyListeners();
  }

  void updatePrice(value) {
    price = value;
    notifyListeners();
  }

  void updateHintText(String value) {
    hintText = value;
    notifyListeners();
  }

  void updateBorderColor(Color value) {
    borderColor = value;
    notifyListeners();
  }

  void updateUnitValue() {
    if (PER_TRUCK) {
      // unitValue = "PER_TRUCK";
      unitValue = "PER_TRUCK".tr;
    } else if (PER_TON) {
      unitValue = "PER_TON".tr;
    } else if (unitValue == "") {
      return null;
    }
    notifyListeners();
  }

  void updateDropDownValue(value) {
    dropDownValue = value;
    notifyListeners();
  }

  //------------------------FUNCTIONS--------------------------------------------------------------------------

  void clearLoadingPointFindLoad() {
    loadingPointPostLoad = "";
    loadingPointCityFindLoad = "";
    loadingPointStateFindLoad = "";
    notifyListeners();
  }

  void clearUnloadingPointFindLoad() {
    unloadingPointPostLoad = "";
    unloadingPointCityFindLoad = "";
    unloadingPointStateFindLoad = "";
    notifyListeners();
  }

  void updateLoadingPointFindLoad(
      {required String place, required String city, required String state}) {
    loadingPointPostLoad = place;
    loadingPointCityFindLoad = city;
    loadingPointStateFindLoad = state;
    notifyListeners();
  }

  void updateUnloadingPointFindLoad(
      {required String place, required String city, required String state}) {
    unloadingPointPostLoad = place;
    unloadingPointCityFindLoad = city;
    unloadingPointStateFindLoad = state;
    notifyListeners();
  }

  updateControllerOne(value) {
    controller1 = value;
    notifyListeners();
  }

  updateControllerTwo(value) {
    controller2 = value;
    notifyListeners();
  }

  //////////////
  void clearLoadingPointPostLoad() {
    loadingPointPostLoad = "";
    loadingPointCityPostLoad = "";
    loadingPointStatePostLoad = "";
    notifyListeners();
  }
  void clearLoadingPointPostLoad2(){
    loadingPointPostLoad2 = "";
    loadingPointCityPostLoad2 = "";
    loadingPointStatePostLoad2 = "";
    notifyListeners();
  }

  void clearUnloadingPointPostLoad() {
    unloadingPointPostLoad = "";
    unloadingPointCityPostLoad = "";
    unloadingPointStatePostLoad = "";
    notifyListeners();
  }
  void clearUnloadingPointPostLoad2(){
    unloadingPointPostLoad2 = "";
    unloadingPointCityPostLoad2 = "";
    unloadingPointStatePostLoad2 = "";
  }

  void updateLoadingPointPostLoad(
      {required String place, required String city, required String state}) {
    loadingPointPostLoad = place;
    loadingPointCityPostLoad = city;
    loadingPointStatePostLoad = state;

    notifyListeners();
  }
  void updateLoadingPointPostLoad2(
  {required String place, required String city, required String state}){
    loadingPointPostLoad2 = place;
    loadingPointCityPostLoad2 = city;
    loadingPointStatePostLoad2 = state;
    notifyListeners();
  }

  void updateUnloadingPointPostLoad(
      {required String place, required String city, required String state}) {
    unloadingPointPostLoad = place;
    unloadingPointCityPostLoad = city;
    unloadingPointStatePostLoad = state;

    notifyListeners();
  }
  void updateUnloadingPointPostLoad2(
  {required String place, required String city, required String state}){
    unloadingPointPostLoad2 = place;
    unloadingPointCityPostLoad2 = city;
    unloadingPointStatePostLoad2 = state;
  }

  //functions for login screen

  void updatePhoneController(String value) {
    phoneController = value;
    print(phoneController);
    notifyListeners();
  }

  void updateInputControllerLengthCheck(bool value) {
    inputControllerLengthCheck = value;
    notifyListeners();
  }

  void updateButtonColor(dynamic value) {
    buttonColor = value;
    notifyListeners();
  }

  void updateSmsCode(value) {
    smsCode = value;
    notifyListeners();
  }

  void updateProductType(value) {
    productType = value;
    notifyListeners();
  }

  //TODO: name change to something more relevant
  void clearAll() {
    inputControllerLengthCheck = false;
    buttonColor = MaterialStateProperty.all<Color>(Colors.grey);

    smsCode = '';
    notifyListeners();
  }

//-------------------------------------

  // functions for add truck pages

  void updateTruckTypeValue(value) {
    truckTypeValue = value;
    notifyListeners();
  }

  void updatePassingWeightValue(value) {
    passingWeightValue = value;
    notifyListeners();
  }

  void updateTotalTyresValue(value) {
    totalTyresValue = value;
    notifyListeners();
  }

  void updateTruckLengthValue(value) {
    truckLengthValue = value;
    notifyListeners();
  }

  void updateDriverDetailsValue(value) {
    driverIdValue = value;
    notifyListeners();
  }

  void updateTruckNumberValue(value) {
    truckNumberValue = value;
    notifyListeners();
  }

  void updateTruckNumber(value) {
    truckNumber = value;
    notifyListeners();
  }

  void updateTruckId(value) {
    truckId = value;
    notifyListeners();
  }

  void updateResetActive(bool value) {
    resetActive = value;
    notifyListeners();
  }

  void resetUnitValue() {
    PER_TON = false;
    PER_TRUCK = false;
  }

  void resetTruckFilters() {
    // productType = "Choose Product Type";
    truckTypeValue = '';
    passingWeightValue = 0;
    totalTyresValue = 0;
    // truckNumber = 0;
    truckLengthValue = 0;
    // price = 0;
    driverIdValue = '';
    // unitValue = "";
    // resetUnitValue();
    notifyListeners();
  }

  void resetPostLoadFilters() {
    productType = "Choose Product Type";
    truckTypeValue = '';
    passingWeightValue = 0;
    totalTyresValue = 0;
    truckNumber = 0;
    truckLengthValue = 0;
    price = 0;
    driverIdValue = '';
    unitValue = "";
    resetUnitValue();
    notifyListeners();
  }

  void resetPostLoadScreenOne() {
    clearLoadingPointPostLoad();
    clearUnloadingPointPostLoad();
    clearBookingDate();
    updateResetActive(false);
    notifyListeners();
  }
  void resetPostLoadScreenMultiple(){
    clearLoadingPointPostLoad();
    clearUnloadingPointPostLoad();
    clearLoadingPointPostLoad2();
    clearUnloadingPointPostLoad2();
    updateResetActive(false);
    notifyListeners();
  }

  void resetOnNewType() {
    passingWeightValue = 0;
    totalTyresValue = 0;
    truckLengthValue = 0;
    driverIdValue = '';
    truckNumber = 0;

    notifyListeners();
  }

  void clearProductType() {
    productType = "";
    notifyListeners();
  }

  void clearBookingDate() {
    PostLoadVariablesController postLoadVariables =
        Get.put(PostLoadVariablesController());
    postLoadVariables.updateBookingDate("");
    notifyListeners();
  }

  void clearController() {
    controller = "";
    notifyListeners();
  }

  void resetTruckNumber() {
    truckNumberValue = '';
    notifyListeners();
  }

  void resetTruckNum() {
    truckNumber = 0;
    notifyListeners();
  }

  void updateDriverList(value) {
    driverList = value;
    notifyListeners();
  }

  bool postLoadScreenTwoButton() {
    if (totalTyresValue != 0 &&
        passingWeightValue != 0 &&
        truckTypeValue != '' &&
        productType != "Choose Product Type" &&
        ((PER_TRUCK != PER_TON) && price != 0 ||
            (PER_TRUCK == PER_TON) && price == 0)) {
      return true;
    } else {
      return false;
    }
  }

  void updateBookingDate(value) {
    PostLoadVariablesController postLoadVariables =
        Get.put(PostLoadVariablesController());
    postLoadVariables.updateBookingDate(value);
    notifyListeners();
  }

  bool postLoadScreenOneButton() {
    PostLoadVariablesController postLoadVariables =
        Get.put(PostLoadVariablesController());
    if (loadingPointCityPostLoad != "" &&
        postLoadVariables.bookingDate.value != "" &&
        unloadingPointCityPostLoad != '') {
      return true;
    } else {
      return false;
    }
  }

  void PerTruckTrue(truck, ton) {
    PER_TRUCK = truck;
    PER_TON = ton;

    notifyListeners();
  }

  void PerTonTrue(ton, truck) {
    PER_TON = ton;
    PER_TRUCK = truck;

    notifyListeners();
  }

  void updateCompletedDate(value) {
    completedDate = value;
    notifyListeners();
  }

  void updateOtpValid(value) {
    otpIsValid = value;
    notifyListeners();
  }

  void updatePostLoadError(value) {
    postLoadError = value;
    notifyListeners();
  }

  void updateLoadWidget(value) {
    loadWidget = value;
    notifyListeners();
  }

  bool showDialogPrice() {
    if (((PER_TRUCK != PER_TON) && price != 0 ||
        (PER_TRUCK == PER_TON) && price == 0)) {
      return false;
    } else {
      return true;
    }
  }

  // List truckModels = [];
  // List driverModels = [];
  // // bool updatedOnce = false;
  //
  // void updateTruckDriverModels(newTruckModels , newDriverModels , didUpdateOnce){
  //   truckModels = newTruckModels;
  //   driverModels = newDriverModels;
  //   // updatedOnce = didUpdateOnce;
  //   notifyListeners();
  // }

  bool isAddTruckSrcDropDown = false;

  updateIsAddTruckSrcDropDown(bool value) {
    isAddTruckSrcDropDown = value;
  }

//----------------------------------

  // Language locale Provider

  Locale? _locale;

  Locale? get locale => _locale;

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }

// ------------------------------------------------
  // Language selection provider

  LanguageItem _languageItem = LanguageItem.English;

  LanguageItem get languageItem => _languageItem;

  void setLanguageItem(LanguageItem languageItems) {
    _languageItem = languageItems;
    notifyListeners();
  }

  File? LrPhotoFile;
  String? LrPhoto64;
  File? EwayBillPhotoFile;
  String? EwayBillPhoto64;
  File? WeightReceiptPhotoFile;
  String? WeightReceiptPhoto64;
  File? PodPhotoFile;
  String? PodPhoto64;

  updateLrPhoto(File? newFile) {
    LrPhotoFile = newFile;
    notifyListeners();
  }

  updateLrPhotoStr(String? newStr) {
    LrPhoto64 = newStr;
    notifyListeners();
  }

  updateEwayBillPhoto(File? newFile) {
    EwayBillPhotoFile = newFile;
    notifyListeners();
  }

  updateEwayBillPhotoStr(String? newStr) {
    EwayBillPhoto64 = newStr;
    notifyListeners();
  }

  updateWeightReceiptPhoto(File? newFile) {
    WeightReceiptPhotoFile = newFile;
    notifyListeners();
  }

  updateWeightReceiptPhotoStr(String? newStr) {
    WeightReceiptPhoto64 = newStr;
    notifyListeners();
  }

  updatePodPhoto(File? newFile) {
    PodPhotoFile = newFile;
    notifyListeners();
  }

  updatePodPhotoStr(String? newStr) {
    PodPhoto64 = newStr;
    notifyListeners();
  }

  // for Google SignIn
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount? get user => _user!;

  Future googleLogin() async{
    try {
      print("googleLogin called");
      final googleUser = await googleSignIn.signIn();

      if(googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      notifyListeners();
    } catch (e){
      print(e);
    }
  }
}
