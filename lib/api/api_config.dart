bool isProduction = false;

class ApiConfig {
  static const String betaUserNumber = "7405579403";

  static String baseUrl = isProduction ? productionUrl : stagingUrl;
  static const String productionUrl = "https://fpliydit3h.execute-api.us-east-2.amazonaws.com";
  static const String stagingUrl = "https://swift-exact-gobbler.ngrok-free.app";

  static String webHostingURL = isProduction ? productionWeblink : stagingWeblink;
   static const String productionWeblink = "https://superadmin.mytruckboss.com";
   static const String stagingWeblink = "https://dev-superadmin.mytruckboss.com";
   // static const String stagingWeblink = "https://feat-development.d1fj7jpy186xfj.amplifyapp.com";

  static String stripeBaseUrl = isProduction ? productionStripe : stagingStripe;
  static const String productionStripe = "https://jwlzrjuyg4.execute-api.us-east-2.amazonaws.com/";
  static const String stagingStripe = "https://vrb648gebb.execute-api.us-east-2.amazonaws.com/";
  static String stripeUrl = "${stripeBaseUrl}stripe/webhook";

  static String getPdfLink = "$baseUrl/pdf/genrate-link";
  static const String callPDF = "https://pdf.mytruckboss.com/pdf";


  static String requestPDFUrl = isProduction ? productionPDFUrl : stagingPDFUrl;
  static const String productionPDFUrl = "main.dsp3mow78vw3p.amplifyapp.com";
  static const String stagingPDFUrl = "development.dsp3mow78vw3p.amplifyapp.com";

  static const String methodPOST = "post";
  static const String methodPATCH = "patch";
  static const String methodGET = "get";
  static const String methodPUT = "put";
  static const String methodDELETE = "delete";

  static const String error = "Alert!";
  static const String success = "Success";
  static const String warning = "Warning";
  static const String api = "/api/";

  static String getTicketDetails = "$baseUrl";

}


