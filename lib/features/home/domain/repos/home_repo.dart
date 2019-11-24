import 'package:dartz/dartz.dart';
import 'package:ieee_mvp/core/errors/failure.dart';
import 'package:ieee_mvp/features/home/domain/entities/order.dart' as entity;
import 'package:ieee_mvp/features/home/domain/entities/provider.dart';

abstract class HomeRepository {
  Future<Either<Failure, Provider>> getAllProviders();
  Future<Either<Failure, entity.Order>> getAllOrders();
}