import '../shipperApis/isolatedShipperGetData.dart';
import '/functions/traccarCalls/createNotificationTraccar.dart';
import '/functions/traccarCalls/createUserTraccar.dart';
import '/functions/traccarCalls/linkNotificationAndUserTraccar.dart';

void createTraccarUserAndNotifications(String? token, String? mobileNum) async {
  String? traccarId = sidstorage.read("traccarUserId");
  if (traccarId == null) {
    String? userId = await createUserTraccar(token, mobileNum);
    // if (userId != null) {
    //   List<String?>? id = await createNotificationTraccar();
    //   if (id != []) {
    //     linkNotificationAndUserTraccar(userId, id);
    //   }
    // }
  } else {
    //do nothing
  }
}
