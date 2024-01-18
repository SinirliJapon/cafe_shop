import 'package:auto_route/auto_route.dart';
import 'package:cafe_shop/resource/styles.dart';
import 'package:cafe_shop/routes/app_router.gr.dart';
import 'package:flutter/material.dart';

class EnterShopButton extends StatelessWidget {
  const EnterShopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AutoRouter.of(context).replace(const HomeRoute()),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.brown),
          child: const Padding(padding: EdgeInsets.all(8.0), child: Text('Enter Shop', style: Styles.buttonTextStyle)),
        ),
      ),
    );
  }
}
