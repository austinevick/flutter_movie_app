import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'logo.dart';

class MovieAppBar extends StatelessWidget {
  const MovieAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      IconButton(onPressed: () {}, icon: SvgPicture.asset('assets/menu.svg')),
      IconButton(onPressed: () {}, icon: const Logo()),
      IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
    ]);
  }
}
