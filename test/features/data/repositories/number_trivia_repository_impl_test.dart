import 'package:dartz/dartz.dart';
import 'package:flutter_tdd/core/error/exceptions.dart';
import 'package:flutter_tdd/core/error/failures.dart';
import 'package:flutter_tdd/core/network/network_info.dart';
import 'package:flutter_tdd/features/number_trivia/data/data_sources/local_datasource.dart';
import 'package:flutter_tdd/features/number_trivia/data/data_sources/number_trivia_remote_datasources.dart';
import 'package:flutter_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_tdd/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:flutter_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDatasource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late NumberTriviaRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  const tNumber = 4;
  const tNumberTriviaModel = NumberTriviaModel(text: 'Test', number: tNumber);

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
      remoteDataSource: mockRemoteDataSource,
    );

    when(() => mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel))
        .thenAnswer((_) async => {});
  });

  group('get Concrete number trivia', () {
    const NumberTrivia tNumberTrivia = tNumberTriviaModel;
    test(
      'should check whether user is online',
      () async {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.getConcreteNumberTrivia(any()))
            .thenAnswer((_) async => tNumberTriviaModel);

        await repository.getConcreteNumberTrivia(tNumber);

        verify(() => mockNetworkInfo.isConnected);
      },
    );

    group(
      'device is online',
      () {
        setUp(() {
          when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        });
        test('should return remote data when call to remote data is succesfull',
            () async {
          when(() => mockRemoteDataSource.getConcreteNumberTrivia(any()))
              .thenAnswer((_) async => tNumberTriviaModel);
          final result = await repository.getConcreteNumberTrivia(tNumber);

          verify(() => mockRemoteDataSource.getConcreteNumberTrivia(tNumber));

          expect(result, const Right(tNumberTrivia));
        });

        test('should cache data locally when call to remote data is succesfull',
            () async {
          when(() => mockRemoteDataSource.getConcreteNumberTrivia(any()))
              .thenAnswer((_) async => tNumberTriviaModel);
          await repository.getConcreteNumberTrivia(tNumber);

          verify(() => mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
          verify(
              () => mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
        });

        test(
            'should return serverFailure when call to remote data is unsuccesfull',
            () async {
          when(() => mockRemoteDataSource.getConcreteNumberTrivia(any()))
              .thenThrow(ServerException());
          final result = await repository.getConcreteNumberTrivia(tNumber);

          verify(() => mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, Left(ServerFailure()));
        });
      },
    );
    group(
      'device is offline',
      () {
        setUp(() {
          when(() => mockNetworkInfo.isConnected)
              .thenAnswer((_) async => false);
        });

        test(
          'should return last locally saved data when cached data is present',
          () async {
            when(() => mockLocalDataSource.getLastNumberTrivia())
                .thenAnswer((_) async => tNumberTriviaModel);
            final result = await repository.getConcreteNumberTrivia(tNumber);
            verifyZeroInteractions(mockRemoteDataSource);
            verify(() => mockLocalDataSource.getLastNumberTrivia());
            expect(result, const Right(tNumberTrivia));
          },
        );

        test(
          'should return cache failure when cached data is NOT present',
          () async {
            when(() => mockLocalDataSource.getLastNumberTrivia())
                .thenThrow(CacheException());
            final result = await repository.getConcreteNumberTrivia(tNumber);
            verifyZeroInteractions(mockRemoteDataSource);
            verify(() => mockLocalDataSource.getLastNumberTrivia());
            expect(result, Left(CacheFailure()));
          },
        );
      },
    );
  });

  group('get Random number trivia', () {
    const NumberTrivia tNumberTrivia = tNumberTriviaModel;
    test(
      'should check whether user is online',
      () async {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);

        await repository.getRandomNumberTrivia();

        verify(() => mockNetworkInfo.isConnected);
      },
    );

    group(
      'device is online',
      () {
        setUp(() {
          when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        });
        test('should return remote data when call to remote data is succesfull',
            () async {
          when(() => mockRemoteDataSource.getRandomNumberTrivia())
              .thenAnswer((_) async => tNumberTriviaModel);
          final result = await repository.getRandomNumberTrivia();

          verify(() => mockRemoteDataSource.getRandomNumberTrivia());

          expect(result, const Right(tNumberTrivia));
        });

        test('should cache data locally when call to remote data is succesfull',
            () async {
          when(() => mockRemoteDataSource.getRandomNumberTrivia())
              .thenAnswer((_) async => tNumberTriviaModel);
          await repository.getRandomNumberTrivia();

          verify(() => mockRemoteDataSource.getRandomNumberTrivia());
          verify(
              () => mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
        });

        test(
            'should return serverFailure when call to remote data is unsuccesfull',
            () async {
          when(() => mockRemoteDataSource.getRandomNumberTrivia())
              .thenThrow(ServerException());
          final result = await repository.getRandomNumberTrivia();

          verify(() => mockRemoteDataSource.getRandomNumberTrivia());
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, Left(ServerFailure()));
        });
      },
    );
    group(
      'device is offline',
      () {
        setUp(() {
          when(() => mockNetworkInfo.isConnected)
              .thenAnswer((_) async => false);
        });

        test(
          'should return last locally saved data when cached data is present',
          () async {
            when(() => mockLocalDataSource.getLastNumberTrivia())
                .thenAnswer((_) async => tNumberTriviaModel);
            final result = await repository.getRandomNumberTrivia();
            verifyZeroInteractions(mockRemoteDataSource);
            verify(() => mockLocalDataSource.getLastNumberTrivia());
            expect(result, const Right(tNumberTrivia));
          },
        );

        test(
          'should return cache failure when cached data is NOT present',
          () async {
            when(() => mockLocalDataSource.getLastNumberTrivia())
                .thenThrow(CacheException());
            final result = await repository.getRandomNumberTrivia();
            verifyZeroInteractions(mockRemoteDataSource);
            verify(() => mockLocalDataSource.getLastNumberTrivia());
            expect(result, Left(CacheFailure()));
          },
        );
      },
    );
  });
}
