import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'config/theme.dart';
import 'firebase_options.dart';
import 'state/auth/providers/providers.dart';
import 'state/providers/is_loading_provider.dart';
import 'views/components/loading/loading_screen.dart';
import 'views/login/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: const App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: Consumer(builder: (_, ref, __) {
        /// Listen to [loading state]
        ref.listen(isLoadingProvider, (_, isLoading) {
          if (isLoading)
            LoadingScreen.instance().show(context);
          else
            LoadingScreen.instance().hide();
        });

        final isLoggedin = ref.watch(isLoggedinProvider);
        debugPrint('isLoggedin: $isLoggedin');
        return isLoggedin ? const MainView() : const LoginView();
      }),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Main View')),
        body: Center(
          child: Consumer(builder: (_, ref, __) {
            return ElevatedButton(
              onPressed: () => ref.read(authStaeProvider.notifier).logOut(),
              child: Text('Sign Out'),
            );
          }),
        ));
  }
}

// class LoginView extends ConsumerWidget {
//   const LoginView({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Login View')),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ElevatedButton(
//               onPressed: () =>
//                   ref.read(authStaeProvider.notifier).loginWithGoogle,
//               child: Text('Login with Google'),
//             ),
//             ElevatedButton(
//               onPressed: () =>
//                   ref.read(authStaeProvider.notifier).loginWithFacebook,
//               child: Text('Login with Facebook'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
