import 'package:flutter/material.dart';
import '../core/app_export.dart';

extension on TextStyle {
  TextStyle get roboto {
    return copyWith(
      fontFamily: 'Roboto',
    );
  }

  TextStyle get leagueSpartan {
    return copyWith(
      fontFamily: 'League Spartan',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get pTSerif {
    return copyWith(
      fontFamily: 'PT Serif',
    );
  }

  TextStyle get nunitoSans {
    return copyWith(
      fontFamily: 'Nunito Sans',
    );
  }

  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }

  TextStyle get workSans {
    return copyWith(
      fontFamily: 'Work Sans',
    );
  }
}

class CustomTextStyle {
  // Body text styles
  static get bodyLargeLeagueSpartanPrimaryContainer =>
      theme.textTheme.bodyLarge!.leagueSpartan.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontSize: 18.fSize,
      );
  static get bodyLargePoppinsOnPrimary =>
      theme.textTheme.bodyLarge!.poppins.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  static get bodyLargeRedA700 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.redA700,
      );
  static get bodyMediumErrorContainer => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.errorContainer,
        fontSize: 13.fSize,
        fontWeight: FontWeight.w300,
      );
  static get bodyMediumOnPrimary => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        fontSize: 13.fSize,
        fontWeight: FontWeight.w300,
      );
  static get bodyMediumOnPrimaryLight => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        fontSize: 13.fSize,
        fontWeight: FontWeight.w300,
      );
  static get bodyMediumPoppinsBlueA700 =>
      theme.textTheme.bodyMedium!.poppins.copyWith(
        color: appTheme.blueA700,
        fontSize: 13.fSize,
        fontWeight: FontWeight.w300,
      );
  static get bodyMediumPoppinsOnPrimary =>
      theme.textTheme.bodyMedium!.poppins.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        fontSize: 13.fSize,
        fontWeight: FontWeight.w300,
      );
  static get bodyMediumPoppinsOnPrimaryLight =>
      theme.textTheme.bodyMedium!.poppins.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        fontSize: 13.fSize,
        fontWeight: FontWeight.w300,
      );
  static get bodyMediumPoppinsTela900 =>
      theme.textTheme.bodyMedium!.poppins.copyWith(
        color: appTheme.teal900,
        fontSize: 13.fSize,
        fontWeight: FontWeight.w300,
      );
  static get bodyMediumRobotoBlack900 =>
      theme.textTheme.bodyMedium!.roboto.copyWith(
        color: appTheme.black900,
        fontSize: 13.fSize,
      );
  static get bodyMediumRobotalack900Light =>
      theme.textTheme.bodyMedium!.roboto.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w300,
      );
  static get bodyMediumRobotoGray600 =>
      theme.textTheme.bodyMedium!.roboto.copyWith(
        color: appTheme.gray600,
        fontSize: 13.fSize,
      );
  static get bodySmall10 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 10.fSize,
      );
  static get bodySmallRobotoBlack900 =>
      theme.textTheme.bodySmall!.roboto.copyWith(
        color: appTheme.black900,
      );
  static get bodySmallRobotoBlack900Light =>
      theme.textTheme.bodySmall!.roboto.copyWith(
        color: appTheme.black900,
        fontSize: 10.fSize,
        fontWeight: FontWeight.w300,
      );
  static get bodySmallRobotoBlack900_1 =>
      theme.textTheme.bodySmall!.roboto.copyWith(
        color: appTheme.black900,
      );
  static get bodySmallRobotoGray600 =>
      theme.textTheme.bodySmall!.roboto.copyWith(
        color: appTheme.gray600,
        fontWeight: FontWeight.w300,
      );
  static get bodySmallRobotoOnPrimaryContainer =>
      theme.textTheme.bodySmall!.roboto.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );
  static get bodySmallWorkSans8lack900 =>
      theme.textTheme.bodySmall!.workSans.copyWith(
        color: appTheme.black900,
      );
  // Label text style
  static get labelLargeBlack900 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w800,
      );

  static get labelLargePoppinsOnPrimary =>
      theme.textTheme.labelLarge!.poppins.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        fontSize: 13.fSize,
        fontWeight: FontWeight.w600,
      );
  static get labelLargePoppinsOnPrimarySemi8old =>
      theme.textTheme.labelLarge!.poppins.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        fontSize: 13.fSize,
        fontWeight: FontWeight.w600,
      );
// Title text style
  static get titleLargeNunitoSansBlack900 =>
      theme.textTheme.titleLarge!.nunitoSans.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w700,
      );
  static get titleLargeOnPrimary => theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        fontWeight: FontWeight.w600,
      );
  static get titleLargeOnPrimaryBold => theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        fontWeight: FontWeight.w700,
      );
  static get titleLargePTSerifOnPrimary =>
      theme.textTheme.titleLarge!.pTSerif.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        fontWeight: FontWeight.w400,
      );
  static get titleLargeTeal900 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.teal900,
        fontWeight: FontWeight.w600,
      );
  static get titleMedium18 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18.fSize,
      );
  static get titleMediumInterBluegray400 =>
      theme.textTheme.titleMedium!.inter.copyWith(
        color: appTheme.blueGray400,
      );
  static get titleMediumInterBluegray400_1 =>
      theme.textTheme.titleMedium!.inter.copyWith(
        color: appTheme.blueGray400,
      );
  static get titleMediumPTSerifBlack900 =>
      theme.textTheme.titleMedium!.pTSerif.copyWith(
        color: appTheme.black900.withOpacity(0.96),
      );
  static get titleMediumPoppinsOnPrimary =>
      theme.textTheme.titleMedium!.poppins.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        fontSize: 18.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallBlueA700 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueA700,
        fontSize: 14.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallLeagueSpartan =>
      theme.textTheme.titleSmall!.leagueSpartan.copyWith(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallOnErrorContainer => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onErrorContainer,
      );
  static get titleSmallPTSerifOnPrimaryContainer =>
      theme.textTheme.titleSmall!.pTSerif.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontSize: 14.fSize,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallTeal900 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.teal900,
        fontSize: 14.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallTeal900SemiBold => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.teal900,
        fontSize: 14.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallTeal900SemiBold1 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.teal900,
        fontSize: 12.fSize,
        fontWeight: FontWeight.w600,
      );
}
