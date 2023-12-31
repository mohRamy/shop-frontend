import 'package:dio/dio.dart' as diox;
import 'package:shop_app/src/resources/base_repository.dart';
import 'package:shop_app/src/resources/local/user_local.dart';

import '../../../public/api_gateway.dart';

class NotificationRepository {
  final BaseRepository baseRepository;
  NotificationRepository(this.baseRepository);

  Future<diox.Response> pushNotofication({
    required String userId,
    required String title,
    required String message,
  }) async {
      var body = {
        "userId": userId,
        "title": title,
        "message": message,
      };
      return await baseRepository.postRoute(
        ApiGateway.SEND_NOTIFICATION,
        body,
      );
  }

    Future<diox.Response> getNotofications() async {
    return await baseRepository.getRoute(
      ApiGateway.GET_NOTIFICATIONS,
      params: UserLocal().getUserId(),
    );
  }

  Future<diox.Response> seenNotofication() async {
      return await baseRepository.postRoute(
        ApiGateway.SEEN_NOTIFICATION,
        {},
      );
  }
}
