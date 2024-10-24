import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eunoia_chat_application/core/response/response.dart';
import 'package:eunoia_chat_application/features/contact/data/datasources/contact_remote_data_source.dart';
import 'package:eunoia_chat_application/features/contact/domain/entities/contact.dart';
import 'package:eunoia_chat_application/features/contact/domain/entities/helper/get_contacts_helper.dart';
import 'package:eunoia_chat_application/features/contact/domain/repositories/contact_repository.dart';

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
}
