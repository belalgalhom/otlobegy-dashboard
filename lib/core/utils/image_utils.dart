class ImageUtils {
  static const String baseUrl = 'https://api.otlob-egy.online';

  static String formatImageUrl(String? url) {
    if (url == null || url.isEmpty) return '';
    if (url.startsWith('http')) return url;
    
    var base = baseUrl;
    if (base.endsWith('/')) {
      base = base.substring(0, base.length - 1);
    }
    
    // Ensure URL starts with /
    final path = url.startsWith('/') ? url : '/$url';
    return '$base$path';
  }
}
