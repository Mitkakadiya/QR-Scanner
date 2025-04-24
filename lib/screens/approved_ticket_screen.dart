import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:qr_scanner/controller/homeController.dart';
import 'package:qr_scanner/screens/home_screen.dart';
import 'package:qr_scanner/utility/common_method.dart';
import 'package:qr_scanner/model/ticket_data_model.dart';
import 'package:qr_scanner/utility/colors.dart';

import '../commonWidgets/common_button.dart';

class ApprovedTicketScreen extends StatelessWidget {
  Barcode? result;

  ApprovedTicketScreen({super.key, this.result});

  RxList<String> selectedTickets = RxList();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
              child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          )),
          centerTitle: true,
          backgroundColor: colorDF1827,
          title: Text(
            "My Tickets",
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: SizedBox(
            width: double.infinity,
            child: HomeController.to.ticketList.isNotEmpty
                ? Column(
                    children: [
                      if(HomeController.to.ticketList.where((element) => element.status == "Active").isNotEmpty) Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Select all").paddingOnly(right: 4),
                      GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              if (isAllSelected()) {
                                selectedTickets.clear();
                              } else {
                                selectedTickets.clear();
                                for (int i = 0; i < HomeController.to.ticketList.length; i++) {
                                  if (HomeController.to.ticketList[i].status == "Active") {
                                    selectedTickets.add(HomeController.to.ticketList[i].id ?? '');
                                  }
                                }
                              }
                              print(selectedTickets);
                            },
                            child: Image.asset(
                              isAllSelected() ? "assets/icon/check_box.png" : "assets/icon/un_check_box.png",
                              scale: 3.5,
                            ),
                          ),
                        ],
                      ).paddingOnly(bottom: 12),
                      ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ticketView(ticketDataModel: HomeController.to.ticketList[index], index: index);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 20,
                            );
                          },
                          itemCount: HomeController.to.ticketList.length),
                    ],
                  )
                : Center(
                  child:  Lottie.asset('assets/icon/no_ticket.json'),
                ),
          ),
        ),
        bottomNavigationBar: bottomButton(context: context),
      ),
    );
  }

  bool isAllSelected() {
    if (HomeController.to.ticketList.where((element) => element.status == "Active").length == selectedTickets.length &&
        HomeController.to.ticketList.isNotEmpty ) {
      return true;
    } else {
      return false;
    }
  }

  ticketListing() {}

  ticketView({required TicketDataModel ticketDataModel, required int index}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (selectedTickets.contains(HomeController.to.ticketList[index].id ?? '')) {
          selectedTickets.remove(HomeController.to.ticketList[index].id ?? '');
        } else {
          selectedTickets.add(HomeController.to.ticketList[index].id ?? '');
        }
        print(selectedTickets);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: ticketDataModel.status == "Active" ? color06B268 : colorF04438,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(ticketDataModel.type ?? "").paddingOnly(right: 12),
                      Container(
                          decoration: BoxDecoration(color: ticketDataModel.status == "Active" ? color06B268 : colorF04438, borderRadius: BorderRadius.circular(4)),
                          child: Text(
                            ticketDataModel.status == "Active" ? "Active" : "DeActive",
                            style: TextStyle(color: Colors.white, fontSize: 8),
                          ).paddingSymmetric(horizontal: 4, vertical: 2)),
                    ],
                  ).paddingOnly(bottom: 4),
                  Text(extractDateOnly(ticketDataModel.date.toString()))
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            ticketDataModel.status == "Active"
                ? Image.asset(
                    selectedTickets.contains(HomeController.to.ticketList[index].id ?? '') ? "assets/icon/check_box.png" : "assets/icon/un_check_box.png",
                    scale: 3.5,
                  )
                : SizedBox()
          ],
        ).paddingAll(15),
      ),
    );
  }

  Widget bottomButton({required BuildContext context}) {
    return Obx(
      () => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: CommonButton(
            isEnable: selectedTickets.isNotEmpty,
            isLoading: HomeController.to.ticketLoader.value,
            onPressed: () async {
              HomeController.to.approveTicket({"status": "Used", "ticketIds": selectedTickets}, callBack: () {
                showActionableDialog(context: context, title: "Success", message: "Your Ticket has been approved successfully");
              });
            },
            title: 'Approved',
          ),
        ),
      ),
    );
  }

  showActionableDialog({
    required BuildContext context,
    required String title,
    required String message,
    void Function()? onCancel,
    void Function()? onSuccess,
    void Function()? afterCloseDialog,
    String? primaryButtonTitle,
    String? secondaryButtonTitle,
    RxBool? loading,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(color: colorFFFFFF, borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Material(
              color: colorFFFFFF,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: color1E2124,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    message,
                    style: TextStyle(
                      color: color1E2124,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        decoration: BoxDecoration(color: colorDF1827, borderRadius: BorderRadius.circular(4)),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Get.offAll(() => HomeScreen());
                          },
                          child: Text(
                            "Scan Again",
                            style: TextStyle(color: Colors.white),
                          ).paddingSymmetric(vertical: 4, horizontal: 8),
                        )),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
