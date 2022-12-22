// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'models/category.dart';
import 'models/item.dart';
import 'models/item_qty.dart';
import 'models/receipts.dart';
import 'models/settings.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 1454581974588577974),
      name: 'Category',
      lastPropertyId: const IdUid(5, 5776594166086902538),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 1402245200493208971),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(2, 4122890120377872665),
            name: 'items',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 4015180901428388142),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(5, 5776594166086902538),
            name: 'color',
            type: 6,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 2653371548284163512),
      name: 'Item',
      lastPropertyId: const IdUid(10, 5661535892374039616),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3958307507819552808),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 1155895079856093697),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 4982579105386289832),
            name: 'barcode',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 3658196232756825245),
            name: 'price',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 4921925973018533803),
            name: 'cost',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 8876581926866698635),
            name: 'stockCount',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 1686487853823481052),
            name: 'color',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 7878761970085120728),
            name: 'shape',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 7171971469928662862),
            name: 'image',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 5661535892374039616),
            name: 'categoryId',
            type: 11,
            flags: 520,
            indexId: const IdUid(1, 7057262496736662276),
            relationTarget: 'Category')
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(3, 5081414179245264874),
      name: 'ItemQty',
      lastPropertyId: const IdUid(3, 3067754426484193403),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 8975640846124225026),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 4296588769392580694),
            name: 'qty',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 3067754426484193403),
            name: 'itemId',
            type: 11,
            flags: 520,
            indexId: const IdUid(2, 7599025199795592852),
            relationTarget: 'Item')
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(4, 311949754708615431),
      name: 'Receipt',
      lastPropertyId: const IdUid(6, 2427576160433008848),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 8204403732343589214),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 4414812340080656483),
            name: 'itemCount',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 3420968320976194737),
            name: 'totalCost',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 79647245843032830),
            name: 'time',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 2427576160433008848),
            name: 'totalPrice',
            type: 6,
            flags: 0)
      ],
      relations: <ModelRelation>[
        ModelRelation(
            id: const IdUid(3, 101624229004863566),
            name: 'items',
            targetId: const IdUid(3, 5081414179245264874))
      ],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(5, 5503686465859089333),
      name: 'Settings',
      lastPropertyId: const IdUid(2, 1196692966763398702),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4295287080779848632),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 1196692966763398702),
            name: 'showPrice',
            type: 1,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(5, 5503686465859089333),
      lastIndexId: const IdUid(2, 7599025199795592852),
      lastRelationId: const IdUid(3, 101624229004863566),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [422095882667025137, 4627432496685139972],
      retiredRelationUids: const [6717258977099672173, 9191916916070458019],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Category: EntityDefinition<Category>(
        model: _entities[0],
        toOneRelations: (Category object) => [],
        toManyRelations: (Category object) => {},
        getId: (Category object) => object.id,
        setId: (Category object, int id) {
          object.id = id;
        },
        objectToFB: (Category object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          fbb.startTable(6);
          fbb.addOffset(0, nameOffset);
          fbb.addInt64(1, object.items);
          fbb.addInt64(2, object.id ?? 0);
          fbb.addInt64(4, object.color);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Category(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 12, 0),
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 4, ''),
              items: const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0),
              id: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 8));

          return object;
        }),
    Item: EntityDefinition<Item>(
        model: _entities[1],
        toOneRelations: (Item object) => [object.category],
        toManyRelations: (Item object) => {},
        getId: (Item object) => object.id,
        setId: (Item object, int id) {
          object.id = id;
        },
        objectToFB: (Item object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          final barcodeOffset =
              object.barcode == null ? null : fbb.writeString(object.barcode!);
          final imageOffset =
              object.image == null ? null : fbb.writeString(object.image!);
          fbb.startTable(11);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, barcodeOffset);
          fbb.addInt64(3, object.price);
          fbb.addInt64(4, object.cost);
          fbb.addInt64(5, object.stockCount);
          fbb.addInt64(6, object.color);
          fbb.addInt64(7, object.shape);
          fbb.addOffset(8, imageOffset);
          fbb.addInt64(9, object.category.targetId);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Item(
              id: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 4),
              barcode: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8),
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              price:
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0),
              stockCount: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 14),
              color:
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 16, 0),
              cost: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 12),
              shape:
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 18, 0),
              image: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 20));
          object.category.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 22, 0);
          object.category.attach(store);
          return object;
        }),
    ItemQty: EntityDefinition<ItemQty>(
        model: _entities[2],
        toOneRelations: (ItemQty object) => [object.item],
        toManyRelations: (ItemQty object) => {},
        getId: (ItemQty object) => object.id,
        setId: (ItemQty object, int id) {
          object.id = id;
        },
        objectToFB: (ItemQty object, fb.Builder fbb) {
          fbb.startTable(4);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addInt64(1, object.qty);
          fbb.addInt64(2, object.item.targetId);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = ItemQty(
              qty: const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0),
              item: ToOne(
                  targetId: const fb.Int64Reader()
                      .vTableGet(buffer, rootOffset, 8, 0)))
            ..id =
                const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 4);
          object.item.attach(store);
          return object;
        }),
    Receipt: EntityDefinition<Receipt>(
        model: _entities[3],
        toOneRelations: (Receipt object) => [],
        toManyRelations: (Receipt object) =>
            {RelInfo<Receipt>.toMany(3, object.id!): object.items},
        getId: (Receipt object) => object.id,
        setId: (Receipt object, int id) {
          object.id = id;
        },
        objectToFB: (Receipt object, fb.Builder fbb) {
          fbb.startTable(7);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addInt64(1, object.itemCount);
          fbb.addInt64(2, object.totalCost);
          fbb.addInt64(3, object.time.millisecondsSinceEpoch);
          fbb.addInt64(5, object.totalPrice);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Receipt(
              itemCount:
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0),
              totalCost:
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0),
              totalPrice:
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 14, 0),
              time: DateTime.fromMillisecondsSinceEpoch(
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0)),
              id: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 4),
              items: ToMany());
          InternalToManyAccess.setRelInfo(object.items, store,
              RelInfo<Receipt>.toMany(3, object.id!), store.box<Receipt>());
          return object;
        }),
    Settings: EntityDefinition<Settings>(
        model: _entities[4],
        toOneRelations: (Settings object) => [],
        toManyRelations: (Settings object) => {},
        getId: (Settings object) => object.id,
        setId: (Settings object, int id) {
          object.id = id;
        },
        objectToFB: (Settings object, fb.Builder fbb) {
          fbb.startTable(3);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addBool(1, object.showPrice);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Settings(
              showPrice:
                  const fb.BoolReader().vTableGet(buffer, rootOffset, 6, false))
            ..id =
                const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 4);

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Category] entity fields to define ObjectBox queries.
class Category_ {
  /// see [Category.name]
  static final name = QueryStringProperty<Category>(_entities[0].properties[0]);

