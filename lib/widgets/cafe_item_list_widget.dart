import 'package:cafe_shop/model/cafe_item.dart';
import 'package:cafe_shop/resource/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:cafe_shop/resource/styles.dart';

class CafeItemListWidget extends StatelessWidget {
  final List<CafeItem> items;
  final String categoryTitle;
  final IconData icon;
  final void Function(CafeItem) onAddToCart;

  const CafeItemListWidget({
    Key? key,
    required this.items,
    required this.categoryTitle,
    required this.icon,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        ExpansionTile(
          leading: Icon(icon),
          title: Text(categoryTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.grey[200],
          textColor: ThemeColor.primaryColor,
          iconColor: ThemeColor.primaryColor,
          collapsedBackgroundColor: ThemeColor.primaryColor[400],
          collapsedTextColor: ThemeColor.foregroundColor,
          collapsedIconColor: ThemeColor.foregroundColor,
          initiallyExpanded: true,
          children: [
            ...items.map(
              (cafeItem) => ListTile(
                minVerticalPadding: 10,
                shape: const Border(bottom: BorderSide(width: 0.5, color: Colors.grey)),
                leading: SizedBox(height: screenWidth / 2, child: Image(image: AssetImage(cafeItem.image), fit: BoxFit.contain)),
                title: Text(cafeItem.name, style: Styles.orderTitleTextStyle),
                subtitle: Text("${cafeItem.price.toStringAsFixed(2)} PLN", style: Styles.orderSubtitleTextStyle),
                trailing: IconButton(onPressed: () => onAddToCart(cafeItem), icon: const Icon(Icons.add_circle_outline, color: Colors.brown)),
                tileColor: Colors.grey[200],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
