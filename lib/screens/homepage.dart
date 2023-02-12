import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmaster/constants/colors.dart';
import 'package:taskmaster/controllers/controller.dart';
import 'package:taskmaster/screens/editor.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    cx.update();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cx.body = "".obs;
          cx.background = 1.obs;
          cx.head = "".obs;
          cx.idp = 0;
          cx.news = true.obs;
          cx.edit = true.obs;
          Get.to(() => const Editor());
        },
        child: const Icon(Icons.add),
      ),
      backgroundColor: cc.primary,
      body: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: cc.primary,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/settings.png",
                  height: 30,
                  width: 30,
                ),
              ),
            ],
          ),
          cx.data.length > 0
              ? Obx(() => Expanded(
                      child: SingleChildScrollView(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        shrinkWrap: true,
                        primary: false,
                        itemCount: cx.data.length,
                        itemBuilder: (context, index) {
                          return dataHolder(index);
                        }),
                  )))
              : Text(cx.storedata.toString()),
          // Text("//"),
          // Text(cx.data.toString())
        ],
      ),
    );
  }

  Widget dataHolder(int index) {
    return GestureDetector(
      onTap: () {
        cx.idp = index;
        cx.news = false.obs;
        cx.edit = false.obs;
        cx.background = int.parse(cx.data[index]["background"].toString()).obs;
        cx.head = cx.data[index]["label"].toString().obs;
        cx.body = cx.data[index]["notes"].toString().obs;
        Get.to(() => const Editor());
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/back" +
                    cx.data[index]["background"].toString() +
                    ".jpg"),
                fit: BoxFit.fitWidth),
            border: Border.all(color: cc.darkpurple),
            //color: cc.navy,
            borderRadius: BorderRadius.circular(21)),
        child: Column(
          children: [
            Text(
              "${cx.data[index]["label"]}",
              maxLines: 1,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            Text(
              cx.data[index]["notes"],
              style: const TextStyle(fontSize: 18),
              maxLines: 4,
            ),
          ],
        ),
      ),
    );
  }
}

ColorsConst cc = ColorsConst();
ControllerX cx = Get.put(ControllerX());