  /// see [Category.items]
  static final items =
      QueryIntegerProperty<Category>(_entities[0].properties[1]);

  /// see [Category.id]
  static final id = QueryIntegerProperty<Category>(_entities[0].properties[2]);

  /// see [Category.color]
  static final color =
      QueryIntegerProperty<Category>(_entities[0].properties[3]);
}

/// [Item] entity fields to define ObjectBox queries.
class Item_ {
  /// see [Item.id]
  static final id = QueryIntegerProperty<Item>(_entities[1].properties[0]);

  /// see [Item.name]
  static final name = QueryStringProperty<Item>(_entities[1].properties[1]);

  /// see [Item.barcode]
  static final barcode = QueryStringProperty<Item>(_entities[1].properties[2]);

  /// see [Item.price]
  static final price = QueryIntegerProperty<Item>(_entities[1].properties[3]);

  /// see [Item.cost]
  static final cost = QueryIntegerProperty<Item>(_entities[1].properties[4]);

  /// see [Item.stockCount]
  static final stockCount =
      QueryIntegerProperty<Item>(_entities[1].properties[5]);

  /// see [Item.color]
  static final color = QueryIntegerProperty<Item>(_entities[1].properties[6]);

  /// see [Item.shape]
  static final shape = QueryIntegerProperty<Item>(_entities[1].properties[7]);

  /// see [Item.image]
  static final image = QueryStringProperty<Item>(_entities[1].properties[8]);

  /// see [Item.category]
  static final category =
      QueryRelationToOne<Item, Category>(_entities[1].properties[9]);
}

/// [ItemQty] entity fields to define ObjectBox queries.
class ItemQty_ {
  /// see [ItemQty.id]
  static final id = QueryIntegerProperty<ItemQty>(_entities[2].properties[0]);

  /// see [ItemQty.qty]
  static final qty = QueryIntegerProperty<ItemQty>(_entities[2].properties[1]);

  /// see [ItemQty.item]
  static final item =
      QueryRelationToOne<ItemQty, Item>(_entities[2].properties[2]);
}

/// [Receipt] entity fields to define ObjectBox queries.
class Receipt_ {
  /// see [Receipt.id]
  static final id = QueryIntegerProperty<Receipt>(_entities[3].properties[0]);

  /// see [Receipt.itemCount]
  static final itemCount =
      QueryIntegerProperty<Receipt>(_entities[3].properties[1]);

  /// see [Receipt.totalCost]
  static final totalCost =
      QueryIntegerProperty<Receipt>(_entities[3].properties[2]);

  /// see [Receipt.time]
  static final time = QueryIntegerProperty<Receipt>(_entities[3].properties[3]);

  /// see [Receipt.totalPrice]
  static final totalPrice =
      QueryIntegerProperty<Receipt>(_entities[3].properties[4]);

  /// see [Receipt.items]
  static final items =
      QueryRelationToMany<Receipt, ItemQty>(_entities[3].relations[0]);
}

/// [Settings] entity fields to define ObjectBox queries.
class Settings_ {
  /// see [Settings.id]
  static final id = QueryIntegerProperty<Settings>(_entities[4].properties[0]);

  /// see [Settings.showPrice]
  static final showPrice =
      QueryBooleanProperty<Settings>(_entities[4].properties[1]);
}