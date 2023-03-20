import 'dart:async' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:flutter_contact/model/kontak.dart' as _i3;
import 'package:flutter_contact/database/dbhelper.dart' as _i4;
import 'package:sqflite/sqflite.dart' as _i2;

class _FakeDatabase_0 extends _i1.Fake implements _i2.Database{}
class _FakeContact_1 extends _i1.Fake implements _i3.Kontak{}

class MockContactService extends _i1.Mock implements _i4.DBHelper{
  MockContactService(){
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Database get db=> (super.noSuchMethod(Invocation.getter(#db),
  returnValue: _FakeDatabase_0()) as _i2.Database);
  @override
  set db(_i2.Database? _db) => super.noSuchMethod(Invocation.setter(#db, _db),
      returnValueForMissingStub: null);
  @override
  _i5.Future<dynamic> initialize(String? path) =>
      (super.noSuchMethod(Invocation.method(#initialize, [path]),
          returnValue: Future<dynamic>.value()) as _i5.Future<dynamic>);
  @override
  _i5.Future<int?> saveKontak(_i3.Kontak kontak) =>
      (super.noSuchMethod(Invocation.method(#insert, [kontak]),
      returnValue: Future<_i3.Kontak>.value(_FakeContact_1())));
  @override
  _i5.Future<List?> getAllContact() =>
      (super.noSuchMethod(Invocation.method(#getAllContact, []),
          returnValue: Future<List<_i3.Kontak>?>.value())
      as _i5.Future<List<_i3.Kontak>?>);
  @override
  _i5.Future<int?> delete(int id) =>
      (super.noSuchMethod(Invocation.method(#delete, [id]),
          returnValue: Future<int?>.value()) as _i5.Future<int?>);
  @override
  _i5.Future<int?> update(_i3.Kontak kontak) =>
      (super.noSuchMethod(Invocation.method(#update, [kontak]),
          returnValue: Future<int?>.value()) as _i5.Future<int?>);
}