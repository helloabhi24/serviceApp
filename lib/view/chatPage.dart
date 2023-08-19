import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service/constant/constant.dart';
import 'package:service/utils/customText.dart';
import 'package:service/view/imagePage.dart';
import '../constant/sizeHelper.dart';
import '../controllers.dart/homepageController.dart';
import '../main.dart';
import '../model/chatRoommodel.dart';
import '../model/messageModel.dart';

class ChatsWithPerson extends GetView<HomepageController> {
  final int? index;
  final List? chatProduct;
  final ChatRoomModel? chatRoomModel;
  final String? userUid;
  const ChatsWithPerson(
      {this.userUid,
      this.chatRoomModel,
      this.index,
      this.chatProduct,
      super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: KColors.grey.withOpacity(0.2),
        toolbarHeight: Get.height * 0.09,
        leadingWidth: Get.width * 0.29,
        leading: Row(
          children: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: KColors.persistentBlack,
                )),
            GestureDetector(
              onTap: () {
                Get.to(ImagePage());
              },
              child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1.5,
                      color: KColors.red,
                    ),
                  ),
                  child: Container(
                    height: Get.height * 0.12,
                    width: Get.width * 0.13,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: KColors.green,
                      ),
                      shape: BoxShape.circle,
                      color: KColors.white,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: KColors.persistentBlack,
                    ),
                    // child: Container(
                    //   height: Get.height * 0.22,
                    //   width: Get.width * 0.22,
                    // ),
                  )),
            ),
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              color: KColors.persistentBlack,
              text: controller.localStorageController.userName.value,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
            const AppText(
              color: KColors.grey,
              text: "WHOLESALER",
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getHorizontalSize(10)),
              child: SizedBox(
                height: Get.height * 0.75,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("ChatRoom")
                        .orderBy("createdOn", descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.hasData) {
                          QuerySnapshot dataSnapshot =
                              snapshot.data as QuerySnapshot;
                          return SizedBox(
                            height: Get.height,
                            child: ListView.builder(
                              shrinkWrap: true,
                              reverse: true,
                              itemBuilder: (context, index) {
                                Timestamp myDateTime = dataSnapshot.docs[index]
                                    ["createdOn"] as Timestamp;
                                DateTime date = myDateTime.toDate();
                                return Align(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          dataSnapshot.docs[index]["sender"] ==
                                                  controller
                                                      .localStorageController
                                                      .userName
                                                      .value
                                              ? CrossAxisAlignment.end
                                              : CrossAxisAlignment.start,
                                      children: [
                                        dataSnapshot.docs[index]["msg"] == ""
                                            ? GestureDetector(
                                                onTap: () {
                                                  print("This is url of image");
                                                  print(dataSnapshot.docs[index]
                                                      ["image"]);
                                                  showAnimatedDialog(
                                                    context: context,
                                                    barrierDismissible: true,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Center(
                                                        child:
                                                            CachedNetworkImage(
                                                          // height: Get.height * 0.40,
                                                          // width: Get.width * 0.50,
                                                          imageUrl: dataSnapshot
                                                                  .docs[index]
                                                              ["image"],
                                                          fit: BoxFit.cover,
                                                        ),
                                                      );
                                                    },
                                                    animationType:
                                                        DialogTransitionType
                                                            .size,
                                                    curve: Curves.fastOutSlowIn,
                                                    duration: const Duration(
                                                        seconds: 1),
                                                  );
                                                },
                                                child: Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                    image: MemoryImage(
                                                        base64Decode(
                                                            dataSnapshot
                                                                    .docs[index]
                                                                ["image"])),
                                                  )),
                                                ),
                                              )
                                            : Chip(
                                                label: Text(dataSnapshot
                                                    .docs[index]["msg"])),
                                        Row(
                                          mainAxisAlignment: dataSnapshot
                                                      .docs[index]["sender"] ==
                                                  controller
                                                      .localStorageController
                                                      .userName
                                                      .value
                                              ? MainAxisAlignment.end
                                              : MainAxisAlignment.start,
                                          children: [
                                            AppText(
                                              text:
                                                  "${date.year}-${date.month}-${date.day}  ${date.hour}:${date.minute}:${date.second} ",
                                              fontSize: 9,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            AppText(
                                              text: dataSnapshot.docs[index]
                                                          ["sender"] ==
                                                      controller
                                                          .localStorageController
                                                          .userName
                                                          .value
                                                  ? "You"
                                                  : dataSnapshot.docs[index]
                                                      ["sender"],
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w700,
                                              color: KColors.orange,
                                            ),
                                          ],
                                        )
                                      ],
                                    ));
                              },
                              itemCount: dataSnapshot.docs.length,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return const Center(child: Text("an error occured"));
                        } else {
                          return const Center(child: Text("Say hii"));
                        }
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    maxLines: null,
                    controller: controller.chatController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: getVerticalSize(20)),
                      prefixIcon: IconButton(
                          onPressed: () {
                            controller.getImage(ImageSource.gallery);
                          },
                          icon: const Icon(
                            Icons.image,
                            color: KColors.blue,
                          )),
                      hintText: "Message ",
                      hintStyle:
                          const TextStyle(color: KColors.yellow, fontSize: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CircleAvatar(
                    backgroundColor: controller.chatController.text.isEmpty
                        ? KColors.grey
                        : KColors.persistentBlack,
                    minRadius: 20,
                    child: IconButton(
                        onPressed: () {
                          controller.sendMessage("allchats");
                          String msg = controller.chatController.text.trim();
                          controller.chatController.clear();
                          if (msg != "") {
                            MessageModel newMessage = MessageModel(
                                messageid: uuid.v1(),
                                sender: FirebaseAuth.instance.currentUser!.uid,
                                createdOn: DateTime.now(),
                                text: msg,
                                seen: false);
                            FirebaseFirestore.instance
                                .collection("ChatRoom")
                                .doc(
                                  chatRoomModel!.chatroomId!,
                                )
                                .collection("message")
                                .doc(newMessage.messageid)
                                .set(newMessage.toMap());
                          }
                        },
                        icon: const Icon(
                          Icons.send,
                          color: KColors.white,
                        )),
                  ),
                )
              ],
            ),
            height10,
          ],
        ),
      ),
    ));
  }
}
