import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text("Digital Episode App"),
      backgroundColor: const Color.fromARGB(255, 220, 179, 228),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}