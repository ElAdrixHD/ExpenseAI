import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:nylo_framework/nylo_framework.dart';

/// Analytics Service for tracking user events and behaviors
class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  static final FirebaseAnalyticsObserver _observer =
      FirebaseAnalyticsObserver(analytics: _analytics);

  /// Firebase Analytics Observer for navigation tracking
  static FirebaseAnalyticsObserver get observer => _observer;

  /// Set user ID for analytics tracking
  static Future<void> setUserId(String userId) async {
    try {
      await _analytics.setUserId(id: userId);
    } catch (e) {
      NyLogger.error('Failed to set user ID: $e');
    }
  }

  /// Set user properties
  static Future<void> setUserProperty({
    required String name,
    required String value,
  }) async {
    try {
      await _analytics.setUserProperty(name: name, value: value);
    } catch (e) {
      NyLogger.error('Failed to set user property: $e');
    }
  }

  /// Track user login event
  static Future<void> trackLogin({String? method}) async {
    try {
      await _analytics.logLogin(loginMethod: method ?? 'email');
    } catch (e) {
      NyLogger.error('Failed to track login: $e');
    }
  }

  /// Track user logout event
  static Future<void> trackLogout() async {
    try {
      await _analytics.logEvent(
        name: 'logout',
        parameters: {
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );
    } catch (e) {
      NyLogger.error('Failed to track logout: $e');
    }
  }

  /// Track receipt capture event
  static Future<void> trackReceiptCapture({
    String? source, // 'camera' or 'gallery'
    String? receiptId,
  }) async {
    try {
      await _analytics.logEvent(
        name: 'receipt_capture',
        parameters: {
          'source': source ?? 'unknown',
          'receipt_id': receiptId ?? 'unknown',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );
    } catch (e) {
      NyLogger.error('Failed to track receipt capture: $e');
    }
  }

  /// Track expense added event
  static Future<void> trackExpenseAdded({
    double? amount,
    String? category,
    String? currency,
    String? source,
  }) async {
    try {
      await _analytics.logEvent(
        name: 'expense_added',
        parameters: {
          'amount': amount ?? 0.0,
          'category': category ?? 'unknown',
          'currency': currency ?? 'USD',
          'source': source ?? 'manual', // 'receipt', 'manual'
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );
    } catch (e) {
      NyLogger.error('Failed to track expense added: $e');
    }
  }

  /// Track search query event
  static Future<void> trackSearch({
    required String query,
    String? category,
    int? resultsCount,
  }) async {
    try {
      await _analytics.logSearch(
        searchTerm: query,
        parameters: {
          'numberOfItems': resultsCount ?? '',
          'contentType': category ?? 'expense'
        },
      );
    } catch (e) {
      NyLogger.error('Failed to track search: $e');
    }
  }

  /// Track screen view event
  static Future<void> trackScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    try {
      await _analytics.logScreenView(
        screenName: screenName,
        screenClass: screenClass ?? screenName,
      );
    } catch (e) {
      NyLogger.error('Failed to track screen view: $e');
    }
  }

  /// Track custom event
  static Future<void> trackEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    try {
      await _analytics.logEvent(
        name: name,
        parameters: parameters,
      );
    } catch (e) {
      NyLogger.error('Failed to track event: $e');
    }
  }

  /// Track expense export event
  static Future<void> trackExpenseExport({
    String? format, // 'pdf', 'csv', 'excel'
    int? itemCount,
    String? dateRange,
  }) async {
    try {
      await _analytics.logEvent(
        name: 'expense_export',
        parameters: {
          'format': format ?? 'unknown',
          'item_count': itemCount ?? 0,
          'date_range': dateRange ?? 'unknown',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );
    } catch (e) {
      NyLogger.error('Failed to track expense export: $e');
    }
  }

  /// Track dashboard view with filters
  static Future<void> trackDashboardView({
    String? filterType,
    String? timeRange,
  }) async {
    try {
      await _analytics.logEvent(
        name: 'dashboard_view',
        parameters: {
          'filter_type': filterType ?? 'all',
          'time_range': timeRange ?? 'month',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );
    } catch (e) {
      NyLogger.error('Failed to track dashboard view: $e');
    }
  }

  /// Track OCR processing event
  static Future<void> trackOCRProcessing({
    bool? success,
    String? receiptId,
    int? processingTimeMs,
    String? errorMessage,
  }) async {
    try {
      await _analytics.logEvent(
        name: 'ocr_processing',
        parameters: {
          'success': success ?? false,
          'receipt_id': receiptId ?? 'unknown',
          'processing_time_ms': processingTimeMs ?? 0,
          'error_message': errorMessage ?? '',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );
    } catch (e) {
      NyLogger.error('Failed to track OCR processing: $e');
    }
  }

  /// Track user engagement events
  static Future<void> trackEngagement({
    required String action, // 'scroll', 'tap', 'swipe'
    String? screen,
    String? element,
  }) async {
    try {
      await _analytics.logEvent(
        name: 'user_engagement',
        parameters: {
          'action': action,
          'screen': screen ?? 'unknown',
          'element': element ?? 'unknown',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );
    } catch (e) {
      NyLogger.error('Failed to track engagement: $e');
    }
  }

  /// Track app performance metrics
  static Future<void> trackPerformance({
    required String metric, // 'load_time', 'api_response_time'
    required int value,
    String? screen,
  }) async {
    try {
      await _analytics.logEvent(
        name: 'performance_metric',
        parameters: {
          'metric': metric,
          'value': value,
          'screen': screen ?? 'unknown',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );
    } catch (e) {
      NyLogger.error('Failed to track performance: $e');
    }
  }
}
