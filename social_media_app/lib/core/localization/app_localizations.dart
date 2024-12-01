import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppLanguage {
  english,
  arabic,
  spanish
}

class AppLocalizations {
  static final Map<AppLanguage, Locale> supportedLocales = {
    AppLanguage.english: const Locale('en', 'US'),
    AppLanguage.arabic: const Locale('ar', 'SA'),
    AppLanguage.spanish: const Locale('es', 'ES'),
  };

  static Map<String, String> getTranslations(AppLanguage language) {
    switch (language) {
      case AppLanguage.english:
        return {
          'app_title': 'Omniversify',
          'home': 'Home',
          'profile': 'Profile',
          'settings': 'Settings',
          'language': 'Language',
          'theme': 'Theme',
          'privacy_policy': 'Privacy Policy',
          'licenses': 'Licenses',
          'exit': 'Exit',
          'exit_confirmation': 'Are you sure you want to exit?',
          'open_link': 'Open Link',
          'open_link_confirmation': 'Do you want to open this link in your browser?',
          'cancel': 'Cancel',
          'ok': 'OK',
          'save': 'Save',
          'delete': 'Delete',
          'edit': 'Edit',
          'share': 'Share',
          'search': 'Search',
          'notifications': 'Notifications',
          'messages': 'Messages',
          'friends': 'Friends',
          'followers': 'Followers',
          'following': 'Following',
          'posts': 'Posts',
          'comments': 'Comments',
          'likes': 'Likes',
          'about': 'About',
          'help': 'Help',
          'feedback': 'Feedback',
          'report': 'Report',
          'block': 'Block',
          'unblock': 'Unblock',
          'mute': 'Mute',
          'unmute': 'Unmute',
          'dark_mode': 'Dark Mode',
          'light_mode': 'Light Mode',
          'system_theme': 'System Theme',
          'account': 'Account',
          'security': 'Security',
          'privacy': 'Privacy',
          'logout': 'Logout',
          'login': 'Login',
          'signup': 'Sign Up',
          'forgot_password': 'Forgot Password?',
          'username': 'Username',
          'password': 'Password',
          'email': 'Email',
          'phone': 'Phone',
          'bio': 'Bio',
          'website': 'Website',
          'location': 'Location',
          'birthday': 'Birthday',
          'gender': 'Gender',
          'doom_scroll': 'Doom Scroll',
          'whats_on_your_mind': "What's on your mind?",
          'image': 'Image',
          'video': 'Video',
          'book': 'Book',
          'movie': 'Movie',
          'game': 'Game',
          'post': 'Post',
          'series': 'Series',
          'audio': 'Audio',
          'music': 'Music',
        };
      case AppLanguage.arabic:
        return {
          'app_title': ' اومنيفيرسيفي',
          'home': 'الصفحة الرئيسية',
          'profile': 'الملف الشخصي',
          'settings': 'الإعدادات',
          'language': 'اللغة',
          'theme': 'المظهر',
          'privacy_policy': 'سياسة الخصوصية',
          'licenses': 'التراخيص',
          'exit': 'خروج',
          'exit_confirmation': 'هل أنت متأكد أنك تريد الخروج؟',
          'open_link': 'فتح الرابط',
          'open_link_confirmation': 'هل تريد فتح هذا الرابط في المتصفح؟',
          'cancel': 'إلغاء',
          'ok': 'موافق',
          'save': 'حفظ',
          'delete': 'حذف',
          'edit': 'تعديل',
          'share': 'مشاركة',
          'search': 'بحث',
          'notifications': 'الإشعارات',
          'messages': 'الرسائل',
          'friends': 'الأصدقاء',
          'followers': 'المتابعون',
          'following': 'يتابع',
          'posts': 'المنشورات',
          'comments': 'التعليقات',
          'likes': 'الإعجابات',
          'about': 'حول',
          'help': 'مساعدة',
          'feedback': 'تعليقات',
          'report': 'إبلاغ',
          'block': 'حظر',
          'unblock': 'إلغاء الحظر',
          'mute': 'كتم',
          'unmute': 'إلغاء الكتم',
          'dark_mode': 'الوضع الداكن',
          'light_mode': 'الوضع الفاتح',
          'system_theme': 'مظهر النظام',
          'account': 'الحساب',
          'security': 'الأمان',
          'privacy': 'الخصوصية',
          'logout': 'تسجيل الخروج',
          'login': 'تسجيل الدخول',
          'signup': 'إنشاء حساب',
          'forgot_password': 'نسيت كلمة المرور؟',
          'username': 'اسم المستخدم',
          'password': 'كلمة المرور',
          'email': 'البريد الإلكتروني',
          'phone': 'الهاتف',
          'bio': 'نبذة',
          'website': 'الموقع الإلكتروني',
          'location': 'موقع',
          'birthday': 'تاريخ الميلاد',
          'gender': 'الجنس',
          'doom_scroll': 'تمرير الهلاك',
          'whats_on_your_mind': 'ما يدور في ذهنك؟',
          'image': 'صورة',
          'video': 'فيديو',
          'book': 'كتاب',
          'movie': 'فيلم',
          'game': 'لعبة',
          'post': 'نشر',
          'series': 'مسلسل',
          'audio': 'صوت',
          'music': 'موسيقى',
        };
      case AppLanguage.spanish:
        return {
          'app_title': 'Omniversify',
          'home': 'Inicio',
          'profile': 'Perfil',
          'settings': 'Configuración',
          'language': 'Idioma',
          'theme': 'Tema',
          'privacy_policy': 'Política de Privacidad',
          'licenses': 'Licencias',
          'exit': 'Salir',
          'exit_confirmation': '¿Estás seguro de que quieres salir?',
          'open_link': 'Abrir enlace',
          'open_link_confirmation': '¿Quieres abrir este enlace en tu navegador?',
          'cancel': 'Cancelar',
          'ok': 'Aceptar',
          'save': 'Guardar',
          'delete': 'Eliminar',
          'edit': 'Editar',
          'share': 'Compartir',
          'search': 'Buscar',
          'notifications': 'Notificaciones',
          'messages': 'Mensajes',
          'friends': 'Amigos',
          'followers': 'Seguidores',
          'following': 'Siguiendo',
          'posts': 'Publicaciones',
          'comments': 'Comentarios',
          'likes': 'Me gusta',
          'about': 'Acerca de',
          'help': 'Ayuda',
          'feedback': 'Comentarios',
          'report': 'Reportar',
          'block': 'Bloquear',
          'unblock': 'Desbloquear',
          'mute': 'Silenciar',
          'unmute': 'Activar sonido',
          'dark_mode': 'Modo oscuro',
          'light_mode': 'Modo claro',
          'system_theme': 'Tema del sistema',
          'account': 'Cuenta',
          'security': 'Seguridad',
          'privacy': 'Privacidad',
          'logout': 'Cerrar sesión',
          'login': 'Iniciar sesión',
          'signup': 'Registrarse',
          'forgot_password': '¿Olvidaste tu contraseña?',
          'username': 'Nombre de usuario',
          'password': 'Contraseña',
          'email': 'Correo electrónico',
          'phone': 'Teléfono',
          'bio': 'Biografía',
          'website': 'Sitio web',
          'location': 'Ubicación',
          'birthday': 'Cumpleaños',
          'gender': 'Género',
          'doom_scroll': 'Desplazamiento Infinito',
          'whats_on_your_mind': '¿Qué pasa por tu mente?',
          'image': 'Imagen',
          'video': 'Video',
          'book': 'Libro',
          'movie': 'Película',
          'game': 'Juego',
          'post': 'Publicar',
          'series': 'Serie',
          'audio': 'Audio',
          'music': 'Música',
        };
    }
  }
}

// Localization Provider
final localizationProvider = StateNotifierProvider<LocalizationNotifier, Locale>((ref) {
  return LocalizationNotifier();
});

class LocalizationNotifier extends StateNotifier<Locale> {
  LocalizationNotifier() : super(const Locale('en', 'US')) {
    _loadLanguageFromPrefs();
  }

  Future<void> _loadLanguageFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final languageIndex = prefs.getInt('language_mode') ?? 0;
    
    state = AppLocalizations.supportedLocales.values.elementAt(languageIndex);
  }

  void setLanguage(AppLanguage language) async {
    final prefs = await SharedPreferences.getInstance();
    
    state = AppLocalizations.supportedLocales[language]!;
    await prefs.setInt('language_mode', AppLanguage.values.indexOf(language));
  }

  String translate(BuildContext context, String key, {AppLanguage? language}) {
    final currentLanguage = language ?? AppLanguage.values[
      AppLocalizations.supportedLocales.values.toList().indexOf(state)
    ];
    
    return AppLocalizations.getTranslations(currentLanguage)[key] ?? key;
  }
}
