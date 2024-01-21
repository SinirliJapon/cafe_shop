import 'package:cafe_shop/resource/styles.dart';
import 'package:cafe_shop/resource/theme_color.dart';
import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;

  const DrawerListTile({Key? key, required this.title, required this.icon, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Icon(icon),
      onTap: onTap,
      titleTextStyle: Styles.drawerTitleTextStyle,
      iconColor: ThemeColor.primaryColor,
      tileColor: ThemeColor.tileColor,
    );
  }
}
