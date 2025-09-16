import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.bottomNavHeight,
      decoration: const BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppConstants.radiusLarge),
          topRight: Radius.circular(AppConstants.radiusLarge),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context,
            index: 0,
            icon: 'assets/icons/Acceuil orange.svg',
            inactiveIcon: 'assets/icons/Forfait.svg',
            label: 'Accueil',
          ),
          _buildNavItem(
            context,
            index: 1,
            icon: 'assets/icons/Forfait orange.svg',
            inactiveIcon: 'assets/icons/Forfait.svg',
            label: 'Forfait',
          ),
          _buildNavItem(
            context,
            index: 2,
            icon: 'assets/icons/Task orange.svg',
            inactiveIcon: 'assets/icons/Task.svg',
            label: 'Mes pass',
          ),
          _buildNavItem(
            context,
            index: 3,
            icon: 'assets/icons/Historique orange.svg',
            inactiveIcon: 'assets/icons/Historique.svg',
            label: 'Historique',
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required String icon,
    required String inactiveIcon,
    required String label,
  }) {
    final isSelected = currentIndex == index;
    
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingSmall,
          vertical: AppConstants.paddingSmall,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.lightOrange : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  isSelected ? icon : inactiveIcon,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    isSelected ? AppTheme.primaryOrange : AppTheme.textGray,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? AppTheme.primaryOrange : AppTheme.textGray,
              ),
            ),
            if (isSelected)
              Container(
                margin: const EdgeInsets.only(top: 1),
                width: 16,
                height: 2,
                decoration: BoxDecoration(
                  color: AppTheme.primaryOrange,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
