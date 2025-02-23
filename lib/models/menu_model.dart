class MenuModel {
  final String name;
  final num price;
  final String image;
  final Productcategory category;
  const MenuModel(
      {required this.name,
      required this.price,
      required this.image,
      required this.category});
  factory MenuModel.fromjson(Map<String, dynamic> Json) {
    return MenuModel(
        name: Json['name'],
        price: Json['price'],
        image: Json['image'],
        category: Productcategory.values.byName(Json['category']));
  }
}

enum Productcategory {
  All,
  Appetizer,
  Soup,
  Salad,
  MainCourse,
  SideDish,
  Dessert,
  Beverage
}
