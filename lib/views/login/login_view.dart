import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state/auth/providers/providers.dart';
import '../constants/app_colors.dart';
import '../constants/strings.dart';
import 'create_social_account_links.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text(Strings.appName)),
      body: ListView(
        padding: EdgeInsets.all(size.width * 0.05),
        children: [
          SizedBox(height: size.height * 0.1),
          Text(
            Strings.welcomeToAppName,
            style: textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          Divider(height: size.height * 0.15, color: Colors.grey[900]),
          Text(
            Strings.logIntoYourAccount,
            style: textTheme.titleMedium?.copyWith(height: 1.5),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: size.height * 0.05),
          ElevatedButton.icon(
            icon: FaIcon(FontAwesomeIcons.facebook,
                color: AppColors.facebookColor),
            onPressed: ref.read(authStaeProvider.notifier).loginWithFacebook,
            label: const Text(Strings.facebook),
          ),
          SizedBox(height: size.height * 0.01),
          ElevatedButton.icon(
            icon: FaIcon(FontAwesomeIcons.google, color: AppColors.googleColor),
            onPressed: ref.read(authStaeProvider.notifier).loginWithGoogle,
            label: const Text(Strings.google),
          ),
          Divider(height: size.height * 0.15, color: Colors.grey[900]),
          CreateSocialAccountsText(),
        ],
      ),
    );
  }
}
