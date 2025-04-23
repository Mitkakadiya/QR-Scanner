import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:qr_scanner/main.dart';
import 'package:qr_scanner/model/error_data_model.dart';
import 'package:qr_scanner/model/ticket_data_model.dart';
import '../model/approve_ticket_data_model.dart';
import '../model/login_data_model.dart';
import '../api/api_config.dart';
import '../api/api_service.dart';
import 'package:dio/dio.dart' as dio;

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  RxBool loginLoader = false.obs;
  Rx<LoginDataModel> loginDataModel = LoginDataModel().obs;

  Future<void> loginUser(Map<String, dynamic> params, {Function? callBack}) async {
    await apiServiceCall(
      params: params,
      serviceUrl: ApiConfig.authLogin,
      success: (dio.Response<dynamic> response) {
          loginDataModel.value = LoginDataModel.fromJson(jsonDecode(response.data));
          setObject("loginModel", loginDataModel.value);
        if (callBack != null) {
          callBack();
        }
      },
      error: (dio.Response<dynamic> response) {
        ErrorDataModel errorData =  ErrorDataModel.fromJson(jsonDecode(response.data));
        print(errorData.errors?[0].msg);
        showSnackBar(title: ApiConfig.error, message: errorData.errors?[0].msg ?? "Something went wrong");
      },
      isStopAction: true.obs,
      isLoading: loginLoader,
      methodType: ApiConfig.methodPOST,
      isQueryParam: false,
    );
  }

  RxBool qrLoader = false.obs;
  RxList<TicketDataModel> ticketList = RxList();
  Rx<TicketDataModel> dataFromQr = TicketDataModel().obs;
  // LoginDataModel storedLoginDataModel = LoginDataModel.fromJson(getObject("loginModel") ?? {});

  Future<void> getDetailsFromQr(Map<String, dynamic> params, {Function? callBack , required String phone}) async{
    await apiServiceCall(
        params: params,
        serviceUrl: "${ApiConfig.getTicketDetails}$phone",
        success: (dio.Response<dynamic> response) {
          print(response.data);
          List data = jsonDecode(response.data) ?? [];
          ticketList.value = data.map((e) => TicketDataModel.fromJson(e)).toList();

            // dataFromQr.value = TicketDataModel.fromJson(jsonDecode(response.data));

          if (callBack != null) {
            callBack();
          }
        },
        error: (dio.Response<dynamic> response) {},
        isStopAction: true.obs,
        isLoading: qrLoader,
        methodType: ApiConfig.methodGET,
        isQueryParam: true);
  }

  RxBool ticketLoader = false.obs;
  Rx<ApproveTicketDataModel> ticketApprove = ApproveTicketDataModel().obs;

  Future<void> approveTicket(Map<String, dynamic> params, {Function? callBack}) async {
    await apiServiceCall(
      params:params,
      serviceUrl: ApiConfig.approveTicket,
      success: (dio.Response<dynamic> response) {
        ticketApprove.value = ApproveTicketDataModel.fromJson(jsonDecode(response.data));
         if (callBack != null) {
          callBack();
        }
      },
      error: (dio.Response<dynamic> response) {
        ErrorDataModel errorData = ErrorDataModel.fromJson(jsonDecode(response.data));
         showSnackBar(title: ApiConfig.error, message: errorData.errors?[0].msg ?? "Something went wrong");
      },
      isStopAction: true.obs,
      isLoading: ticketLoader,
      methodType: ApiConfig.methodPATCH,
      isQueryParam: false,
    );
  }
final String pravesh = 'ravesh';
  final RxList<bool> isVisible = List.generate(6, (_) => false).obs;


  Timer? _animationTimer;

  @override
  void onInit() {
    super.onInit();
    _startLoopAnimation();
  }

  void _startLoopAnimation() {
    _animationTimer = Timer.periodic(const Duration(milliseconds: 1500), (timer) async {
      for (int i = 0; i < isVisible.length; i++) {
        isVisible[i] = true;
        await Future.delayed(const Duration(milliseconds: 150));
      }
      await Future.delayed(const Duration(milliseconds: 500));
      for (int i = 0; i < isVisible.length; i++) {
        isVisible[i] = false;
      }
    });
  }

  @override
  void onClose() {
    _animationTimer?.cancel();
    super.onClose();
  }

}

getObject(String key) {
  return getPreference.read(key) != null ? json.decode(getPreference.read(key)) : null;
}

setObject(String key, value) {
  getPreference.write(key, json.encode(value));
}
