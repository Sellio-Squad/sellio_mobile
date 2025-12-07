import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';

import '../widgets/login_footer.dart';
import '../widgets/login_form.dart';
import '../widgets/login_header.dart';

Widget buildLoginContent(BuildContext context) {
  return const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      LoginHeader(),
      Gap(40),
      LoginForm(),
      Gap(175),
      LoginFooter(),
      Gap(16),
    ],
  );
}
