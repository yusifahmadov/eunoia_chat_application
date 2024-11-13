import 'package:dartz/dartz.dart';

import '../response/response.dart';

abstract class Usecase<T, A> {
  Future<Either<ResponseI, T>> call(A params);
}
