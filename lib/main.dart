import 'package:flutter/material.dart';

class ClothingItem {
  final int id;
  final String name;
  final String description;
  final String image;
  final double price;

  ClothingItem({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
  });
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My clothing store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "/details": (context) => const DetailsPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ClothingItem> clothingItems = [
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

    return Scaffold(
      appBar: AppBar(
        title: const Text("211080", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: clothingItems.length,
        itemBuilder: (context, index) {
          final item = clothingItems[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Image.asset(item.image, width: 50, fit: BoxFit.cover),
              title: Text(item.name),
              subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/details',
                  arguments: item,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as ClothingItem;

    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(item.image, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(
              item.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${item.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 16),
            Text(item.description),
          ],
        ),
      ),
    );
  }
}
