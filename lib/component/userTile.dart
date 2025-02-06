import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../themes/theme_provider.dart';

class Usertile extends StatelessWidget {
  final String text;
  final  void Function()? onTap;

  const Usertile({
    super.key,
    required this.text,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {

    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(30),
        child: Row(
          children: [
            Icon(
              Icons.people,
              color: isDarkMode? Colors.white : Colors.white,
              size: 30,
            ),
            const SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                color: isDarkMode? Colors.white : Colors.white,
                fontSize: 16
              )
            )
          ],
        ),
      ),
    );
  }
}
