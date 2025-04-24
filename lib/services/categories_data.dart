import '../models/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> category = [
    CategoryModel(categoryName: "Business", image: "assets/images/business.jpg"),
    CategoryModel(categoryName: "Entertainment", image: "assets/images/Entertainment.jpeg"),
    CategoryModel(categoryName: "General", image: "assets/images/general.jpg"),
    CategoryModel(categoryName: "Health", image: "assets/images/Health.jpg"),
    CategoryModel(categoryName: "Sports", image: "assets/images/sports.jpg"),
    CategoryModel(categoryName: "Technology", image: "assets/images/tec.jpeg"),
  ];

  return category;
}
