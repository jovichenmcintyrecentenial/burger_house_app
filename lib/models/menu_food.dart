

class MenuItem {

  final String image;
  final String name;
  final double price;
  final int likes;
  final int calories;

  MenuItem(
      {required this.image,
      required this.name,
      required this.price,
      this.likes = 0,
      required this.calories});
}