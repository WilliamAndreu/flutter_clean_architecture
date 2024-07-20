import 'package:material_color_utilities/palettes/core_palette.dart';
import 'package:material_color_utilities/scheme/scheme.dart';
import 'package:rickmorty/core/theme/base_theme.dart';

class DarkTheme {
  Scheme scheme({required BaseTheme baseTheme}) {
    final base = CorePalette.of(baseTheme.primaryColor.value);
    final primary = base.primary;
    final tertiary = CorePalette.of(baseTheme.tertiaryColor.value).primary;
    final neutral = CorePalette.of(baseTheme.neutralColor.value).neutral;
    return Scheme(
      primary: primary.get(80),
      onPrimary: primary.get(100),
      primaryContainer: primary.get(100),
      onPrimaryContainer: primary.get(90),
      secondary: base.secondary.get(80),
      onSecondary: base.secondary.get(100),
      secondaryContainer: base.secondary.get(30),
      onSecondaryContainer: base.secondary.get(90),
      tertiary: tertiary.get(80),
      onTertiary: tertiary.get(20),
      tertiaryContainer: tertiary.get(30),
      onTertiaryContainer: tertiary.get(90),
      surface: neutral.get(10),
      onSurface: neutral.get(90),
      background: neutral.get(6),
      onBackground: neutral.get(90),
      error: base.error.get(80),
      onError: base.error.get(20),
      errorContainer: base.error.get(30),
      onErrorContainer: base.error.get(90),
      outline: base.neutralVariant.get(60),
      outlineVariant: base.neutralVariant.get(30),
      surfaceVariant: base.neutralVariant.get(30),
      onSurfaceVariant: base.neutralVariant.get(80),
      shadow: neutral.get(0),
      scrim: neutral.get(0),
      inverseSurface: neutral.get(90),
      inverseOnSurface: neutral.get(20),
      inversePrimary: primary.get(100),
    );
  }
}
