import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_tdd/core/network/network_info.dart';

class MockInternetConnChecker extends Mock
    implements InternetConnectionChecker {}

void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockInternetConnChecker mockInternetConnChecker;
  setUp(() {
    mockInternetConnChecker = MockInternetConnChecker();
    networkInfoImpl = NetworkInfoImpl(mockInternetConnChecker);
  });

  group(
    'isConnected',
    () {
      test(
          'should forward the call to Internet connection checker . hasConnection',
          () async {
        final tHasConnectionfFuture = Future.value(true);

        when(() => mockInternetConnChecker.hasConnection)
            .thenAnswer((_) => tHasConnectionfFuture);

        final result = networkInfoImpl.isConnected;

        verify(() => mockInternetConnChecker.hasConnection);
        expect(result, tHasConnectionfFuture);
      });

      test(
          'should not forward the call to Internet connection checker . hasConnection',
          () async {
        final tHasConnectionfFuture = Future.value(false);

        when(() => mockInternetConnChecker.hasConnection)
            .thenAnswer((_) => tHasConnectionfFuture);

        final result = networkInfoImpl.isConnected;

        verify(() => mockInternetConnChecker.hasConnection);
        expect(result, tHasConnectionfFuture);
      });
    },
  );
}
