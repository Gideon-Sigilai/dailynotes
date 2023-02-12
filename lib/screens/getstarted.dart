import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmaster/screens/homepage.dart';

import '../constants/colors.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/freshback.jpg"),filterQuality: FilterQuality.high,fit: BoxFit.fitHeight,),
          ),
          child: Scaffold(

            backgroundColor: Colors.transparent,
            body: Column(
              children:  [
                const SizedBox(height: 60,),
                const Text("Manage Your  \ndaily Notes",style: TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                const SizedBox(height: 250,),
                Text("Project management with solution providing app",
                  style: TextStyle(
                    color: Colors.white70,
                      fontSize: 25
                  ),
                ),
                const Spacer(),
                InkWell(
                    onTap: (){
                      Get.to(()=> HomePage());
                    },
                    child: neumorh()),
              ],
            ),
          )
      ),
    );
  }
  Widget neumorh(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            color: cc.bestblue,
            borderRadius: BorderRadius.circular(360),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 2,
                  color: cc.navy,
                  offset: Offset(-3, -3)
              ),
              BoxShadow(
                  spreadRadius: 3,
                  blurRadius: 3,
                  color: Colors.black38,
                  offset: Offset(3, 3)
              )
            ]
        ),
        child: Center(child: Text("Get Started",style: TextStyle(
            fontSize: 20,
            color: Colors.white
        ),)),
      ),
    );
  }
}

ColorsConst cc = ColorsConst();