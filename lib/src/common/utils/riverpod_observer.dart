import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logman/logman.dart';

class RiverpodObserver extends ProviderObserver {
  final logman = Logman.instance;

  @override
  void didAddProvider(
    ProviderBase provider,
    Object? value,
    ProviderContainer container,
  ) {
    logman.info('Provider $provider was initialized with $value');
  }

  @override
  void didDisposeProvider(
    ProviderBase provider,
    ProviderContainer container,
  ) {
    logman.info('Provider $provider was disposed');
  }

  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    logman.info(
      'Provider $provider updated from $previousValue to $newValue',
    );
  }

  @override
  void providerDidFail(
    ProviderBase provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    logman.info('Provider $provider threw $error at $stackTrace');
  }
}
