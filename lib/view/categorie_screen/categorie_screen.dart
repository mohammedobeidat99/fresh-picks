import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fresh_picks/consts/list.dart';
import 'package:fresh_picks/services/data.dart';
import 'package:fresh_picks/view/categorie_screen/smart_screen.dart';
import 'package:fresh_picks/widgets/bg_widget.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';
import '../../models/category.dart';
import 'categorie_details.dart';

class CategorieScreen extends StatefulWidget {
  const CategorieScreen({Key? key}) : super(key: key);

  @override
  _CategorieScreenState createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // Show the notification after the first frame is built
      showNotification();
    });
  }

  void showNotification() {
    Fluttertoast.showToast(
      msg: 'Tap on the smart button icon on the top right corner for smart features!',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: mainColor,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Store Snapshop",
            style: TextStyle(color: mainColor),
          ),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                // Handle the smart button action
                Get.to(() => SmartPage());
              },
              icon: Icon(Icons.auto_fix_high ,color: mainColor,),
            ),
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: ListView(children: [
          SafeArea(
            child: Column(
              children: [
                40.heightBox,
                VxSwiper.builder(
                  aspectRatio: 16 / 9,
                  height: 150,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  itemCount: SlidersList.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      SlidersList[index],
                      fit: BoxFit.fill,
                    )
                        .box
                        .rounded
                        .clip(Clip.antiAlias)
                        .margin(const EdgeInsets.symmetric(horizontal: 2))
                        .make();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: GridView.builder(
                      itemCount: categories.length,
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 30,
                        crossAxisSpacing: 15,
                        mainAxisExtent: 200,
                      ),
                      itemBuilder: (context, index) {
                        Category category = categories[index];

                        return Column(
                          children: [
                            Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    category.image!,
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.6)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      category.name.tr,
                                      style: TextStyle(
                                        fontFamily: semibold,
                                        color: whiteColor,
                                        fontSize: 24,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                            .box
                            .white
                            .rounded
                            .clip(Clip.antiAlias)
                            .outerShadow
                            .make()
                            .onTap(() {
                          Get.to(() => CategoryDetails(category));
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
