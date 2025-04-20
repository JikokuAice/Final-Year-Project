import 'package:dio/dio.dart';
import 'package:frontend/Features/Home/Data/model/AddCommentModel.dart';
import 'package:frontend/Features/Home/Data/model/Hiking_Card_Model.dart';
import 'package:frontend/Features/Home/Data/model/comment_model.dart';
import 'package:frontend/Features/Home/Data/model/trail_detail_model.dart';
import 'package:frontend/contrant/Network_Route.dart';
import 'package:logger/logger.dart';

abstract class RemoteDataSource {
  Future<List<HikingCardModel>?> getHomePageDetails();
  Future<TrailDetailModel?> getTrailDetail(int trailId);
  Future<List<CommentModel>?> getTrailComment(int trailId);
  Future<bool> deleteUserComment(int commentId, int userId);
  Future<bool> addComment(AddCommentModel addCommentModel);
}

class RemoteDataSourceImp extends RemoteDataSource {
  final Dio dio;
  final Logger log;

  RemoteDataSourceImp(this.dio, this.log);
  @override
  Future<List<HikingCardModel>?> getHomePageDetails() async {
    var result = await dio
        .get("$localHostUrl/api/User/GetAllTrial")
        .timeout(const Duration(seconds: 5));
    log.e(result.data);
    log.e(result);
    List<dynamic> jsonList = result.data; // Raw list from API
    return jsonList.map((json) => HikingCardModel.fromJson(json)).toList();
  }

  @override
  Future<TrailDetailModel?> getTrailDetail(int trailId) async {
    try {
      var result =
          await dio.get("$localHostUrl/api/User/GetTrailDetail/$trailId");

      if (result.statusCode != 200) {
        return null;
      }
      var data = TrailDetailModel.fromJson(result.data);
      return data;
    } catch (e) {
      log.e(e.toString());
    }
    return null;
  }

  @override
  Future<List<CommentModel>?> getTrailComment(int trailId) async {
    try {
      var result =
          await dio.get("$localHostUrl/api/User/GetTrailComments/$trailId");
      log.e(result.data);
      List<CommentModel>? commentModel = [];
      for (var i in result.data) {
        commentModel.add(CommentModel.fromJson(i));
      }
      return commentModel;
    } catch (e) {
      log.e(e.toString());
    }
    return null;
  }

  @override
  Future<bool> deleteUserComment(int commentId, int userId) async {
    var result = await dio.delete(
        '$localHostUrl/api/User/DeleteComment?commentId=$commentId&userId=$userId');

    log.d(result.data);
    if (result.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> addComment(AddCommentModel addCommentModel) async {
    try {
      var result = await dio.post("$localHostUrl/api/User/AddComment", data: {
        "comments": {
          "commentText": addCommentModel.commentText,
          "userId": addCommentModel.userId,
          "trailId": addCommentModel.trailId
        }
      });
      log.e(result.data);
      return result.data;
    } catch (e) {
      return false;
    }
  }
}
