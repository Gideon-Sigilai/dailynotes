import 'package:get_storage/get_storage.dart';
import 'package:taskmaster/logics/storage.dart';

import 'package:get/get.dart';

class ControllerX extends GetxController {
  @override
  void onInit() async {
    await GetStorage.init();
    if (gs.read("data") != null) {
      storedata = await gs.read("data");
      dataInit();
    } else {
      data = [].obs;
    }

    super.onInit();
  }

  var news = false.obs;
  int idp = 0;

  List data = [].obs;

  void dataInit() {
    for (int i = 0; i < storedata.length; i++) {
      Map<String, dynamic> _tempstore = {
        "label": storedata[i]["label"].toString().obs,
        "notes": storedata[i]["notes"],
        "attachments": storedata[i]["attachments"],
        "background": storedata[i]["background"],
        "id": storedata[i]["id"],
      };
      data.add(_tempstore);
    }
  }

  List storedata = [];

  void addData(String label, String notes, List attachments) async {
    Map<String, dynamic> _temp = {
      "label": label,
      "notes": notes,
      "attachments": attachments,
      "background": background.toInt(),
      "id": data.length,
    };
    Map<String, dynamic> _tempstore = {
      "label": label.obs,
      "notes": notes,
      "attachments": attachments,
      "background": background.toInt(),
      "id": data.length,
    };
    storedata.add(_temp);
    data.add(_tempstore);
    savedata();
  }

  void savedata() async {
    await gs.write("data", storedata);
  }

  GetStorage gs = GetStorage();

  var edit = false.obs;
  var background = 1.obs;
  var body = "".obs;
  var head = "".obs;
}

Storage st = Get.put(Storage());
