import 'package:dio/dio.dart';
import 'package:wakatime_dashboard/infrastructure/models/user_data.dart';

BaseOptions options = BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "POST,GET,DELETE,PUT,OPTIONS"
    },
    responseType: ResponseType.json);

Dio dio = Dio(options);

Future<UserData?> getUserSummaryService(
    String apiKey, String startDate, String endDate) async {
  Response response;
  var url =
      "https://wakatime.com/api/v1/users/current/summaries?start=$startDate&end=$endDate&api_key=$apiKey";
  print(url);
  try {
    response = await dio.get(url);
    if (response.statusCode == 200) {
      print("Hey");
      print(response.data.toString());
      return UserData.fromJson(response.data);
    } else {
      return null;
    }
  } on DioException catch (e) {
    print(":(");
    print(e);
  }
  return null;
}
