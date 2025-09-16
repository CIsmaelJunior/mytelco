import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/responsive_helper.dart';
import '../viewmodels/forfaits_viewmodel.dart';
import '../widgets/custom_app_bar.dart';
import 'subscription_page.dart';

class ForfaitsPage extends StatefulWidget {
  const ForfaitsPage({super.key});

  @override
  State<ForfaitsPage> createState() => _ForfaitsPageState();
}

class _ForfaitsPageState extends State<ForfaitsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ForfaitsViewModel>().loadForfaits();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundGray,
      appBar: const CustomAppBar(
        title: 'Forfaits disponibles',
        showBackButton: false,
      ),
      body: Consumer<ForfaitsViewModel>(
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
                    onPressed: () => viewModel.loadForfaits(),
                    child: const Text('Réessayer'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: ResponsiveHelper.getResponsivePadding(context),
            child: Column(
              children: [
                _buildForfaitsList(viewModel),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildForfaitsList(ForfaitsViewModel viewModel) {
    return Column(
      children: viewModel.forfaits.map((forfait) {
        return Container(
          margin: const EdgeInsets.only(bottom: AppConstants.paddingMedium),
          child: _buildForfaitCard(forfait, viewModel),
        );
      }).toList(),
    );
  }

  Widget _buildForfaitCard(forfait, ForfaitsViewModel viewModel) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      decoration: BoxDecoration(
        color: forfait.isPopular ? AppTheme.lightOrange : AppTheme.cardBackground,
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
                    forfait.icon,
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
                            forfait.name,
                            style: const TextStyle(
                              fontSize: AppConstants.fontSizeLarge,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textDark,
                            ),
                          ),
                        ),
                        if (forfait.isPopular)
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
                      forfait.description,
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
          _buildFeaturesList(forfait.features),
          const SizedBox(height: AppConstants.paddingLarge),
          // Prix et validité
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    viewModel.formatPrice(forfait.price),
                    style: const TextStyle(
                      fontSize: AppConstants.fontSizeXXLarge,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    viewModel.formatValidity(forfait.validityDays),
                    style: const TextStyle(
                      fontSize: AppConstants.fontSizeMedium,
                      color: AppTheme.textGray,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingLarge),
          // Bouton souscrire
          SizedBox(
            width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _navigateToSubscription(forfait),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryOrange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingMedium),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                ),
              ),
              child: const Text(
                'Souscrire',
                style: TextStyle(
                  fontSize: AppConstants.fontSizeMedium,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
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

  void _navigateToSubscription(forfait) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SubscriptionPage(forfait: forfait),
      ),
    );
  }
}
