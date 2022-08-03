import 'package:flutter/material.dart';
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
                  _onTapHome(context);
                },
                child: Text(
                  "dkajiii",
                  style: GoogleFonts.monoton(fontSize: 30),
                )),
            const Spacer(),
            TextButton(
                onPressed: () => _onTapResume(context),
                child: const Text('Resume', style: TextStyle(fontSize: 16)))
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);

  void _onTapResume(BuildContext context) {
    Navigator.pushNamed(
      context,
      '/resume',
    );
  }

  void _onTapHome(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
