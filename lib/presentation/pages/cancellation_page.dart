import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';
import '../viewmodels/passes_viewmodel.dart';
import '../widgets/custom_app_bar.dart';

class CancellationPage extends StatefulWidget {
  final dynamic pass;
  
  const CancellationPage({
    super.key,
    required this.pass,
  });

  @override
  State<CancellationPage> createState() => _CancellationPageState();
}

class _CancellationPageState extends State<CancellationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundGray,
      appBar: const CustomAppBar(
        title: 'Résilier pass',
        showBackButton: true,
      ),
      body: Consumer<PassesViewModel>(
        builder: (context, viewModel, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.paddingLarge),
            child: Column(
              children: [
                _buildWarningSection(),
                const SizedBox(height: AppConstants.paddingLarge),
                _buildPassDetailsCard(viewModel),
                const SizedBox(height: AppConstants.paddingLarge),
                _buildActionButtons(viewModel),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildWarningSection() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.amber.shade200,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.warning_amber_rounded,
            size: 40,
            color: Colors.amber,
          ),
        ),
        const SizedBox(height: AppConstants.paddingMedium),
        const Text(
          'Vous êtes sur le point de résilier votre forfait.\nCette action est irréversible.',
          style: TextStyle(
            fontSize: AppConstants.fontSizeMedium,
            color: AppTheme.textDark,
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPassDetailsCard(PassesViewModel viewModel) {
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
          // Header avec icône, nom et statut
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppTheme.lightOrange,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    widget.pass.icon,
                    width: 20,
                    height: 20,
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
                  widget.pass.name,
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
          const SizedBox(height: AppConstants.paddingLarge),
          // Dates d'activation et expiration
          Row(
            children: [
              Expanded(
                child: _buildDateInfo(
                  Icons.calendar_today,
                  'Activation',
                  viewModel.formatDate(widget.pass.activationDate),
                ),
              ),
              Expanded(
                child: _buildDateInfo(
                  Icons.access_time,
                  'Expiration',
                  viewModel.formatDate(widget.pass.expirationDate),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingLarge),
          // Temps restant avec barre de progression
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Temps restant',
                style: TextStyle(
                  fontSize: AppConstants.fontSizeMedium,
                  color: AppTheme.textGray,
                ),
              ),
              Text(
                viewModel.formatRemainingTime(widget.pass.remainingDays),
                style: const TextStyle(
                  fontSize: AppConstants.fontSizeMedium,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          _buildProgressBar(viewModel.getProgressPercentage(widget.pass)),
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

  Widget _buildActionButtons(PassesViewModel viewModel) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingMedium),
              side: const BorderSide(color: AppTheme.textDark),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
              ),
            ),
            child: const Text(
              'Annuler',
              style: TextStyle(
                fontSize: AppConstants.fontSizeMedium,
                fontWeight: FontWeight.w600,
                color: AppTheme.textDark,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppConstants.paddingMedium),
        Expanded(
          child: ElevatedButton(
            onPressed: viewModel.isCancelling
                ? null
                : () => _handleCancellation(viewModel),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingMedium),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
              ),
            ),
            child: viewModel.isCancelling
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    'Résilier pass',
                    style: TextStyle(
                      fontSize: AppConstants.fontSizeMedium,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleCancellation(PassesViewModel viewModel) async {
    final success = await viewModel.cancelPass(widget.pass.id);
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Le pass "${widget.pass.name}" a été résilié avec succès'),
          backgroundColor: AppTheme.successGreen,
        ),
      );
      Navigator.of(context).pop();
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(viewModel.error ?? 'Erreur lors de la résiliation'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
