import 'package:guitarshop/api/review_api.dart';
import 'package:guitarshop/response/review_response.dart';

class ReviewRepository {
  Future<ReviewResponse?> getReview(String guitarId) async {
    return ReviewAPI().getReview(guitarId);
  }

  Future<bool> addReview(guitarId, String comment, int rating) async {
    return ReviewAPI().addReview(guitarId, comment, rating);
  }

  Future<bool> deleteReview(String reviewId) async {
    return ReviewAPI().deleteReview(reviewId);
  }
}
