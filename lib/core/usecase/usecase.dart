import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/core/response/response.dart';

abstract class Usecase<T, A> {
  Future<Either<ResponseI, T>> call(A params);
}
