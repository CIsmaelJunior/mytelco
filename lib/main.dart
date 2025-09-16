import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/user_repository.dart';
import 'data/repositories/forfait_repository.dart';
import 'data/repositories/pass_repository.dart';
import 'data/repositories/consommation_repository.dart';
import 'presentation/viewmodels/dashboard_viewmodel.dart';
import 'presentation/viewmodels/forfaits_viewmodel.dart';
import 'presentation/viewmodels/passes_viewmodel.dart';
import 'presentation/viewmodels/historique_viewmodel.dart';
import 'presentation/pages/main_page.dart';

void main() {
  runApp(const MyTelcoApp());
}

class MyTelcoApp extends StatelessWidget {
  const MyTelcoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Repositories
        Provider<UserRepository>(
          create: (_) => UserRepository(),
        ),
        Provider<ForfaitRepository>(
          create: (_) => ForfaitRepository(),
        ),
        Provider<PassRepository>(
          create: (_) => PassRepository(),
        ),
        Provider<ConsommationRepository>(
          create: (_) => ConsommationRepository(),
        ),
        
        // ViewModels
        ChangeNotifierProxyProvider<UserRepository, DashboardViewModel>(
          create: (context) => DashboardViewModel(
            context.read<UserRepository>(),
          ),
          update: (context, userRepo, previous) => 
              previous ?? DashboardViewModel(userRepo),
        ),
        ChangeNotifierProxyProvider3<ForfaitRepository, PassRepository, UserRepository, ForfaitsViewModel>(
          create: (context) => ForfaitsViewModel(
            context.read<ForfaitRepository>(),
            context.read<PassRepository>(),
            context.read<UserRepository>(),
          ),
          update: (context, forfaitRepo, passRepo, userRepo, previous) => 
              previous ?? ForfaitsViewModel(forfaitRepo, passRepo, userRepo),
        ),
        ChangeNotifierProxyProvider<PassRepository, PassesViewModel>(
          create: (context) => PassesViewModel(
            context.read<PassRepository>(),
          ),
          update: (context, passRepo, previous) => 
              previous ?? PassesViewModel(passRepo),
        ),
        ChangeNotifierProxyProvider<ConsommationRepository, HistoriqueViewModel>(
          create: (context) => HistoriqueViewModel(
            context.read<ConsommationRepository>(),
          ),
          update: (context, consommationRepo, previous) => 
              previous ?? HistoriqueViewModel(consommationRepo),
        ),
      ],
      child: MaterialApp(
        title: 'MyTelco',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const MainPage(),
      ),
    );
  }
}
