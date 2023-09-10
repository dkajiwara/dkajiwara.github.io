import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        alignment: Alignment.center,
        child: Row(
          children: [
            GestureDetector(
                onTap: () {
                  context.go('/');
                },
                child: Text(
                  "dkajiii",
                  style: GoogleFonts.monoton(fontSize: 30),
                )),
            const Spacer()
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);
}
