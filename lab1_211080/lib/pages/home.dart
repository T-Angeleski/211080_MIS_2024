import 'package:flutter/material.dart';
import 'package:lab1_211080/models/clothing_item.dart';
import 'package:lab1_211080/services/clothing_service.dart';
import 'package:lab1_211080/widgets/clothing_item_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ClothingItem> clothingItems = ClothingService.getClothingItems();

    return Scaffold(
      appBar: AppBar(
        title: const Text("211080", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.grey[100],
        child: ListView.builder(
          itemCount: clothingItems.length,
          itemBuilder: (context, index) {
            final item = clothingItems[index];
            return ClothingItemCard(item: item);
          },
        ),
      ),
    );
  }
}
