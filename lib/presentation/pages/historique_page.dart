import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/responsive_helper.dart';
import '../../data/models/consommation_model.dart';
import '../viewmodels/historique_viewmodel.dart';
import '../widgets/custom_app_bar.dart';

class HistoriquePage extends StatefulWidget {
  const HistoriquePage({super.key});

  @override
  State<HistoriquePage> createState() => _HistoriquePageState();
}

class _HistoriquePageState extends State<HistoriquePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HistoriqueViewModel>().loadConsommations();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundGray,
      appBar: const CustomAppBar(
        title: 'Historique',
        showBackButton: false,
      ),
      body: Consumer<HistoriqueViewModel>(
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
                    onPressed: () => viewModel.loadConsommations(),
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
                _buildSectionHeader('Activité récente'),
                const SizedBox(height: AppConstants.paddingMedium),
                _buildFilterTabs(viewModel),
                const SizedBox(height: AppConstants.paddingMedium),
                _buildConsommationsList(viewModel),
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

  Widget _buildFilterTabs(HistoriqueViewModel viewModel) {
    return Row(
      children: [
        Expanded(
          child: _buildFilterTab(
            ConsommationType.call,
            'Appels',
            'assets/icons/Appel.svg',
            viewModel,
          ),
        ),
        const SizedBox(width: AppConstants.paddingSmall),
        Expanded(
          child: _buildFilterTab(
            ConsommationType.internet,
            'Internet',
            'assets/icons/Wifi.svg',
            viewModel,
          ),
        ),
        const SizedBox(width: AppConstants.paddingSmall),
        Expanded(
          child: _buildFilterTab(
            ConsommationType.sms,
            'sms',
            'assets/icons/sms.svg',
            viewModel,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterTab(
    ConsommationType type,
    String label,
    String icon,
    HistoriqueViewModel viewModel,
  ) {
    final isSelected = viewModel.selectedType == type;
    
    return GestureDetector(
      onTap: () => viewModel.selectType(type),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingMedium,
          vertical: AppConstants.paddingSmall,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryOrange : AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          border: isSelected
              ? null
              : Border.all(
                  color: AppTheme.textGray.withValues(alpha: 0.3),
                  width: 1,
                ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              width: 16,
              height: 16,
              colorFilter: ColorFilter.mode(
                isSelected ? Colors.white : AppTheme.textGray,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: AppConstants.fontSizeSmall,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : AppTheme.textGray,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConsommationsList(HistoriqueViewModel viewModel) {
    final consommations = viewModel.consommations;

    if (consommations.isEmpty) {
      return Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Icon(
              Icons.history,
              size: 64,
              color: AppTheme.textGray,
            ),
            const SizedBox(height: 16),
            Text(
              'Aucune consommation ${viewModel.getTypeName(viewModel.selectedType).toLowerCase()}',
              style: const TextStyle(
                fontSize: AppConstants.fontSizeLarge,
                color: AppTheme.textGray,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Vos consommations apparaîtront ici.',
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
      children: consommations.map((consommation) {
        return Container(
          margin: const EdgeInsets.only(bottom: AppConstants.paddingSmall),
          child: _buildConsommationCard(consommation, viewModel),
        );
      }).toList(),
    );
  }

  Widget _buildConsommationCard(ConsommationModel consommation, HistoriqueViewModel viewModel) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
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
      child: Row(
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
                viewModel.getTypeIcon(consommation.type),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  consommation.formattedAmount,
                  style: const TextStyle(
                    fontSize: AppConstants.fontSizeLarge,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
                if (consommation.destination != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    'À: ${consommation.destination}',
                    style: const TextStyle(
                      fontSize: AppConstants.fontSizeMedium,
                      color: AppTheme.textDark,
                    ),
                  ),
                ],
                const SizedBox(height: 4),
                Text(
                  'Date: ${viewModel.formatDate(consommation.date)}',
                  style: const TextStyle(
                    fontSize: AppConstants.fontSizeSmall,
                    color: AppTheme.textGray,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
