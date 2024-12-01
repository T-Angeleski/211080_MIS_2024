import 'package:lab1_211080/models/clothing_item.dart';

class ClothingService {
  static List<ClothingItem> getClothingItems() {
    return [
      ClothingItem(
          id: 1,
          name: 'Red T-shirt',
          description: "A vibrant red t-shirt for casual outings",
          image: "assets/red_shirt.png",
          price: 19.99),
      ClothingItem(
        id: 2,
        name: 'Blue Jeans',
        description: 'Stylish blue jeans with a comfortable fit.',
        image: 'assets/blue_jeans.jpg',
        price: 39.99,
      ),
      ClothingItem(
        id: 3,
        name: 'Black Dress',
        description: 'A black dress for a night out.',
        image: 'assets/black_dress.png',
        price: 49.99,
      ),
    ];
  }
}
