import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ieee_mvp/core/errors/failure.dart';
import 'package:ieee_mvp/features/home/domain/entities/provider.dart';
import 'package:ieee_mvp/features/home/domain/repos/home_repo.dart';
import 'package:mockito/mockito.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  GetAllProviders usecase;
  MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    usecase = GetAllProviders(mockHomeRepository);
  });

  final tNumberTrivia =
      Provider(name: 'test name', mobile: 'test mobile', location: 'test location');

  test(
    'should get all providers',
    () async {
      // "On the fly" implementation of the Repository using the Mockito package.
      // When getConcreteNumberTrivia is called with any argument, always answer with
      // the Right "side" of Either containing a test NumberTrivia object.
      when(mockHomeRepository.getAllProviders())
          .thenAnswer((_) async => Right(tNumberTrivia));
      // The "act" phase of the test. Call the not-yet-existent method.
      final result = await usecase.execute();
      // UseCase should simply return whatever was returned from the Repository
      expect(result, Right(tNumberTrivia));
      // Verify that the method has been called on the Repository
      verify(mockHomeRepository.getAllProviders());
      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockHomeRepository);
    },
  );
}

class GetAllProviders {
  final HomeRepository repository;

  GetAllProviders(this.repository);

  Future<Either<Failure, Provider>> execute() async {
    return await repository.getAllProviders();
  }
}
