import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:farmer/import.dart';
import 'package:logger/logger.dart';
import '../model/result.dart';

class DBServices extends GetxService {
  static DBServices get call => Get.find();
  RxBool isLoading = false.obs;
  final dio = Dio(BaseOptions(baseUrl: BASE_URL));

  Future<DBServices> init() async {
    return this;
  }

  @override
  void onInit() {
    super.onInit();
    printInfo(info: "API Service INIT");
    var logger = Logger();
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      isLoading(true);
      if (options.data != null) {
        options.data.removeWhere((k, v) => v == "" || v == null);
      }
      if (kDebugMode) {
        print("==========API Call Start============");
        logger.i(options.uri);
        logger.i(options.data);
        logger.i(await StorageService.to.read("id"));
      }
      if (StorageService.to.has("id")) {
        options.headers['userId'] = await StorageService.to.read("id");
      }
      return handler.next(options);
    }, onResponse: (response, handler) {
      if (kDebugMode) {
        print("==========API Call END============");
        logger.i(response.data.toString());
      }
      isLoading(false);
      return handler.next(response);
    }, onError: (DioError e, handler) {
      isLoading(false);
      return handler.next(e);
    }));
  }

  Future<Result> getOTP(dynamic auth) async {
    final response = await dio.post("auth/getOTP", data: auth);
    return Result.fromJson(response.data);
  }

  Future<Result> validateOTP(dynamic auth) async {
    final response = await dio.post("auth/validateOTP", data: auth);
    return Result.fromJson(response.data);
  }

  Future<Result> login(dynamic auth) async {
    final response = await dio.post("auth/login", data: auth);
    return Result.fromJson(response.data);
  }

  Future<Result> forgotPassword(dynamic auth) async {
    final response = await dio.post("auth/forgot", data: auth);
    return Result.fromJson(response.data);
  }

  Future<Result> checkUser(String mobile) async {
    final data = {"mobile_number": mobile};
    final response = await dio.post("auth/checkuser", data: data);
    return Result.fromJson(response.data);
  }

  Future<Result> addUser(dynamic data) async {
    final response = await dio.post("customer/add", data: data);
    return Result.fromJson(response.data);
  }

  Future<Result> updateProfile(dynamic data) async {
    final response = await dio.post("customer/profile/Update", data: data);
    return Result.fromJson(response.data);
  }

  Future<Result> updateFirebaseToken(String token) async {
    final id = await StorageService.to.read("id");

    final data = {"pk_frm_customer_id": id, "firebase_token": token};
    final response = await dio.post("customer/update/token", data: data);
    return Result.fromJson(response.data);
  }

  Future<Result> updateLanguage(String language) async {
    final id = await StorageService.to.read("id");

    final data = {"pk_frm_customer_id": id, "prefered_language": language};
    final response = await dio.post("customer/update/language", data: data);
    return Result.fromJson(response.data);
  }

  Future<Result> updateDP(dynamic data) async {
    final response = await dio.post("customer/profile/dp", data: data);
    return Result.fromJson(response.data);
  }

  Future<Result> profile() async {
    final response = await dio.get("customer");
    return Result.fromJson(response.data);
  }

  Future<Result> dp(String data) async {
    final response = await dio.get("customer/dp");
    return Result.fromJson(response.data);
  }

  Future<Result> location() async {
    final response = await dio.get("location");
    return Result.fromJson(response.data);
  }

  Future<Result> crops() async {
    final response = await dio.get("crop/list");
    return Result.fromJson(response.data);
  }

  Future<Result> cropDetail(String id) async {
    final response = await dio.get("crop/$id/detail");
    return Result.fromJson(response.data);
  }

  Future<Result> addFavorite(String cropId) async {
    final response = await dio.get("crop/addfavorite/$cropId");
    return Result.fromJson(response.data);
  }

  Future<Result> removeFavorite(String cropId) async {
    final response = await dio.get("crop/deletefavorite/$cropId");
    return Result.fromJson(response.data);
  }

  Future<Result> myFavorite() async {
    final response = await dio.get("crop/favorite");
    return Result.fromJson(response.data);
  }

  Future<Result> diseaseList(String cid) async {
    final response = await dio.get("crop/$cid/disease");
    return Result.fromJson(response.data);
  }

  Future<Result> sendChat(String chat) async {
    final id = await StorageService.to.read("id");
    final data = {
      "sender_id": id,
      "content": chat,
    };
    final response = await dio.post("chat/send", data: data);
    return Result.fromJson(response.data);
  }

  Future<Result> myChat() async {
    final response = await dio.get("chat");
    return Result.fromJson(response.data);
  }

  Future<Result> deleteChat(String id) async {
    final response = await dio.get("chat/$id/delete");
    return Result.fromJson(response.data);
  }

  Future<dynamic> uploadChatImage(String image) async {
    final id = await StorageService.to.read("id");
    var response = await http.post(
      Uri.parse("http://cimapfarmer.bitoapps.in/upload/chat/mobile_upload.php"),
      body: {"image": image, "sender": id},
    );
    return response.body;
  }

  Future<dynamic> weather(String city) async {
    final dd = Dio();
    // final response = await dd.get("http://api.weatherstack.com/current?access_key=$WeatherAPIKey&query=$city");
    final response = await dd.get(
        "https://api.weatherapi.com/v1/current.json?key=$WeatherAPIKey&q=$city&aqi=no");
    return response.data;
  }

  Future<Result> addDistillation(dynamic data) async {
    final response = await dio.post("distillation/add", data: data);
    return Result.fromJson(response.data);
  }

  Future<Result> distillationUnits() async {
    final response = await dio.get("distillation");
    return Result.fromJson(response.data);
  }

  Future<Result> faq(String cid) async {
    final response = await dio.get("faq/$cid");
    return Result.fromJson(response.data);
  }

  Future<Result> advertisement() async {
    final response = await dio.get("advertisement");
    return Result.fromJson(response.data);
  }

  Future<Result> process(processType) async {
    final response = await dio.get("process/list/$processType");
    return Result.fromJson(response.data);
  }

  Future<Result> processDetail(String id) async {
    final response = await dio.get("process/detail/$id");
    return Result.fromJson(response.data);
  }

  Future<Result> addRequirement(dynamic data) async {
    final response = await dio.post("marketplace/addrequirement", data: data);
    return Result.fromJson(response.data);
  }

  Future<Result> saleProduct(dynamic data) async {
    final response = await dio.post("marketplace/saleproduct", data: data);
    return Result.fromJson(response.data);
  }

  Future<Result> getMyItems() async {
    final response = await dio.get("marketplace/my");
    return Result.fromJson(response.data);
  }

  Future<Result> deleteMarketItem(data) async {
    final response = await dio.post("marketplace/delete", data: data);
    return Result.fromJson(response.data);
  }

  Future<Result> getMarketDemand() async {
    final response = await dio.get("marketplace/getdemand");
    return Result.fromJson(response.data);
  }

  Future<Result> getMarketDemandByCrop(String? id) async {
    final response = await dio.get("marketplace/getdemand/$id");
    return Result.fromJson(response.data);
  }

  Future<Result> getMarket() async {
    final response = await dio.get("marketplace/getmarket");
    return Result.fromJson(response.data);
  }

  Future<Result> getMarketByCrop(String? id) async {
    final response = await dio.get("marketplace/getmarket/$id");
    return Result.fromJson(response.data);
  }

  Future<Result> getNotifications() async {
    final response = await dio.get("notification");
    return Result.fromJson(response.data);
  }

  Future<Result> getDisclaimer() async {
    final response = await dio.get("disclaimer");
    return Result.fromJson(response.data);
  }
}
