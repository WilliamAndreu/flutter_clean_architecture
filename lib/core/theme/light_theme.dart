import 'package:material_color_utilities/palettes/core_palette.dart';
import 'package:material_color_utilities/scheme/scheme.dart';
import 'package:rickmorty/core/theme/base_theme.dart';

class LightTheme {
  Scheme scheme({required BaseTheme baseTheme}) {
    final base = CorePalette.of(baseTheme.primaryColor.value);
    final primary = base.primary;
    final tertiary = CorePalette.of(baseTheme.tertiaryColor.value).primary;
    final neutral = CorePalette.of(baseTheme.neutralColor.value).neutral;
    return Scheme(
      primary: primary.get(40),
      onPrimary: primary.get(100),
      primaryContainer: primary.get(90),
      onPrimaryContainer: primary.get(10),
      secondary: base.secondary.get(40),
      onSecondary: base.secondary.get(100),
      secondaryContainer: base.secondary.get(90),
      onSecondaryContainer: base.secondary.get(10),
      tertiary: tertiary.get(40),
      onTertiary: tertiary.get(100),
      tertiaryContainer: tertiary.get(90),
      onTertiaryContainer: tertiary.get(10),
      error: base.error.get(40),
      onError: base.error.get(100),
      errorContainer: base.error.get(90),
      onErrorContainer: base.error.get(10),
      background: neutral.get(98),
      onBackground: neutral.get(6),
      surface: neutral.get(99),
      onSurface: neutral.get(10),
      outline: base.neutralVariant.get(50),
      outlineVariant: base.neutralVariant.get(80),
      surfaceVariant: base.neutralVariant.get(90),
      onSurfaceVariant: base.neutralVariant.get(30),
      shadow: neutral.get(0),
      scrim: neutral.get(0),
      inverseSurface: neutral.get(20),
      inverseOnSurface: neutral.get(95),
      inversePrimary: primary.get(40),
    );
  }
}
