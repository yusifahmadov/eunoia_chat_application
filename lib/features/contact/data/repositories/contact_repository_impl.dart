import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/response/response.dart';
import '../../../user/data/models/user_model.dart';
import '../../domain/entities/contact.dart';
import '../../domain/entities/helper/get_contacts_helper.dart';
import '../../domain/repositories/contact_repository.dart';
import '../datasources/contact_remote_data_source.dart';

class ContactRepositoryImpl implements ContactRepository {
  ContactRemoteDataSource contactRemoteDataSource;

  ContactRepositoryImpl({required this.contactRemoteDataSource});

  @override
  Future<Either<ResponseI, List<EunoiaContact>>> getContacts(
      {required GetContactsHelper body}) async {
    try {
      return Right(await contactRemoteDataSource.getContacts(body: body));
    } on DioException catch (e) {
      return Left(ResponseI(message: e.response.toString()));
    }
  }

  @override
  Future<Either<ResponseI, int>> checkContact({required String contactId}) async {
    try {
      return Right(await contactRemoteDataSource.checkContact(contactId: contactId));
    } on DioException catch (e) {
      return Left(ResponseI(message: e.response.toString()));
    }
  }

  @override
  Future<Either<ResponseI, List<UserModel>>> searchContacts(
      {required GetContactsHelper body}) async {
    try {
      return Right(await contactRemoteDataSource.searchContacts(body: body));
    } on DioException catch (e) {
      return Left(ResponseI(message: e.response.toString()));
    }
  }
}
