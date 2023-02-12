import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_notebook_background/responsive_notebook_background.dart';
import 'package:taskmaster/constants/colors.dart';
import 'package:taskmaster/controllers/controller.dart';

ControllerX cx = Get.put(ControllerX());
ColorsConst cc = ColorsConst();

class Editor extends StatefulWidget {
  const Editor({Key? key}) : super(key: key);

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  @override
  void initState() {
    _bod.text = cx.body.toString();
    _hed.text = cx.head.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget themesdata(int index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
            onTap: () {
              cx.background = index.obs;
              setState(() {});
            },
            child: Image.asset("assets/back" + index.toString() + ".jpg")),
      );
    }

    Widget bottomsheets() {
      return Container(
        height: 200,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  themesdata(1),
                  themesdata(2),
                  themesdata(3),
                  themesdata(4),
                  themesdata(5),
                  themesdata(6),
                ],
              ),
            )
          ],
        ),
      );
    }

    return SafeArea(
      child: Obx(() => Container(
            height: 150,
            width: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assets/back" + cx.background.toString() + ".jpg"),
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fitHeight),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBar(
                      elevation: 0,
                      actions: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: () {
                                showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return bottomsheets();
                                    });
                              },
                              child: Image.asset("assets/theme.png")),
                        ),
                        cx.edit == false.obs
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        cx.edit = true.obs;
                                      });
                                    },
                                    child: Image.asset("assets/edit.png")),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                    onTap: () {
                                      if (cx.news == true) {
                                        setState(() {
                                          if (_hed.text.isNotEmpty &&
                                              _bod.text.isNotEmpty) {
                                            cx.addData(
                                                _hed.text, _bod.text, []);
                                          } else if (_hed.text.isEmpty &&
                                              _bod.text.isNotEmpty) {
                                            cx.addData(
                                                _hed.text, _bod.text, []);
                                          } else if (_hed.text.isNotEmpty &&
                                              _bod.text.isEmpty) {
                                            cx.addData(
                                                _hed.text, _bod.text, []);
                                          } else {}
                                          cx.update();
                                          cx.edit = false.obs;
                                        });
                                      } else {
                                        cx.data[cx.idp]["label"] =
                                            _hed.text.obs;
                                        cx.data[cx.idp]["notes"] = _bod.text;
                                        cx.data[cx.idp]["background"] =
                                            cx.background.toInt();

                                        cx.storedata[cx.idp]["label"] =
                                            _hed.text;
                                        cx.storedata[cx.idp]["notes"] =
                                            _bod.text;
                                        cx.storedata[cx.idp]["background"] =
                                            cx.background.toInt();
                                        cx.savedata();
                                        cx.update();
                                      }
                                    },
                                    child: Image.asset("assets/save.png")),
                              )
                      ],
                      backgroundColor: Colors.transparent,
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Hero(
                      tag: "label",
                      child: TextField(
                        maxLines: 2,
                        controller: _hed,
                        readOnly: !cx.edit.value,
                        decoration: const InputDecoration(
                          hintText: "Title here",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        primary: false,
                        child: TextField(
                          showCursor: true,
                          enabled: true,
                          scribbleEnabled: true,
                          decoration: const InputDecoration(
                            hintText: "Start typing",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          ),
                          //expands: true,
                          readOnly: !cx.edit.value,
                          maxLines: 1000,
                          minLines: 1,

                          controller: _bod,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

TextEditingController _hed = TextEditingController();
TextEditingController _bod = TextEditingController();
