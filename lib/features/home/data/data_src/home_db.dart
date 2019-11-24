import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

// Moor works by source gen. This file will all the generated code.
part 'home_db.g.dart';

@DataClassName('ProvidersTable')

class Providers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get long => text().withLength(min: 1, max: 100)();
  TextColumn get lat => text().withLength(min: 1, max: 100)();
  TextColumn get location => text().withLength(min: 1, max: 100)();
  TextColumn get mobile => text().withLength(min: 1, max: 20)();

  @override
  Set<Column> get primaryKey => {id};
}

@UseMoor(tables: [Providers], daos: [ProviderDao])

@UseDao(tables: [Providers])
class ProviderDao extends DatabaseAccessor<AppDatabase> with _$ProviderDaoMixin {
  final AppDatabase db;

  // Called by the AppDatabase class
  ProviderDao(this.db) : super(db);

  Future<List<ProvidersTable>> getAllProviders() => select(providers).get();

  Stream<List<ProvidersTable>> watchAllProviders() => select(providers).watch();

  Stream<List<ProvidersTable>> watchAllTasks() {
    // Wrap the whole select statement in parenthesis
    return (select(providers)
    // Statements like orderBy and where return void => the need to use a cascading ".." operator
      ..orderBy(
        ([
          // Primary sorting by id TODO change it
              (t) =>
              OrderingTerm(expression: t.id, mode: OrderingMode.asc),
          // Secondary alphabetical sorting
              (t) => OrderingTerm(expression: t.name),
        ]),
      ))
    // watch the whole select statement
        .watch();
  }

  Future insertProvider(Insertable<ProvidersTable> provider) => into(providers).insert(provider);
  Future updateProvider(Insertable<ProvidersTable> provider) => update(providers).replace(provider);
  Future deleteProvider(Insertable<ProvidersTable> provider) => delete(providers).delete(provider);
}

///
//@DataClassName('OrdersTable')
//class Orders extends Table {
//  IntColumn get id => integer().autoIncrement()();
//  DateTimeColumn get date => dateTime().nullable()();
//  RealColumn get price => real()();
//
//  @override
//  Set<Column> get primaryKey => {id};
//}
//
//@UseMoor(tables: [Orders], daos: [OrdersDao])
//
//@UseDao(tables: [Orders])
//class OrderDao extends DatabaseAccessor<AppDatabase> with _$OrderDaoMixin {
//  final AppDatabase db;
//
//  // Called by the AppDatabase class
//  OrderDao(this.db) : super(db);
//
//  Future<List<OrdersTable>> getAllProviders() => select(orders).get();
//
//  Stream<List<OrdersTable>> watchAllProviders() => select(orders).watch();
//
//  Stream<List<OrdersTable>> watchAllTasks() {
//    // Wrap the whole select statement in parenthesis
//    return (select(orders)
//    // Statements like orderBy and where return void => the need to use a cascading ".." operator
//      ..orderBy(
//        ([
//          // Primary sorting by id TODO change it
//              (t) =>
//              OrderingTerm(expression: t.id, mode: OrderingMode.asc),
//          // Secondary alphabetical sorting
//              (t) => OrderingTerm(expression: t.name),
//        ]),
//      ))
//    // watch the whole select statement
//        .watch();
//  }
//
//  Future insertOrder(Insertable<OrdersTable> order) => into(orders).insert(order);
//  Future updateOrder(Insertable<OrdersTable> order) => update(orders).replace(order);
//  Future deleteOrder(Insertable<OrdersTable> order) => delete(orders).delete(order);
//}
///

class AppDatabase extends _$AppDatabase {
  AppDatabase()
  // Specify the location of the database file
      : super((FlutterQueryExecutor.inDatabaseFolder(
    path: 'db.sqlite',
    // Good for debugging - prints SQL in the console
    logStatements: true,
  )));

  @override
  int get schemaVersion => 3;
}

//flutter packages pub run build_runner watch