import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instant_gram/state/auth/providers/providers.dart';

final isLoadingProvider =
    Provider<bool>((ref) => ref.watch(authStaeProvider).isLoading);
