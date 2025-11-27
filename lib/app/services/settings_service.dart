import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/app_color.dart';
import '../../common/ui.dart';
import '../models/address_model.dart';
import '../models/setting_model.dart';
import '../repositories/setting_repository.dart';

class SettingsService extends GetxService {
  final setting = Setting().obs;
  final address = Address().obs;
  late GetStorage _box;

  late SettingRepository _settingsRepo;

  SettingsService() {
    _settingsRepo = new SettingRepository();
    _box = new GetStorage();
  }

  Future<SettingsService> init() async {
    address.listen((Address _address) {
      _box.write('current_address', _address.toJson());
    });
    setting.value = await _settingsRepo.get();
    setting.value.modules = await _settingsRepo.getModules();
    return this;
  }

  ThemeData getLightTheme() {
    // TODO change font dynamically
    return ThemeData(
        primaryColor: AppColor.scaffoldBackgroundLight,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            elevation: 0, foregroundColor: AppColor.white),
        scaffoldBackgroundColor: AppColor.scaffoldBackgroundLight,
        brightness: Brightness.light,
        dividerColor:
            Ui.parseColor(setting.value.accentColor ?? '#000000', opacity: 0.1),
        focusColor: Ui.parseColor(setting.value.accentColor ?? '#000000'),
        hintColor: Ui.parseColor(setting.value.secondColor ?? '#000000'),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: AppColor.primary),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primary,
            foregroundColor: Colors.white,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColor.primary,
            side: BorderSide(color: AppColor.primary),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: AppColor.primary,
            foregroundColor: Colors.white,
          ),
        ),
        colorScheme: ColorScheme.light(
          primary: AppColor.primary,
          secondary: AppColor.primary,
        ),
        textTheme: GoogleFonts.getTextTheme(
          _getLocale().startsWith('ar') ? 'Cairo' : 'Poppins',
          TextTheme(
            titleLarge: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w700,
                color: Ui.parseColor(setting.value.mainColor ?? '#000000'),
                height: 1.2),
            headlineSmall: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                color: Ui.parseColor(setting.value.secondColor ?? '#000000'),
                height: 1.2),
            headlineMedium: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: Ui.parseColor(setting.value.secondColor ?? '#000000'),
                height: 1.3),
            displaySmall: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Ui.parseColor(setting.value.secondColor ?? '#000000'),
                height: 1.3),
            displayMedium: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
                color: Ui.parseColor(setting.value.mainColor ?? '#000000'),
                height: 1.4),
            displayLarge: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w300,
                color: Ui.parseColor(setting.value.secondColor ?? '#000000'),
                height: 1.4),
            titleSmall: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                color: Ui.parseColor(setting.value.secondColor ?? '#000000'),
                height: 1.2),
            titleMedium: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
                color: Ui.parseColor(setting.value.mainColor ?? '#000000'),
                height: 1.2),
            bodyMedium: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                color: Ui.parseColor(setting.value.secondColor ?? '#000000'),
                height: 1.2),
            bodyLarge: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: Ui.parseColor(setting.value.secondColor ?? '#000000'),
                height: 1.2),
            bodySmall: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w300,
                color: Ui.parseColor(setting.value.accentColor ?? '#000000'),
                height: 1.2),
          ),
        ));
  }

  ThemeData getDarkTheme() {
    // TODO change font dynamically
    return ThemeData(
        primaryColor: AppColor.primaryBackgroundDark,
        floatingActionButtonTheme: FloatingActionButtonThemeData(elevation: 0),
        scaffoldBackgroundColor: AppColor.scaffoldBackgroundDark,
        brightness: Brightness.dark,
        dividerColor: Ui.parseColor(setting.value.accentDarkColor ?? '#000000',
            opacity: 0.1),
        focusColor: Ui.parseColor(setting.value.accentDarkColor ?? '#000000'),
        hintColor: Ui.parseColor(setting.value.secondDarkColor ?? '#000000'),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: AppColor.primary),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primary,
            foregroundColor: Colors.white,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColor.primary,
            side: BorderSide(color: AppColor.primary),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: AppColor.primary,
            foregroundColor: Colors.white,
          ),
        ),
        colorScheme: ColorScheme.dark(
          primary: AppColor.primary,
          secondary: AppColor.primary,
        ),
        textTheme: GoogleFonts.getTextTheme(
            _getLocale().startsWith('ar') ? 'Cairo' : 'Poppins',
            TextTheme(
              titleLarge: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                  color:
                      Ui.parseColor(setting.value.mainDarkColor ?? '#000000'),
                  height: 1.2),
              headlineSmall: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color:
                      Ui.parseColor(setting.value.secondDarkColor ?? '#000000'),
                  height: 1.2),
              headlineMedium: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color:
                      Ui.parseColor(setting.value.secondDarkColor ?? '#000000'),
                  height: 1.3),
              displaySmall: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color:
                      Ui.parseColor(setting.value.secondDarkColor ?? '#000000'),
                  height: 1.3),
              displayMedium: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                  color:
                      Ui.parseColor(setting.value.mainDarkColor ?? '#000000'),
                  height: 1.4),
              displayLarge: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w300,
                  color:
                      Ui.parseColor(setting.value.secondDarkColor ?? '#000000'),
                  height: 1.4),
              titleSmall: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  color:
                      Ui.parseColor(setting.value.secondDarkColor ?? '#000000'),
                  height: 1.2),
              titleMedium: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  color:
                      Ui.parseColor(setting.value.mainDarkColor ?? '#000000'),
                  height: 1.2),
              bodyMedium: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                  color:
                      Ui.parseColor(setting.value.secondDarkColor ?? '#000000'),
                  height: 1.2),
              bodyLarge: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color:
                      Ui.parseColor(setting.value.secondDarkColor ?? '#000000'),
                  height: 1.2),
              bodySmall: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w300,
                  color:
                      Ui.parseColor(setting.value.accentDarkColor ?? '#000000'),
                  height: 1.2),
            )),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return Ui.parseColor(setting.value.mainDarkColor ?? '#000000');
            }
            return null;
          }),
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return Ui.parseColor(setting.value.mainDarkColor ?? '#000000');
            }
            return null;
          }),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return Ui.parseColor(setting.value.mainDarkColor ?? '#000000');
            }
            return null;
          }),
          trackColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            if (states.contains(MaterialState.selected)) {
              return Ui.parseColor(setting.value.mainDarkColor ?? '#000000');
            }
            return null;
          }),
        ));
  }

  String _getLocale() {
    String? _locale = GetStorage().read<String>('language');
    if (_locale == null || _locale.isEmpty) {
      _locale = setting.value.mobileLanguage;
    }
    return _locale ?? 'en';
  }

  ThemeMode getThemeMode() {
    String? _themeMode = GetStorage().read<String>('theme_mode');
    switch (_themeMode) {
      case 'ThemeMode.light':
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.light
              .copyWith(systemNavigationBarColor: AppColor.white),
        );
        return ThemeMode.light;
      case 'ThemeMode.dark':
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.dark
              .copyWith(systemNavigationBarColor: AppColor.textBlack),
        );
        return ThemeMode.dark;
      case 'ThemeMode.system':
        return ThemeMode.system;
      default:
        if (setting.value.defaultTheme == "dark") {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle.dark
                .copyWith(systemNavigationBarColor: AppColor.textBlack),
          );
          return ThemeMode.dark;
        } else {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle.light
                .copyWith(systemNavigationBarColor: AppColor.white),
          );
          return ThemeMode.light;
        }
    }
  }
}
