class BasketItem {
  final String name;
  final double price;
  final String image;
  final int quantity;
  const BasketItem ({required this.name,required this.price,
  required this.image,required this.quantity});
  factory BasketItem.fromjson ( Map<String,dynamic> Json){
    return BasketItem(name: Json['name'],
     price: Json['price'], image: Json['image'], quantity: Json['quantity']);
  }
}