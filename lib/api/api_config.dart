bool isProduction = false;

class ApiConfig {
  static const String betaUserNumber = "7405579403";

  static String baseUrl = isProduction ? productionUrl : stagingUrl;
  static const String productionUrl = "https://pravesh-backend.onrender.com/api/v1";
  static const String stagingUrl = "https://pravesh-backend.onrender.com/api/v1";

  static  String authLogin = "$baseUrl/auth/login";
  static String getTicketDetails = "$baseUrl/ticket/";
  static String approveTicket = "$baseUrl/ticket/update-status/";


  static const String methodPOST = "post";
  static const String methodPATCH = "patch";
  static const String methodGET = "get";
  static const String methodPUT = "put";
  static const String methodDELETE = "delete";

  static const String error = "Alert!";
  static const String success = "Success";
  static const String warning = "Warning";
  static const String api = "/api/";


}


