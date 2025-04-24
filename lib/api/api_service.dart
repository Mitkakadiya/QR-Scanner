import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as get_x;
import '../commonWidgets/custom_text.dart';
import '../utility/colors.dart';
import '../utility/text_style.dart';
import 'api_config.dart';
import 'api_utility.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

Future<void> apiServiceCall(
    {required Map<String, dynamic> params,
    required String serviceUrl,
    required Function success,
    required Function error,
    required get_x.RxBool isStopAction,
    required get_x.RxBool isLoading,
    required String methodType,
    required bool isQueryParam,
    bool isFromLogout = false,
    FormData? formValues}) async {
  Map<String, dynamic>? tempParams = params;
  String? tempServiceUrl = serviceUrl;
  Function? tempSuccess = success;
  String? tempMethodType = methodType;
  Function? tempError = error;
  bool? tempIsFromLogout = isFromLogout;
  bool? tempIsQueryParam = isQueryParam;
  FormData? tempFormData = formValues;
  if (await checkInternet()) {
    isLoading.value = true;
    if (isStopAction.value == true) {
      showProgressLoader();
    }
    if (tempFormData != null) {
      Map<String, dynamic> tempMap = <String, dynamic>{};
      for (var element in tempFormData.fields) {
        tempMap[element.key] = element.value;
      }
      FormData reGenerateFormData = FormData.fromMap(tempMap);
      for (var element in tempFormData.files) {
        reGenerateFormData.files.add(MapEntry(element.key, element.value));
      }
      tempFormData = reGenerateFormData;
    }
    Map<String, String> headerParameters;
    headerParameters = {};
    // if (getPreference.read('token') == null) {
    //   headerParameters = {'Accept': 'application/json'};
    // } else {
    //   headerParameters = {'Accept': 'application/json', 'Authorization': 'Bearer ${getPreference.read('token')}'};
    // }

    try {
      Response response;
      if (tempMethodType == ApiConfig.methodGET) {
        response = await APIProvider.getDio().get(tempServiceUrl, queryParameters: trimJsonValues(tempParams), options: Options(headers: headerParameters, responseType: ResponseType.plain));
      } else if (tempMethodType == ApiConfig.methodPUT) {
        if (tempIsQueryParam) {
          response = await APIProvider.getDio().put(tempServiceUrl, queryParameters: trimJsonValues(tempParams), options: Options(headers: headerParameters, responseType: ResponseType.plain));
        } else {
          response = await APIProvider.getDio().put(tempServiceUrl, data: tempFormData ?? trimJsonValues(tempParams), options: Options(headers: headerParameters, responseType: ResponseType.plain));
        }
      } else if (tempMethodType == ApiConfig.methodDELETE) {
        if (tempIsQueryParam) {
          response = await APIProvider.getDio().delete(tempServiceUrl, queryParameters: trimJsonValues(tempParams), options: Options(headers: headerParameters, responseType: ResponseType.plain));
        } else {
          response = await APIProvider.getDio().delete(tempServiceUrl, data: trimJsonValues(tempParams), options: Options(headers: headerParameters, responseType: ResponseType.plain));
        }
      } else if (tempMethodType == ApiConfig.methodPATCH) {
        if (tempIsQueryParam) {
          response = await APIProvider.getDio().patch(tempServiceUrl, queryParameters: trimJsonValues(tempParams), options: Options(headers: headerParameters, responseType: ResponseType.plain));
        } else {
          response = await APIProvider.getDio().patch(tempServiceUrl, data: tempFormData ?? trimJsonValues(tempParams), options: Options(headers: headerParameters, responseType: ResponseType.plain));
        }
      } else {
        if (tempIsQueryParam) {
          response = await APIProvider.getDio().post(tempServiceUrl, queryParameters: trimJsonValues(tempParams), options: Options(headers: headerParameters, responseType: ResponseType.plain));
        } else {
          response = await APIProvider.getDio().post(tempServiceUrl, data: tempFormData ?? trimJsonValues(tempParams), options: Options(headers: headerParameters, responseType: ResponseType.plain));
        }
      }

      if (handleResponse(response)) {
        if (isStopAction.value == true) {
          Navigator.of(get_x.Get.overlayContext!).pop();
        }
        isLoading.value = false;
        if (kDebugMode) {
          print("---------------------------------------------");
          // print(getPreference.read('token'));
          print(tempServiceUrl);
          print(trimJsonValues(tempParams));
          print(response.data);
          print(response.statusCode);
          print("---------------------------------------------");
        }

        if (response.statusCode == 200) {
          tempSuccess(response);
        } else if (response.statusCode == 201) {
          tempSuccess(response);
        } else if (response.statusCode == 401) {
        } else {
          if (response != null && response.data != null) {
            try {
              var jsonResponse = jsonDecode(response.data);
              tempError(response);
            } catch (e) {
              final response = Response(
                data: {"error": "something went wrong"},
                statusCode: 400,
                requestOptions: RequestOptions(path: tempServiceUrl),
              );
              tempError(response);
              showSnackBar(title: ApiConfig.error, message: "Something went wrong");
            }
          } else {
            showSnackBar(
              title: ApiConfig.error,
              message: "Something went wrong",
            );
          }
        }
      } else {
        if (isStopAction.value == true) {
          Navigator.of(get_x.Get.overlayContext!).pop();
        }
        isLoading.value = false;
        get_x.Get.showSnackbar(get_x.GetSnackBar(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          backgroundColor: colorFFFFFF,
          message: "Something went wrong",
          borderRadius: 4,
          icon: const Icon(Icons.info_outline, color: colorFFFFFF),
          duration: const Duration(seconds: 3),
        ));
        tempError(response);
      }
    } catch (e) {
      print(e);
      showSnackBar(
        title: ApiConfig.error,
        message: "Something went wrong",
      );
      if (isStopAction.value == true) {
        Navigator.of(get_x.Get.overlayContext!).pop();
      }
      isLoading.value = false;
    }
  } else {
    if (isStopAction.value == true) {
      Navigator.of(get_x.Get.overlayContext!).pop();
    }
    isLoading.value = false;
    showSnackBar(title: ApiConfig.error, message: "Make sure wifi or cellular data is turned on and then try again.");
  }
}

