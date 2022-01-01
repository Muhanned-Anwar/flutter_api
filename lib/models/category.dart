class Category {
  late int id;
  late String title;
  late String description;
  late String image;
  late int visible;
  late int productsCount;



  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    visible = json['visible'];
    productsCount = json['products_count'];
  }


}