import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/responsive_helper.dart';
import '../viewmodels/passes_viewmodel.dart';
import '../widgets/custom_app_bar.dart';
import 'cancellation_page.dart';

class PassesPage extends StatefulWidget {
  const PassesPage({super.key});

  @override
  State<PassesPage> createState() => _PassesPageState();
}

class _PassesPageState extends State<PassesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PassesViewModel>().loadPasses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundGray,
      appBar: const CustomAppBar(
        title: 'Mes Pass',
        showBackButton: false,
      ),
      body: Consumer<PassesViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppTheme.primaryOrange,
              ),
            );
          }

          if (viewModel.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppTheme.textGray,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    viewModel.error!,
                    style: const TextStyle(
                      color: AppTheme.textGray,
                      fontSize: AppConstants.fontSizeMedium,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => viewModel.loadPasses(),
                    child: const Text('Réessayer'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: ResponsiveHelper.getResponsivePadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('Mes pass actifs (${viewModel.activePasses.length})'),
                const SizedBox(height: AppConstants.paddingMedium),
                _buildPassesList(viewModel),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: AppConstants.fontSizeLarge,
        fontWeight: FontWeight.w600,
        color: AppTheme.textDark,
      ),
    );
  }

  Widget _buildPassesList(PassesViewModel viewModel) {
    if (viewModel.activePasses.isEmpty) {
      return Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Icon(
              Icons.inbox_outlined,
              size: 64,
              color: AppTheme.textGray,
            ),
            const SizedBox(height: 16),
            const Text(
              'Aucun pass actif',
              style: TextStyle(
                fontSize: AppConstants.fontSizeLarge,
                color: AppTheme.textGray,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Souscrivez à un forfait pour voir vos passes actifs ici.',
              style: TextStyle(
                fontSize: AppConstants.fontSizeMedium,
                color: AppTheme.textGray,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Column(
      children: viewModel.activePasses.map((pass) {
        return Container(
          margin: const EdgeInsets.only(bottom: AppConstants.paddingMedium),
          child: _buildPassCard(pass, viewModel),
        );
      }).toList(),
    );
  }

  Widget _buildPassCard(pass, PassesViewModel viewModel) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        border: Border.all(
          color: AppTheme.lightGreen,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppTheme.lightOrange,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    pass.icon,
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      AppTheme.primaryOrange,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.paddingMedium),
              Expanded(
                child: Text(
                  pass.name,
                  style: const TextStyle(
                    fontSize: AppConstants.fontSizeLarge,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingSmall,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.lightGreen,
                  borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                ),
                child: const Text(
                  'Actif',
                  style: TextStyle(
                    fontSize: AppConstants.fontSizeSmall,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          Row(
            children: [
              Expanded(
                child: _buildDateInfo(
                  Icons.calendar_today,
                  'Activation',
                  viewModel.formatDate(pass.activationDate),
                ),
              ),
              Expanded(
                child: _buildDateInfo(
                  Icons.access_time,
                  'Expiration',
                  viewModel.formatDate(pass.expirationDate),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Temps restant',
                style: const TextStyle(
                  fontSize: AppConstants.fontSizeMedium,
                  color: AppTheme.textGray,
                ),
              ),
              Text(
                viewModel.formatRemainingTime(pass.remainingDays),
                style: const TextStyle(
                  fontSize: AppConstants.fontSizeMedium,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          _buildProgressBar(viewModel.getProgressPercentage(pass)),
          const SizedBox(height: AppConstants.paddingMedium),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => _navigateToCancellation(pass),
              child: const Text('Résilier pass'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateInfo(IconData icon, String label, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: AppTheme.textGray,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: AppConstants.fontSizeSmall,
                color: AppTheme.textGray,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          date,
          style: const TextStyle(
            fontSize: AppConstants.fontSizeMedium,
            fontWeight: FontWeight.w600,
            color: AppTheme.textDark,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar(double progress) {
    return Container(
      height: 4,
      decoration: BoxDecoration(
        color: AppTheme.backgroundGray,
        borderRadius: BorderRadius.circular(2),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.primaryOrange,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  void _navigateToCancellation(pass) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CancellationPage(pass: pass),
      ),
    );
  }
}
