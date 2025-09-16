import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';
import '../viewmodels/forfaits_viewmodel.dart';
import '../widgets/custom_app_bar.dart';

class SubscriptionPage extends StatefulWidget {
  final dynamic forfait;
  
  const SubscriptionPage({
    super.key,
    required this.forfait,
  });

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundGray,
      appBar: const CustomAppBar(
        title: 'Forfaits disponibles',
        showBackButton: true,
      ),
      body: Consumer<ForfaitsViewModel>(
        builder: (context, viewModel, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.paddingLarge),
            child: Column(
              children: [
                _buildTransactionSummary(viewModel),
                const SizedBox(height: AppConstants.paddingLarge),
                _buildPaymentMethod(viewModel),
                const SizedBox(height: AppConstants.paddingLarge),
                _buildSubscribeButton(viewModel),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTransactionSummary(ForfaitsViewModel viewModel) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
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
          const Text(
            'Récap de la transaction',
            style: TextStyle(
              fontSize: AppConstants.fontSizeLarge,
              fontWeight: FontWeight.w600,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          // Icône et titre
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
                    widget.forfait.icon,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.forfait.name,
                            style: const TextStyle(
                              fontSize: AppConstants.fontSizeLarge,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textDark,
                            ),
                          ),
                        ),
                        if (widget.forfait.isPopular)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppConstants.paddingSmall,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber.shade200,
                              borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                            ),
                            child: const Text(
                              'Forfait Populaire',
                              style: TextStyle(
                                fontSize: AppConstants.fontSizeSmall,
                                color: AppTheme.textDark,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.forfait.description,
                      style: const TextStyle(
                        fontSize: AppConstants.fontSizeMedium,
                        color: AppTheme.textGray,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          // Tags de fonctionnalités
          _buildFeaturesList(widget.forfait.features),
          const SizedBox(height: AppConstants.paddingLarge),
          // Prix et validité
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    viewModel.formatPrice(widget.forfait.price),
                    style: const TextStyle(
                      fontSize: AppConstants.fontSizeXXLarge,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    viewModel.formatValidity(widget.forfait.validityDays),
                    style: const TextStyle(
                      fontSize: AppConstants.fontSizeMedium,
                      color: AppTheme.textGray,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod(ForfaitsViewModel viewModel) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
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
          // Méthode de paiement
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
                    'assets/icons/Solde.svg',
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Méthode de paiement',
                      style: TextStyle(
                        fontSize: AppConstants.fontSizeMedium,
                        color: AppTheme.textGray,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Balance',
                      style: TextStyle(
                        fontSize: AppConstants.fontSizeLarge,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '18 525 FCFA',
                      style: const TextStyle(
                        fontSize: AppConstants.fontSizeMedium,
                        color: AppTheme.textGray,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingLarge),
          // Séparateur
          Container(
            height: 1,
            color: AppTheme.textGray.withValues(alpha: 0.2),
          ),
          const SizedBox(height: AppConstants.paddingLarge),
          // Résumé de paiement
          const Text(
            'Résumé de paiement',
            style: TextStyle(
              fontSize: AppConstants.fontSizeMedium,
              color: AppTheme.textGray,
            ),
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Montant',
                style: TextStyle(
                  fontSize: AppConstants.fontSizeMedium,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textDark,
                ),
              ),
              Text(
                viewModel.formatPrice(widget.forfait.price),
                style: const TextStyle(
                  fontSize: AppConstants.fontSizeMedium,
                  color: AppTheme.textGray,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: AppConstants.fontSizeLarge,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryOrange,
                ),
              ),
              Text(
                viewModel.formatPrice(widget.forfait.price),
                style: const TextStyle(
                  fontSize: AppConstants.fontSizeLarge,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryOrange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesList(List<String> features) {
    return Wrap(
      spacing: AppConstants.paddingSmall,
      runSpacing: AppConstants.paddingSmall,
      children: features.map((feature) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingSmall,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: AppTheme.textGray.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
          ),
          child: Text(
            feature,
            style: const TextStyle(
              fontSize: AppConstants.fontSizeSmall,
              color: AppTheme.textGray,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSubscribeButton(ForfaitsViewModel viewModel) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: viewModel.isSubscribing
            ? null
            : () => _handleSubscription(viewModel),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryOrange,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingLarge),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          ),
        ),
        child: viewModel.isSubscribing
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                'Souscrire',
                style: TextStyle(
                  fontSize: AppConstants.fontSizeLarge,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Future<void> _handleSubscription(ForfaitsViewModel viewModel) async {
    final success = await viewModel.subscribeToForfait(widget.forfait);
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Souscription au forfait "${widget.forfait.name}" réussie !'),
          backgroundColor: AppTheme.successGreen,
        ),
      );
      Navigator.of(context).pop();
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(viewModel.error ?? 'Erreur lors de la souscription'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
