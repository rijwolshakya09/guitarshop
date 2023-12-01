import 'package:guitarshop/model/show_category.dart';
import 'package:guitarshop/response/category_response.dart';

import '../api/category_api.dart';

class CategoryRepository {
  Future<List<ShowCategory?>> loadCategory() {
    return CategoryAPI().loadCategory();
  }

  Future<CategoryResponse?> getCategory() async {
    return CategoryAPI().getCategory();
  }
}