get_x.RxBool isOnline = true.obs;

Future<bool> checkInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    isOnline.value = true;
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    isOnline.value = true;
    return true;
  }
  isOnline.value = false;
  return false;
}

isNotEmptyString(String? string) {
  return string != null && string.isNotEmpty;
}

bool handleResponse(Response response) {
  try {
    if (isNotEmptyString(response.toString())) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

showProgressLoader() {
  get_x.Get.dialog(
    WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: StatefulBuilder(builder: (context, setState) {
        return SizedBox(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height);
      }),
    ),
    barrierDismissible: false,
    barrierColor: Colors.transparent,
  );
}

Map<String, dynamic> trimJsonValues(Map<String, dynamic> json) {
  json.forEach((key, value) {
    if (value is String) {
      json[key] = value.trim(); // Trim string values
    } else if (value is Map) {
      json[key] = trimJsonValues(value.cast<String, dynamic>()); // Recursively trim nested JSON objects
    } else if (value is List) {
      json[key] = value.map((item) {
        if (item is String) {
          return item.trim();
        } else if (item is Map) {
          return trimJsonValues(item.cast<String, dynamic>());
        }
        return item;
      }).toList(); // Recursively trim lists
    }
  });
  return json;
}

showSnackBar({required String title, required String message}) {
  if (!get_x.Get.isSnackbarOpen) {
    return get_x.Get.snackbar(title, message,
        backgroundColor: Colors.transparent,
        onTap: (_) {},
        shouldIconPulse: true,
        barBlur: 0,
        isDismissible: true,
        userInputForm: Form(
            child: Wrap(
          children: [
            Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: title == ApiConfig.success ? color4AA900 : colorB3261E,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: <BoxShadow>[BoxShadow(color: Colors.black12.withOpacity(0.15), blurRadius: 20)]),
                child: Wrap(children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    width: double.infinity,
                    decoration: BoxDecoration(color: colorFFFFFF, borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //  Image.asset(title == ApiConfig.success ? 'assets/icon/success.png' : 'assets/icon/error.png', scale: 4),
                            const SizedBox(width: 5),
                            CustomText(txtTitle: title, style: title == ApiConfig.success ? color4AA900w60016 : colorB3261Ew60016)
                          ],
                        ),
                        const SizedBox(height: 15),
                        CustomText(txtTitle: message, style: color4AA900w50014.copyWith(color: title == ApiConfig.success ? color4AA900 : colorB3261E), textOverflow: TextOverflow.visible)
                      ],
                    ),
                  )
                ]))
          ],
        )),
        borderRadius: 0,
        padding: EdgeInsets.zero,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        //boxShadows: <BoxShadow>[BoxShadow(color: Colors.black12.withOpacity(0.15), blurRadius: 16)],
        duration: const Duration(seconds: 2));
  }
}
