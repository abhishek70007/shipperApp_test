import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

//TODO: This is used to create the company database in firebase realtime database
class CreateCompanyDatabase {
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  //TODO: This function checks whether the company is already exists inn firebase database
  Future<bool> checkCompanyExistence(DatabaseReference databaseReference) async{
    final snapshot = await databaseReference.get();
    return snapshot.value == null;
  }

  //TODO: If the company doesn't exist in firebase database, we are adding that company to database with the owner uid and owner shipperId
  // We are considering the user who creates the branch for his company in database as owner of that company,
  // So we are adding him as owner and his shipper Id as company's shipper Id.
  createCompanyDatabase(String companyName, String ownerShipperId) async{
    final newCompanyRef = ref.child("companies/${companyName.capitalizeFirst}");
    final uid = FirebaseAuth.instance.currentUser!.uid;
    if(await checkCompanyExistence(ref.child("companies/${companyName.capitalizeFirst}"))) {
      newCompanyRef.set({
          "data": {
            "sid": ownerShipperId
          },
          "members": {
            uid: "owner"
          }
      });
    }
  }
}