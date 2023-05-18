import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:oil_market/models/schedule_model.dart';

class ScheduleRepository {
  final _dio = Dio();
  final _targetUrl = 'https://${Platform.isAndroid ? '10.0.2.2' : 'localhost'}:3000/schedule';

  Future<List<SchedulesModel>> getSchedules ({
  required DateTime date,
}) async {
    final resp = await _dio.get(
      _targetUrl,
      queryParameters: {
        'date': '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}'
      },
    );

    return resp.data
        .map<SchedulesModel>(
        (x) => SchedulesModel.fromJson(
          json: x
        ),
    ).toList();
  }

  Future<String> createSchedules ({
    required SchedulesModel schedule,
  }) async {
    final json = schedule.toJson();

    final resp = await _dio.post(_targetUrl, data: json);

    return resp.data?['id'];
  }

  Future<String> deleteSchedules ({
    required String id,
  }) async {
    final resp = await _dio.delete(_targetUrl, data: {'id': id});

    return resp.data?['id'];
  }

}