class MenuModel {
  final String name;
  final num price;
  final String image;
  final Productcategory category;
  final String discrption;
  final String id;
  const MenuModel(
      {required this.name,
      required this.price,
      required this.image,
      required this.category,
      required this.discrption,
      required this.id});
  factory MenuModel.fromjson(Map<String, dynamic> Json) {
    return MenuModel(
        name: Json['name'],
        price: Json['price'],
        image: Json['image'],
        discrption: Json['description'],
        id: Json['_id'],
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
