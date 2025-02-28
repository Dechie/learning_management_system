import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_system/core/constants/enums.dart';
import 'package:lms_system/features/auth_status_registration/provider/auth_status_controller.dart';
import 'package:lms_system/features/check_seen_onboarding/provider/check_seen_onboarding_provider.dart';
import 'package:lms_system/features/shared/model/start_routes.dart';
import 'package:lms_system/features/shared/provider/start_routes_provider.dart';

import 'core/app_router.dart';
import 'core/constants/colors.dart';

void main() async {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

final initialRouteProvider = FutureProvider<StartRoutes>((ref) async {
  final checkSeenOnboardingController =
      ref.watch(checkSeenOnboardingControllerProvider.notifier);
  final checkAuthedController = ref.watch(authStatusProvider.notifier);

  bool hasSeenOnboarding =
      await checkSeenOnboardingController.checkSeenOnboarding();
  AuthStatus authStat = await checkAuthedController.checkAuthStatus();
  String firstRoute = Routes.onboarding;
  String secondRoute = Routes.signup;

  if (hasSeenOnboarding) {
    switch (authStat) {
      case AuthStatus.authed:
        firstRoute = Routes.wrapper;
        break;
      case AuthStatus.pending:
        firstRoute = Routes.login;
        secondRoute = Routes.wrapper;
        break;
      case AuthStatus.notAuthed:
        firstRoute = Routes.signup;
        secondRoute = Routes.wrapper;
        break;
    }
  }

  ref.read(startRoutesProvider.notifier).changeRoute(
        firstRoute: firstRoute,
        secondRoute: secondRoute,
      );
  return StartRoutes(
    firstRoute: firstRoute,
    secondRoute: secondRoute,
  );
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routesAsync = ref.watch(initialRouteProvider);

    return routesAsync.when(
      loading: () => Container(
        color: Colors.white,
      ),
      error: (error, stackTrace) => Text('Error: $error'),
      data: (routesData) {
        return OrientationBuilder(
          builder: (context, orientation) {
            return MaterialApp(
              theme: ThemeData(
                colorScheme:
                    ColorScheme.fromSeed(seedColor: AppColors.mainBlue),
                useMaterial3: true,
              ),
              initialRoute: routesData.firstRoute, // Now correctly accessed
              onGenerateRoute: Approuter.generateRoute,
            );
          },
        );
      },
    );
  }
}

// class MyApp extends ConsumerWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final checkSeenOnboardingController =
//         ref.watch(checkSeenOnboardingControllerProvider.notifier);
//     bool hasSeenOnboarding =
//         await checkSeenOnboardingController.checkSeenOnboarding();

//     return OrientationBuilder(builder: (context, orientation) {
//       return MaterialApp(
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainBlue),
//           useMaterial3: true,
//         ),
//         initialRoute: Routes.onboarding,
//         onGenerateRoute: Approuter.generateRoute,
//       );
//     });
//   }
// }
