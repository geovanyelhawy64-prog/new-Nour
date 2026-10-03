// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BibleBooksTable extends BibleBooks
    with TableInfo<$BibleBooksTable, BibleBook> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BibleBooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameArMeta = const VerificationMeta('nameAr');
  @override
  late final GeneratedColumn<String> nameAr = GeneratedColumn<String>(
      'name_ar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
      'name_en', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameCopticMeta =
      const VerificationMeta('nameCoptic');
  @override
  late final GeneratedColumn<String> nameCoptic = GeneratedColumn<String>(
      'name_coptic', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _testamentMeta =
      const VerificationMeta('testament');
  @override
  late final GeneratedColumn<String> testament = GeneratedColumn<String>(
      'testament', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _testamentArMeta =
      const VerificationMeta('testamentAr');
  @override
  late final GeneratedColumn<String> testamentAr = GeneratedColumn<String>(
      'testament_ar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryArMeta =
      const VerificationMeta('categoryAr');
  @override
  late final GeneratedColumn<String> categoryAr = GeneratedColumn<String>(
      'category_ar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bookOrderMeta =
      const VerificationMeta('bookOrder');
  @override
  late final GeneratedColumn<int> bookOrder = GeneratedColumn<int>(
      'book_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _chapterCountMeta =
      const VerificationMeta('chapterCount');
  @override
  late final GeneratedColumn<int> chapterCount = GeneratedColumn<int>(
      'chapter_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        nameAr,
        nameEn,
        nameCoptic,
        testament,
        testamentAr,
        category,
        categoryAr,
        bookOrder,
        chapterCount
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bible_books';
  @override
  VerificationContext validateIntegrity(Insertable<BibleBook> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name_ar')) {
      context.handle(_nameArMeta,
          nameAr.isAcceptableOrUnknown(data['name_ar']!, _nameArMeta));
    } else if (isInserting) {
      context.missing(_nameArMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(_nameEnMeta,
          nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta));
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_coptic')) {
      context.handle(
          _nameCopticMeta,
          nameCoptic.isAcceptableOrUnknown(
              data['name_coptic']!, _nameCopticMeta));
    }
    if (data.containsKey('testament')) {
      context.handle(_testamentMeta,
          testament.isAcceptableOrUnknown(data['testament']!, _testamentMeta));
    } else if (isInserting) {
      context.missing(_testamentMeta);
    }
    if (data.containsKey('testament_ar')) {
      context.handle(
          _testamentArMeta,
          testamentAr.isAcceptableOrUnknown(
              data['testament_ar']!, _testamentArMeta));
    } else if (isInserting) {
      context.missing(_testamentArMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('category_ar')) {
      context.handle(
          _categoryArMeta,
          categoryAr.isAcceptableOrUnknown(
              data['category_ar']!, _categoryArMeta));
    } else if (isInserting) {
      context.missing(_categoryArMeta);
    }
    if (data.containsKey('book_order')) {
      context.handle(_bookOrderMeta,
          bookOrder.isAcceptableOrUnknown(data['book_order']!, _bookOrderMeta));
    } else if (isInserting) {
      context.missing(_bookOrderMeta);
    }
    if (data.containsKey('chapter_count')) {
      context.handle(
          _chapterCountMeta,
          chapterCount.isAcceptableOrUnknown(
              data['chapter_count']!, _chapterCountMeta));
    } else if (isInserting) {
      context.missing(_chapterCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BibleBook map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BibleBook(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nameAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_ar'])!,
      nameEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_en'])!,
      nameCoptic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_coptic']),
      testament: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}testament'])!,
      testamentAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}testament_ar'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      categoryAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_ar'])!,
      bookOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}book_order'])!,
      chapterCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chapter_count'])!,
    );
  }

  @override
  $BibleBooksTable createAlias(String alias) {
    return $BibleBooksTable(attachedDatabase, alias);
  }
}

class BibleBook extends DataClass implements Insertable<BibleBook> {
  final int id;
  final String nameAr;
  final String nameEn;
  final String? nameCoptic;
  final String testament;
  final String testamentAr;
  final String category;
  final String categoryAr;
  final int bookOrder;
  final int chapterCount;
  const BibleBook(
      {required this.id,
      required this.nameAr,
      required this.nameEn,
      this.nameCoptic,
      required this.testament,
      required this.testamentAr,
      required this.category,
      required this.categoryAr,
      required this.bookOrder,
      required this.chapterCount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name_ar'] = Variable<String>(nameAr);
    map['name_en'] = Variable<String>(nameEn);
    if (!nullToAbsent || nameCoptic != null) {
      map['name_coptic'] = Variable<String>(nameCoptic);
    }
    map['testament'] = Variable<String>(testament);
    map['testament_ar'] = Variable<String>(testamentAr);
    map['category'] = Variable<String>(category);
    map['category_ar'] = Variable<String>(categoryAr);
    map['book_order'] = Variable<int>(bookOrder);
    map['chapter_count'] = Variable<int>(chapterCount);
    return map;
  }

  BibleBooksCompanion toCompanion(bool nullToAbsent) {
    return BibleBooksCompanion(
      id: Value(id),
      nameAr: Value(nameAr),
      nameEn: Value(nameEn),
      nameCoptic: nameCoptic == null && nullToAbsent
          ? const Value.absent()
          : Value(nameCoptic),
      testament: Value(testament),
      testamentAr: Value(testamentAr),
      category: Value(category),
      categoryAr: Value(categoryAr),
      bookOrder: Value(bookOrder),
      chapterCount: Value(chapterCount),
    );
  }

  factory BibleBook.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BibleBook(
      id: serializer.fromJson<int>(json['id']),
      nameAr: serializer.fromJson<String>(json['nameAr']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameCoptic: serializer.fromJson<String?>(json['nameCoptic']),
      testament: serializer.fromJson<String>(json['testament']),
      testamentAr: serializer.fromJson<String>(json['testamentAr']),
      category: serializer.fromJson<String>(json['category']),
      categoryAr: serializer.fromJson<String>(json['categoryAr']),
      bookOrder: serializer.fromJson<int>(json['bookOrder']),
      chapterCount: serializer.fromJson<int>(json['chapterCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nameAr': serializer.toJson<String>(nameAr),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameCoptic': serializer.toJson<String?>(nameCoptic),
      'testament': serializer.toJson<String>(testament),
      'testamentAr': serializer.toJson<String>(testamentAr),
      'category': serializer.toJson<String>(category),
      'categoryAr': serializer.toJson<String>(categoryAr),
      'bookOrder': serializer.toJson<int>(bookOrder),
      'chapterCount': serializer.toJson<int>(chapterCount),
    };
  }

  BibleBook copyWith(
          {int? id,
          String? nameAr,
          String? nameEn,
          Value<String?> nameCoptic = const Value.absent(),
          String? testament,
          String? testamentAr,
          String? category,
          String? categoryAr,
          int? bookOrder,
          int? chapterCount}) =>
      BibleBook(
        id: id ?? this.id,
        nameAr: nameAr ?? this.nameAr,
        nameEn: nameEn ?? this.nameEn,
        nameCoptic: nameCoptic.present ? nameCoptic.value : this.nameCoptic,
        testament: testament ?? this.testament,
        testamentAr: testamentAr ?? this.testamentAr,
        category: category ?? this.category,
        categoryAr: categoryAr ?? this.categoryAr,
        bookOrder: bookOrder ?? this.bookOrder,
        chapterCount: chapterCount ?? this.chapterCount,
      );
  BibleBook copyWithCompanion(BibleBooksCompanion data) {
    return BibleBook(
      id: data.id.present ? data.id.value : this.id,
      nameAr: data.nameAr.present ? data.nameAr.value : this.nameAr,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameCoptic:
          data.nameCoptic.present ? data.nameCoptic.value : this.nameCoptic,
      testament: data.testament.present ? data.testament.value : this.testament,
      testamentAr:
          data.testamentAr.present ? data.testamentAr.value : this.testamentAr,
      category: data.category.present ? data.category.value : this.category,
      categoryAr:
          data.categoryAr.present ? data.categoryAr.value : this.categoryAr,
      bookOrder: data.bookOrder.present ? data.bookOrder.value : this.bookOrder,
      chapterCount: data.chapterCount.present
          ? data.chapterCount.value
          : this.chapterCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BibleBook(')
          ..write('id: $id, ')
          ..write('nameAr: $nameAr, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameCoptic: $nameCoptic, ')
          ..write('testament: $testament, ')
          ..write('testamentAr: $testamentAr, ')
          ..write('category: $category, ')
          ..write('categoryAr: $categoryAr, ')
          ..write('bookOrder: $bookOrder, ')
          ..write('chapterCount: $chapterCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nameAr, nameEn, nameCoptic, testament,
      testamentAr, category, categoryAr, bookOrder, chapterCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BibleBook &&
          other.id == this.id &&
          other.nameAr == this.nameAr &&
          other.nameEn == this.nameEn &&
          other.nameCoptic == this.nameCoptic &&
          other.testament == this.testament &&
          other.testamentAr == this.testamentAr &&
          other.category == this.category &&
          other.categoryAr == this.categoryAr &&
          other.bookOrder == this.bookOrder &&
          other.chapterCount == this.chapterCount);
}

class BibleBooksCompanion extends UpdateCompanion<BibleBook> {
  final Value<int> id;
  final Value<String> nameAr;
  final Value<String> nameEn;
  final Value<String?> nameCoptic;
  final Value<String> testament;
  final Value<String> testamentAr;
  final Value<String> category;
  final Value<String> categoryAr;
  final Value<int> bookOrder;
  final Value<int> chapterCount;
  const BibleBooksCompanion({
    this.id = const Value.absent(),
    this.nameAr = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameCoptic = const Value.absent(),
    this.testament = const Value.absent(),
    this.testamentAr = const Value.absent(),
    this.category = const Value.absent(),
    this.categoryAr = const Value.absent(),
    this.bookOrder = const Value.absent(),
    this.chapterCount = const Value.absent(),
  });
  BibleBooksCompanion.insert({
    this.id = const Value.absent(),
    required String nameAr,
    required String nameEn,
    this.nameCoptic = const Value.absent(),
    required String testament,
    required String testamentAr,
    required String category,
    required String categoryAr,
    required int bookOrder,
    required int chapterCount,
  })  : nameAr = Value(nameAr),
        nameEn = Value(nameEn),
        testament = Value(testament),
        testamentAr = Value(testamentAr),
        category = Value(category),
        categoryAr = Value(categoryAr),
        bookOrder = Value(bookOrder),
        chapterCount = Value(chapterCount);
  static Insertable<BibleBook> custom({
    Expression<int>? id,
    Expression<String>? nameAr,
    Expression<String>? nameEn,
    Expression<String>? nameCoptic,
    Expression<String>? testament,
    Expression<String>? testamentAr,
    Expression<String>? category,
    Expression<String>? categoryAr,
    Expression<int>? bookOrder,
    Expression<int>? chapterCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameAr != null) 'name_ar': nameAr,
      if (nameEn != null) 'name_en': nameEn,
      if (nameCoptic != null) 'name_coptic': nameCoptic,
      if (testament != null) 'testament': testament,
      if (testamentAr != null) 'testament_ar': testamentAr,
      if (category != null) 'category': category,
      if (categoryAr != null) 'category_ar': categoryAr,
      if (bookOrder != null) 'book_order': bookOrder,
      if (chapterCount != null) 'chapter_count': chapterCount,
    });
  }

  BibleBooksCompanion copyWith(
      {Value<int>? id,
      Value<String>? nameAr,
      Value<String>? nameEn,
      Value<String?>? nameCoptic,
      Value<String>? testament,
      Value<String>? testamentAr,
      Value<String>? category,
      Value<String>? categoryAr,
      Value<int>? bookOrder,
      Value<int>? chapterCount}) {
    return BibleBooksCompanion(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      nameCoptic: nameCoptic ?? this.nameCoptic,
      testament: testament ?? this.testament,
      testamentAr: testamentAr ?? this.testamentAr,
      category: category ?? this.category,
      categoryAr: categoryAr ?? this.categoryAr,
      bookOrder: bookOrder ?? this.bookOrder,
      chapterCount: chapterCount ?? this.chapterCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nameAr.present) {
      map['name_ar'] = Variable<String>(nameAr.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameCoptic.present) {
      map['name_coptic'] = Variable<String>(nameCoptic.value);
    }
    if (testament.present) {
      map['testament'] = Variable<String>(testament.value);
    }
    if (testamentAr.present) {
      map['testament_ar'] = Variable<String>(testamentAr.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (categoryAr.present) {
      map['category_ar'] = Variable<String>(categoryAr.value);
    }
    if (bookOrder.present) {
      map['book_order'] = Variable<int>(bookOrder.value);
    }
    if (chapterCount.present) {
      map['chapter_count'] = Variable<int>(chapterCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BibleBooksCompanion(')
          ..write('id: $id, ')
          ..write('nameAr: $nameAr, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameCoptic: $nameCoptic, ')
          ..write('testament: $testament, ')
          ..write('testamentAr: $testamentAr, ')
          ..write('category: $category, ')
          ..write('categoryAr: $categoryAr, ')
          ..write('bookOrder: $bookOrder, ')
          ..write('chapterCount: $chapterCount')
          ..write(')'))
        .toString();
  }
}

class $BibleVersesTable extends BibleVerses
    with TableInfo<$BibleVersesTable, BibleVerse> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BibleVersesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
      'book_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES bible_books (id)'));
  static const VerificationMeta _chapterMeta =
      const VerificationMeta('chapter');
  @override
  late final GeneratedColumn<int> chapter = GeneratedColumn<int>(
      'chapter', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _verseNumberMeta =
      const VerificationMeta('verseNumber');
  @override
  late final GeneratedColumn<int> verseNumber = GeneratedColumn<int>(
      'verse_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _textWithTashkeelMeta =
      const VerificationMeta('textWithTashkeel');
  @override
  late final GeneratedColumn<String> textWithTashkeel = GeneratedColumn<String>(
      'text_with_tashkeel', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, bookId, chapter, verseNumber, content, textWithTashkeel];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bible_verses';
  @override
  VerificationContext validateIntegrity(Insertable<BibleVerse> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('book_id')) {
      context.handle(_bookIdMeta,
          bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta));
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('chapter')) {
      context.handle(_chapterMeta,
          chapter.isAcceptableOrUnknown(data['chapter']!, _chapterMeta));
    } else if (isInserting) {
      context.missing(_chapterMeta);
    }
    if (data.containsKey('verse_number')) {
      context.handle(
          _verseNumberMeta,
          verseNumber.isAcceptableOrUnknown(
              data['verse_number']!, _verseNumberMeta));
    } else if (isInserting) {
      context.missing(_verseNumberMeta);
    }
    if (data.containsKey('text')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['text']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('text_with_tashkeel')) {
      context.handle(
          _textWithTashkeelMeta,
          textWithTashkeel.isAcceptableOrUnknown(
              data['text_with_tashkeel']!, _textWithTashkeelMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {bookId, chapter, verseNumber},
      ];
  @override
  BibleVerse map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BibleVerse(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      bookId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}book_id'])!,
      chapter: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chapter'])!,
      verseNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}verse_number'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text'])!,
      textWithTashkeel: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}text_with_tashkeel']),
    );
  }

  @override
  $BibleVersesTable createAlias(String alias) {
    return $BibleVersesTable(attachedDatabase, alias);
  }
}

class BibleVerse extends DataClass implements Insertable<BibleVerse> {
  final int id;
  final int bookId;
  final int chapter;
  final int verseNumber;
  final String content;
  final String? textWithTashkeel;
  const BibleVerse(
      {required this.id,
      required this.bookId,
      required this.chapter,
      required this.verseNumber,
      required this.content,
      this.textWithTashkeel});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['book_id'] = Variable<int>(bookId);
    map['chapter'] = Variable<int>(chapter);
    map['verse_number'] = Variable<int>(verseNumber);
    map['text'] = Variable<String>(content);
    if (!nullToAbsent || textWithTashkeel != null) {
      map['text_with_tashkeel'] = Variable<String>(textWithTashkeel);
    }
    return map;
  }

  BibleVersesCompanion toCompanion(bool nullToAbsent) {
    return BibleVersesCompanion(
      id: Value(id),
      bookId: Value(bookId),
      chapter: Value(chapter),
      verseNumber: Value(verseNumber),
      content: Value(content),
      textWithTashkeel: textWithTashkeel == null && nullToAbsent
          ? const Value.absent()
          : Value(textWithTashkeel),
    );
  }

  factory BibleVerse.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BibleVerse(
      id: serializer.fromJson<int>(json['id']),
      bookId: serializer.fromJson<int>(json['bookId']),
      chapter: serializer.fromJson<int>(json['chapter']),
      verseNumber: serializer.fromJson<int>(json['verseNumber']),
      content: serializer.fromJson<String>(json['content']),
      textWithTashkeel: serializer.fromJson<String?>(json['textWithTashkeel']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bookId': serializer.toJson<int>(bookId),
      'chapter': serializer.toJson<int>(chapter),
      'verseNumber': serializer.toJson<int>(verseNumber),
      'content': serializer.toJson<String>(content),
      'textWithTashkeel': serializer.toJson<String?>(textWithTashkeel),
    };
  }

  BibleVerse copyWith(
          {int? id,
          int? bookId,
          int? chapter,
          int? verseNumber,
          String? content,
          Value<String?> textWithTashkeel = const Value.absent()}) =>
      BibleVerse(
        id: id ?? this.id,
        bookId: bookId ?? this.bookId,
        chapter: chapter ?? this.chapter,
        verseNumber: verseNumber ?? this.verseNumber,
        content: content ?? this.content,
        textWithTashkeel: textWithTashkeel.present
            ? textWithTashkeel.value
            : this.textWithTashkeel,
      );
  BibleVerse copyWithCompanion(BibleVersesCompanion data) {
    return BibleVerse(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      chapter: data.chapter.present ? data.chapter.value : this.chapter,
      verseNumber:
          data.verseNumber.present ? data.verseNumber.value : this.verseNumber,
      content: data.content.present ? data.content.value : this.content,
      textWithTashkeel: data.textWithTashkeel.present
          ? data.textWithTashkeel.value
          : this.textWithTashkeel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BibleVerse(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('verseNumber: $verseNumber, ')
          ..write('content: $content, ')
          ..write('textWithTashkeel: $textWithTashkeel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, bookId, chapter, verseNumber, content, textWithTashkeel);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BibleVerse &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.chapter == this.chapter &&
          other.verseNumber == this.verseNumber &&
          other.content == this.content &&
          other.textWithTashkeel == this.textWithTashkeel);
}

class BibleVersesCompanion extends UpdateCompanion<BibleVerse> {
  final Value<int> id;
  final Value<int> bookId;
  final Value<int> chapter;
  final Value<int> verseNumber;
  final Value<String> content;
  final Value<String?> textWithTashkeel;
  const BibleVersesCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.chapter = const Value.absent(),
    this.verseNumber = const Value.absent(),
    this.content = const Value.absent(),
    this.textWithTashkeel = const Value.absent(),
  });
  BibleVersesCompanion.insert({
    this.id = const Value.absent(),
    required int bookId,
    required int chapter,
    required int verseNumber,
    required String content,
    this.textWithTashkeel = const Value.absent(),
  })  : bookId = Value(bookId),
        chapter = Value(chapter),
        verseNumber = Value(verseNumber),
        content = Value(content);
  static Insertable<BibleVerse> custom({
    Expression<int>? id,
    Expression<int>? bookId,
    Expression<int>? chapter,
    Expression<int>? verseNumber,
    Expression<String>? content,
    Expression<String>? textWithTashkeel,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (chapter != null) 'chapter': chapter,
      if (verseNumber != null) 'verse_number': verseNumber,
      if (content != null) 'text': content,
      if (textWithTashkeel != null) 'text_with_tashkeel': textWithTashkeel,
    });
  }

  BibleVersesCompanion copyWith(
      {Value<int>? id,
      Value<int>? bookId,
      Value<int>? chapter,
      Value<int>? verseNumber,
      Value<String>? content,
      Value<String?>? textWithTashkeel}) {
    return BibleVersesCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      chapter: chapter ?? this.chapter,
      verseNumber: verseNumber ?? this.verseNumber,
      content: content ?? this.content,
      textWithTashkeel: textWithTashkeel ?? this.textWithTashkeel,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<int>(bookId.value);
    }
    if (chapter.present) {
      map['chapter'] = Variable<int>(chapter.value);
    }
    if (verseNumber.present) {
      map['verse_number'] = Variable<int>(verseNumber.value);
    }
    if (content.present) {
      map['text'] = Variable<String>(content.value);
    }
    if (textWithTashkeel.present) {
      map['text_with_tashkeel'] = Variable<String>(textWithTashkeel.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BibleVersesCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('verseNumber: $verseNumber, ')
          ..write('content: $content, ')
          ..write('textWithTashkeel: $textWithTashkeel')
          ..write(')'))
        .toString();
  }
}

class $AgpeyaHoursTable extends AgpeyaHours
    with TableInfo<$AgpeyaHoursTable, AgpeyaHour> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AgpeyaHoursTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameArMeta = const VerificationMeta('nameAr');
  @override
  late final GeneratedColumn<String> nameAr = GeneratedColumn<String>(
      'name_ar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
      'name_en', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _hourOrderMeta =
      const VerificationMeta('hourOrder');
  @override
  late final GeneratedColumn<int> hourOrder = GeneratedColumn<int>(
      'hour_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, nameAr, nameEn, hourOrder, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'agpeya_hours';
  @override
  VerificationContext validateIntegrity(Insertable<AgpeyaHour> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name_ar')) {
      context.handle(_nameArMeta,
          nameAr.isAcceptableOrUnknown(data['name_ar']!, _nameArMeta));
    } else if (isInserting) {
      context.missing(_nameArMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(_nameEnMeta,
          nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta));
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('hour_order')) {
      context.handle(_hourOrderMeta,
          hourOrder.isAcceptableOrUnknown(data['hour_order']!, _hourOrderMeta));
    } else if (isInserting) {
      context.missing(_hourOrderMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AgpeyaHour map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AgpeyaHour(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      nameAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_ar'])!,
      nameEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_en'])!,
      hourOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}hour_order'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
    );
  }

  @override
  $AgpeyaHoursTable createAlias(String alias) {
    return $AgpeyaHoursTable(attachedDatabase, alias);
  }
}

class AgpeyaHour extends DataClass implements Insertable<AgpeyaHour> {
  final String id;
  final String nameAr;
  final String nameEn;
  final int hourOrder;
  final String? description;
  const AgpeyaHour(
      {required this.id,
      required this.nameAr,
      required this.nameEn,
      required this.hourOrder,
      this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name_ar'] = Variable<String>(nameAr);
    map['name_en'] = Variable<String>(nameEn);
    map['hour_order'] = Variable<int>(hourOrder);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  AgpeyaHoursCompanion toCompanion(bool nullToAbsent) {
    return AgpeyaHoursCompanion(
      id: Value(id),
      nameAr: Value(nameAr),
      nameEn: Value(nameEn),
      hourOrder: Value(hourOrder),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory AgpeyaHour.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AgpeyaHour(
      id: serializer.fromJson<String>(json['id']),
      nameAr: serializer.fromJson<String>(json['nameAr']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      hourOrder: serializer.fromJson<int>(json['hourOrder']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nameAr': serializer.toJson<String>(nameAr),
      'nameEn': serializer.toJson<String>(nameEn),
      'hourOrder': serializer.toJson<int>(hourOrder),
      'description': serializer.toJson<String?>(description),
    };
  }

  AgpeyaHour copyWith(
          {String? id,
          String? nameAr,
          String? nameEn,
          int? hourOrder,
          Value<String?> description = const Value.absent()}) =>
      AgpeyaHour(
        id: id ?? this.id,
        nameAr: nameAr ?? this.nameAr,
        nameEn: nameEn ?? this.nameEn,
        hourOrder: hourOrder ?? this.hourOrder,
        description: description.present ? description.value : this.description,
      );
  AgpeyaHour copyWithCompanion(AgpeyaHoursCompanion data) {
    return AgpeyaHour(
      id: data.id.present ? data.id.value : this.id,
      nameAr: data.nameAr.present ? data.nameAr.value : this.nameAr,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      hourOrder: data.hourOrder.present ? data.hourOrder.value : this.hourOrder,
      description:
          data.description.present ? data.description.value : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AgpeyaHour(')
          ..write('id: $id, ')
          ..write('nameAr: $nameAr, ')
          ..write('nameEn: $nameEn, ')
          ..write('hourOrder: $hourOrder, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nameAr, nameEn, hourOrder, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AgpeyaHour &&
          other.id == this.id &&
          other.nameAr == this.nameAr &&
          other.nameEn == this.nameEn &&
          other.hourOrder == this.hourOrder &&
          other.description == this.description);
}

class AgpeyaHoursCompanion extends UpdateCompanion<AgpeyaHour> {
  final Value<String> id;
  final Value<String> nameAr;
  final Value<String> nameEn;
  final Value<int> hourOrder;
  final Value<String?> description;
  final Value<int> rowid;
  const AgpeyaHoursCompanion({
    this.id = const Value.absent(),
    this.nameAr = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.hourOrder = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AgpeyaHoursCompanion.insert({
    required String id,
    required String nameAr,
    required String nameEn,
    required int hourOrder,
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        nameAr = Value(nameAr),
        nameEn = Value(nameEn),
        hourOrder = Value(hourOrder);
  static Insertable<AgpeyaHour> custom({
    Expression<String>? id,
    Expression<String>? nameAr,
    Expression<String>? nameEn,
    Expression<int>? hourOrder,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameAr != null) 'name_ar': nameAr,
      if (nameEn != null) 'name_en': nameEn,
      if (hourOrder != null) 'hour_order': hourOrder,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AgpeyaHoursCompanion copyWith(
      {Value<String>? id,
      Value<String>? nameAr,
      Value<String>? nameEn,
      Value<int>? hourOrder,
      Value<String?>? description,
      Value<int>? rowid}) {
    return AgpeyaHoursCompanion(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      hourOrder: hourOrder ?? this.hourOrder,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nameAr.present) {
      map['name_ar'] = Variable<String>(nameAr.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (hourOrder.present) {
      map['hour_order'] = Variable<int>(hourOrder.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AgpeyaHoursCompanion(')
          ..write('id: $id, ')
          ..write('nameAr: $nameAr, ')
          ..write('nameEn: $nameEn, ')
          ..write('hourOrder: $hourOrder, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AgpeyaSectionsTable extends AgpeyaSections
    with TableInfo<$AgpeyaSectionsTable, AgpeyaSection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AgpeyaSectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _hourIdMeta = const VerificationMeta('hourId');
  @override
  late final GeneratedColumn<String> hourId = GeneratedColumn<String>(
      'hour_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES agpeya_hours (id)'));
  static const VerificationMeta _sectionOrderMeta =
      const VerificationMeta('sectionOrder');
  @override
  late final GeneratedColumn<int> sectionOrder = GeneratedColumn<int>(
      'section_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _textArMeta = const VerificationMeta('textAr');
  @override
  late final GeneratedColumn<String> textAr = GeneratedColumn<String>(
      'text_ar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _textCopticMeta =
      const VerificationMeta('textCoptic');
  @override
  late final GeneratedColumn<String> textCoptic = GeneratedColumn<String>(
      'text_coptic', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _textPhoneticMeta =
      const VerificationMeta('textPhonetic');
  @override
  late final GeneratedColumn<String> textPhonetic = GeneratedColumn<String>(
      'text_phonetic', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _referenceMeta =
      const VerificationMeta('reference');
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
      'reference', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        hourId,
        sectionOrder,
        type,
        title,
        role,
        textAr,
        textCoptic,
        textPhonetic,
        reference
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'agpeya_sections';
  @override
  VerificationContext validateIntegrity(Insertable<AgpeyaSection> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('hour_id')) {
      context.handle(_hourIdMeta,
          hourId.isAcceptableOrUnknown(data['hour_id']!, _hourIdMeta));
    } else if (isInserting) {
      context.missing(_hourIdMeta);
    }
    if (data.containsKey('section_order')) {
      context.handle(
          _sectionOrderMeta,
          sectionOrder.isAcceptableOrUnknown(
              data['section_order']!, _sectionOrderMeta));
    } else if (isInserting) {
      context.missing(_sectionOrderMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('text_ar')) {
      context.handle(_textArMeta,
          textAr.isAcceptableOrUnknown(data['text_ar']!, _textArMeta));
    } else if (isInserting) {
      context.missing(_textArMeta);
    }
    if (data.containsKey('text_coptic')) {
      context.handle(
          _textCopticMeta,
          textCoptic.isAcceptableOrUnknown(
              data['text_coptic']!, _textCopticMeta));
    }
    if (data.containsKey('text_phonetic')) {
      context.handle(
          _textPhoneticMeta,
          textPhonetic.isAcceptableOrUnknown(
              data['text_phonetic']!, _textPhoneticMeta));
    }
    if (data.containsKey('reference')) {
      context.handle(_referenceMeta,
          reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AgpeyaSection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AgpeyaSection(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      hourId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hour_id'])!,
      sectionOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}section_order'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      textAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_ar'])!,
      textCoptic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_coptic']),
      textPhonetic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_phonetic']),
      reference: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reference']),
    );
  }

  @override
  $AgpeyaSectionsTable createAlias(String alias) {
    return $AgpeyaSectionsTable(attachedDatabase, alias);
  }
}

class AgpeyaSection extends DataClass implements Insertable<AgpeyaSection> {
  final int id;
  final String hourId;
  final int sectionOrder;
  final String type;
  final String title;
  final String role;
  final String textAr;
  final String? textCoptic;
  final String? textPhonetic;
  final String? reference;
  const AgpeyaSection(
      {required this.id,
      required this.hourId,
      required this.sectionOrder,
      required this.type,
      required this.title,
      required this.role,
      required this.textAr,
      this.textCoptic,
      this.textPhonetic,
      this.reference});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['hour_id'] = Variable<String>(hourId);
    map['section_order'] = Variable<int>(sectionOrder);
    map['type'] = Variable<String>(type);
    map['title'] = Variable<String>(title);
    map['role'] = Variable<String>(role);
    map['text_ar'] = Variable<String>(textAr);
    if (!nullToAbsent || textCoptic != null) {
      map['text_coptic'] = Variable<String>(textCoptic);
    }
    if (!nullToAbsent || textPhonetic != null) {
      map['text_phonetic'] = Variable<String>(textPhonetic);
    }
    if (!nullToAbsent || reference != null) {
      map['reference'] = Variable<String>(reference);
    }
    return map;
  }

  AgpeyaSectionsCompanion toCompanion(bool nullToAbsent) {
    return AgpeyaSectionsCompanion(
      id: Value(id),
      hourId: Value(hourId),
      sectionOrder: Value(sectionOrder),
      type: Value(type),
      title: Value(title),
      role: Value(role),
      textAr: Value(textAr),
      textCoptic: textCoptic == null && nullToAbsent
          ? const Value.absent()
          : Value(textCoptic),
      textPhonetic: textPhonetic == null && nullToAbsent
          ? const Value.absent()
          : Value(textPhonetic),
      reference: reference == null && nullToAbsent
          ? const Value.absent()
          : Value(reference),
    );
  }

  factory AgpeyaSection.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AgpeyaSection(
      id: serializer.fromJson<int>(json['id']),
      hourId: serializer.fromJson<String>(json['hourId']),
      sectionOrder: serializer.fromJson<int>(json['sectionOrder']),
      type: serializer.fromJson<String>(json['type']),
      title: serializer.fromJson<String>(json['title']),
      role: serializer.fromJson<String>(json['role']),
      textAr: serializer.fromJson<String>(json['textAr']),
      textCoptic: serializer.fromJson<String?>(json['textCoptic']),
      textPhonetic: serializer.fromJson<String?>(json['textPhonetic']),
      reference: serializer.fromJson<String?>(json['reference']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'hourId': serializer.toJson<String>(hourId),
      'sectionOrder': serializer.toJson<int>(sectionOrder),
      'type': serializer.toJson<String>(type),
      'title': serializer.toJson<String>(title),
      'role': serializer.toJson<String>(role),
      'textAr': serializer.toJson<String>(textAr),
      'textCoptic': serializer.toJson<String?>(textCoptic),
      'textPhonetic': serializer.toJson<String?>(textPhonetic),
      'reference': serializer.toJson<String?>(reference),
    };
  }

  AgpeyaSection copyWith(
          {int? id,
          String? hourId,
          int? sectionOrder,
          String? type,
          String? title,
          String? role,
          String? textAr,
          Value<String?> textCoptic = const Value.absent(),
          Value<String?> textPhonetic = const Value.absent(),
          Value<String?> reference = const Value.absent()}) =>
      AgpeyaSection(
        id: id ?? this.id,
        hourId: hourId ?? this.hourId,
        sectionOrder: sectionOrder ?? this.sectionOrder,
        type: type ?? this.type,
        title: title ?? this.title,
        role: role ?? this.role,
        textAr: textAr ?? this.textAr,
        textCoptic: textCoptic.present ? textCoptic.value : this.textCoptic,
        textPhonetic:
            textPhonetic.present ? textPhonetic.value : this.textPhonetic,
        reference: reference.present ? reference.value : this.reference,
      );
  AgpeyaSection copyWithCompanion(AgpeyaSectionsCompanion data) {
    return AgpeyaSection(
      id: data.id.present ? data.id.value : this.id,
      hourId: data.hourId.present ? data.hourId.value : this.hourId,
      sectionOrder: data.sectionOrder.present
          ? data.sectionOrder.value
          : this.sectionOrder,
      type: data.type.present ? data.type.value : this.type,
      title: data.title.present ? data.title.value : this.title,
      role: data.role.present ? data.role.value : this.role,
      textAr: data.textAr.present ? data.textAr.value : this.textAr,
      textCoptic:
          data.textCoptic.present ? data.textCoptic.value : this.textCoptic,
      textPhonetic: data.textPhonetic.present
          ? data.textPhonetic.value
          : this.textPhonetic,
      reference: data.reference.present ? data.reference.value : this.reference,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AgpeyaSection(')
          ..write('id: $id, ')
          ..write('hourId: $hourId, ')
          ..write('sectionOrder: $sectionOrder, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('role: $role, ')
          ..write('textAr: $textAr, ')
          ..write('textCoptic: $textCoptic, ')
          ..write('textPhonetic: $textPhonetic, ')
          ..write('reference: $reference')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, hourId, sectionOrder, type, title, role,
      textAr, textCoptic, textPhonetic, reference);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AgpeyaSection &&
          other.id == this.id &&
          other.hourId == this.hourId &&
          other.sectionOrder == this.sectionOrder &&
          other.type == this.type &&
          other.title == this.title &&
          other.role == this.role &&
          other.textAr == this.textAr &&
          other.textCoptic == this.textCoptic &&
          other.textPhonetic == this.textPhonetic &&
          other.reference == this.reference);
}

class AgpeyaSectionsCompanion extends UpdateCompanion<AgpeyaSection> {
  final Value<int> id;
  final Value<String> hourId;
  final Value<int> sectionOrder;
  final Value<String> type;
  final Value<String> title;
  final Value<String> role;
  final Value<String> textAr;
  final Value<String?> textCoptic;
  final Value<String?> textPhonetic;
  final Value<String?> reference;
  const AgpeyaSectionsCompanion({
    this.id = const Value.absent(),
    this.hourId = const Value.absent(),
    this.sectionOrder = const Value.absent(),
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.role = const Value.absent(),
    this.textAr = const Value.absent(),
    this.textCoptic = const Value.absent(),
    this.textPhonetic = const Value.absent(),
    this.reference = const Value.absent(),
  });
  AgpeyaSectionsCompanion.insert({
    this.id = const Value.absent(),
    required String hourId,
    required int sectionOrder,
    required String type,
    required String title,
    required String role,
    required String textAr,
    this.textCoptic = const Value.absent(),
    this.textPhonetic = const Value.absent(),
    this.reference = const Value.absent(),
  })  : hourId = Value(hourId),
        sectionOrder = Value(sectionOrder),
        type = Value(type),
        title = Value(title),
        role = Value(role),
        textAr = Value(textAr);
  static Insertable<AgpeyaSection> custom({
    Expression<int>? id,
    Expression<String>? hourId,
    Expression<int>? sectionOrder,
    Expression<String>? type,
    Expression<String>? title,
    Expression<String>? role,
    Expression<String>? textAr,
    Expression<String>? textCoptic,
    Expression<String>? textPhonetic,
    Expression<String>? reference,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (hourId != null) 'hour_id': hourId,
      if (sectionOrder != null) 'section_order': sectionOrder,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (role != null) 'role': role,
      if (textAr != null) 'text_ar': textAr,
      if (textCoptic != null) 'text_coptic': textCoptic,
      if (textPhonetic != null) 'text_phonetic': textPhonetic,
      if (reference != null) 'reference': reference,
    });
  }

  AgpeyaSectionsCompanion copyWith(
      {Value<int>? id,
      Value<String>? hourId,
      Value<int>? sectionOrder,
      Value<String>? type,
      Value<String>? title,
      Value<String>? role,
      Value<String>? textAr,
      Value<String?>? textCoptic,
      Value<String?>? textPhonetic,
      Value<String?>? reference}) {
    return AgpeyaSectionsCompanion(
      id: id ?? this.id,
      hourId: hourId ?? this.hourId,
      sectionOrder: sectionOrder ?? this.sectionOrder,
      type: type ?? this.type,
      title: title ?? this.title,
      role: role ?? this.role,
      textAr: textAr ?? this.textAr,
      textCoptic: textCoptic ?? this.textCoptic,
      textPhonetic: textPhonetic ?? this.textPhonetic,
      reference: reference ?? this.reference,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (hourId.present) {
      map['hour_id'] = Variable<String>(hourId.value);
    }
    if (sectionOrder.present) {
      map['section_order'] = Variable<int>(sectionOrder.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (textAr.present) {
      map['text_ar'] = Variable<String>(textAr.value);
    }
    if (textCoptic.present) {
      map['text_coptic'] = Variable<String>(textCoptic.value);
    }
    if (textPhonetic.present) {
      map['text_phonetic'] = Variable<String>(textPhonetic.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AgpeyaSectionsCompanion(')
          ..write('id: $id, ')
          ..write('hourId: $hourId, ')
          ..write('sectionOrder: $sectionOrder, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('role: $role, ')
          ..write('textAr: $textAr, ')
          ..write('textCoptic: $textCoptic, ')
          ..write('textPhonetic: $textPhonetic, ')
          ..write('reference: $reference')
          ..write(')'))
        .toString();
  }
}

class $LiturgiesTable extends Liturgies
    with TableInfo<$LiturgiesTable, Liturgy> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LiturgiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameArMeta = const VerificationMeta('nameAr');
  @override
  late final GeneratedColumn<String> nameAr = GeneratedColumn<String>(
      'name_ar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
      'name_en', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _liturgyOrderMeta =
      const VerificationMeta('liturgyOrder');
  @override
  late final GeneratedColumn<int> liturgyOrder = GeneratedColumn<int>(
      'liturgy_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, nameAr, nameEn, liturgyOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'liturgies';
  @override
  VerificationContext validateIntegrity(Insertable<Liturgy> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name_ar')) {
      context.handle(_nameArMeta,
          nameAr.isAcceptableOrUnknown(data['name_ar']!, _nameArMeta));
    } else if (isInserting) {
      context.missing(_nameArMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(_nameEnMeta,
          nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta));
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('liturgy_order')) {
      context.handle(
          _liturgyOrderMeta,
          liturgyOrder.isAcceptableOrUnknown(
              data['liturgy_order']!, _liturgyOrderMeta));
    } else if (isInserting) {
      context.missing(_liturgyOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Liturgy map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Liturgy(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      nameAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_ar'])!,
      nameEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_en'])!,
      liturgyOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}liturgy_order'])!,
    );
  }

  @override
  $LiturgiesTable createAlias(String alias) {
    return $LiturgiesTable(attachedDatabase, alias);
  }
}

class Liturgy extends DataClass implements Insertable<Liturgy> {
  final String id;
  final String nameAr;
  final String nameEn;
  final int liturgyOrder;
  const Liturgy(
      {required this.id,
      required this.nameAr,
      required this.nameEn,
      required this.liturgyOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name_ar'] = Variable<String>(nameAr);
    map['name_en'] = Variable<String>(nameEn);
    map['liturgy_order'] = Variable<int>(liturgyOrder);
    return map;
  }

  LiturgiesCompanion toCompanion(bool nullToAbsent) {
    return LiturgiesCompanion(
      id: Value(id),
      nameAr: Value(nameAr),
      nameEn: Value(nameEn),
      liturgyOrder: Value(liturgyOrder),
    );
  }

  factory Liturgy.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Liturgy(
      id: serializer.fromJson<String>(json['id']),
      nameAr: serializer.fromJson<String>(json['nameAr']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      liturgyOrder: serializer.fromJson<int>(json['liturgyOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nameAr': serializer.toJson<String>(nameAr),
      'nameEn': serializer.toJson<String>(nameEn),
      'liturgyOrder': serializer.toJson<int>(liturgyOrder),
    };
  }

  Liturgy copyWith(
          {String? id, String? nameAr, String? nameEn, int? liturgyOrder}) =>
      Liturgy(
        id: id ?? this.id,
        nameAr: nameAr ?? this.nameAr,
        nameEn: nameEn ?? this.nameEn,
        liturgyOrder: liturgyOrder ?? this.liturgyOrder,
      );
  Liturgy copyWithCompanion(LiturgiesCompanion data) {
    return Liturgy(
      id: data.id.present ? data.id.value : this.id,
      nameAr: data.nameAr.present ? data.nameAr.value : this.nameAr,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      liturgyOrder: data.liturgyOrder.present
          ? data.liturgyOrder.value
          : this.liturgyOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Liturgy(')
          ..write('id: $id, ')
          ..write('nameAr: $nameAr, ')
          ..write('nameEn: $nameEn, ')
          ..write('liturgyOrder: $liturgyOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nameAr, nameEn, liturgyOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Liturgy &&
          other.id == this.id &&
          other.nameAr == this.nameAr &&
          other.nameEn == this.nameEn &&
          other.liturgyOrder == this.liturgyOrder);
}

class LiturgiesCompanion extends UpdateCompanion<Liturgy> {
  final Value<String> id;
  final Value<String> nameAr;
  final Value<String> nameEn;
  final Value<int> liturgyOrder;
  final Value<int> rowid;
  const LiturgiesCompanion({
    this.id = const Value.absent(),
    this.nameAr = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.liturgyOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LiturgiesCompanion.insert({
    required String id,
    required String nameAr,
    required String nameEn,
    required int liturgyOrder,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        nameAr = Value(nameAr),
        nameEn = Value(nameEn),
        liturgyOrder = Value(liturgyOrder);
  static Insertable<Liturgy> custom({
    Expression<String>? id,
    Expression<String>? nameAr,
    Expression<String>? nameEn,
    Expression<int>? liturgyOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameAr != null) 'name_ar': nameAr,
      if (nameEn != null) 'name_en': nameEn,
      if (liturgyOrder != null) 'liturgy_order': liturgyOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LiturgiesCompanion copyWith(
      {Value<String>? id,
      Value<String>? nameAr,
      Value<String>? nameEn,
      Value<int>? liturgyOrder,
      Value<int>? rowid}) {
    return LiturgiesCompanion(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      liturgyOrder: liturgyOrder ?? this.liturgyOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nameAr.present) {
      map['name_ar'] = Variable<String>(nameAr.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (liturgyOrder.present) {
      map['liturgy_order'] = Variable<int>(liturgyOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LiturgiesCompanion(')
          ..write('id: $id, ')
          ..write('nameAr: $nameAr, ')
          ..write('nameEn: $nameEn, ')
          ..write('liturgyOrder: $liturgyOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LiturgySectionsTable extends LiturgySections
    with TableInfo<$LiturgySectionsTable, LiturgySection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LiturgySectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _liturgyIdMeta =
      const VerificationMeta('liturgyId');
  @override
  late final GeneratedColumn<String> liturgyId = GeneratedColumn<String>(
      'liturgy_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES liturgies (id)'));
  static const VerificationMeta _nameArMeta = const VerificationMeta('nameAr');
  @override
  late final GeneratedColumn<String> nameAr = GeneratedColumn<String>(
      'name_ar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sectionOrderMeta =
      const VerificationMeta('sectionOrder');
  @override
  late final GeneratedColumn<int> sectionOrder = GeneratedColumn<int>(
      'section_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, liturgyId, nameAr, sectionOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'liturgy_sections';
  @override
  VerificationContext validateIntegrity(Insertable<LiturgySection> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('liturgy_id')) {
      context.handle(_liturgyIdMeta,
          liturgyId.isAcceptableOrUnknown(data['liturgy_id']!, _liturgyIdMeta));
    } else if (isInserting) {
      context.missing(_liturgyIdMeta);
    }
    if (data.containsKey('name_ar')) {
      context.handle(_nameArMeta,
          nameAr.isAcceptableOrUnknown(data['name_ar']!, _nameArMeta));
    } else if (isInserting) {
      context.missing(_nameArMeta);
    }
    if (data.containsKey('section_order')) {
      context.handle(
          _sectionOrderMeta,
          sectionOrder.isAcceptableOrUnknown(
              data['section_order']!, _sectionOrderMeta));
    } else if (isInserting) {
      context.missing(_sectionOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LiturgySection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LiturgySection(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      liturgyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}liturgy_id'])!,
      nameAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_ar'])!,
      sectionOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}section_order'])!,
    );
  }

  @override
  $LiturgySectionsTable createAlias(String alias) {
    return $LiturgySectionsTable(attachedDatabase, alias);
  }
}

class LiturgySection extends DataClass implements Insertable<LiturgySection> {
  final String id;
  final String liturgyId;
  final String nameAr;
  final int sectionOrder;
  const LiturgySection(
      {required this.id,
      required this.liturgyId,
      required this.nameAr,
      required this.sectionOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['liturgy_id'] = Variable<String>(liturgyId);
    map['name_ar'] = Variable<String>(nameAr);
    map['section_order'] = Variable<int>(sectionOrder);
    return map;
  }

  LiturgySectionsCompanion toCompanion(bool nullToAbsent) {
    return LiturgySectionsCompanion(
      id: Value(id),
      liturgyId: Value(liturgyId),
      nameAr: Value(nameAr),
      sectionOrder: Value(sectionOrder),
    );
  }

  factory LiturgySection.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LiturgySection(
      id: serializer.fromJson<String>(json['id']),
      liturgyId: serializer.fromJson<String>(json['liturgyId']),
      nameAr: serializer.fromJson<String>(json['nameAr']),
      sectionOrder: serializer.fromJson<int>(json['sectionOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'liturgyId': serializer.toJson<String>(liturgyId),
      'nameAr': serializer.toJson<String>(nameAr),
      'sectionOrder': serializer.toJson<int>(sectionOrder),
    };
  }

  LiturgySection copyWith(
          {String? id, String? liturgyId, String? nameAr, int? sectionOrder}) =>
      LiturgySection(
        id: id ?? this.id,
        liturgyId: liturgyId ?? this.liturgyId,
        nameAr: nameAr ?? this.nameAr,
        sectionOrder: sectionOrder ?? this.sectionOrder,
      );
  LiturgySection copyWithCompanion(LiturgySectionsCompanion data) {
    return LiturgySection(
      id: data.id.present ? data.id.value : this.id,
      liturgyId: data.liturgyId.present ? data.liturgyId.value : this.liturgyId,
      nameAr: data.nameAr.present ? data.nameAr.value : this.nameAr,
      sectionOrder: data.sectionOrder.present
          ? data.sectionOrder.value
          : this.sectionOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LiturgySection(')
          ..write('id: $id, ')
          ..write('liturgyId: $liturgyId, ')
          ..write('nameAr: $nameAr, ')
          ..write('sectionOrder: $sectionOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, liturgyId, nameAr, sectionOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LiturgySection &&
          other.id == this.id &&
          other.liturgyId == this.liturgyId &&
          other.nameAr == this.nameAr &&
          other.sectionOrder == this.sectionOrder);
}

class LiturgySectionsCompanion extends UpdateCompanion<LiturgySection> {
  final Value<String> id;
  final Value<String> liturgyId;
  final Value<String> nameAr;
  final Value<int> sectionOrder;
  final Value<int> rowid;
  const LiturgySectionsCompanion({
    this.id = const Value.absent(),
    this.liturgyId = const Value.absent(),
    this.nameAr = const Value.absent(),
    this.sectionOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LiturgySectionsCompanion.insert({
    required String id,
    required String liturgyId,
    required String nameAr,
    required int sectionOrder,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        liturgyId = Value(liturgyId),
        nameAr = Value(nameAr),
        sectionOrder = Value(sectionOrder);
  static Insertable<LiturgySection> custom({
    Expression<String>? id,
    Expression<String>? liturgyId,
    Expression<String>? nameAr,
    Expression<int>? sectionOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (liturgyId != null) 'liturgy_id': liturgyId,
      if (nameAr != null) 'name_ar': nameAr,
      if (sectionOrder != null) 'section_order': sectionOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LiturgySectionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? liturgyId,
      Value<String>? nameAr,
      Value<int>? sectionOrder,
      Value<int>? rowid}) {
    return LiturgySectionsCompanion(
      id: id ?? this.id,
      liturgyId: liturgyId ?? this.liturgyId,
      nameAr: nameAr ?? this.nameAr,
      sectionOrder: sectionOrder ?? this.sectionOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (liturgyId.present) {
      map['liturgy_id'] = Variable<String>(liturgyId.value);
    }
    if (nameAr.present) {
      map['name_ar'] = Variable<String>(nameAr.value);
    }
    if (sectionOrder.present) {
      map['section_order'] = Variable<int>(sectionOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LiturgySectionsCompanion(')
          ..write('id: $id, ')
          ..write('liturgyId: $liturgyId, ')
          ..write('nameAr: $nameAr, ')
          ..write('sectionOrder: $sectionOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LiturgyPartsTable extends LiturgyParts
    with TableInfo<$LiturgyPartsTable, LiturgyPart> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LiturgyPartsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _sectionIdMeta =
      const VerificationMeta('sectionId');
  @override
  late final GeneratedColumn<String> sectionId = GeneratedColumn<String>(
      'section_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES liturgy_sections (id)'));
  static const VerificationMeta _partOrderMeta =
      const VerificationMeta('partOrder');
  @override
  late final GeneratedColumn<int> partOrder = GeneratedColumn<int>(
      'part_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _textArMeta = const VerificationMeta('textAr');
  @override
  late final GeneratedColumn<String> textAr = GeneratedColumn<String>(
      'text_ar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _textCopticMeta =
      const VerificationMeta('textCoptic');
  @override
  late final GeneratedColumn<String> textCoptic = GeneratedColumn<String>(
      'text_coptic', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _textPhoneticMeta =
      const VerificationMeta('textPhonetic');
  @override
  late final GeneratedColumn<String> textPhonetic = GeneratedColumn<String>(
      'text_phonetic', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _rubricMeta = const VerificationMeta('rubric');
  @override
  late final GeneratedColumn<String> rubric = GeneratedColumn<String>(
      'rubric', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isSecretMeta =
      const VerificationMeta('isSecret');
  @override
  late final GeneratedColumn<bool> isSecret = GeneratedColumn<bool>(
      'is_secret', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_secret" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sectionId,
        partOrder,
        role,
        type,
        textAr,
        textCoptic,
        textPhonetic,
        rubric,
        isSecret
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'liturgy_parts';
  @override
  VerificationContext validateIntegrity(Insertable<LiturgyPart> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('section_id')) {
      context.handle(_sectionIdMeta,
          sectionId.isAcceptableOrUnknown(data['section_id']!, _sectionIdMeta));
    } else if (isInserting) {
      context.missing(_sectionIdMeta);
    }
    if (data.containsKey('part_order')) {
      context.handle(_partOrderMeta,
          partOrder.isAcceptableOrUnknown(data['part_order']!, _partOrderMeta));
    } else if (isInserting) {
      context.missing(_partOrderMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('text_ar')) {
      context.handle(_textArMeta,
          textAr.isAcceptableOrUnknown(data['text_ar']!, _textArMeta));
    } else if (isInserting) {
      context.missing(_textArMeta);
    }
    if (data.containsKey('text_coptic')) {
      context.handle(
          _textCopticMeta,
          textCoptic.isAcceptableOrUnknown(
              data['text_coptic']!, _textCopticMeta));
    }
    if (data.containsKey('text_phonetic')) {
      context.handle(
          _textPhoneticMeta,
          textPhonetic.isAcceptableOrUnknown(
              data['text_phonetic']!, _textPhoneticMeta));
    }
    if (data.containsKey('rubric')) {
      context.handle(_rubricMeta,
          rubric.isAcceptableOrUnknown(data['rubric']!, _rubricMeta));
    }
    if (data.containsKey('is_secret')) {
      context.handle(_isSecretMeta,
          isSecret.isAcceptableOrUnknown(data['is_secret']!, _isSecretMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LiturgyPart map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LiturgyPart(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sectionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}section_id'])!,
      partOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}part_order'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      textAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_ar'])!,
      textCoptic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_coptic']),
      textPhonetic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_phonetic']),
      rubric: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rubric']),
      isSecret: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_secret'])!,
    );
  }

  @override
  $LiturgyPartsTable createAlias(String alias) {
    return $LiturgyPartsTable(attachedDatabase, alias);
  }
}

class LiturgyPart extends DataClass implements Insertable<LiturgyPart> {
  final int id;
  final String sectionId;
  final int partOrder;
  final String role;
  final String type;
  final String textAr;
  final String? textCoptic;
  final String? textPhonetic;
  final String? rubric;
  final bool isSecret;
  const LiturgyPart(
      {required this.id,
      required this.sectionId,
      required this.partOrder,
      required this.role,
      required this.type,
      required this.textAr,
      this.textCoptic,
      this.textPhonetic,
      this.rubric,
      required this.isSecret});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['section_id'] = Variable<String>(sectionId);
    map['part_order'] = Variable<int>(partOrder);
    map['role'] = Variable<String>(role);
    map['type'] = Variable<String>(type);
    map['text_ar'] = Variable<String>(textAr);
    if (!nullToAbsent || textCoptic != null) {
      map['text_coptic'] = Variable<String>(textCoptic);
    }
    if (!nullToAbsent || textPhonetic != null) {
      map['text_phonetic'] = Variable<String>(textPhonetic);
    }
    if (!nullToAbsent || rubric != null) {
      map['rubric'] = Variable<String>(rubric);
    }
    map['is_secret'] = Variable<bool>(isSecret);
    return map;
  }

  LiturgyPartsCompanion toCompanion(bool nullToAbsent) {
    return LiturgyPartsCompanion(
      id: Value(id),
      sectionId: Value(sectionId),
      partOrder: Value(partOrder),
      role: Value(role),
      type: Value(type),
      textAr: Value(textAr),
      textCoptic: textCoptic == null && nullToAbsent
          ? const Value.absent()
          : Value(textCoptic),
      textPhonetic: textPhonetic == null && nullToAbsent
          ? const Value.absent()
          : Value(textPhonetic),
      rubric:
          rubric == null && nullToAbsent ? const Value.absent() : Value(rubric),
      isSecret: Value(isSecret),
    );
  }

  factory LiturgyPart.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LiturgyPart(
      id: serializer.fromJson<int>(json['id']),
      sectionId: serializer.fromJson<String>(json['sectionId']),
      partOrder: serializer.fromJson<int>(json['partOrder']),
      role: serializer.fromJson<String>(json['role']),
      type: serializer.fromJson<String>(json['type']),
      textAr: serializer.fromJson<String>(json['textAr']),
      textCoptic: serializer.fromJson<String?>(json['textCoptic']),
      textPhonetic: serializer.fromJson<String?>(json['textPhonetic']),
      rubric: serializer.fromJson<String?>(json['rubric']),
      isSecret: serializer.fromJson<bool>(json['isSecret']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sectionId': serializer.toJson<String>(sectionId),
      'partOrder': serializer.toJson<int>(partOrder),
      'role': serializer.toJson<String>(role),
      'type': serializer.toJson<String>(type),
      'textAr': serializer.toJson<String>(textAr),
      'textCoptic': serializer.toJson<String?>(textCoptic),
      'textPhonetic': serializer.toJson<String?>(textPhonetic),
      'rubric': serializer.toJson<String?>(rubric),
      'isSecret': serializer.toJson<bool>(isSecret),
    };
  }

  LiturgyPart copyWith(
          {int? id,
          String? sectionId,
          int? partOrder,
          String? role,
          String? type,
          String? textAr,
          Value<String?> textCoptic = const Value.absent(),
          Value<String?> textPhonetic = const Value.absent(),
          Value<String?> rubric = const Value.absent(),
          bool? isSecret}) =>
      LiturgyPart(
        id: id ?? this.id,
        sectionId: sectionId ?? this.sectionId,
        partOrder: partOrder ?? this.partOrder,
        role: role ?? this.role,
        type: type ?? this.type,
        textAr: textAr ?? this.textAr,
        textCoptic: textCoptic.present ? textCoptic.value : this.textCoptic,
        textPhonetic:
            textPhonetic.present ? textPhonetic.value : this.textPhonetic,
        rubric: rubric.present ? rubric.value : this.rubric,
        isSecret: isSecret ?? this.isSecret,
      );
  LiturgyPart copyWithCompanion(LiturgyPartsCompanion data) {
    return LiturgyPart(
      id: data.id.present ? data.id.value : this.id,
      sectionId: data.sectionId.present ? data.sectionId.value : this.sectionId,
      partOrder: data.partOrder.present ? data.partOrder.value : this.partOrder,
      role: data.role.present ? data.role.value : this.role,
      type: data.type.present ? data.type.value : this.type,
      textAr: data.textAr.present ? data.textAr.value : this.textAr,
      textCoptic:
          data.textCoptic.present ? data.textCoptic.value : this.textCoptic,
      textPhonetic: data.textPhonetic.present
          ? data.textPhonetic.value
          : this.textPhonetic,
      rubric: data.rubric.present ? data.rubric.value : this.rubric,
      isSecret: data.isSecret.present ? data.isSecret.value : this.isSecret,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LiturgyPart(')
          ..write('id: $id, ')
          ..write('sectionId: $sectionId, ')
          ..write('partOrder: $partOrder, ')
          ..write('role: $role, ')
          ..write('type: $type, ')
          ..write('textAr: $textAr, ')
          ..write('textCoptic: $textCoptic, ')
          ..write('textPhonetic: $textPhonetic, ')
          ..write('rubric: $rubric, ')
          ..write('isSecret: $isSecret')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sectionId, partOrder, role, type, textAr,
      textCoptic, textPhonetic, rubric, isSecret);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LiturgyPart &&
          other.id == this.id &&
          other.sectionId == this.sectionId &&
          other.partOrder == this.partOrder &&
          other.role == this.role &&
          other.type == this.type &&
          other.textAr == this.textAr &&
          other.textCoptic == this.textCoptic &&
          other.textPhonetic == this.textPhonetic &&
          other.rubric == this.rubric &&
          other.isSecret == this.isSecret);
}

class LiturgyPartsCompanion extends UpdateCompanion<LiturgyPart> {
  final Value<int> id;
  final Value<String> sectionId;
  final Value<int> partOrder;
  final Value<String> role;
  final Value<String> type;
  final Value<String> textAr;
  final Value<String?> textCoptic;
  final Value<String?> textPhonetic;
  final Value<String?> rubric;
  final Value<bool> isSecret;
  const LiturgyPartsCompanion({
    this.id = const Value.absent(),
    this.sectionId = const Value.absent(),
    this.partOrder = const Value.absent(),
    this.role = const Value.absent(),
    this.type = const Value.absent(),
    this.textAr = const Value.absent(),
    this.textCoptic = const Value.absent(),
    this.textPhonetic = const Value.absent(),
    this.rubric = const Value.absent(),
    this.isSecret = const Value.absent(),
  });
  LiturgyPartsCompanion.insert({
    this.id = const Value.absent(),
    required String sectionId,
    required int partOrder,
    required String role,
    required String type,
    required String textAr,
    this.textCoptic = const Value.absent(),
    this.textPhonetic = const Value.absent(),
    this.rubric = const Value.absent(),
    this.isSecret = const Value.absent(),
  })  : sectionId = Value(sectionId),
        partOrder = Value(partOrder),
        role = Value(role),
        type = Value(type),
        textAr = Value(textAr);
  static Insertable<LiturgyPart> custom({
    Expression<int>? id,
    Expression<String>? sectionId,
    Expression<int>? partOrder,
    Expression<String>? role,
    Expression<String>? type,
    Expression<String>? textAr,
    Expression<String>? textCoptic,
    Expression<String>? textPhonetic,
    Expression<String>? rubric,
    Expression<bool>? isSecret,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sectionId != null) 'section_id': sectionId,
      if (partOrder != null) 'part_order': partOrder,
      if (role != null) 'role': role,
      if (type != null) 'type': type,
      if (textAr != null) 'text_ar': textAr,
      if (textCoptic != null) 'text_coptic': textCoptic,
      if (textPhonetic != null) 'text_phonetic': textPhonetic,
      if (rubric != null) 'rubric': rubric,
      if (isSecret != null) 'is_secret': isSecret,
    });
  }

  LiturgyPartsCompanion copyWith(
      {Value<int>? id,
      Value<String>? sectionId,
      Value<int>? partOrder,
      Value<String>? role,
      Value<String>? type,
      Value<String>? textAr,
      Value<String?>? textCoptic,
      Value<String?>? textPhonetic,
      Value<String?>? rubric,
      Value<bool>? isSecret}) {
    return LiturgyPartsCompanion(
      id: id ?? this.id,
      sectionId: sectionId ?? this.sectionId,
      partOrder: partOrder ?? this.partOrder,
      role: role ?? this.role,
      type: type ?? this.type,
      textAr: textAr ?? this.textAr,
      textCoptic: textCoptic ?? this.textCoptic,
      textPhonetic: textPhonetic ?? this.textPhonetic,
      rubric: rubric ?? this.rubric,
      isSecret: isSecret ?? this.isSecret,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sectionId.present) {
      map['section_id'] = Variable<String>(sectionId.value);
    }
    if (partOrder.present) {
      map['part_order'] = Variable<int>(partOrder.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (textAr.present) {
      map['text_ar'] = Variable<String>(textAr.value);
    }
    if (textCoptic.present) {
      map['text_coptic'] = Variable<String>(textCoptic.value);
    }
    if (textPhonetic.present) {
      map['text_phonetic'] = Variable<String>(textPhonetic.value);
    }
    if (rubric.present) {
      map['rubric'] = Variable<String>(rubric.value);
    }
    if (isSecret.present) {
      map['is_secret'] = Variable<bool>(isSecret.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LiturgyPartsCompanion(')
          ..write('id: $id, ')
          ..write('sectionId: $sectionId, ')
          ..write('partOrder: $partOrder, ')
          ..write('role: $role, ')
          ..write('type: $type, ')
          ..write('textAr: $textAr, ')
          ..write('textCoptic: $textCoptic, ')
          ..write('textPhonetic: $textPhonetic, ')
          ..write('rubric: $rubric, ')
          ..write('isSecret: $isSecret')
          ..write(')'))
        .toString();
  }
}

class $HymnBooksTable extends HymnBooks
    with TableInfo<$HymnBooksTable, HymnBook> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HymnBooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameArMeta = const VerificationMeta('nameAr');
  @override
  late final GeneratedColumn<String> nameAr = GeneratedColumn<String>(
      'name_ar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bookOrderMeta =
      const VerificationMeta('bookOrder');
  @override
  late final GeneratedColumn<int> bookOrder = GeneratedColumn<int>(
      'book_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, nameAr, bookOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hymn_books';
  @override
  VerificationContext validateIntegrity(Insertable<HymnBook> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name_ar')) {
      context.handle(_nameArMeta,
          nameAr.isAcceptableOrUnknown(data['name_ar']!, _nameArMeta));
    } else if (isInserting) {
      context.missing(_nameArMeta);
    }
    if (data.containsKey('book_order')) {
      context.handle(_bookOrderMeta,
          bookOrder.isAcceptableOrUnknown(data['book_order']!, _bookOrderMeta));
    } else if (isInserting) {
      context.missing(_bookOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HymnBook map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HymnBook(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      nameAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_ar'])!,
      bookOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}book_order'])!,
    );
  }

  @override
  $HymnBooksTable createAlias(String alias) {
    return $HymnBooksTable(attachedDatabase, alias);
  }
}

class HymnBook extends DataClass implements Insertable<HymnBook> {
  final String id;
  final String nameAr;
  final int bookOrder;
  const HymnBook(
      {required this.id, required this.nameAr, required this.bookOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name_ar'] = Variable<String>(nameAr);
    map['book_order'] = Variable<int>(bookOrder);
    return map;
  }

  HymnBooksCompanion toCompanion(bool nullToAbsent) {
    return HymnBooksCompanion(
      id: Value(id),
      nameAr: Value(nameAr),
      bookOrder: Value(bookOrder),
    );
  }

  factory HymnBook.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HymnBook(
      id: serializer.fromJson<String>(json['id']),
      nameAr: serializer.fromJson<String>(json['nameAr']),
      bookOrder: serializer.fromJson<int>(json['bookOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nameAr': serializer.toJson<String>(nameAr),
      'bookOrder': serializer.toJson<int>(bookOrder),
    };
  }

  HymnBook copyWith({String? id, String? nameAr, int? bookOrder}) => HymnBook(
        id: id ?? this.id,
        nameAr: nameAr ?? this.nameAr,
        bookOrder: bookOrder ?? this.bookOrder,
      );
  HymnBook copyWithCompanion(HymnBooksCompanion data) {
    return HymnBook(
      id: data.id.present ? data.id.value : this.id,
      nameAr: data.nameAr.present ? data.nameAr.value : this.nameAr,
      bookOrder: data.bookOrder.present ? data.bookOrder.value : this.bookOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HymnBook(')
          ..write('id: $id, ')
          ..write('nameAr: $nameAr, ')
          ..write('bookOrder: $bookOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nameAr, bookOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HymnBook &&
          other.id == this.id &&
          other.nameAr == this.nameAr &&
          other.bookOrder == this.bookOrder);
}

class HymnBooksCompanion extends UpdateCompanion<HymnBook> {
  final Value<String> id;
  final Value<String> nameAr;
  final Value<int> bookOrder;
  final Value<int> rowid;
  const HymnBooksCompanion({
    this.id = const Value.absent(),
    this.nameAr = const Value.absent(),
    this.bookOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HymnBooksCompanion.insert({
    required String id,
    required String nameAr,
    required int bookOrder,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        nameAr = Value(nameAr),
        bookOrder = Value(bookOrder);
  static Insertable<HymnBook> custom({
    Expression<String>? id,
    Expression<String>? nameAr,
    Expression<int>? bookOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameAr != null) 'name_ar': nameAr,
      if (bookOrder != null) 'book_order': bookOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HymnBooksCompanion copyWith(
      {Value<String>? id,
      Value<String>? nameAr,
      Value<int>? bookOrder,
      Value<int>? rowid}) {
    return HymnBooksCompanion(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      bookOrder: bookOrder ?? this.bookOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nameAr.present) {
      map['name_ar'] = Variable<String>(nameAr.value);
    }
    if (bookOrder.present) {
      map['book_order'] = Variable<int>(bookOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HymnBooksCompanion(')
          ..write('id: $id, ')
          ..write('nameAr: $nameAr, ')
          ..write('bookOrder: $bookOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HymnsTable extends Hymns with TableInfo<$HymnsTable, Hymn> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HymnsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
      'book_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES hymn_books (id)'));
  static const VerificationMeta _nameArMeta = const VerificationMeta('nameAr');
  @override
  late final GeneratedColumn<String> nameAr = GeneratedColumn<String>(
      'name_ar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameCopticMeta =
      const VerificationMeta('nameCoptic');
  @override
  late final GeneratedColumn<String> nameCoptic = GeneratedColumn<String>(
      'name_coptic', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _occasionMeta =
      const VerificationMeta('occasion');
  @override
  late final GeneratedColumn<String> occasion = GeneratedColumn<String>(
      'occasion', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _toneMeta = const VerificationMeta('tone');
  @override
  late final GeneratedColumn<String> tone = GeneratedColumn<String>(
      'tone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _hymnOrderMeta =
      const VerificationMeta('hymnOrder');
  @override
  late final GeneratedColumn<int> hymnOrder = GeneratedColumn<int>(
      'hymn_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, bookId, nameAr, nameCoptic, occasion, tone, hymnOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hymns';
  @override
  VerificationContext validateIntegrity(Insertable<Hymn> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('book_id')) {
      context.handle(_bookIdMeta,
          bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta));
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('name_ar')) {
      context.handle(_nameArMeta,
          nameAr.isAcceptableOrUnknown(data['name_ar']!, _nameArMeta));
    } else if (isInserting) {
      context.missing(_nameArMeta);
    }
    if (data.containsKey('name_coptic')) {
      context.handle(
          _nameCopticMeta,
          nameCoptic.isAcceptableOrUnknown(
              data['name_coptic']!, _nameCopticMeta));
    }
    if (data.containsKey('occasion')) {
      context.handle(_occasionMeta,
          occasion.isAcceptableOrUnknown(data['occasion']!, _occasionMeta));
    } else if (isInserting) {
      context.missing(_occasionMeta);
    }
    if (data.containsKey('tone')) {
      context.handle(
          _toneMeta, tone.isAcceptableOrUnknown(data['tone']!, _toneMeta));
    } else if (isInserting) {
      context.missing(_toneMeta);
    }
    if (data.containsKey('hymn_order')) {
      context.handle(_hymnOrderMeta,
          hymnOrder.isAcceptableOrUnknown(data['hymn_order']!, _hymnOrderMeta));
    } else if (isInserting) {
      context.missing(_hymnOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Hymn map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Hymn(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      bookId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}book_id'])!,
      nameAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_ar'])!,
      nameCoptic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_coptic']),
      occasion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}occasion'])!,
      tone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tone'])!,
      hymnOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}hymn_order'])!,
    );
  }

  @override
  $HymnsTable createAlias(String alias) {
    return $HymnsTable(attachedDatabase, alias);
  }
}

class Hymn extends DataClass implements Insertable<Hymn> {
  final String id;
  final String bookId;
  final String nameAr;
  final String? nameCoptic;
  final String occasion;
  final String tone;
  final int hymnOrder;
  const Hymn(
      {required this.id,
      required this.bookId,
      required this.nameAr,
      this.nameCoptic,
      required this.occasion,
      required this.tone,
      required this.hymnOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['book_id'] = Variable<String>(bookId);
    map['name_ar'] = Variable<String>(nameAr);
    if (!nullToAbsent || nameCoptic != null) {
      map['name_coptic'] = Variable<String>(nameCoptic);
    }
    map['occasion'] = Variable<String>(occasion);
    map['tone'] = Variable<String>(tone);
    map['hymn_order'] = Variable<int>(hymnOrder);
    return map;
  }

  HymnsCompanion toCompanion(bool nullToAbsent) {
    return HymnsCompanion(
      id: Value(id),
      bookId: Value(bookId),
      nameAr: Value(nameAr),
      nameCoptic: nameCoptic == null && nullToAbsent
          ? const Value.absent()
          : Value(nameCoptic),
      occasion: Value(occasion),
      tone: Value(tone),
      hymnOrder: Value(hymnOrder),
    );
  }

  factory Hymn.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Hymn(
      id: serializer.fromJson<String>(json['id']),
      bookId: serializer.fromJson<String>(json['bookId']),
      nameAr: serializer.fromJson<String>(json['nameAr']),
      nameCoptic: serializer.fromJson<String?>(json['nameCoptic']),
      occasion: serializer.fromJson<String>(json['occasion']),
      tone: serializer.fromJson<String>(json['tone']),
      hymnOrder: serializer.fromJson<int>(json['hymnOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'bookId': serializer.toJson<String>(bookId),
      'nameAr': serializer.toJson<String>(nameAr),
      'nameCoptic': serializer.toJson<String?>(nameCoptic),
      'occasion': serializer.toJson<String>(occasion),
      'tone': serializer.toJson<String>(tone),
      'hymnOrder': serializer.toJson<int>(hymnOrder),
    };
  }

  Hymn copyWith(
          {String? id,
          String? bookId,
          String? nameAr,
          Value<String?> nameCoptic = const Value.absent(),
          String? occasion,
          String? tone,
          int? hymnOrder}) =>
      Hymn(
        id: id ?? this.id,
        bookId: bookId ?? this.bookId,
        nameAr: nameAr ?? this.nameAr,
        nameCoptic: nameCoptic.present ? nameCoptic.value : this.nameCoptic,
        occasion: occasion ?? this.occasion,
        tone: tone ?? this.tone,
        hymnOrder: hymnOrder ?? this.hymnOrder,
      );
  Hymn copyWithCompanion(HymnsCompanion data) {
    return Hymn(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      nameAr: data.nameAr.present ? data.nameAr.value : this.nameAr,
      nameCoptic:
          data.nameCoptic.present ? data.nameCoptic.value : this.nameCoptic,
      occasion: data.occasion.present ? data.occasion.value : this.occasion,
      tone: data.tone.present ? data.tone.value : this.tone,
      hymnOrder: data.hymnOrder.present ? data.hymnOrder.value : this.hymnOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Hymn(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('nameAr: $nameAr, ')
          ..write('nameCoptic: $nameCoptic, ')
          ..write('occasion: $occasion, ')
          ..write('tone: $tone, ')
          ..write('hymnOrder: $hymnOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, bookId, nameAr, nameCoptic, occasion, tone, hymnOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Hymn &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.nameAr == this.nameAr &&
          other.nameCoptic == this.nameCoptic &&
          other.occasion == this.occasion &&
          other.tone == this.tone &&
          other.hymnOrder == this.hymnOrder);
}

class HymnsCompanion extends UpdateCompanion<Hymn> {
  final Value<String> id;
  final Value<String> bookId;
  final Value<String> nameAr;
  final Value<String?> nameCoptic;
  final Value<String> occasion;
  final Value<String> tone;
  final Value<int> hymnOrder;
  final Value<int> rowid;
  const HymnsCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.nameAr = const Value.absent(),
    this.nameCoptic = const Value.absent(),
    this.occasion = const Value.absent(),
    this.tone = const Value.absent(),
    this.hymnOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HymnsCompanion.insert({
    required String id,
    required String bookId,
    required String nameAr,
    this.nameCoptic = const Value.absent(),
    required String occasion,
    required String tone,
    required int hymnOrder,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        bookId = Value(bookId),
        nameAr = Value(nameAr),
        occasion = Value(occasion),
        tone = Value(tone),
        hymnOrder = Value(hymnOrder);
  static Insertable<Hymn> custom({
    Expression<String>? id,
    Expression<String>? bookId,
    Expression<String>? nameAr,
    Expression<String>? nameCoptic,
    Expression<String>? occasion,
    Expression<String>? tone,
    Expression<int>? hymnOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (nameAr != null) 'name_ar': nameAr,
      if (nameCoptic != null) 'name_coptic': nameCoptic,
      if (occasion != null) 'occasion': occasion,
      if (tone != null) 'tone': tone,
      if (hymnOrder != null) 'hymn_order': hymnOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HymnsCompanion copyWith(
      {Value<String>? id,
      Value<String>? bookId,
      Value<String>? nameAr,
      Value<String?>? nameCoptic,
      Value<String>? occasion,
      Value<String>? tone,
      Value<int>? hymnOrder,
      Value<int>? rowid}) {
    return HymnsCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      nameAr: nameAr ?? this.nameAr,
      nameCoptic: nameCoptic ?? this.nameCoptic,
      occasion: occasion ?? this.occasion,
      tone: tone ?? this.tone,
      hymnOrder: hymnOrder ?? this.hymnOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    if (nameAr.present) {
      map['name_ar'] = Variable<String>(nameAr.value);
    }
    if (nameCoptic.present) {
      map['name_coptic'] = Variable<String>(nameCoptic.value);
    }
    if (occasion.present) {
      map['occasion'] = Variable<String>(occasion.value);
    }
    if (tone.present) {
      map['tone'] = Variable<String>(tone.value);
    }
    if (hymnOrder.present) {
      map['hymn_order'] = Variable<int>(hymnOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HymnsCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('nameAr: $nameAr, ')
          ..write('nameCoptic: $nameCoptic, ')
          ..write('occasion: $occasion, ')
          ..write('tone: $tone, ')
          ..write('hymnOrder: $hymnOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HymnSegmentsTable extends HymnSegments
    with TableInfo<$HymnSegmentsTable, HymnSegment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HymnSegmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _hymnIdMeta = const VerificationMeta('hymnId');
  @override
  late final GeneratedColumn<String> hymnId = GeneratedColumn<String>(
      'hymn_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES hymns (id)'));
  static const VerificationMeta _segmentOrderMeta =
      const VerificationMeta('segmentOrder');
  @override
  late final GeneratedColumn<int> segmentOrder = GeneratedColumn<int>(
      'segment_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _lineNumberMeta =
      const VerificationMeta('lineNumber');
  @override
  late final GeneratedColumn<int> lineNumber = GeneratedColumn<int>(
      'line_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _copticMeta = const VerificationMeta('coptic');
  @override
  late final GeneratedColumn<String> coptic = GeneratedColumn<String>(
      'coptic', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneticMeta =
      const VerificationMeta('phonetic');
  @override
  late final GeneratedColumn<String> phonetic = GeneratedColumn<String>(
      'phonetic', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _arabicMeta = const VerificationMeta('arabic');
  @override
  late final GeneratedColumn<String> arabic = GeneratedColumn<String>(
      'arabic', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _syllablesJsonMeta =
      const VerificationMeta('syllablesJson');
  @override
  late final GeneratedColumn<String> syllablesJson = GeneratedColumn<String>(
      'syllables_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        hymnId,
        segmentOrder,
        lineNumber,
        coptic,
        phonetic,
        arabic,
        syllablesJson
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hymn_segments';
  @override
  VerificationContext validateIntegrity(Insertable<HymnSegment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('hymn_id')) {
      context.handle(_hymnIdMeta,
          hymnId.isAcceptableOrUnknown(data['hymn_id']!, _hymnIdMeta));
    } else if (isInserting) {
      context.missing(_hymnIdMeta);
    }
    if (data.containsKey('segment_order')) {
      context.handle(
          _segmentOrderMeta,
          segmentOrder.isAcceptableOrUnknown(
              data['segment_order']!, _segmentOrderMeta));
    } else if (isInserting) {
      context.missing(_segmentOrderMeta);
    }
    if (data.containsKey('line_number')) {
      context.handle(
          _lineNumberMeta,
          lineNumber.isAcceptableOrUnknown(
              data['line_number']!, _lineNumberMeta));
    } else if (isInserting) {
      context.missing(_lineNumberMeta);
    }
    if (data.containsKey('coptic')) {
      context.handle(_copticMeta,
          coptic.isAcceptableOrUnknown(data['coptic']!, _copticMeta));
    } else if (isInserting) {
      context.missing(_copticMeta);
    }
    if (data.containsKey('phonetic')) {
      context.handle(_phoneticMeta,
          phonetic.isAcceptableOrUnknown(data['phonetic']!, _phoneticMeta));
    } else if (isInserting) {
      context.missing(_phoneticMeta);
    }
    if (data.containsKey('arabic')) {
      context.handle(_arabicMeta,
          arabic.isAcceptableOrUnknown(data['arabic']!, _arabicMeta));
    } else if (isInserting) {
      context.missing(_arabicMeta);
    }
    if (data.containsKey('syllables_json')) {
      context.handle(
          _syllablesJsonMeta,
          syllablesJson.isAcceptableOrUnknown(
              data['syllables_json']!, _syllablesJsonMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HymnSegment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HymnSegment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      hymnId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hymn_id'])!,
      segmentOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}segment_order'])!,
      lineNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}line_number'])!,
      coptic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}coptic'])!,
      phonetic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phonetic'])!,
      arabic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}arabic'])!,
      syllablesJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}syllables_json']),
    );
  }

  @override
  $HymnSegmentsTable createAlias(String alias) {
    return $HymnSegmentsTable(attachedDatabase, alias);
  }
}

class HymnSegment extends DataClass implements Insertable<HymnSegment> {
  final int id;
  final String hymnId;
  final int segmentOrder;
  final int lineNumber;
  final String coptic;
  final String phonetic;
  final String arabic;
  final String? syllablesJson;
  const HymnSegment(
      {required this.id,
      required this.hymnId,
      required this.segmentOrder,
      required this.lineNumber,
      required this.coptic,
      required this.phonetic,
      required this.arabic,
      this.syllablesJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['hymn_id'] = Variable<String>(hymnId);
    map['segment_order'] = Variable<int>(segmentOrder);
    map['line_number'] = Variable<int>(lineNumber);
    map['coptic'] = Variable<String>(coptic);
    map['phonetic'] = Variable<String>(phonetic);
    map['arabic'] = Variable<String>(arabic);
    if (!nullToAbsent || syllablesJson != null) {
      map['syllables_json'] = Variable<String>(syllablesJson);
    }
    return map;
  }

  HymnSegmentsCompanion toCompanion(bool nullToAbsent) {
    return HymnSegmentsCompanion(
      id: Value(id),
      hymnId: Value(hymnId),
      segmentOrder: Value(segmentOrder),
      lineNumber: Value(lineNumber),
      coptic: Value(coptic),
      phonetic: Value(phonetic),
      arabic: Value(arabic),
      syllablesJson: syllablesJson == null && nullToAbsent
          ? const Value.absent()
          : Value(syllablesJson),
    );
  }

  factory HymnSegment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HymnSegment(
      id: serializer.fromJson<int>(json['id']),
      hymnId: serializer.fromJson<String>(json['hymnId']),
      segmentOrder: serializer.fromJson<int>(json['segmentOrder']),
      lineNumber: serializer.fromJson<int>(json['lineNumber']),
      coptic: serializer.fromJson<String>(json['coptic']),
      phonetic: serializer.fromJson<String>(json['phonetic']),
      arabic: serializer.fromJson<String>(json['arabic']),
      syllablesJson: serializer.fromJson<String?>(json['syllablesJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'hymnId': serializer.toJson<String>(hymnId),
      'segmentOrder': serializer.toJson<int>(segmentOrder),
      'lineNumber': serializer.toJson<int>(lineNumber),
      'coptic': serializer.toJson<String>(coptic),
      'phonetic': serializer.toJson<String>(phonetic),
      'arabic': serializer.toJson<String>(arabic),
      'syllablesJson': serializer.toJson<String?>(syllablesJson),
    };
  }

  HymnSegment copyWith(
          {int? id,
          String? hymnId,
          int? segmentOrder,
          int? lineNumber,
          String? coptic,
          String? phonetic,
          String? arabic,
          Value<String?> syllablesJson = const Value.absent()}) =>
      HymnSegment(
        id: id ?? this.id,
        hymnId: hymnId ?? this.hymnId,
        segmentOrder: segmentOrder ?? this.segmentOrder,
        lineNumber: lineNumber ?? this.lineNumber,
        coptic: coptic ?? this.coptic,
        phonetic: phonetic ?? this.phonetic,
        arabic: arabic ?? this.arabic,
        syllablesJson:
            syllablesJson.present ? syllablesJson.value : this.syllablesJson,
      );
  HymnSegment copyWithCompanion(HymnSegmentsCompanion data) {
    return HymnSegment(
      id: data.id.present ? data.id.value : this.id,
      hymnId: data.hymnId.present ? data.hymnId.value : this.hymnId,
      segmentOrder: data.segmentOrder.present
          ? data.segmentOrder.value
          : this.segmentOrder,
      lineNumber:
          data.lineNumber.present ? data.lineNumber.value : this.lineNumber,
      coptic: data.coptic.present ? data.coptic.value : this.coptic,
      phonetic: data.phonetic.present ? data.phonetic.value : this.phonetic,
      arabic: data.arabic.present ? data.arabic.value : this.arabic,
      syllablesJson: data.syllablesJson.present
          ? data.syllablesJson.value
          : this.syllablesJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HymnSegment(')
          ..write('id: $id, ')
          ..write('hymnId: $hymnId, ')
          ..write('segmentOrder: $segmentOrder, ')
          ..write('lineNumber: $lineNumber, ')
          ..write('coptic: $coptic, ')
          ..write('phonetic: $phonetic, ')
          ..write('arabic: $arabic, ')
          ..write('syllablesJson: $syllablesJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, hymnId, segmentOrder, lineNumber, coptic,
      phonetic, arabic, syllablesJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HymnSegment &&
          other.id == this.id &&
          other.hymnId == this.hymnId &&
          other.segmentOrder == this.segmentOrder &&
          other.lineNumber == this.lineNumber &&
          other.coptic == this.coptic &&
          other.phonetic == this.phonetic &&
          other.arabic == this.arabic &&
          other.syllablesJson == this.syllablesJson);
}

class HymnSegmentsCompanion extends UpdateCompanion<HymnSegment> {
  final Value<int> id;
  final Value<String> hymnId;
  final Value<int> segmentOrder;
  final Value<int> lineNumber;
  final Value<String> coptic;
  final Value<String> phonetic;
  final Value<String> arabic;
  final Value<String?> syllablesJson;
  const HymnSegmentsCompanion({
    this.id = const Value.absent(),
    this.hymnId = const Value.absent(),
    this.segmentOrder = const Value.absent(),
    this.lineNumber = const Value.absent(),
    this.coptic = const Value.absent(),
    this.phonetic = const Value.absent(),
    this.arabic = const Value.absent(),
    this.syllablesJson = const Value.absent(),
  });
  HymnSegmentsCompanion.insert({
    this.id = const Value.absent(),
    required String hymnId,
    required int segmentOrder,
    required int lineNumber,
    required String coptic,
    required String phonetic,
    required String arabic,
    this.syllablesJson = const Value.absent(),
  })  : hymnId = Value(hymnId),
        segmentOrder = Value(segmentOrder),
        lineNumber = Value(lineNumber),
        coptic = Value(coptic),
        phonetic = Value(phonetic),
        arabic = Value(arabic);
  static Insertable<HymnSegment> custom({
    Expression<int>? id,
    Expression<String>? hymnId,
    Expression<int>? segmentOrder,
    Expression<int>? lineNumber,
    Expression<String>? coptic,
    Expression<String>? phonetic,
    Expression<String>? arabic,
    Expression<String>? syllablesJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (hymnId != null) 'hymn_id': hymnId,
      if (segmentOrder != null) 'segment_order': segmentOrder,
      if (lineNumber != null) 'line_number': lineNumber,
      if (coptic != null) 'coptic': coptic,
      if (phonetic != null) 'phonetic': phonetic,
      if (arabic != null) 'arabic': arabic,
      if (syllablesJson != null) 'syllables_json': syllablesJson,
    });
  }

  HymnSegmentsCompanion copyWith(
      {Value<int>? id,
      Value<String>? hymnId,
      Value<int>? segmentOrder,
      Value<int>? lineNumber,
      Value<String>? coptic,
      Value<String>? phonetic,
      Value<String>? arabic,
      Value<String?>? syllablesJson}) {
    return HymnSegmentsCompanion(
      id: id ?? this.id,
      hymnId: hymnId ?? this.hymnId,
      segmentOrder: segmentOrder ?? this.segmentOrder,
      lineNumber: lineNumber ?? this.lineNumber,
      coptic: coptic ?? this.coptic,
      phonetic: phonetic ?? this.phonetic,
      arabic: arabic ?? this.arabic,
      syllablesJson: syllablesJson ?? this.syllablesJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (hymnId.present) {
      map['hymn_id'] = Variable<String>(hymnId.value);
    }
    if (segmentOrder.present) {
      map['segment_order'] = Variable<int>(segmentOrder.value);
    }
    if (lineNumber.present) {
      map['line_number'] = Variable<int>(lineNumber.value);
    }
    if (coptic.present) {
      map['coptic'] = Variable<String>(coptic.value);
    }
    if (phonetic.present) {
      map['phonetic'] = Variable<String>(phonetic.value);
    }
    if (arabic.present) {
      map['arabic'] = Variable<String>(arabic.value);
    }
    if (syllablesJson.present) {
      map['syllables_json'] = Variable<String>(syllablesJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HymnSegmentsCompanion(')
          ..write('id: $id, ')
          ..write('hymnId: $hymnId, ')
          ..write('segmentOrder: $segmentOrder, ')
          ..write('lineNumber: $lineNumber, ')
          ..write('coptic: $coptic, ')
          ..write('phonetic: $phonetic, ')
          ..write('arabic: $arabic, ')
          ..write('syllablesJson: $syllablesJson')
          ..write(')'))
        .toString();
  }
}

class $SynaxariumEntriesTable extends SynaxariumEntries
    with TableInfo<$SynaxariumEntriesTable, SynaxariumEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SynaxariumEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _copticMonthMeta =
      const VerificationMeta('copticMonth');
  @override
  late final GeneratedColumn<int> copticMonth = GeneratedColumn<int>(
      'coptic_month', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _copticDayMeta =
      const VerificationMeta('copticDay');
  @override
  late final GeneratedColumn<int> copticDay = GeneratedColumn<int>(
      'coptic_day', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _entryOrderMeta =
      const VerificationMeta('entryOrder');
  @override
  late final GeneratedColumn<int> entryOrder = GeneratedColumn<int>(
      'entry_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _shortTextMeta =
      const VerificationMeta('shortText');
  @override
  late final GeneratedColumn<String> shortText = GeneratedColumn<String>(
      'short_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fullTextMeta =
      const VerificationMeta('fullText');
  @override
  late final GeneratedColumn<String> fullText = GeneratedColumn<String>(
      'full_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        copticMonth,
        copticDay,
        entryOrder,
        title,
        type,
        shortText,
        fullText
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'synaxarium_entries';
  @override
  VerificationContext validateIntegrity(Insertable<SynaxariumEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('coptic_month')) {
      context.handle(
          _copticMonthMeta,
          copticMonth.isAcceptableOrUnknown(
              data['coptic_month']!, _copticMonthMeta));
    } else if (isInserting) {
      context.missing(_copticMonthMeta);
    }
    if (data.containsKey('coptic_day')) {
      context.handle(_copticDayMeta,
          copticDay.isAcceptableOrUnknown(data['coptic_day']!, _copticDayMeta));
    } else if (isInserting) {
      context.missing(_copticDayMeta);
    }
    if (data.containsKey('entry_order')) {
      context.handle(
          _entryOrderMeta,
          entryOrder.isAcceptableOrUnknown(
              data['entry_order']!, _entryOrderMeta));
    } else if (isInserting) {
      context.missing(_entryOrderMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('short_text')) {
      context.handle(_shortTextMeta,
          shortText.isAcceptableOrUnknown(data['short_text']!, _shortTextMeta));
    } else if (isInserting) {
      context.missing(_shortTextMeta);
    }
    if (data.containsKey('full_text')) {
      context.handle(_fullTextMeta,
          fullText.isAcceptableOrUnknown(data['full_text']!, _fullTextMeta));
    } else if (isInserting) {
      context.missing(_fullTextMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SynaxariumEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SynaxariumEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      copticMonth: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}coptic_month'])!,
      copticDay: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}coptic_day'])!,
      entryOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}entry_order'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      shortText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}short_text'])!,
      fullText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}full_text'])!,
    );
  }

  @override
  $SynaxariumEntriesTable createAlias(String alias) {
    return $SynaxariumEntriesTable(attachedDatabase, alias);
  }
}

class SynaxariumEntry extends DataClass implements Insertable<SynaxariumEntry> {
  final String id;
  final int copticMonth;
  final int copticDay;
  final int entryOrder;
  final String title;
  final String type;
  final String shortText;
  final String fullText;
  const SynaxariumEntry(
      {required this.id,
      required this.copticMonth,
      required this.copticDay,
      required this.entryOrder,
      required this.title,
      required this.type,
      required this.shortText,
      required this.fullText});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['coptic_month'] = Variable<int>(copticMonth);
    map['coptic_day'] = Variable<int>(copticDay);
    map['entry_order'] = Variable<int>(entryOrder);
    map['title'] = Variable<String>(title);
    map['type'] = Variable<String>(type);
    map['short_text'] = Variable<String>(shortText);
    map['full_text'] = Variable<String>(fullText);
    return map;
  }

  SynaxariumEntriesCompanion toCompanion(bool nullToAbsent) {
    return SynaxariumEntriesCompanion(
      id: Value(id),
      copticMonth: Value(copticMonth),
      copticDay: Value(copticDay),
      entryOrder: Value(entryOrder),
      title: Value(title),
      type: Value(type),
      shortText: Value(shortText),
      fullText: Value(fullText),
    );
  }

  factory SynaxariumEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SynaxariumEntry(
      id: serializer.fromJson<String>(json['id']),
      copticMonth: serializer.fromJson<int>(json['copticMonth']),
      copticDay: serializer.fromJson<int>(json['copticDay']),
      entryOrder: serializer.fromJson<int>(json['entryOrder']),
      title: serializer.fromJson<String>(json['title']),
      type: serializer.fromJson<String>(json['type']),
      shortText: serializer.fromJson<String>(json['shortText']),
      fullText: serializer.fromJson<String>(json['fullText']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'copticMonth': serializer.toJson<int>(copticMonth),
      'copticDay': serializer.toJson<int>(copticDay),
      'entryOrder': serializer.toJson<int>(entryOrder),
      'title': serializer.toJson<String>(title),
      'type': serializer.toJson<String>(type),
      'shortText': serializer.toJson<String>(shortText),
      'fullText': serializer.toJson<String>(fullText),
    };
  }

  SynaxariumEntry copyWith(
          {String? id,
          int? copticMonth,
          int? copticDay,
          int? entryOrder,
          String? title,
          String? type,
          String? shortText,
          String? fullText}) =>
      SynaxariumEntry(
        id: id ?? this.id,
        copticMonth: copticMonth ?? this.copticMonth,
        copticDay: copticDay ?? this.copticDay,
        entryOrder: entryOrder ?? this.entryOrder,
        title: title ?? this.title,
        type: type ?? this.type,
        shortText: shortText ?? this.shortText,
        fullText: fullText ?? this.fullText,
      );
  SynaxariumEntry copyWithCompanion(SynaxariumEntriesCompanion data) {
    return SynaxariumEntry(
      id: data.id.present ? data.id.value : this.id,
      copticMonth:
          data.copticMonth.present ? data.copticMonth.value : this.copticMonth,
      copticDay: data.copticDay.present ? data.copticDay.value : this.copticDay,
      entryOrder:
          data.entryOrder.present ? data.entryOrder.value : this.entryOrder,
      title: data.title.present ? data.title.value : this.title,
      type: data.type.present ? data.type.value : this.type,
      shortText: data.shortText.present ? data.shortText.value : this.shortText,
      fullText: data.fullText.present ? data.fullText.value : this.fullText,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SynaxariumEntry(')
          ..write('id: $id, ')
          ..write('copticMonth: $copticMonth, ')
          ..write('copticDay: $copticDay, ')
          ..write('entryOrder: $entryOrder, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('shortText: $shortText, ')
          ..write('fullText: $fullText')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, copticMonth, copticDay, entryOrder, title, type, shortText, fullText);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SynaxariumEntry &&
          other.id == this.id &&
          other.copticMonth == this.copticMonth &&
          other.copticDay == this.copticDay &&
          other.entryOrder == this.entryOrder &&
          other.title == this.title &&
          other.type == this.type &&
          other.shortText == this.shortText &&
          other.fullText == this.fullText);
}

class SynaxariumEntriesCompanion extends UpdateCompanion<SynaxariumEntry> {
  final Value<String> id;
  final Value<int> copticMonth;
  final Value<int> copticDay;
  final Value<int> entryOrder;
  final Value<String> title;
  final Value<String> type;
  final Value<String> shortText;
  final Value<String> fullText;
  final Value<int> rowid;
  const SynaxariumEntriesCompanion({
    this.id = const Value.absent(),
    this.copticMonth = const Value.absent(),
    this.copticDay = const Value.absent(),
    this.entryOrder = const Value.absent(),
    this.title = const Value.absent(),
    this.type = const Value.absent(),
    this.shortText = const Value.absent(),
    this.fullText = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SynaxariumEntriesCompanion.insert({
    required String id,
    required int copticMonth,
    required int copticDay,
    required int entryOrder,
    required String title,
    required String type,
    required String shortText,
    required String fullText,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        copticMonth = Value(copticMonth),
        copticDay = Value(copticDay),
        entryOrder = Value(entryOrder),
        title = Value(title),
        type = Value(type),
        shortText = Value(shortText),
        fullText = Value(fullText);
  static Insertable<SynaxariumEntry> custom({
    Expression<String>? id,
    Expression<int>? copticMonth,
    Expression<int>? copticDay,
    Expression<int>? entryOrder,
    Expression<String>? title,
    Expression<String>? type,
    Expression<String>? shortText,
    Expression<String>? fullText,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (copticMonth != null) 'coptic_month': copticMonth,
      if (copticDay != null) 'coptic_day': copticDay,
      if (entryOrder != null) 'entry_order': entryOrder,
      if (title != null) 'title': title,
      if (type != null) 'type': type,
      if (shortText != null) 'short_text': shortText,
      if (fullText != null) 'full_text': fullText,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SynaxariumEntriesCompanion copyWith(
      {Value<String>? id,
      Value<int>? copticMonth,
      Value<int>? copticDay,
      Value<int>? entryOrder,
      Value<String>? title,
      Value<String>? type,
      Value<String>? shortText,
      Value<String>? fullText,
      Value<int>? rowid}) {
    return SynaxariumEntriesCompanion(
      id: id ?? this.id,
      copticMonth: copticMonth ?? this.copticMonth,
      copticDay: copticDay ?? this.copticDay,
      entryOrder: entryOrder ?? this.entryOrder,
      title: title ?? this.title,
      type: type ?? this.type,
      shortText: shortText ?? this.shortText,
      fullText: fullText ?? this.fullText,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (copticMonth.present) {
      map['coptic_month'] = Variable<int>(copticMonth.value);
    }
    if (copticDay.present) {
      map['coptic_day'] = Variable<int>(copticDay.value);
    }
    if (entryOrder.present) {
      map['entry_order'] = Variable<int>(entryOrder.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (shortText.present) {
      map['short_text'] = Variable<String>(shortText.value);
    }
    if (fullText.present) {
      map['full_text'] = Variable<String>(fullText.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SynaxariumEntriesCompanion(')
          ..write('id: $id, ')
          ..write('copticMonth: $copticMonth, ')
          ..write('copticDay: $copticDay, ')
          ..write('entryOrder: $entryOrder, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('shortText: $shortText, ')
          ..write('fullText: $fullText, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KatamerosReadingsTable extends KatamerosReadings
    with TableInfo<$KatamerosReadingsTable, KatamerosReading> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KatamerosReadingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _copticMonthMeta =
      const VerificationMeta('copticMonth');
  @override
  late final GeneratedColumn<int> copticMonth = GeneratedColumn<int>(
      'coptic_month', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _copticDayMeta =
      const VerificationMeta('copticDay');
  @override
  late final GeneratedColumn<int> copticDay = GeneratedColumn<int>(
      'coptic_day', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _periodTypeMeta =
      const VerificationMeta('periodType');
  @override
  late final GeneratedColumn<String> periodType = GeneratedColumn<String>(
      'period_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _riteMeta = const VerificationMeta('rite');
  @override
  late final GeneratedColumn<String> rite = GeneratedColumn<String>(
      'rite', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _serviceTypeMeta =
      const VerificationMeta('serviceType');
  @override
  late final GeneratedColumn<String> serviceType = GeneratedColumn<String>(
      'service_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _readingTypeMeta =
      const VerificationMeta('readingType');
  @override
  late final GeneratedColumn<String> readingType = GeneratedColumn<String>(
      'reading_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _referenceMeta =
      const VerificationMeta('reference');
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
      'reference', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _synaxariumIdMeta =
      const VerificationMeta('synaxariumId');
  @override
  late final GeneratedColumn<String> synaxariumId = GeneratedColumn<String>(
      'synaxarium_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        copticMonth,
        copticDay,
        periodType,
        rite,
        serviceType,
        readingType,
        reference,
        content,
        synaxariumId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'katameros_readings';
  @override
  VerificationContext validateIntegrity(Insertable<KatamerosReading> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('coptic_month')) {
      context.handle(
          _copticMonthMeta,
          copticMonth.isAcceptableOrUnknown(
              data['coptic_month']!, _copticMonthMeta));
    } else if (isInserting) {
      context.missing(_copticMonthMeta);
    }
    if (data.containsKey('coptic_day')) {
      context.handle(_copticDayMeta,
          copticDay.isAcceptableOrUnknown(data['coptic_day']!, _copticDayMeta));
    } else if (isInserting) {
      context.missing(_copticDayMeta);
    }
    if (data.containsKey('period_type')) {
      context.handle(
          _periodTypeMeta,
          periodType.isAcceptableOrUnknown(
              data['period_type']!, _periodTypeMeta));
    } else if (isInserting) {
      context.missing(_periodTypeMeta);
    }
    if (data.containsKey('rite')) {
      context.handle(
          _riteMeta, rite.isAcceptableOrUnknown(data['rite']!, _riteMeta));
    } else if (isInserting) {
      context.missing(_riteMeta);
    }
    if (data.containsKey('service_type')) {
      context.handle(
          _serviceTypeMeta,
          serviceType.isAcceptableOrUnknown(
              data['service_type']!, _serviceTypeMeta));
    } else if (isInserting) {
      context.missing(_serviceTypeMeta);
    }
    if (data.containsKey('reading_type')) {
      context.handle(
          _readingTypeMeta,
          readingType.isAcceptableOrUnknown(
              data['reading_type']!, _readingTypeMeta));
    } else if (isInserting) {
      context.missing(_readingTypeMeta);
    }
    if (data.containsKey('reference')) {
      context.handle(_referenceMeta,
          reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta));
    } else if (isInserting) {
      context.missing(_referenceMeta);
    }
    if (data.containsKey('text')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['text']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('synaxarium_id')) {
      context.handle(
          _synaxariumIdMeta,
          synaxariumId.isAcceptableOrUnknown(
              data['synaxarium_id']!, _synaxariumIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KatamerosReading map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KatamerosReading(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      copticMonth: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}coptic_month'])!,
      copticDay: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}coptic_day'])!,
      periodType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}period_type'])!,
      rite: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rite'])!,
      serviceType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}service_type'])!,
      readingType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reading_type'])!,
      reference: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reference'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text'])!,
      synaxariumId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}synaxarium_id']),
    );
  }

  @override
  $KatamerosReadingsTable createAlias(String alias) {
    return $KatamerosReadingsTable(attachedDatabase, alias);
  }
}

class KatamerosReading extends DataClass
    implements Insertable<KatamerosReading> {
  final int id;
  final int copticMonth;
  final int copticDay;
  final String periodType;
  final String rite;
  final String serviceType;
  final String readingType;
  final String reference;
  final String content;
  final String? synaxariumId;
  const KatamerosReading(
      {required this.id,
      required this.copticMonth,
      required this.copticDay,
      required this.periodType,
      required this.rite,
      required this.serviceType,
      required this.readingType,
      required this.reference,
      required this.content,
      this.synaxariumId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['coptic_month'] = Variable<int>(copticMonth);
    map['coptic_day'] = Variable<int>(copticDay);
    map['period_type'] = Variable<String>(periodType);
    map['rite'] = Variable<String>(rite);
    map['service_type'] = Variable<String>(serviceType);
    map['reading_type'] = Variable<String>(readingType);
    map['reference'] = Variable<String>(reference);
    map['text'] = Variable<String>(content);
    if (!nullToAbsent || synaxariumId != null) {
      map['synaxarium_id'] = Variable<String>(synaxariumId);
    }
    return map;
  }

  KatamerosReadingsCompanion toCompanion(bool nullToAbsent) {
    return KatamerosReadingsCompanion(
      id: Value(id),
      copticMonth: Value(copticMonth),
      copticDay: Value(copticDay),
      periodType: Value(periodType),
      rite: Value(rite),
      serviceType: Value(serviceType),
      readingType: Value(readingType),
      reference: Value(reference),
      content: Value(content),
      synaxariumId: synaxariumId == null && nullToAbsent
          ? const Value.absent()
          : Value(synaxariumId),
    );
  }

  factory KatamerosReading.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KatamerosReading(
      id: serializer.fromJson<int>(json['id']),
      copticMonth: serializer.fromJson<int>(json['copticMonth']),
      copticDay: serializer.fromJson<int>(json['copticDay']),
      periodType: serializer.fromJson<String>(json['periodType']),
      rite: serializer.fromJson<String>(json['rite']),
      serviceType: serializer.fromJson<String>(json['serviceType']),
      readingType: serializer.fromJson<String>(json['readingType']),
      reference: serializer.fromJson<String>(json['reference']),
      content: serializer.fromJson<String>(json['content']),
      synaxariumId: serializer.fromJson<String?>(json['synaxariumId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'copticMonth': serializer.toJson<int>(copticMonth),
      'copticDay': serializer.toJson<int>(copticDay),
      'periodType': serializer.toJson<String>(periodType),
      'rite': serializer.toJson<String>(rite),
      'serviceType': serializer.toJson<String>(serviceType),
      'readingType': serializer.toJson<String>(readingType),
      'reference': serializer.toJson<String>(reference),
      'content': serializer.toJson<String>(content),
      'synaxariumId': serializer.toJson<String?>(synaxariumId),
    };
  }

  KatamerosReading copyWith(
          {int? id,
          int? copticMonth,
          int? copticDay,
          String? periodType,
          String? rite,
          String? serviceType,
          String? readingType,
          String? reference,
          String? content,
          Value<String?> synaxariumId = const Value.absent()}) =>
      KatamerosReading(
        id: id ?? this.id,
        copticMonth: copticMonth ?? this.copticMonth,
        copticDay: copticDay ?? this.copticDay,
        periodType: periodType ?? this.periodType,
        rite: rite ?? this.rite,
        serviceType: serviceType ?? this.serviceType,
        readingType: readingType ?? this.readingType,
        reference: reference ?? this.reference,
        content: content ?? this.content,
        synaxariumId:
            synaxariumId.present ? synaxariumId.value : this.synaxariumId,
      );
  KatamerosReading copyWithCompanion(KatamerosReadingsCompanion data) {
    return KatamerosReading(
      id: data.id.present ? data.id.value : this.id,
      copticMonth:
          data.copticMonth.present ? data.copticMonth.value : this.copticMonth,
      copticDay: data.copticDay.present ? data.copticDay.value : this.copticDay,
      periodType:
          data.periodType.present ? data.periodType.value : this.periodType,
      rite: data.rite.present ? data.rite.value : this.rite,
      serviceType:
          data.serviceType.present ? data.serviceType.value : this.serviceType,
      readingType:
          data.readingType.present ? data.readingType.value : this.readingType,
      reference: data.reference.present ? data.reference.value : this.reference,
      content: data.content.present ? data.content.value : this.content,
      synaxariumId: data.synaxariumId.present
          ? data.synaxariumId.value
          : this.synaxariumId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KatamerosReading(')
          ..write('id: $id, ')
          ..write('copticMonth: $copticMonth, ')
          ..write('copticDay: $copticDay, ')
          ..write('periodType: $periodType, ')
          ..write('rite: $rite, ')
          ..write('serviceType: $serviceType, ')
          ..write('readingType: $readingType, ')
          ..write('reference: $reference, ')
          ..write('content: $content, ')
          ..write('synaxariumId: $synaxariumId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, copticMonth, copticDay, periodType, rite,
      serviceType, readingType, reference, content, synaxariumId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KatamerosReading &&
          other.id == this.id &&
          other.copticMonth == this.copticMonth &&
          other.copticDay == this.copticDay &&
          other.periodType == this.periodType &&
          other.rite == this.rite &&
          other.serviceType == this.serviceType &&
          other.readingType == this.readingType &&
          other.reference == this.reference &&
          other.content == this.content &&
          other.synaxariumId == this.synaxariumId);
}

class KatamerosReadingsCompanion extends UpdateCompanion<KatamerosReading> {
  final Value<int> id;
  final Value<int> copticMonth;
  final Value<int> copticDay;
  final Value<String> periodType;
  final Value<String> rite;
  final Value<String> serviceType;
  final Value<String> readingType;
  final Value<String> reference;
  final Value<String> content;
  final Value<String?> synaxariumId;
  const KatamerosReadingsCompanion({
    this.id = const Value.absent(),
    this.copticMonth = const Value.absent(),
    this.copticDay = const Value.absent(),
    this.periodType = const Value.absent(),
    this.rite = const Value.absent(),
    this.serviceType = const Value.absent(),
    this.readingType = const Value.absent(),
    this.reference = const Value.absent(),
    this.content = const Value.absent(),
    this.synaxariumId = const Value.absent(),
  });
  KatamerosReadingsCompanion.insert({
    this.id = const Value.absent(),
    required int copticMonth,
    required int copticDay,
    required String periodType,
    required String rite,
    required String serviceType,
    required String readingType,
    required String reference,
    required String content,
    this.synaxariumId = const Value.absent(),
  })  : copticMonth = Value(copticMonth),
        copticDay = Value(copticDay),
        periodType = Value(periodType),
        rite = Value(rite),
        serviceType = Value(serviceType),
        readingType = Value(readingType),
        reference = Value(reference),
        content = Value(content);
  static Insertable<KatamerosReading> custom({
    Expression<int>? id,
    Expression<int>? copticMonth,
    Expression<int>? copticDay,
    Expression<String>? periodType,
    Expression<String>? rite,
    Expression<String>? serviceType,
    Expression<String>? readingType,
    Expression<String>? reference,
    Expression<String>? content,
    Expression<String>? synaxariumId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (copticMonth != null) 'coptic_month': copticMonth,
      if (copticDay != null) 'coptic_day': copticDay,
      if (periodType != null) 'period_type': periodType,
      if (rite != null) 'rite': rite,
      if (serviceType != null) 'service_type': serviceType,
      if (readingType != null) 'reading_type': readingType,
      if (reference != null) 'reference': reference,
      if (content != null) 'text': content,
      if (synaxariumId != null) 'synaxarium_id': synaxariumId,
    });
  }

  KatamerosReadingsCompanion copyWith(
      {Value<int>? id,
      Value<int>? copticMonth,
      Value<int>? copticDay,
      Value<String>? periodType,
      Value<String>? rite,
      Value<String>? serviceType,
      Value<String>? readingType,
      Value<String>? reference,
      Value<String>? content,
      Value<String?>? synaxariumId}) {
    return KatamerosReadingsCompanion(
      id: id ?? this.id,
      copticMonth: copticMonth ?? this.copticMonth,
      copticDay: copticDay ?? this.copticDay,
      periodType: periodType ?? this.periodType,
      rite: rite ?? this.rite,
      serviceType: serviceType ?? this.serviceType,
      readingType: readingType ?? this.readingType,
      reference: reference ?? this.reference,
      content: content ?? this.content,
      synaxariumId: synaxariumId ?? this.synaxariumId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (copticMonth.present) {
      map['coptic_month'] = Variable<int>(copticMonth.value);
    }
    if (copticDay.present) {
      map['coptic_day'] = Variable<int>(copticDay.value);
    }
    if (periodType.present) {
      map['period_type'] = Variable<String>(periodType.value);
    }
    if (rite.present) {
      map['rite'] = Variable<String>(rite.value);
    }
    if (serviceType.present) {
      map['service_type'] = Variable<String>(serviceType.value);
    }
    if (readingType.present) {
      map['reading_type'] = Variable<String>(readingType.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (content.present) {
      map['text'] = Variable<String>(content.value);
    }
    if (synaxariumId.present) {
      map['synaxarium_id'] = Variable<String>(synaxariumId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KatamerosReadingsCompanion(')
          ..write('id: $id, ')
          ..write('copticMonth: $copticMonth, ')
          ..write('copticDay: $copticDay, ')
          ..write('periodType: $periodType, ')
          ..write('rite: $rite, ')
          ..write('serviceType: $serviceType, ')
          ..write('readingType: $readingType, ')
          ..write('reference: $reference, ')
          ..write('content: $content, ')
          ..write('synaxariumId: $synaxariumId')
          ..write(')'))
        .toString();
  }
}

class $SaintsTable extends Saints with TableInfo<$SaintsTable, Saint> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SaintsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameArMeta = const VerificationMeta('nameAr');
  @override
  late final GeneratedColumn<String> nameAr = GeneratedColumn<String>(
      'name_ar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameCopticMeta =
      const VerificationMeta('nameCoptic');
  @override
  late final GeneratedColumn<String> nameCoptic = GeneratedColumn<String>(
      'name_coptic', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
      'name_en', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _feastMonthMeta =
      const VerificationMeta('feastMonth');
  @override
  late final GeneratedColumn<int> feastMonth = GeneratedColumn<int>(
      'feast_month', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _feastDayMeta =
      const VerificationMeta('feastDay');
  @override
  late final GeneratedColumn<int> feastDay = GeneratedColumn<int>(
      'feast_day', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _biographyMeta =
      const VerificationMeta('biography');
  @override
  late final GeneratedColumn<String> biography = GeneratedColumn<String>(
      'biography', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _shortBioMeta =
      const VerificationMeta('shortBio');
  @override
  late final GeneratedColumn<String> shortBio = GeneratedColumn<String>(
      'short_bio', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        nameAr,
        nameCoptic,
        nameEn,
        type,
        feastMonth,
        feastDay,
        biography,
        shortBio
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saints';
  @override
  VerificationContext validateIntegrity(Insertable<Saint> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name_ar')) {
      context.handle(_nameArMeta,
          nameAr.isAcceptableOrUnknown(data['name_ar']!, _nameArMeta));
    } else if (isInserting) {
      context.missing(_nameArMeta);
    }
    if (data.containsKey('name_coptic')) {
      context.handle(
          _nameCopticMeta,
          nameCoptic.isAcceptableOrUnknown(
              data['name_coptic']!, _nameCopticMeta));
    }
    if (data.containsKey('name_en')) {
      context.handle(_nameEnMeta,
          nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('feast_month')) {
      context.handle(
          _feastMonthMeta,
          feastMonth.isAcceptableOrUnknown(
              data['feast_month']!, _feastMonthMeta));
    }
    if (data.containsKey('feast_day')) {
      context.handle(_feastDayMeta,
          feastDay.isAcceptableOrUnknown(data['feast_day']!, _feastDayMeta));
    }
    if (data.containsKey('biography')) {
      context.handle(_biographyMeta,
          biography.isAcceptableOrUnknown(data['biography']!, _biographyMeta));
    } else if (isInserting) {
      context.missing(_biographyMeta);
    }
    if (data.containsKey('short_bio')) {
      context.handle(_shortBioMeta,
          shortBio.isAcceptableOrUnknown(data['short_bio']!, _shortBioMeta));
    } else if (isInserting) {
      context.missing(_shortBioMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Saint map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Saint(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      nameAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_ar'])!,
      nameCoptic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_coptic']),
      nameEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_en']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      feastMonth: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}feast_month']),
      feastDay: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}feast_day']),
      biography: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}biography'])!,
      shortBio: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}short_bio'])!,
    );
  }

  @override
  $SaintsTable createAlias(String alias) {
    return $SaintsTable(attachedDatabase, alias);
  }
}

class Saint extends DataClass implements Insertable<Saint> {
  final String id;
  final String nameAr;
  final String? nameCoptic;
  final String? nameEn;
  final String type;
  final int? feastMonth;
  final int? feastDay;
  final String biography;
  final String shortBio;
  const Saint(
      {required this.id,
      required this.nameAr,
      this.nameCoptic,
      this.nameEn,
      required this.type,
      this.feastMonth,
      this.feastDay,
      required this.biography,
      required this.shortBio});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name_ar'] = Variable<String>(nameAr);
    if (!nullToAbsent || nameCoptic != null) {
      map['name_coptic'] = Variable<String>(nameCoptic);
    }
    if (!nullToAbsent || nameEn != null) {
      map['name_en'] = Variable<String>(nameEn);
    }
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || feastMonth != null) {
      map['feast_month'] = Variable<int>(feastMonth);
    }
    if (!nullToAbsent || feastDay != null) {
      map['feast_day'] = Variable<int>(feastDay);
    }
    map['biography'] = Variable<String>(biography);
    map['short_bio'] = Variable<String>(shortBio);
    return map;
  }

  SaintsCompanion toCompanion(bool nullToAbsent) {
    return SaintsCompanion(
      id: Value(id),
      nameAr: Value(nameAr),
      nameCoptic: nameCoptic == null && nullToAbsent
          ? const Value.absent()
          : Value(nameCoptic),
      nameEn:
          nameEn == null && nullToAbsent ? const Value.absent() : Value(nameEn),
      type: Value(type),
      feastMonth: feastMonth == null && nullToAbsent
          ? const Value.absent()
          : Value(feastMonth),
      feastDay: feastDay == null && nullToAbsent
          ? const Value.absent()
          : Value(feastDay),
      biography: Value(biography),
      shortBio: Value(shortBio),
    );
  }

  factory Saint.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Saint(
      id: serializer.fromJson<String>(json['id']),
      nameAr: serializer.fromJson<String>(json['nameAr']),
      nameCoptic: serializer.fromJson<String?>(json['nameCoptic']),
      nameEn: serializer.fromJson<String?>(json['nameEn']),
      type: serializer.fromJson<String>(json['type']),
      feastMonth: serializer.fromJson<int?>(json['feastMonth']),
      feastDay: serializer.fromJson<int?>(json['feastDay']),
      biography: serializer.fromJson<String>(json['biography']),
      shortBio: serializer.fromJson<String>(json['shortBio']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nameAr': serializer.toJson<String>(nameAr),
      'nameCoptic': serializer.toJson<String?>(nameCoptic),
      'nameEn': serializer.toJson<String?>(nameEn),
      'type': serializer.toJson<String>(type),
      'feastMonth': serializer.toJson<int?>(feastMonth),
      'feastDay': serializer.toJson<int?>(feastDay),
      'biography': serializer.toJson<String>(biography),
      'shortBio': serializer.toJson<String>(shortBio),
    };
  }

  Saint copyWith(
          {String? id,
          String? nameAr,
          Value<String?> nameCoptic = const Value.absent(),
          Value<String?> nameEn = const Value.absent(),
          String? type,
          Value<int?> feastMonth = const Value.absent(),
          Value<int?> feastDay = const Value.absent(),
          String? biography,
          String? shortBio}) =>
      Saint(
        id: id ?? this.id,
        nameAr: nameAr ?? this.nameAr,
        nameCoptic: nameCoptic.present ? nameCoptic.value : this.nameCoptic,
        nameEn: nameEn.present ? nameEn.value : this.nameEn,
        type: type ?? this.type,
        feastMonth: feastMonth.present ? feastMonth.value : this.feastMonth,
        feastDay: feastDay.present ? feastDay.value : this.feastDay,
        biography: biography ?? this.biography,
        shortBio: shortBio ?? this.shortBio,
      );
  Saint copyWithCompanion(SaintsCompanion data) {
    return Saint(
      id: data.id.present ? data.id.value : this.id,
      nameAr: data.nameAr.present ? data.nameAr.value : this.nameAr,
      nameCoptic:
          data.nameCoptic.present ? data.nameCoptic.value : this.nameCoptic,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      type: data.type.present ? data.type.value : this.type,
      feastMonth:
          data.feastMonth.present ? data.feastMonth.value : this.feastMonth,
      feastDay: data.feastDay.present ? data.feastDay.value : this.feastDay,
      biography: data.biography.present ? data.biography.value : this.biography,
      shortBio: data.shortBio.present ? data.shortBio.value : this.shortBio,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Saint(')
          ..write('id: $id, ')
          ..write('nameAr: $nameAr, ')
          ..write('nameCoptic: $nameCoptic, ')
          ..write('nameEn: $nameEn, ')
          ..write('type: $type, ')
          ..write('feastMonth: $feastMonth, ')
          ..write('feastDay: $feastDay, ')
          ..write('biography: $biography, ')
          ..write('shortBio: $shortBio')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nameAr, nameCoptic, nameEn, type,
      feastMonth, feastDay, biography, shortBio);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Saint &&
          other.id == this.id &&
          other.nameAr == this.nameAr &&
          other.nameCoptic == this.nameCoptic &&
          other.nameEn == this.nameEn &&
          other.type == this.type &&
          other.feastMonth == this.feastMonth &&
          other.feastDay == this.feastDay &&
          other.biography == this.biography &&
          other.shortBio == this.shortBio);
}

class SaintsCompanion extends UpdateCompanion<Saint> {
  final Value<String> id;
  final Value<String> nameAr;
  final Value<String?> nameCoptic;
  final Value<String?> nameEn;
  final Value<String> type;
  final Value<int?> feastMonth;
  final Value<int?> feastDay;
  final Value<String> biography;
  final Value<String> shortBio;
  final Value<int> rowid;
  const SaintsCompanion({
    this.id = const Value.absent(),
    this.nameAr = const Value.absent(),
    this.nameCoptic = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.type = const Value.absent(),
    this.feastMonth = const Value.absent(),
    this.feastDay = const Value.absent(),
    this.biography = const Value.absent(),
    this.shortBio = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SaintsCompanion.insert({
    required String id,
    required String nameAr,
    this.nameCoptic = const Value.absent(),
    this.nameEn = const Value.absent(),
    required String type,
    this.feastMonth = const Value.absent(),
    this.feastDay = const Value.absent(),
    required String biography,
    required String shortBio,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        nameAr = Value(nameAr),
        type = Value(type),
        biography = Value(biography),
        shortBio = Value(shortBio);
  static Insertable<Saint> custom({
    Expression<String>? id,
    Expression<String>? nameAr,
    Expression<String>? nameCoptic,
    Expression<String>? nameEn,
    Expression<String>? type,
    Expression<int>? feastMonth,
    Expression<int>? feastDay,
    Expression<String>? biography,
    Expression<String>? shortBio,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameAr != null) 'name_ar': nameAr,
      if (nameCoptic != null) 'name_coptic': nameCoptic,
      if (nameEn != null) 'name_en': nameEn,
      if (type != null) 'type': type,
      if (feastMonth != null) 'feast_month': feastMonth,
      if (feastDay != null) 'feast_day': feastDay,
      if (biography != null) 'biography': biography,
      if (shortBio != null) 'short_bio': shortBio,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SaintsCompanion copyWith(
      {Value<String>? id,
      Value<String>? nameAr,
      Value<String?>? nameCoptic,
      Value<String?>? nameEn,
      Value<String>? type,
      Value<int?>? feastMonth,
      Value<int?>? feastDay,
      Value<String>? biography,
      Value<String>? shortBio,
      Value<int>? rowid}) {
    return SaintsCompanion(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      nameCoptic: nameCoptic ?? this.nameCoptic,
      nameEn: nameEn ?? this.nameEn,
      type: type ?? this.type,
      feastMonth: feastMonth ?? this.feastMonth,
      feastDay: feastDay ?? this.feastDay,
      biography: biography ?? this.biography,
      shortBio: shortBio ?? this.shortBio,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nameAr.present) {
      map['name_ar'] = Variable<String>(nameAr.value);
    }
    if (nameCoptic.present) {
      map['name_coptic'] = Variable<String>(nameCoptic.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (feastMonth.present) {
      map['feast_month'] = Variable<int>(feastMonth.value);
    }
    if (feastDay.present) {
      map['feast_day'] = Variable<int>(feastDay.value);
    }
    if (biography.present) {
      map['biography'] = Variable<String>(biography.value);
    }
    if (shortBio.present) {
      map['short_bio'] = Variable<String>(shortBio.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SaintsCompanion(')
          ..write('id: $id, ')
          ..write('nameAr: $nameAr, ')
          ..write('nameCoptic: $nameCoptic, ')
          ..write('nameEn: $nameEn, ')
          ..write('type: $type, ')
          ..write('feastMonth: $feastMonth, ')
          ..write('feastDay: $feastDay, ')
          ..write('biography: $biography, ')
          ..write('shortBio: $shortBio, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DifnarEntriesTable extends DifnarEntries
    with TableInfo<$DifnarEntriesTable, DifnarEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DifnarEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _copticMonthMeta =
      const VerificationMeta('copticMonth');
  @override
  late final GeneratedColumn<int> copticMonth = GeneratedColumn<int>(
      'coptic_month', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _copticDayMeta =
      const VerificationMeta('copticDay');
  @override
  late final GeneratedColumn<int> copticDay = GeneratedColumn<int>(
      'coptic_day', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _textCopticMeta =
      const VerificationMeta('textCoptic');
  @override
  late final GeneratedColumn<String> textCoptic = GeneratedColumn<String>(
      'text_coptic', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _textPhoneticMeta =
      const VerificationMeta('textPhonetic');
  @override
  late final GeneratedColumn<String> textPhonetic = GeneratedColumn<String>(
      'text_phonetic', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _textArMeta = const VerificationMeta('textAr');
  @override
  late final GeneratedColumn<String> textAr = GeneratedColumn<String>(
      'text_ar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, copticMonth, copticDay, textCoptic, textPhonetic, textAr];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'difnar_entries';
  @override
  VerificationContext validateIntegrity(Insertable<DifnarEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('coptic_month')) {
      context.handle(
          _copticMonthMeta,
          copticMonth.isAcceptableOrUnknown(
              data['coptic_month']!, _copticMonthMeta));
    } else if (isInserting) {
      context.missing(_copticMonthMeta);
    }
    if (data.containsKey('coptic_day')) {
      context.handle(_copticDayMeta,
          copticDay.isAcceptableOrUnknown(data['coptic_day']!, _copticDayMeta));
    } else if (isInserting) {
      context.missing(_copticDayMeta);
    }
    if (data.containsKey('text_coptic')) {
      context.handle(
          _textCopticMeta,
          textCoptic.isAcceptableOrUnknown(
              data['text_coptic']!, _textCopticMeta));
    } else if (isInserting) {
      context.missing(_textCopticMeta);
    }
    if (data.containsKey('text_phonetic')) {
      context.handle(
          _textPhoneticMeta,
          textPhonetic.isAcceptableOrUnknown(
              data['text_phonetic']!, _textPhoneticMeta));
    } else if (isInserting) {
      context.missing(_textPhoneticMeta);
    }
    if (data.containsKey('text_ar')) {
      context.handle(_textArMeta,
          textAr.isAcceptableOrUnknown(data['text_ar']!, _textArMeta));
    } else if (isInserting) {
      context.missing(_textArMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DifnarEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DifnarEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      copticMonth: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}coptic_month'])!,
      copticDay: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}coptic_day'])!,
      textCoptic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_coptic'])!,
      textPhonetic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_phonetic'])!,
      textAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_ar'])!,
    );
  }

  @override
  $DifnarEntriesTable createAlias(String alias) {
    return $DifnarEntriesTable(attachedDatabase, alias);
  }
}

class DifnarEntry extends DataClass implements Insertable<DifnarEntry> {
  final String id;
  final int copticMonth;
  final int copticDay;
  final String textCoptic;
  final String textPhonetic;
  final String textAr;
  const DifnarEntry(
      {required this.id,
      required this.copticMonth,
      required this.copticDay,
      required this.textCoptic,
      required this.textPhonetic,
      required this.textAr});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['coptic_month'] = Variable<int>(copticMonth);
    map['coptic_day'] = Variable<int>(copticDay);
    map['text_coptic'] = Variable<String>(textCoptic);
    map['text_phonetic'] = Variable<String>(textPhonetic);
    map['text_ar'] = Variable<String>(textAr);
    return map;
  }

  DifnarEntriesCompanion toCompanion(bool nullToAbsent) {
    return DifnarEntriesCompanion(
      id: Value(id),
      copticMonth: Value(copticMonth),
      copticDay: Value(copticDay),
      textCoptic: Value(textCoptic),
      textPhonetic: Value(textPhonetic),
      textAr: Value(textAr),
    );
  }

  factory DifnarEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DifnarEntry(
      id: serializer.fromJson<String>(json['id']),
      copticMonth: serializer.fromJson<int>(json['copticMonth']),
      copticDay: serializer.fromJson<int>(json['copticDay']),
      textCoptic: serializer.fromJson<String>(json['textCoptic']),
      textPhonetic: serializer.fromJson<String>(json['textPhonetic']),
      textAr: serializer.fromJson<String>(json['textAr']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'copticMonth': serializer.toJson<int>(copticMonth),
      'copticDay': serializer.toJson<int>(copticDay),
      'textCoptic': serializer.toJson<String>(textCoptic),
      'textPhonetic': serializer.toJson<String>(textPhonetic),
      'textAr': serializer.toJson<String>(textAr),
    };
  }

  DifnarEntry copyWith(
          {String? id,
          int? copticMonth,
          int? copticDay,
          String? textCoptic,
          String? textPhonetic,
          String? textAr}) =>
      DifnarEntry(
        id: id ?? this.id,
        copticMonth: copticMonth ?? this.copticMonth,
        copticDay: copticDay ?? this.copticDay,
        textCoptic: textCoptic ?? this.textCoptic,
        textPhonetic: textPhonetic ?? this.textPhonetic,
        textAr: textAr ?? this.textAr,
      );
  DifnarEntry copyWithCompanion(DifnarEntriesCompanion data) {
    return DifnarEntry(
      id: data.id.present ? data.id.value : this.id,
      copticMonth:
          data.copticMonth.present ? data.copticMonth.value : this.copticMonth,
      copticDay: data.copticDay.present ? data.copticDay.value : this.copticDay,
      textCoptic:
          data.textCoptic.present ? data.textCoptic.value : this.textCoptic,
      textPhonetic: data.textPhonetic.present
          ? data.textPhonetic.value
          : this.textPhonetic,
      textAr: data.textAr.present ? data.textAr.value : this.textAr,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DifnarEntry(')
          ..write('id: $id, ')
          ..write('copticMonth: $copticMonth, ')
          ..write('copticDay: $copticDay, ')
          ..write('textCoptic: $textCoptic, ')
          ..write('textPhonetic: $textPhonetic, ')
          ..write('textAr: $textAr')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, copticMonth, copticDay, textCoptic, textPhonetic, textAr);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DifnarEntry &&
          other.id == this.id &&
          other.copticMonth == this.copticMonth &&
          other.copticDay == this.copticDay &&
          other.textCoptic == this.textCoptic &&
          other.textPhonetic == this.textPhonetic &&
          other.textAr == this.textAr);
}

class DifnarEntriesCompanion extends UpdateCompanion<DifnarEntry> {
  final Value<String> id;
  final Value<int> copticMonth;
  final Value<int> copticDay;
  final Value<String> textCoptic;
  final Value<String> textPhonetic;
  final Value<String> textAr;
  final Value<int> rowid;
  const DifnarEntriesCompanion({
    this.id = const Value.absent(),
    this.copticMonth = const Value.absent(),
    this.copticDay = const Value.absent(),
    this.textCoptic = const Value.absent(),
    this.textPhonetic = const Value.absent(),
    this.textAr = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DifnarEntriesCompanion.insert({
    required String id,
    required int copticMonth,
    required int copticDay,
    required String textCoptic,
    required String textPhonetic,
    required String textAr,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        copticMonth = Value(copticMonth),
        copticDay = Value(copticDay),
        textCoptic = Value(textCoptic),
        textPhonetic = Value(textPhonetic),
        textAr = Value(textAr);
  static Insertable<DifnarEntry> custom({
    Expression<String>? id,
    Expression<int>? copticMonth,
    Expression<int>? copticDay,
    Expression<String>? textCoptic,
    Expression<String>? textPhonetic,
    Expression<String>? textAr,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (copticMonth != null) 'coptic_month': copticMonth,
      if (copticDay != null) 'coptic_day': copticDay,
      if (textCoptic != null) 'text_coptic': textCoptic,
      if (textPhonetic != null) 'text_phonetic': textPhonetic,
      if (textAr != null) 'text_ar': textAr,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DifnarEntriesCompanion copyWith(
      {Value<String>? id,
      Value<int>? copticMonth,
      Value<int>? copticDay,
      Value<String>? textCoptic,
      Value<String>? textPhonetic,
      Value<String>? textAr,
      Value<int>? rowid}) {
    return DifnarEntriesCompanion(
      id: id ?? this.id,
      copticMonth: copticMonth ?? this.copticMonth,
      copticDay: copticDay ?? this.copticDay,
      textCoptic: textCoptic ?? this.textCoptic,
      textPhonetic: textPhonetic ?? this.textPhonetic,
      textAr: textAr ?? this.textAr,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (copticMonth.present) {
      map['coptic_month'] = Variable<int>(copticMonth.value);
    }
    if (copticDay.present) {
      map['coptic_day'] = Variable<int>(copticDay.value);
    }
    if (textCoptic.present) {
      map['text_coptic'] = Variable<String>(textCoptic.value);
    }
    if (textPhonetic.present) {
      map['text_phonetic'] = Variable<String>(textPhonetic.value);
    }
    if (textAr.present) {
      map['text_ar'] = Variable<String>(textAr.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DifnarEntriesCompanion(')
          ..write('id: $id, ')
          ..write('copticMonth: $copticMonth, ')
          ..write('copticDay: $copticDay, ')
          ..write('textCoptic: $textCoptic, ')
          ..write('textPhonetic: $textPhonetic, ')
          ..write('textAr: $textAr, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaschaReadingsTable extends PaschaReadings
    with TableInfo<$PaschaReadingsTable, PaschaReading> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaschaReadingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dayIdMeta = const VerificationMeta('dayId');
  @override
  late final GeneratedColumn<String> dayId = GeneratedColumn<String>(
      'day_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dayNameArMeta =
      const VerificationMeta('dayNameAr');
  @override
  late final GeneratedColumn<String> dayNameAr = GeneratedColumn<String>(
      'day_name_ar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _hourNumberMeta =
      const VerificationMeta('hourNumber');
  @override
  late final GeneratedColumn<int> hourNumber = GeneratedColumn<int>(
      'hour_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _hourNameArMeta =
      const VerificationMeta('hourNameAr');
  @override
  late final GeneratedColumn<String> hourNameAr = GeneratedColumn<String>(
      'hour_name_ar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _readingTypeMeta =
      const VerificationMeta('readingType');
  @override
  late final GeneratedColumn<String> readingType = GeneratedColumn<String>(
      'reading_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _referenceMeta =
      const VerificationMeta('reference');
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
      'reference', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _readingOrderMeta =
      const VerificationMeta('readingOrder');
  @override
  late final GeneratedColumn<int> readingOrder = GeneratedColumn<int>(
      'reading_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        dayId,
        dayNameAr,
        hourNumber,
        hourNameAr,
        readingType,
        reference,
        content,
        readingOrder
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pascha_readings';
  @override
  VerificationContext validateIntegrity(Insertable<PaschaReading> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('day_id')) {
      context.handle(
          _dayIdMeta, dayId.isAcceptableOrUnknown(data['day_id']!, _dayIdMeta));
    } else if (isInserting) {
      context.missing(_dayIdMeta);
    }
    if (data.containsKey('day_name_ar')) {
      context.handle(
          _dayNameArMeta,
          dayNameAr.isAcceptableOrUnknown(
              data['day_name_ar']!, _dayNameArMeta));
    } else if (isInserting) {
      context.missing(_dayNameArMeta);
    }
    if (data.containsKey('hour_number')) {
      context.handle(
          _hourNumberMeta,
          hourNumber.isAcceptableOrUnknown(
              data['hour_number']!, _hourNumberMeta));
    } else if (isInserting) {
      context.missing(_hourNumberMeta);
    }
    if (data.containsKey('hour_name_ar')) {
      context.handle(
          _hourNameArMeta,
          hourNameAr.isAcceptableOrUnknown(
              data['hour_name_ar']!, _hourNameArMeta));
    } else if (isInserting) {
      context.missing(_hourNameArMeta);
    }
    if (data.containsKey('reading_type')) {
      context.handle(
          _readingTypeMeta,
          readingType.isAcceptableOrUnknown(
              data['reading_type']!, _readingTypeMeta));
    } else if (isInserting) {
      context.missing(_readingTypeMeta);
    }
    if (data.containsKey('reference')) {
      context.handle(_referenceMeta,
          reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta));
    }
    if (data.containsKey('text')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['text']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('reading_order')) {
      context.handle(
          _readingOrderMeta,
          readingOrder.isAcceptableOrUnknown(
              data['reading_order']!, _readingOrderMeta));
    } else if (isInserting) {
      context.missing(_readingOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaschaReading map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaschaReading(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      dayId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}day_id'])!,
      dayNameAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}day_name_ar'])!,
      hourNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}hour_number'])!,
      hourNameAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hour_name_ar'])!,
      readingType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reading_type'])!,
      reference: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reference']),
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text'])!,
      readingOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reading_order'])!,
    );
  }

  @override
  $PaschaReadingsTable createAlias(String alias) {
    return $PaschaReadingsTable(attachedDatabase, alias);
  }
}

class PaschaReading extends DataClass implements Insertable<PaschaReading> {
  final int id;
  final String dayId;
  final String dayNameAr;
  final int hourNumber;
  final String hourNameAr;
  final String readingType;
  final String? reference;
  final String content;
  final int readingOrder;
  const PaschaReading(
      {required this.id,
      required this.dayId,
      required this.dayNameAr,
      required this.hourNumber,
      required this.hourNameAr,
      required this.readingType,
      this.reference,
      required this.content,
      required this.readingOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['day_id'] = Variable<String>(dayId);
    map['day_name_ar'] = Variable<String>(dayNameAr);
    map['hour_number'] = Variable<int>(hourNumber);
    map['hour_name_ar'] = Variable<String>(hourNameAr);
    map['reading_type'] = Variable<String>(readingType);
    if (!nullToAbsent || reference != null) {
      map['reference'] = Variable<String>(reference);
    }
    map['text'] = Variable<String>(content);
    map['reading_order'] = Variable<int>(readingOrder);
    return map;
  }

  PaschaReadingsCompanion toCompanion(bool nullToAbsent) {
    return PaschaReadingsCompanion(
      id: Value(id),
      dayId: Value(dayId),
      dayNameAr: Value(dayNameAr),
      hourNumber: Value(hourNumber),
      hourNameAr: Value(hourNameAr),
      readingType: Value(readingType),
      reference: reference == null && nullToAbsent
          ? const Value.absent()
          : Value(reference),
      content: Value(content),
      readingOrder: Value(readingOrder),
    );
  }

  factory PaschaReading.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaschaReading(
      id: serializer.fromJson<int>(json['id']),
      dayId: serializer.fromJson<String>(json['dayId']),
      dayNameAr: serializer.fromJson<String>(json['dayNameAr']),
      hourNumber: serializer.fromJson<int>(json['hourNumber']),
      hourNameAr: serializer.fromJson<String>(json['hourNameAr']),
      readingType: serializer.fromJson<String>(json['readingType']),
      reference: serializer.fromJson<String?>(json['reference']),
      content: serializer.fromJson<String>(json['content']),
      readingOrder: serializer.fromJson<int>(json['readingOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dayId': serializer.toJson<String>(dayId),
      'dayNameAr': serializer.toJson<String>(dayNameAr),
      'hourNumber': serializer.toJson<int>(hourNumber),
      'hourNameAr': serializer.toJson<String>(hourNameAr),
      'readingType': serializer.toJson<String>(readingType),
      'reference': serializer.toJson<String?>(reference),
      'content': serializer.toJson<String>(content),
      'readingOrder': serializer.toJson<int>(readingOrder),
    };
  }

  PaschaReading copyWith(
          {int? id,
          String? dayId,
          String? dayNameAr,
          int? hourNumber,
          String? hourNameAr,
          String? readingType,
          Value<String?> reference = const Value.absent(),
          String? content,
          int? readingOrder}) =>
      PaschaReading(
        id: id ?? this.id,
        dayId: dayId ?? this.dayId,
        dayNameAr: dayNameAr ?? this.dayNameAr,
        hourNumber: hourNumber ?? this.hourNumber,
        hourNameAr: hourNameAr ?? this.hourNameAr,
        readingType: readingType ?? this.readingType,
        reference: reference.present ? reference.value : this.reference,
        content: content ?? this.content,
        readingOrder: readingOrder ?? this.readingOrder,
      );
  PaschaReading copyWithCompanion(PaschaReadingsCompanion data) {
    return PaschaReading(
      id: data.id.present ? data.id.value : this.id,
      dayId: data.dayId.present ? data.dayId.value : this.dayId,
      dayNameAr: data.dayNameAr.present ? data.dayNameAr.value : this.dayNameAr,
      hourNumber:
          data.hourNumber.present ? data.hourNumber.value : this.hourNumber,
      hourNameAr:
          data.hourNameAr.present ? data.hourNameAr.value : this.hourNameAr,
      readingType:
          data.readingType.present ? data.readingType.value : this.readingType,
      reference: data.reference.present ? data.reference.value : this.reference,
      content: data.content.present ? data.content.value : this.content,
      readingOrder: data.readingOrder.present
          ? data.readingOrder.value
          : this.readingOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaschaReading(')
          ..write('id: $id, ')
          ..write('dayId: $dayId, ')
          ..write('dayNameAr: $dayNameAr, ')
          ..write('hourNumber: $hourNumber, ')
          ..write('hourNameAr: $hourNameAr, ')
          ..write('readingType: $readingType, ')
          ..write('reference: $reference, ')
          ..write('content: $content, ')
          ..write('readingOrder: $readingOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dayId, dayNameAr, hourNumber, hourNameAr,
      readingType, reference, content, readingOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaschaReading &&
          other.id == this.id &&
          other.dayId == this.dayId &&
          other.dayNameAr == this.dayNameAr &&
          other.hourNumber == this.hourNumber &&
          other.hourNameAr == this.hourNameAr &&
          other.readingType == this.readingType &&
          other.reference == this.reference &&
          other.content == this.content &&
          other.readingOrder == this.readingOrder);
}

class PaschaReadingsCompanion extends UpdateCompanion<PaschaReading> {
  final Value<int> id;
  final Value<String> dayId;
  final Value<String> dayNameAr;
  final Value<int> hourNumber;
  final Value<String> hourNameAr;
  final Value<String> readingType;
  final Value<String?> reference;
  final Value<String> content;
  final Value<int> readingOrder;
  const PaschaReadingsCompanion({
    this.id = const Value.absent(),
    this.dayId = const Value.absent(),
    this.dayNameAr = const Value.absent(),
    this.hourNumber = const Value.absent(),
    this.hourNameAr = const Value.absent(),
    this.readingType = const Value.absent(),
    this.reference = const Value.absent(),
    this.content = const Value.absent(),
    this.readingOrder = const Value.absent(),
  });
  PaschaReadingsCompanion.insert({
    this.id = const Value.absent(),
    required String dayId,
    required String dayNameAr,
    required int hourNumber,
    required String hourNameAr,
    required String readingType,
    this.reference = const Value.absent(),
    required String content,
    required int readingOrder,
  })  : dayId = Value(dayId),
        dayNameAr = Value(dayNameAr),
        hourNumber = Value(hourNumber),
        hourNameAr = Value(hourNameAr),
        readingType = Value(readingType),
        content = Value(content),
        readingOrder = Value(readingOrder);
  static Insertable<PaschaReading> custom({
    Expression<int>? id,
    Expression<String>? dayId,
    Expression<String>? dayNameAr,
    Expression<int>? hourNumber,
    Expression<String>? hourNameAr,
    Expression<String>? readingType,
    Expression<String>? reference,
    Expression<String>? content,
    Expression<int>? readingOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dayId != null) 'day_id': dayId,
      if (dayNameAr != null) 'day_name_ar': dayNameAr,
      if (hourNumber != null) 'hour_number': hourNumber,
      if (hourNameAr != null) 'hour_name_ar': hourNameAr,
      if (readingType != null) 'reading_type': readingType,
      if (reference != null) 'reference': reference,
      if (content != null) 'text': content,
      if (readingOrder != null) 'reading_order': readingOrder,
    });
  }

  PaschaReadingsCompanion copyWith(
      {Value<int>? id,
      Value<String>? dayId,
      Value<String>? dayNameAr,
      Value<int>? hourNumber,
      Value<String>? hourNameAr,
      Value<String>? readingType,
      Value<String?>? reference,
      Value<String>? content,
      Value<int>? readingOrder}) {
    return PaschaReadingsCompanion(
      id: id ?? this.id,
      dayId: dayId ?? this.dayId,
      dayNameAr: dayNameAr ?? this.dayNameAr,
      hourNumber: hourNumber ?? this.hourNumber,
      hourNameAr: hourNameAr ?? this.hourNameAr,
      readingType: readingType ?? this.readingType,
      reference: reference ?? this.reference,
      content: content ?? this.content,
      readingOrder: readingOrder ?? this.readingOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dayId.present) {
      map['day_id'] = Variable<String>(dayId.value);
    }
    if (dayNameAr.present) {
      map['day_name_ar'] = Variable<String>(dayNameAr.value);
    }
    if (hourNumber.present) {
      map['hour_number'] = Variable<int>(hourNumber.value);
    }
    if (hourNameAr.present) {
      map['hour_name_ar'] = Variable<String>(hourNameAr.value);
    }
    if (readingType.present) {
      map['reading_type'] = Variable<String>(readingType.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (content.present) {
      map['text'] = Variable<String>(content.value);
    }
    if (readingOrder.present) {
      map['reading_order'] = Variable<int>(readingOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaschaReadingsCompanion(')
          ..write('id: $id, ')
          ..write('dayId: $dayId, ')
          ..write('dayNameAr: $dayNameAr, ')
          ..write('hourNumber: $hourNumber, ')
          ..write('hourNameAr: $hourNameAr, ')
          ..write('readingType: $readingType, ')
          ..write('reference: $reference, ')
          ..write('content: $content, ')
          ..write('readingOrder: $readingOrder')
          ..write(')'))
        .toString();
  }
}

class $FeastsAndFastsTable extends FeastsAndFasts
    with TableInfo<$FeastsAndFastsTable, FeastsAndFast> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeastsAndFastsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameArMeta = const VerificationMeta('nameAr');
  @override
  late final GeneratedColumn<String> nameAr = GeneratedColumn<String>(
      'name_ar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _copticMonthMeta =
      const VerificationMeta('copticMonth');
  @override
  late final GeneratedColumn<int> copticMonth = GeneratedColumn<int>(
      'coptic_month', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _copticDayMeta =
      const VerificationMeta('copticDay');
  @override
  late final GeneratedColumn<int> copticDay = GeneratedColumn<int>(
      'coptic_day', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _isMovableMeta =
      const VerificationMeta('isMovable');
  @override
  late final GeneratedColumn<bool> isMovable = GeneratedColumn<bool>(
      'is_movable', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_movable" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _calculationRuleMeta =
      const VerificationMeta('calculationRule');
  @override
  late final GeneratedColumn<String> calculationRule = GeneratedColumn<String>(
      'calculation_rule', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _riteMeta = const VerificationMeta('rite');
  @override
  late final GeneratedColumn<String> rite = GeneratedColumn<String>(
      'rite', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _durationDaysMeta =
      const VerificationMeta('durationDays');
  @override
  late final GeneratedColumn<int> durationDays = GeneratedColumn<int>(
      'duration_days', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        nameAr,
        type,
        copticMonth,
        copticDay,
        isMovable,
        calculationRule,
        rite,
        description,
        durationDays
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feasts_and_fasts';
  @override
  VerificationContext validateIntegrity(Insertable<FeastsAndFast> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name_ar')) {
      context.handle(_nameArMeta,
          nameAr.isAcceptableOrUnknown(data['name_ar']!, _nameArMeta));
    } else if (isInserting) {
      context.missing(_nameArMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('coptic_month')) {
      context.handle(
          _copticMonthMeta,
          copticMonth.isAcceptableOrUnknown(
              data['coptic_month']!, _copticMonthMeta));
    }
    if (data.containsKey('coptic_day')) {
      context.handle(_copticDayMeta,
          copticDay.isAcceptableOrUnknown(data['coptic_day']!, _copticDayMeta));
    }
    if (data.containsKey('is_movable')) {
      context.handle(_isMovableMeta,
          isMovable.isAcceptableOrUnknown(data['is_movable']!, _isMovableMeta));
    }
    if (data.containsKey('calculation_rule')) {
      context.handle(
          _calculationRuleMeta,
          calculationRule.isAcceptableOrUnknown(
              data['calculation_rule']!, _calculationRuleMeta));
    }
    if (data.containsKey('rite')) {
      context.handle(
          _riteMeta, rite.isAcceptableOrUnknown(data['rite']!, _riteMeta));
    } else if (isInserting) {
      context.missing(_riteMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('duration_days')) {
      context.handle(
          _durationDaysMeta,
          durationDays.isAcceptableOrUnknown(
              data['duration_days']!, _durationDaysMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FeastsAndFast map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeastsAndFast(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      nameAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_ar'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      copticMonth: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}coptic_month']),
      copticDay: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}coptic_day']),
      isMovable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_movable'])!,
      calculationRule: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}calculation_rule']),
      rite: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rite'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      durationDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_days']),
    );
  }

  @override
  $FeastsAndFastsTable createAlias(String alias) {
    return $FeastsAndFastsTable(attachedDatabase, alias);
  }
}

class FeastsAndFast extends DataClass implements Insertable<FeastsAndFast> {
  final String id;
  final String nameAr;
  final String type;
  final int? copticMonth;
  final int? copticDay;
  final bool isMovable;
  final String? calculationRule;
  final String rite;
  final String description;
  final int? durationDays;
  const FeastsAndFast(
      {required this.id,
      required this.nameAr,
      required this.type,
      this.copticMonth,
      this.copticDay,
      required this.isMovable,
      this.calculationRule,
      required this.rite,
      required this.description,
      this.durationDays});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name_ar'] = Variable<String>(nameAr);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || copticMonth != null) {
      map['coptic_month'] = Variable<int>(copticMonth);
    }
    if (!nullToAbsent || copticDay != null) {
      map['coptic_day'] = Variable<int>(copticDay);
    }
    map['is_movable'] = Variable<bool>(isMovable);
    if (!nullToAbsent || calculationRule != null) {
      map['calculation_rule'] = Variable<String>(calculationRule);
    }
    map['rite'] = Variable<String>(rite);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || durationDays != null) {
      map['duration_days'] = Variable<int>(durationDays);
    }
    return map;
  }

  FeastsAndFastsCompanion toCompanion(bool nullToAbsent) {
    return FeastsAndFastsCompanion(
      id: Value(id),
      nameAr: Value(nameAr),
      type: Value(type),
      copticMonth: copticMonth == null && nullToAbsent
          ? const Value.absent()
          : Value(copticMonth),
      copticDay: copticDay == null && nullToAbsent
          ? const Value.absent()
          : Value(copticDay),
      isMovable: Value(isMovable),
      calculationRule: calculationRule == null && nullToAbsent
          ? const Value.absent()
          : Value(calculationRule),
      rite: Value(rite),
      description: Value(description),
      durationDays: durationDays == null && nullToAbsent
          ? const Value.absent()
          : Value(durationDays),
    );
  }

  factory FeastsAndFast.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeastsAndFast(
      id: serializer.fromJson<String>(json['id']),
      nameAr: serializer.fromJson<String>(json['nameAr']),
      type: serializer.fromJson<String>(json['type']),
      copticMonth: serializer.fromJson<int?>(json['copticMonth']),
      copticDay: serializer.fromJson<int?>(json['copticDay']),
      isMovable: serializer.fromJson<bool>(json['isMovable']),
      calculationRule: serializer.fromJson<String?>(json['calculationRule']),
      rite: serializer.fromJson<String>(json['rite']),
      description: serializer.fromJson<String>(json['description']),
      durationDays: serializer.fromJson<int?>(json['durationDays']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nameAr': serializer.toJson<String>(nameAr),
      'type': serializer.toJson<String>(type),
      'copticMonth': serializer.toJson<int?>(copticMonth),
      'copticDay': serializer.toJson<int?>(copticDay),
      'isMovable': serializer.toJson<bool>(isMovable),
      'calculationRule': serializer.toJson<String?>(calculationRule),
      'rite': serializer.toJson<String>(rite),
      'description': serializer.toJson<String>(description),
      'durationDays': serializer.toJson<int?>(durationDays),
    };
  }

  FeastsAndFast copyWith(
          {String? id,
          String? nameAr,
          String? type,
          Value<int?> copticMonth = const Value.absent(),
          Value<int?> copticDay = const Value.absent(),
          bool? isMovable,
          Value<String?> calculationRule = const Value.absent(),
          String? rite,
          String? description,
          Value<int?> durationDays = const Value.absent()}) =>
      FeastsAndFast(
        id: id ?? this.id,
        nameAr: nameAr ?? this.nameAr,
        type: type ?? this.type,
        copticMonth: copticMonth.present ? copticMonth.value : this.copticMonth,
        copticDay: copticDay.present ? copticDay.value : this.copticDay,
        isMovable: isMovable ?? this.isMovable,
        calculationRule: calculationRule.present
            ? calculationRule.value
            : this.calculationRule,
        rite: rite ?? this.rite,
        description: description ?? this.description,
        durationDays:
            durationDays.present ? durationDays.value : this.durationDays,
      );
  FeastsAndFast copyWithCompanion(FeastsAndFastsCompanion data) {
    return FeastsAndFast(
      id: data.id.present ? data.id.value : this.id,
      nameAr: data.nameAr.present ? data.nameAr.value : this.nameAr,
      type: data.type.present ? data.type.value : this.type,
      copticMonth:
          data.copticMonth.present ? data.copticMonth.value : this.copticMonth,
      copticDay: data.copticDay.present ? data.copticDay.value : this.copticDay,
      isMovable: data.isMovable.present ? data.isMovable.value : this.isMovable,
      calculationRule: data.calculationRule.present
          ? data.calculationRule.value
          : this.calculationRule,
      rite: data.rite.present ? data.rite.value : this.rite,
      description:
          data.description.present ? data.description.value : this.description,
      durationDays: data.durationDays.present
          ? data.durationDays.value
          : this.durationDays,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeastsAndFast(')
          ..write('id: $id, ')
          ..write('nameAr: $nameAr, ')
          ..write('type: $type, ')
          ..write('copticMonth: $copticMonth, ')
          ..write('copticDay: $copticDay, ')
          ..write('isMovable: $isMovable, ')
          ..write('calculationRule: $calculationRule, ')
          ..write('rite: $rite, ')
          ..write('description: $description, ')
          ..write('durationDays: $durationDays')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nameAr, type, copticMonth, copticDay,
      isMovable, calculationRule, rite, description, durationDays);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeastsAndFast &&
          other.id == this.id &&
          other.nameAr == this.nameAr &&
          other.type == this.type &&
          other.copticMonth == this.copticMonth &&
          other.copticDay == this.copticDay &&
          other.isMovable == this.isMovable &&
          other.calculationRule == this.calculationRule &&
          other.rite == this.rite &&
          other.description == this.description &&
          other.durationDays == this.durationDays);
}

class FeastsAndFastsCompanion extends UpdateCompanion<FeastsAndFast> {
  final Value<String> id;
  final Value<String> nameAr;
  final Value<String> type;
  final Value<int?> copticMonth;
  final Value<int?> copticDay;
  final Value<bool> isMovable;
  final Value<String?> calculationRule;
  final Value<String> rite;
  final Value<String> description;
  final Value<int?> durationDays;
  final Value<int> rowid;
  const FeastsAndFastsCompanion({
    this.id = const Value.absent(),
    this.nameAr = const Value.absent(),
    this.type = const Value.absent(),
    this.copticMonth = const Value.absent(),
    this.copticDay = const Value.absent(),
    this.isMovable = const Value.absent(),
    this.calculationRule = const Value.absent(),
    this.rite = const Value.absent(),
    this.description = const Value.absent(),
    this.durationDays = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FeastsAndFastsCompanion.insert({
    required String id,
    required String nameAr,
    required String type,
    this.copticMonth = const Value.absent(),
    this.copticDay = const Value.absent(),
    this.isMovable = const Value.absent(),
    this.calculationRule = const Value.absent(),
    required String rite,
    required String description,
    this.durationDays = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        nameAr = Value(nameAr),
        type = Value(type),
        rite = Value(rite),
        description = Value(description);
  static Insertable<FeastsAndFast> custom({
    Expression<String>? id,
    Expression<String>? nameAr,
    Expression<String>? type,
    Expression<int>? copticMonth,
    Expression<int>? copticDay,
    Expression<bool>? isMovable,
    Expression<String>? calculationRule,
    Expression<String>? rite,
    Expression<String>? description,
    Expression<int>? durationDays,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameAr != null) 'name_ar': nameAr,
      if (type != null) 'type': type,
      if (copticMonth != null) 'coptic_month': copticMonth,
      if (copticDay != null) 'coptic_day': copticDay,
      if (isMovable != null) 'is_movable': isMovable,
      if (calculationRule != null) 'calculation_rule': calculationRule,
      if (rite != null) 'rite': rite,
      if (description != null) 'description': description,
      if (durationDays != null) 'duration_days': durationDays,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FeastsAndFastsCompanion copyWith(
      {Value<String>? id,
      Value<String>? nameAr,
      Value<String>? type,
      Value<int?>? copticMonth,
      Value<int?>? copticDay,
      Value<bool>? isMovable,
      Value<String?>? calculationRule,
      Value<String>? rite,
      Value<String>? description,
      Value<int?>? durationDays,
      Value<int>? rowid}) {
    return FeastsAndFastsCompanion(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      type: type ?? this.type,
      copticMonth: copticMonth ?? this.copticMonth,
      copticDay: copticDay ?? this.copticDay,
      isMovable: isMovable ?? this.isMovable,
      calculationRule: calculationRule ?? this.calculationRule,
      rite: rite ?? this.rite,
      description: description ?? this.description,
      durationDays: durationDays ?? this.durationDays,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nameAr.present) {
      map['name_ar'] = Variable<String>(nameAr.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (copticMonth.present) {
      map['coptic_month'] = Variable<int>(copticMonth.value);
    }
    if (copticDay.present) {
      map['coptic_day'] = Variable<int>(copticDay.value);
    }
    if (isMovable.present) {
      map['is_movable'] = Variable<bool>(isMovable.value);
    }
    if (calculationRule.present) {
      map['calculation_rule'] = Variable<String>(calculationRule.value);
    }
    if (rite.present) {
      map['rite'] = Variable<String>(rite.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (durationDays.present) {
      map['duration_days'] = Variable<int>(durationDays.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeastsAndFastsCompanion(')
          ..write('id: $id, ')
          ..write('nameAr: $nameAr, ')
          ..write('type: $type, ')
          ..write('copticMonth: $copticMonth, ')
          ..write('copticDay: $copticDay, ')
          ..write('isMovable: $isMovable, ')
          ..write('calculationRule: $calculationRule, ')
          ..write('rite: $rite, ')
          ..write('description: $description, ')
          ..write('durationDays: $durationDays, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OccasionalPrayersTable extends OccasionalPrayers
    with TableInfo<$OccasionalPrayersTable, OccasionalPrayer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OccasionalPrayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryArMeta =
      const VerificationMeta('categoryAr');
  @override
  late final GeneratedColumn<String> categoryAr = GeneratedColumn<String>(
      'category_ar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _prayerOrderMeta =
      const VerificationMeta('prayerOrder');
  @override
  late final GeneratedColumn<int> prayerOrder = GeneratedColumn<int>(
      'prayer_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, category, categoryAr, title, content, prayerOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'occasional_prayers';
  @override
  VerificationContext validateIntegrity(Insertable<OccasionalPrayer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('category_ar')) {
      context.handle(
          _categoryArMeta,
          categoryAr.isAcceptableOrUnknown(
              data['category_ar']!, _categoryArMeta));
    } else if (isInserting) {
      context.missing(_categoryArMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('text')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['text']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('prayer_order')) {
      context.handle(
          _prayerOrderMeta,
          prayerOrder.isAcceptableOrUnknown(
              data['prayer_order']!, _prayerOrderMeta));
    } else if (isInserting) {
      context.missing(_prayerOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OccasionalPrayer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OccasionalPrayer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      categoryAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_ar'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text'])!,
      prayerOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}prayer_order'])!,
    );
  }

  @override
  $OccasionalPrayersTable createAlias(String alias) {
    return $OccasionalPrayersTable(attachedDatabase, alias);
  }
}

class OccasionalPrayer extends DataClass
    implements Insertable<OccasionalPrayer> {
  final String id;
  final String category;
  final String categoryAr;
  final String title;
  final String content;
  final int prayerOrder;
  const OccasionalPrayer(
      {required this.id,
      required this.category,
      required this.categoryAr,
      required this.title,
      required this.content,
      required this.prayerOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['category'] = Variable<String>(category);
    map['category_ar'] = Variable<String>(categoryAr);
    map['title'] = Variable<String>(title);
    map['text'] = Variable<String>(content);
    map['prayer_order'] = Variable<int>(prayerOrder);
    return map;
  }

  OccasionalPrayersCompanion toCompanion(bool nullToAbsent) {
    return OccasionalPrayersCompanion(
      id: Value(id),
      category: Value(category),
      categoryAr: Value(categoryAr),
      title: Value(title),
      content: Value(content),
      prayerOrder: Value(prayerOrder),
    );
  }

  factory OccasionalPrayer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OccasionalPrayer(
      id: serializer.fromJson<String>(json['id']),
      category: serializer.fromJson<String>(json['category']),
      categoryAr: serializer.fromJson<String>(json['categoryAr']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      prayerOrder: serializer.fromJson<int>(json['prayerOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'category': serializer.toJson<String>(category),
      'categoryAr': serializer.toJson<String>(categoryAr),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'prayerOrder': serializer.toJson<int>(prayerOrder),
    };
  }

  OccasionalPrayer copyWith(
          {String? id,
          String? category,
          String? categoryAr,
          String? title,
          String? content,
          int? prayerOrder}) =>
      OccasionalPrayer(
        id: id ?? this.id,
        category: category ?? this.category,
        categoryAr: categoryAr ?? this.categoryAr,
        title: title ?? this.title,
        content: content ?? this.content,
        prayerOrder: prayerOrder ?? this.prayerOrder,
      );
  OccasionalPrayer copyWithCompanion(OccasionalPrayersCompanion data) {
    return OccasionalPrayer(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
      categoryAr:
          data.categoryAr.present ? data.categoryAr.value : this.categoryAr,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      prayerOrder:
          data.prayerOrder.present ? data.prayerOrder.value : this.prayerOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OccasionalPrayer(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('categoryAr: $categoryAr, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('prayerOrder: $prayerOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, category, categoryAr, title, content, prayerOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OccasionalPrayer &&
          other.id == this.id &&
          other.category == this.category &&
          other.categoryAr == this.categoryAr &&
          other.title == this.title &&
          other.content == this.content &&
          other.prayerOrder == this.prayerOrder);
}

class OccasionalPrayersCompanion extends UpdateCompanion<OccasionalPrayer> {
  final Value<String> id;
  final Value<String> category;
  final Value<String> categoryAr;
  final Value<String> title;
  final Value<String> content;
  final Value<int> prayerOrder;
  final Value<int> rowid;
  const OccasionalPrayersCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.categoryAr = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.prayerOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OccasionalPrayersCompanion.insert({
    required String id,
    required String category,
    required String categoryAr,
    required String title,
    required String content,
    required int prayerOrder,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        category = Value(category),
        categoryAr = Value(categoryAr),
        title = Value(title),
        content = Value(content),
        prayerOrder = Value(prayerOrder);
  static Insertable<OccasionalPrayer> custom({
    Expression<String>? id,
    Expression<String>? category,
    Expression<String>? categoryAr,
    Expression<String>? title,
    Expression<String>? content,
    Expression<int>? prayerOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (categoryAr != null) 'category_ar': categoryAr,
      if (title != null) 'title': title,
      if (content != null) 'text': content,
      if (prayerOrder != null) 'prayer_order': prayerOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OccasionalPrayersCompanion copyWith(
      {Value<String>? id,
      Value<String>? category,
      Value<String>? categoryAr,
      Value<String>? title,
      Value<String>? content,
      Value<int>? prayerOrder,
      Value<int>? rowid}) {
    return OccasionalPrayersCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      categoryAr: categoryAr ?? this.categoryAr,
      title: title ?? this.title,
      content: content ?? this.content,
      prayerOrder: prayerOrder ?? this.prayerOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (categoryAr.present) {
      map['category_ar'] = Variable<String>(categoryAr.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['text'] = Variable<String>(content.value);
    }
    if (prayerOrder.present) {
      map['prayer_order'] = Variable<int>(prayerOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OccasionalPrayersCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('categoryAr: $categoryAr, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('prayerOrder: $prayerOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TheologyArticlesTable extends TheologyArticles
    with TableInfo<$TheologyArticlesTable, TheologyArticle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TheologyArticlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryArMeta =
      const VerificationMeta('categoryAr');
  @override
  late final GeneratedColumn<String> categoryAr = GeneratedColumn<String>(
      'category_ar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _articleOrderMeta =
      const VerificationMeta('articleOrder');
  @override
  late final GeneratedColumn<int> articleOrder = GeneratedColumn<int>(
      'article_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, category, categoryAr, title, content, articleOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'theology_articles';
  @override
  VerificationContext validateIntegrity(Insertable<TheologyArticle> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('category_ar')) {
      context.handle(
          _categoryArMeta,
          categoryAr.isAcceptableOrUnknown(
              data['category_ar']!, _categoryArMeta));
    } else if (isInserting) {
      context.missing(_categoryArMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('article_order')) {
      context.handle(
          _articleOrderMeta,
          articleOrder.isAcceptableOrUnknown(
              data['article_order']!, _articleOrderMeta));
    } else if (isInserting) {
      context.missing(_articleOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TheologyArticle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TheologyArticle(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      categoryAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_ar'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      articleOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}article_order'])!,
    );
  }

  @override
  $TheologyArticlesTable createAlias(String alias) {
    return $TheologyArticlesTable(attachedDatabase, alias);
  }
}

class TheologyArticle extends DataClass implements Insertable<TheologyArticle> {
  final String id;
  final String category;
  final String categoryAr;
  final String title;
  final String content;
  final int articleOrder;
  const TheologyArticle(
      {required this.id,
      required this.category,
      required this.categoryAr,
      required this.title,
      required this.content,
      required this.articleOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['category'] = Variable<String>(category);
    map['category_ar'] = Variable<String>(categoryAr);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    map['article_order'] = Variable<int>(articleOrder);
    return map;
  }

  TheologyArticlesCompanion toCompanion(bool nullToAbsent) {
    return TheologyArticlesCompanion(
      id: Value(id),
      category: Value(category),
      categoryAr: Value(categoryAr),
      title: Value(title),
      content: Value(content),
      articleOrder: Value(articleOrder),
    );
  }

  factory TheologyArticle.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TheologyArticle(
      id: serializer.fromJson<String>(json['id']),
      category: serializer.fromJson<String>(json['category']),
      categoryAr: serializer.fromJson<String>(json['categoryAr']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      articleOrder: serializer.fromJson<int>(json['articleOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'category': serializer.toJson<String>(category),
      'categoryAr': serializer.toJson<String>(categoryAr),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'articleOrder': serializer.toJson<int>(articleOrder),
    };
  }

  TheologyArticle copyWith(
          {String? id,
          String? category,
          String? categoryAr,
          String? title,
          String? content,
          int? articleOrder}) =>
      TheologyArticle(
        id: id ?? this.id,
        category: category ?? this.category,
        categoryAr: categoryAr ?? this.categoryAr,
        title: title ?? this.title,
        content: content ?? this.content,
        articleOrder: articleOrder ?? this.articleOrder,
      );
  TheologyArticle copyWithCompanion(TheologyArticlesCompanion data) {
    return TheologyArticle(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
      categoryAr:
          data.categoryAr.present ? data.categoryAr.value : this.categoryAr,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      articleOrder: data.articleOrder.present
          ? data.articleOrder.value
          : this.articleOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TheologyArticle(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('categoryAr: $categoryAr, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('articleOrder: $articleOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, category, categoryAr, title, content, articleOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TheologyArticle &&
          other.id == this.id &&
          other.category == this.category &&
          other.categoryAr == this.categoryAr &&
          other.title == this.title &&
          other.content == this.content &&
          other.articleOrder == this.articleOrder);
}

class TheologyArticlesCompanion extends UpdateCompanion<TheologyArticle> {
  final Value<String> id;
  final Value<String> category;
  final Value<String> categoryAr;
  final Value<String> title;
  final Value<String> content;
  final Value<int> articleOrder;
  final Value<int> rowid;
  const TheologyArticlesCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.categoryAr = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.articleOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TheologyArticlesCompanion.insert({
    required String id,
    required String category,
    required String categoryAr,
    required String title,
    required String content,
    required int articleOrder,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        category = Value(category),
        categoryAr = Value(categoryAr),
        title = Value(title),
        content = Value(content),
        articleOrder = Value(articleOrder);
  static Insertable<TheologyArticle> custom({
    Expression<String>? id,
    Expression<String>? category,
    Expression<String>? categoryAr,
    Expression<String>? title,
    Expression<String>? content,
    Expression<int>? articleOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (categoryAr != null) 'category_ar': categoryAr,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (articleOrder != null) 'article_order': articleOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TheologyArticlesCompanion copyWith(
      {Value<String>? id,
      Value<String>? category,
      Value<String>? categoryAr,
      Value<String>? title,
      Value<String>? content,
      Value<int>? articleOrder,
      Value<int>? rowid}) {
    return TheologyArticlesCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      categoryAr: categoryAr ?? this.categoryAr,
      title: title ?? this.title,
      content: content ?? this.content,
      articleOrder: articleOrder ?? this.articleOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (categoryAr.present) {
      map['category_ar'] = Variable<String>(categoryAr.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (articleOrder.present) {
      map['article_order'] = Variable<int>(articleOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TheologyArticlesCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('categoryAr: $categoryAr, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('articleOrder: $articleOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyVersesTable extends DailyVerses
    with TableInfo<$DailyVersesTable, DailyVerse> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyVersesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dayOfYearMeta =
      const VerificationMeta('dayOfYear');
  @override
  late final GeneratedColumn<int> dayOfYear = GeneratedColumn<int>(
      'day_of_year', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _referenceMeta =
      const VerificationMeta('reference');
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
      'reference', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, dayOfYear, reference, content];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_verses';
  @override
  VerificationContext validateIntegrity(Insertable<DailyVerse> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('day_of_year')) {
      context.handle(
          _dayOfYearMeta,
          dayOfYear.isAcceptableOrUnknown(
              data['day_of_year']!, _dayOfYearMeta));
    } else if (isInserting) {
      context.missing(_dayOfYearMeta);
    }
    if (data.containsKey('reference')) {
      context.handle(_referenceMeta,
          reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta));
    } else if (isInserting) {
      context.missing(_referenceMeta);
    }
    if (data.containsKey('text')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['text']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyVerse map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyVerse(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      dayOfYear: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}day_of_year'])!,
      reference: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reference'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text'])!,
    );
  }

  @override
  $DailyVersesTable createAlias(String alias) {
    return $DailyVersesTable(attachedDatabase, alias);
  }
}

class DailyVerse extends DataClass implements Insertable<DailyVerse> {
  final int id;
  final int dayOfYear;
  final String reference;
  final String content;
  const DailyVerse(
      {required this.id,
      required this.dayOfYear,
      required this.reference,
      required this.content});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['day_of_year'] = Variable<int>(dayOfYear);
    map['reference'] = Variable<String>(reference);
    map['text'] = Variable<String>(content);
    return map;
  }

  DailyVersesCompanion toCompanion(bool nullToAbsent) {
    return DailyVersesCompanion(
      id: Value(id),
      dayOfYear: Value(dayOfYear),
      reference: Value(reference),
      content: Value(content),
    );
  }

  factory DailyVerse.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyVerse(
      id: serializer.fromJson<int>(json['id']),
      dayOfYear: serializer.fromJson<int>(json['dayOfYear']),
      reference: serializer.fromJson<String>(json['reference']),
      content: serializer.fromJson<String>(json['content']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dayOfYear': serializer.toJson<int>(dayOfYear),
      'reference': serializer.toJson<String>(reference),
      'content': serializer.toJson<String>(content),
    };
  }

  DailyVerse copyWith(
          {int? id, int? dayOfYear, String? reference, String? content}) =>
      DailyVerse(
        id: id ?? this.id,
        dayOfYear: dayOfYear ?? this.dayOfYear,
        reference: reference ?? this.reference,
        content: content ?? this.content,
      );
  DailyVerse copyWithCompanion(DailyVersesCompanion data) {
    return DailyVerse(
      id: data.id.present ? data.id.value : this.id,
      dayOfYear: data.dayOfYear.present ? data.dayOfYear.value : this.dayOfYear,
      reference: data.reference.present ? data.reference.value : this.reference,
      content: data.content.present ? data.content.value : this.content,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyVerse(')
          ..write('id: $id, ')
          ..write('dayOfYear: $dayOfYear, ')
          ..write('reference: $reference, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dayOfYear, reference, content);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyVerse &&
          other.id == this.id &&
          other.dayOfYear == this.dayOfYear &&
          other.reference == this.reference &&
          other.content == this.content);
}

class DailyVersesCompanion extends UpdateCompanion<DailyVerse> {
  final Value<int> id;
  final Value<int> dayOfYear;
  final Value<String> reference;
  final Value<String> content;
  const DailyVersesCompanion({
    this.id = const Value.absent(),
    this.dayOfYear = const Value.absent(),
    this.reference = const Value.absent(),
    this.content = const Value.absent(),
  });
  DailyVersesCompanion.insert({
    this.id = const Value.absent(),
    required int dayOfYear,
    required String reference,
    required String content,
  })  : dayOfYear = Value(dayOfYear),
        reference = Value(reference),
        content = Value(content);
  static Insertable<DailyVerse> custom({
    Expression<int>? id,
    Expression<int>? dayOfYear,
    Expression<String>? reference,
    Expression<String>? content,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dayOfYear != null) 'day_of_year': dayOfYear,
      if (reference != null) 'reference': reference,
      if (content != null) 'text': content,
    });
  }

  DailyVersesCompanion copyWith(
      {Value<int>? id,
      Value<int>? dayOfYear,
      Value<String>? reference,
      Value<String>? content}) {
    return DailyVersesCompanion(
      id: id ?? this.id,
      dayOfYear: dayOfYear ?? this.dayOfYear,
      reference: reference ?? this.reference,
      content: content ?? this.content,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dayOfYear.present) {
      map['day_of_year'] = Variable<int>(dayOfYear.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (content.present) {
      map['text'] = Variable<String>(content.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyVersesCompanion(')
          ..write('id: $id, ')
          ..write('dayOfYear: $dayOfYear, ')
          ..write('reference: $reference, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }
}

class $BookmarksTable extends Bookmarks
    with TableInfo<$BookmarksTable, Bookmark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _contentTypeMeta =
      const VerificationMeta('contentType');
  @override
  late final GeneratedColumn<String> contentType = GeneratedColumn<String>(
      'content_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentIdMeta =
      const VerificationMeta('contentId');
  @override
  late final GeneratedColumn<String> contentId = GeneratedColumn<String>(
      'content_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _displayTitleMeta =
      const VerificationMeta('displayTitle');
  @override
  late final GeneratedColumn<String> displayTitle = GeneratedColumn<String>(
      'display_title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, contentType, contentId, displayTitle, note, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmarks';
  @override
  VerificationContext validateIntegrity(Insertable<Bookmark> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content_type')) {
      context.handle(
          _contentTypeMeta,
          contentType.isAcceptableOrUnknown(
              data['content_type']!, _contentTypeMeta));
    } else if (isInserting) {
      context.missing(_contentTypeMeta);
    }
    if (data.containsKey('content_id')) {
      context.handle(_contentIdMeta,
          contentId.isAcceptableOrUnknown(data['content_id']!, _contentIdMeta));
    } else if (isInserting) {
      context.missing(_contentIdMeta);
    }
    if (data.containsKey('display_title')) {
      context.handle(
          _displayTitleMeta,
          displayTitle.isAcceptableOrUnknown(
              data['display_title']!, _displayTitleMeta));
    } else if (isInserting) {
      context.missing(_displayTitleMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Bookmark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bookmark(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      contentType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_type'])!,
      contentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_id'])!,
      displayTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_title'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $BookmarksTable createAlias(String alias) {
    return $BookmarksTable(attachedDatabase, alias);
  }
}

class Bookmark extends DataClass implements Insertable<Bookmark> {
  final int id;
  final String contentType;
  final String contentId;
  final String displayTitle;
  final String? note;
  final DateTime createdAt;
  const Bookmark(
      {required this.id,
      required this.contentType,
      required this.contentId,
      required this.displayTitle,
      this.note,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content_type'] = Variable<String>(contentType);
    map['content_id'] = Variable<String>(contentId);
    map['display_title'] = Variable<String>(displayTitle);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BookmarksCompanion toCompanion(bool nullToAbsent) {
    return BookmarksCompanion(
      id: Value(id),
      contentType: Value(contentType),
      contentId: Value(contentId),
      displayTitle: Value(displayTitle),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory Bookmark.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bookmark(
      id: serializer.fromJson<int>(json['id']),
      contentType: serializer.fromJson<String>(json['contentType']),
      contentId: serializer.fromJson<String>(json['contentId']),
      displayTitle: serializer.fromJson<String>(json['displayTitle']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'contentType': serializer.toJson<String>(contentType),
      'contentId': serializer.toJson<String>(contentId),
      'displayTitle': serializer.toJson<String>(displayTitle),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Bookmark copyWith(
          {int? id,
          String? contentType,
          String? contentId,
          String? displayTitle,
          Value<String?> note = const Value.absent(),
          DateTime? createdAt}) =>
      Bookmark(
        id: id ?? this.id,
        contentType: contentType ?? this.contentType,
        contentId: contentId ?? this.contentId,
        displayTitle: displayTitle ?? this.displayTitle,
        note: note.present ? note.value : this.note,
        createdAt: createdAt ?? this.createdAt,
      );
  Bookmark copyWithCompanion(BookmarksCompanion data) {
    return Bookmark(
      id: data.id.present ? data.id.value : this.id,
      contentType:
          data.contentType.present ? data.contentType.value : this.contentType,
      contentId: data.contentId.present ? data.contentId.value : this.contentId,
      displayTitle: data.displayTitle.present
          ? data.displayTitle.value
          : this.displayTitle,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bookmark(')
          ..write('id: $id, ')
          ..write('contentType: $contentType, ')
          ..write('contentId: $contentId, ')
          ..write('displayTitle: $displayTitle, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, contentType, contentId, displayTitle, note, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bookmark &&
          other.id == this.id &&
          other.contentType == this.contentType &&
          other.contentId == this.contentId &&
          other.displayTitle == this.displayTitle &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class BookmarksCompanion extends UpdateCompanion<Bookmark> {
  final Value<int> id;
  final Value<String> contentType;
  final Value<String> contentId;
  final Value<String> displayTitle;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  const BookmarksCompanion({
    this.id = const Value.absent(),
    this.contentType = const Value.absent(),
    this.contentId = const Value.absent(),
    this.displayTitle = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BookmarksCompanion.insert({
    this.id = const Value.absent(),
    required String contentType,
    required String contentId,
    required String displayTitle,
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : contentType = Value(contentType),
        contentId = Value(contentId),
        displayTitle = Value(displayTitle);
  static Insertable<Bookmark> custom({
    Expression<int>? id,
    Expression<String>? contentType,
    Expression<String>? contentId,
    Expression<String>? displayTitle,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (contentType != null) 'content_type': contentType,
      if (contentId != null) 'content_id': contentId,
      if (displayTitle != null) 'display_title': displayTitle,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BookmarksCompanion copyWith(
      {Value<int>? id,
      Value<String>? contentType,
      Value<String>? contentId,
      Value<String>? displayTitle,
      Value<String?>? note,
      Value<DateTime>? createdAt}) {
    return BookmarksCompanion(
      id: id ?? this.id,
      contentType: contentType ?? this.contentType,
      contentId: contentId ?? this.contentId,
      displayTitle: displayTitle ?? this.displayTitle,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (contentType.present) {
      map['content_type'] = Variable<String>(contentType.value);
    }
    if (contentId.present) {
      map['content_id'] = Variable<String>(contentId.value);
    }
    if (displayTitle.present) {
      map['display_title'] = Variable<String>(displayTitle.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksCompanion(')
          ..write('id: $id, ')
          ..write('contentType: $contentType, ')
          ..write('contentId: $contentId, ')
          ..write('displayTitle: $displayTitle, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SacramentsTable extends Sacraments
    with TableInfo<$SacramentsTable, Sacrament> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SacramentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameArMeta = const VerificationMeta('nameAr');
  @override
  late final GeneratedColumn<String> nameAr = GeneratedColumn<String>(
      'name_ar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sacramentOrderMeta =
      const VerificationMeta('sacramentOrder');
  @override
  late final GeneratedColumn<int> sacramentOrder = GeneratedColumn<int>(
      'sacrament_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, nameAr, sacramentOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sacraments';
  @override
  VerificationContext validateIntegrity(Insertable<Sacrament> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name_ar')) {
      context.handle(_nameArMeta,
          nameAr.isAcceptableOrUnknown(data['name_ar']!, _nameArMeta));
    } else if (isInserting) {
      context.missing(_nameArMeta);
    }
    if (data.containsKey('sacrament_order')) {
      context.handle(
          _sacramentOrderMeta,
          sacramentOrder.isAcceptableOrUnknown(
              data['sacrament_order']!, _sacramentOrderMeta));
    } else if (isInserting) {
      context.missing(_sacramentOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Sacrament map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Sacrament(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      nameAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_ar'])!,
      sacramentOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sacrament_order'])!,
    );
  }

  @override
  $SacramentsTable createAlias(String alias) {
    return $SacramentsTable(attachedDatabase, alias);
  }
}

class Sacrament extends DataClass implements Insertable<Sacrament> {
  final String id;
  final String nameAr;
  final int sacramentOrder;
  const Sacrament(
      {required this.id, required this.nameAr, required this.sacramentOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name_ar'] = Variable<String>(nameAr);
    map['sacrament_order'] = Variable<int>(sacramentOrder);
    return map;
  }

  SacramentsCompanion toCompanion(bool nullToAbsent) {
    return SacramentsCompanion(
      id: Value(id),
      nameAr: Value(nameAr),
      sacramentOrder: Value(sacramentOrder),
    );
  }

  factory Sacrament.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sacrament(
      id: serializer.fromJson<String>(json['id']),
      nameAr: serializer.fromJson<String>(json['nameAr']),
      sacramentOrder: serializer.fromJson<int>(json['sacramentOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nameAr': serializer.toJson<String>(nameAr),
      'sacramentOrder': serializer.toJson<int>(sacramentOrder),
    };
  }

  Sacrament copyWith({String? id, String? nameAr, int? sacramentOrder}) =>
      Sacrament(
        id: id ?? this.id,
        nameAr: nameAr ?? this.nameAr,
        sacramentOrder: sacramentOrder ?? this.sacramentOrder,
      );
  Sacrament copyWithCompanion(SacramentsCompanion data) {
    return Sacrament(
      id: data.id.present ? data.id.value : this.id,
      nameAr: data.nameAr.present ? data.nameAr.value : this.nameAr,
      sacramentOrder: data.sacramentOrder.present
          ? data.sacramentOrder.value
          : this.sacramentOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Sacrament(')
          ..write('id: $id, ')
          ..write('nameAr: $nameAr, ')
          ..write('sacramentOrder: $sacramentOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nameAr, sacramentOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sacrament &&
          other.id == this.id &&
          other.nameAr == this.nameAr &&
          other.sacramentOrder == this.sacramentOrder);
}

class SacramentsCompanion extends UpdateCompanion<Sacrament> {
  final Value<String> id;
  final Value<String> nameAr;
  final Value<int> sacramentOrder;
  final Value<int> rowid;
  const SacramentsCompanion({
    this.id = const Value.absent(),
    this.nameAr = const Value.absent(),
    this.sacramentOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SacramentsCompanion.insert({
    required String id,
    required String nameAr,
    required int sacramentOrder,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        nameAr = Value(nameAr),
        sacramentOrder = Value(sacramentOrder);
  static Insertable<Sacrament> custom({
    Expression<String>? id,
    Expression<String>? nameAr,
    Expression<int>? sacramentOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameAr != null) 'name_ar': nameAr,
      if (sacramentOrder != null) 'sacrament_order': sacramentOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SacramentsCompanion copyWith(
      {Value<String>? id,
      Value<String>? nameAr,
      Value<int>? sacramentOrder,
      Value<int>? rowid}) {
    return SacramentsCompanion(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      sacramentOrder: sacramentOrder ?? this.sacramentOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nameAr.present) {
      map['name_ar'] = Variable<String>(nameAr.value);
    }
    if (sacramentOrder.present) {
      map['sacrament_order'] = Variable<int>(sacramentOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SacramentsCompanion(')
          ..write('id: $id, ')
          ..write('nameAr: $nameAr, ')
          ..write('sacramentOrder: $sacramentOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SacramentSectionsTable extends SacramentSections
    with TableInfo<$SacramentSectionsTable, SacramentSection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SacramentSectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _sacramentIdMeta =
      const VerificationMeta('sacramentId');
  @override
  late final GeneratedColumn<String> sacramentId = GeneratedColumn<String>(
      'sacrament_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES sacraments (id)'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _scripturesMeta =
      const VerificationMeta('scriptures');
  @override
  late final GeneratedColumn<String> scriptures = GeneratedColumn<String>(
      'scriptures', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sectionOrderMeta =
      const VerificationMeta('sectionOrder');
  @override
  late final GeneratedColumn<int> sectionOrder = GeneratedColumn<int>(
      'section_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, sacramentId, title, content, scriptures, sectionOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sacrament_sections';
  @override
  VerificationContext validateIntegrity(Insertable<SacramentSection> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sacrament_id')) {
      context.handle(
          _sacramentIdMeta,
          sacramentId.isAcceptableOrUnknown(
              data['sacrament_id']!, _sacramentIdMeta));
    } else if (isInserting) {
      context.missing(_sacramentIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('scriptures')) {
      context.handle(
          _scripturesMeta,
          scriptures.isAcceptableOrUnknown(
              data['scriptures']!, _scripturesMeta));
    }
    if (data.containsKey('section_order')) {
      context.handle(
          _sectionOrderMeta,
          sectionOrder.isAcceptableOrUnknown(
              data['section_order']!, _sectionOrderMeta));
    } else if (isInserting) {
      context.missing(_sectionOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SacramentSection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SacramentSection(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sacramentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sacrament_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      scriptures: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}scriptures']),
      sectionOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}section_order'])!,
    );
  }

  @override
  $SacramentSectionsTable createAlias(String alias) {
    return $SacramentSectionsTable(attachedDatabase, alias);
  }
}

class SacramentSection extends DataClass
    implements Insertable<SacramentSection> {
  final int id;
  final String sacramentId;
  final String title;
  final String content;
  final String? scriptures;
  final int sectionOrder;
  const SacramentSection(
      {required this.id,
      required this.sacramentId,
      required this.title,
      required this.content,
      this.scriptures,
      required this.sectionOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sacrament_id'] = Variable<String>(sacramentId);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || scriptures != null) {
      map['scriptures'] = Variable<String>(scriptures);
    }
    map['section_order'] = Variable<int>(sectionOrder);
    return map;
  }

  SacramentSectionsCompanion toCompanion(bool nullToAbsent) {
    return SacramentSectionsCompanion(
      id: Value(id),
      sacramentId: Value(sacramentId),
      title: Value(title),
      content: Value(content),
      scriptures: scriptures == null && nullToAbsent
          ? const Value.absent()
          : Value(scriptures),
      sectionOrder: Value(sectionOrder),
    );
  }

  factory SacramentSection.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SacramentSection(
      id: serializer.fromJson<int>(json['id']),
      sacramentId: serializer.fromJson<String>(json['sacramentId']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      scriptures: serializer.fromJson<String?>(json['scriptures']),
      sectionOrder: serializer.fromJson<int>(json['sectionOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sacramentId': serializer.toJson<String>(sacramentId),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'scriptures': serializer.toJson<String?>(scriptures),
      'sectionOrder': serializer.toJson<int>(sectionOrder),
    };
  }

  SacramentSection copyWith(
          {int? id,
          String? sacramentId,
          String? title,
          String? content,
          Value<String?> scriptures = const Value.absent(),
          int? sectionOrder}) =>
      SacramentSection(
        id: id ?? this.id,
        sacramentId: sacramentId ?? this.sacramentId,
        title: title ?? this.title,
        content: content ?? this.content,
        scriptures: scriptures.present ? scriptures.value : this.scriptures,
        sectionOrder: sectionOrder ?? this.sectionOrder,
      );
  SacramentSection copyWithCompanion(SacramentSectionsCompanion data) {
    return SacramentSection(
      id: data.id.present ? data.id.value : this.id,
      sacramentId:
          data.sacramentId.present ? data.sacramentId.value : this.sacramentId,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      scriptures:
          data.scriptures.present ? data.scriptures.value : this.scriptures,
      sectionOrder: data.sectionOrder.present
          ? data.sectionOrder.value
          : this.sectionOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SacramentSection(')
          ..write('id: $id, ')
          ..write('sacramentId: $sacramentId, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('scriptures: $scriptures, ')
          ..write('sectionOrder: $sectionOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sacramentId, title, content, scriptures, sectionOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SacramentSection &&
          other.id == this.id &&
          other.sacramentId == this.sacramentId &&
          other.title == this.title &&
          other.content == this.content &&
          other.scriptures == this.scriptures &&
          other.sectionOrder == this.sectionOrder);
}

class SacramentSectionsCompanion extends UpdateCompanion<SacramentSection> {
  final Value<int> id;
  final Value<String> sacramentId;
  final Value<String> title;
  final Value<String> content;
  final Value<String?> scriptures;
  final Value<int> sectionOrder;
  const SacramentSectionsCompanion({
    this.id = const Value.absent(),
    this.sacramentId = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.scriptures = const Value.absent(),
    this.sectionOrder = const Value.absent(),
  });
  SacramentSectionsCompanion.insert({
    this.id = const Value.absent(),
    required String sacramentId,
    required String title,
    required String content,
    this.scriptures = const Value.absent(),
    required int sectionOrder,
  })  : sacramentId = Value(sacramentId),
        title = Value(title),
        content = Value(content),
        sectionOrder = Value(sectionOrder);
  static Insertable<SacramentSection> custom({
    Expression<int>? id,
    Expression<String>? sacramentId,
    Expression<String>? title,
    Expression<String>? content,
    Expression<String>? scriptures,
    Expression<int>? sectionOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sacramentId != null) 'sacrament_id': sacramentId,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (scriptures != null) 'scriptures': scriptures,
      if (sectionOrder != null) 'section_order': sectionOrder,
    });
  }

  SacramentSectionsCompanion copyWith(
      {Value<int>? id,
      Value<String>? sacramentId,
      Value<String>? title,
      Value<String>? content,
      Value<String?>? scriptures,
      Value<int>? sectionOrder}) {
    return SacramentSectionsCompanion(
      id: id ?? this.id,
      sacramentId: sacramentId ?? this.sacramentId,
      title: title ?? this.title,
      content: content ?? this.content,
      scriptures: scriptures ?? this.scriptures,
      sectionOrder: sectionOrder ?? this.sectionOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sacramentId.present) {
      map['sacrament_id'] = Variable<String>(sacramentId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (scriptures.present) {
      map['scriptures'] = Variable<String>(scriptures.value);
    }
    if (sectionOrder.present) {
      map['section_order'] = Variable<int>(sectionOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SacramentSectionsCompanion(')
          ..write('id: $id, ')
          ..write('sacramentId: $sacramentId, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('scriptures: $scriptures, ')
          ..write('sectionOrder: $sectionOrder')
          ..write(')'))
        .toString();
  }
}

class $MonasteriesTable extends Monasteries
    with TableInfo<$MonasteriesTable, MonasteryEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MonasteriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameArMeta = const VerificationMeta('nameAr');
  @override
  late final GeneratedColumn<String> nameAr = GeneratedColumn<String>(
      'name_ar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
      'name_en', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameCopticMeta =
      const VerificationMeta('nameCoptic');
  @override
  late final GeneratedColumn<String> nameCoptic = GeneratedColumn<String>(
      'name_coptic', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('monastery'));
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
      'location', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _foundedMeta =
      const VerificationMeta('founded');
  @override
  late final GeneratedColumn<String> founded = GeneratedColumn<String>(
      'founded', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _founderMeta =
      const VerificationMeta('founder');
  @override
  late final GeneratedColumn<String> founder = GeneratedColumn<String>(
      'founder', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _copticMonthMeta =
      const VerificationMeta('copticMonth');
  @override
  late final GeneratedColumn<int> copticMonth = GeneratedColumn<int>(
      'coptic_month', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _copticDayMeta =
      const VerificationMeta('copticDay');
  @override
  late final GeneratedColumn<int> copticDay = GeneratedColumn<int>(
      'coptic_day', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _patronSaintsMeta =
      const VerificationMeta('patronSaints');
  @override
  late final GeneratedColumn<String> patronSaints = GeneratedColumn<String>(
      'patron_saints', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _visitingHoursMeta =
      const VerificationMeta('visitingHours');
  @override
  late final GeneratedColumn<String> visitingHours = GeneratedColumn<String>(
      'visiting_hours', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _architecturalDescriptionMeta =
      const VerificationMeta('architecturalDescription');
  @override
  late final GeneratedColumn<String> architecturalDescription =
      GeneratedColumn<String>('architectural_description', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _feastDateMeta =
      const VerificationMeta('feastDate');
  @override
  late final GeneratedColumn<String> feastDate = GeneratedColumn<String>(
      'feast_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        nameAr,
        nameEn,
        nameCoptic,
        type,
        location,
        founded,
        founder,
        description,
        copticMonth,
        copticDay,
        latitude,
        longitude,
        patronSaints,
        visitingHours,
        architecturalDescription,
        feastDate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'monasteries';
  @override
  VerificationContext validateIntegrity(Insertable<MonasteryEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name_ar')) {
      context.handle(_nameArMeta,
          nameAr.isAcceptableOrUnknown(data['name_ar']!, _nameArMeta));
    } else if (isInserting) {
      context.missing(_nameArMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(_nameEnMeta,
          nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta));
    }
    if (data.containsKey('name_coptic')) {
      context.handle(
          _nameCopticMeta,
          nameCoptic.isAcceptableOrUnknown(
              data['name_coptic']!, _nameCopticMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('founded')) {
      context.handle(_foundedMeta,
          founded.isAcceptableOrUnknown(data['founded']!, _foundedMeta));
    } else if (isInserting) {
      context.missing(_foundedMeta);
    }
    if (data.containsKey('founder')) {
      context.handle(_founderMeta,
          founder.isAcceptableOrUnknown(data['founder']!, _founderMeta));
    } else if (isInserting) {
      context.missing(_founderMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('coptic_month')) {
      context.handle(
          _copticMonthMeta,
          copticMonth.isAcceptableOrUnknown(
              data['coptic_month']!, _copticMonthMeta));
    }
    if (data.containsKey('coptic_day')) {
      context.handle(_copticDayMeta,
          copticDay.isAcceptableOrUnknown(data['coptic_day']!, _copticDayMeta));
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    }
    if (data.containsKey('patron_saints')) {
      context.handle(
          _patronSaintsMeta,
          patronSaints.isAcceptableOrUnknown(
              data['patron_saints']!, _patronSaintsMeta));
    }
    if (data.containsKey('visiting_hours')) {
      context.handle(
          _visitingHoursMeta,
          visitingHours.isAcceptableOrUnknown(
              data['visiting_hours']!, _visitingHoursMeta));
    }
    if (data.containsKey('architectural_description')) {
      context.handle(
          _architecturalDescriptionMeta,
          architecturalDescription.isAcceptableOrUnknown(
              data['architectural_description']!,
              _architecturalDescriptionMeta));
    }
    if (data.containsKey('feast_date')) {
      context.handle(_feastDateMeta,
          feastDate.isAcceptableOrUnknown(data['feast_date']!, _feastDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MonasteryEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MonasteryEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      nameAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_ar'])!,
      nameEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_en']),
      nameCoptic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_coptic']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      location: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location'])!,
      founded: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}founded'])!,
      founder: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}founder'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      copticMonth: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}coptic_month']),
      copticDay: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}coptic_day']),
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude']),
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude']),
      patronSaints: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}patron_saints']),
      visitingHours: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}visiting_hours']),
      architecturalDescription: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}architectural_description']),
      feastDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}feast_date']),
    );
  }

  @override
  $MonasteriesTable createAlias(String alias) {
    return $MonasteriesTable(attachedDatabase, alias);
  }
}

class MonasteryEntry extends DataClass implements Insertable<MonasteryEntry> {
  final String id;
  final String nameAr;
  final String? nameEn;
  final String? nameCoptic;
  final String type;
  final String location;
  final String founded;
  final String founder;
  final String description;
  final int? copticMonth;
  final int? copticDay;
  final double? latitude;
  final double? longitude;
  final String? patronSaints;
  final String? visitingHours;
  final String? architecturalDescription;
  final String? feastDate;
  const MonasteryEntry(
      {required this.id,
      required this.nameAr,
      this.nameEn,
      this.nameCoptic,
      required this.type,
      required this.location,
      required this.founded,
      required this.founder,
      required this.description,
      this.copticMonth,
      this.copticDay,
      this.latitude,
      this.longitude,
      this.patronSaints,
      this.visitingHours,
      this.architecturalDescription,
      this.feastDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name_ar'] = Variable<String>(nameAr);
    if (!nullToAbsent || nameEn != null) {
      map['name_en'] = Variable<String>(nameEn);
    }
    if (!nullToAbsent || nameCoptic != null) {
      map['name_coptic'] = Variable<String>(nameCoptic);
    }
    map['type'] = Variable<String>(type);
    map['location'] = Variable<String>(location);
    map['founded'] = Variable<String>(founded);
    map['founder'] = Variable<String>(founder);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || copticMonth != null) {
      map['coptic_month'] = Variable<int>(copticMonth);
    }
    if (!nullToAbsent || copticDay != null) {
      map['coptic_day'] = Variable<int>(copticDay);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || patronSaints != null) {
      map['patron_saints'] = Variable<String>(patronSaints);
    }
    if (!nullToAbsent || visitingHours != null) {
      map['visiting_hours'] = Variable<String>(visitingHours);
    }
    if (!nullToAbsent || architecturalDescription != null) {
      map['architectural_description'] =
          Variable<String>(architecturalDescription);
    }
    if (!nullToAbsent || feastDate != null) {
      map['feast_date'] = Variable<String>(feastDate);
    }
    return map;
  }

  MonasteriesCompanion toCompanion(bool nullToAbsent) {
    return MonasteriesCompanion(
      id: Value(id),
      nameAr: Value(nameAr),
      nameEn:
          nameEn == null && nullToAbsent ? const Value.absent() : Value(nameEn),
      nameCoptic: nameCoptic == null && nullToAbsent
          ? const Value.absent()
          : Value(nameCoptic),
      type: Value(type),
      location: Value(location),
      founded: Value(founded),
      founder: Value(founder),
      description: Value(description),
      copticMonth: copticMonth == null && nullToAbsent
          ? const Value.absent()
          : Value(copticMonth),
      copticDay: copticDay == null && nullToAbsent
          ? const Value.absent()
          : Value(copticDay),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      patronSaints: patronSaints == null && nullToAbsent
          ? const Value.absent()
          : Value(patronSaints),
      visitingHours: visitingHours == null && nullToAbsent
          ? const Value.absent()
          : Value(visitingHours),
      architecturalDescription: architecturalDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(architecturalDescription),
      feastDate: feastDate == null && nullToAbsent
          ? const Value.absent()
          : Value(feastDate),
    );
  }

  factory MonasteryEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MonasteryEntry(
      id: serializer.fromJson<String>(json['id']),
      nameAr: serializer.fromJson<String>(json['nameAr']),
      nameEn: serializer.fromJson<String?>(json['nameEn']),
      nameCoptic: serializer.fromJson<String?>(json['nameCoptic']),
      type: serializer.fromJson<String>(json['type']),
      location: serializer.fromJson<String>(json['location']),
      founded: serializer.fromJson<String>(json['founded']),
      founder: serializer.fromJson<String>(json['founder']),
      description: serializer.fromJson<String>(json['description']),
      copticMonth: serializer.fromJson<int?>(json['copticMonth']),
      copticDay: serializer.fromJson<int?>(json['copticDay']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      patronSaints: serializer.fromJson<String?>(json['patronSaints']),
      visitingHours: serializer.fromJson<String?>(json['visitingHours']),
      architecturalDescription:
          serializer.fromJson<String?>(json['architecturalDescription']),
      feastDate: serializer.fromJson<String?>(json['feastDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nameAr': serializer.toJson<String>(nameAr),
      'nameEn': serializer.toJson<String?>(nameEn),
      'nameCoptic': serializer.toJson<String?>(nameCoptic),
      'type': serializer.toJson<String>(type),
      'location': serializer.toJson<String>(location),
      'founded': serializer.toJson<String>(founded),
      'founder': serializer.toJson<String>(founder),
      'description': serializer.toJson<String>(description),
      'copticMonth': serializer.toJson<int?>(copticMonth),
      'copticDay': serializer.toJson<int?>(copticDay),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'patronSaints': serializer.toJson<String?>(patronSaints),
      'visitingHours': serializer.toJson<String?>(visitingHours),
      'architecturalDescription':
          serializer.toJson<String?>(architecturalDescription),
      'feastDate': serializer.toJson<String?>(feastDate),
    };
  }

  MonasteryEntry copyWith(
          {String? id,
          String? nameAr,
          Value<String?> nameEn = const Value.absent(),
          Value<String?> nameCoptic = const Value.absent(),
          String? type,
          String? location,
          String? founded,
          String? founder,
          String? description,
          Value<int?> copticMonth = const Value.absent(),
          Value<int?> copticDay = const Value.absent(),
          Value<double?> latitude = const Value.absent(),
          Value<double?> longitude = const Value.absent(),
          Value<String?> patronSaints = const Value.absent(),
          Value<String?> visitingHours = const Value.absent(),
          Value<String?> architecturalDescription = const Value.absent(),
          Value<String?> feastDate = const Value.absent()}) =>
      MonasteryEntry(
        id: id ?? this.id,
        nameAr: nameAr ?? this.nameAr,
        nameEn: nameEn.present ? nameEn.value : this.nameEn,
        nameCoptic: nameCoptic.present ? nameCoptic.value : this.nameCoptic,
        type: type ?? this.type,
        location: location ?? this.location,
        founded: founded ?? this.founded,
        founder: founder ?? this.founder,
        description: description ?? this.description,
        copticMonth: copticMonth.present ? copticMonth.value : this.copticMonth,
        copticDay: copticDay.present ? copticDay.value : this.copticDay,
        latitude: latitude.present ? latitude.value : this.latitude,
        longitude: longitude.present ? longitude.value : this.longitude,
        patronSaints:
            patronSaints.present ? patronSaints.value : this.patronSaints,
        visitingHours:
            visitingHours.present ? visitingHours.value : this.visitingHours,
        architecturalDescription: architecturalDescription.present
            ? architecturalDescription.value
            : this.architecturalDescription,
        feastDate: feastDate.present ? feastDate.value : this.feastDate,
      );
  MonasteryEntry copyWithCompanion(MonasteriesCompanion data) {
    return MonasteryEntry(
      id: data.id.present ? data.id.value : this.id,
      nameAr: data.nameAr.present ? data.nameAr.value : this.nameAr,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameCoptic:
          data.nameCoptic.present ? data.nameCoptic.value : this.nameCoptic,
      type: data.type.present ? data.type.value : this.type,
      location: data.location.present ? data.location.value : this.location,
      founded: data.founded.present ? data.founded.value : this.founded,
      founder: data.founder.present ? data.founder.value : this.founder,
      description:
          data.description.present ? data.description.value : this.description,
      copticMonth:
          data.copticMonth.present ? data.copticMonth.value : this.copticMonth,
      copticDay: data.copticDay.present ? data.copticDay.value : this.copticDay,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      patronSaints: data.patronSaints.present
          ? data.patronSaints.value
          : this.patronSaints,
      visitingHours: data.visitingHours.present
          ? data.visitingHours.value
          : this.visitingHours,
      architecturalDescription: data.architecturalDescription.present
          ? data.architecturalDescription.value
          : this.architecturalDescription,
      feastDate: data.feastDate.present ? data.feastDate.value : this.feastDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MonasteryEntry(')
          ..write('id: $id, ')
          ..write('nameAr: $nameAr, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameCoptic: $nameCoptic, ')
          ..write('type: $type, ')
          ..write('location: $location, ')
          ..write('founded: $founded, ')
          ..write('founder: $founder, ')
          ..write('description: $description, ')
          ..write('copticMonth: $copticMonth, ')
          ..write('copticDay: $copticDay, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('patronSaints: $patronSaints, ')
          ..write('visitingHours: $visitingHours, ')
          ..write('architecturalDescription: $architecturalDescription, ')
          ..write('feastDate: $feastDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      nameAr,
      nameEn,
      nameCoptic,
      type,
      location,
      founded,
      founder,
      description,
      copticMonth,
      copticDay,
      latitude,
      longitude,
      patronSaints,
      visitingHours,
      architecturalDescription,
      feastDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MonasteryEntry &&
          other.id == this.id &&
          other.nameAr == this.nameAr &&
          other.nameEn == this.nameEn &&
          other.nameCoptic == this.nameCoptic &&
          other.type == this.type &&
          other.location == this.location &&
          other.founded == this.founded &&
          other.founder == this.founder &&
          other.description == this.description &&
          other.copticMonth == this.copticMonth &&
          other.copticDay == this.copticDay &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.patronSaints == this.patronSaints &&
          other.visitingHours == this.visitingHours &&
          other.architecturalDescription == this.architecturalDescription &&
          other.feastDate == this.feastDate);
}

class MonasteriesCompanion extends UpdateCompanion<MonasteryEntry> {
  final Value<String> id;
  final Value<String> nameAr;
  final Value<String?> nameEn;
  final Value<String?> nameCoptic;
  final Value<String> type;
  final Value<String> location;
  final Value<String> founded;
  final Value<String> founder;
  final Value<String> description;
  final Value<int?> copticMonth;
  final Value<int?> copticDay;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String?> patronSaints;
  final Value<String?> visitingHours;
  final Value<String?> architecturalDescription;
  final Value<String?> feastDate;
  final Value<int> rowid;
  const MonasteriesCompanion({
    this.id = const Value.absent(),
    this.nameAr = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameCoptic = const Value.absent(),
    this.type = const Value.absent(),
    this.location = const Value.absent(),
    this.founded = const Value.absent(),
    this.founder = const Value.absent(),
    this.description = const Value.absent(),
    this.copticMonth = const Value.absent(),
    this.copticDay = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.patronSaints = const Value.absent(),
    this.visitingHours = const Value.absent(),
    this.architecturalDescription = const Value.absent(),
    this.feastDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MonasteriesCompanion.insert({
    required String id,
    required String nameAr,
    this.nameEn = const Value.absent(),
    this.nameCoptic = const Value.absent(),
    this.type = const Value.absent(),
    required String location,
    required String founded,
    required String founder,
    required String description,
    this.copticMonth = const Value.absent(),
    this.copticDay = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.patronSaints = const Value.absent(),
    this.visitingHours = const Value.absent(),
    this.architecturalDescription = const Value.absent(),
    this.feastDate = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        nameAr = Value(nameAr),
        location = Value(location),
        founded = Value(founded),
        founder = Value(founder),
        description = Value(description);
  static Insertable<MonasteryEntry> custom({
    Expression<String>? id,
    Expression<String>? nameAr,
    Expression<String>? nameEn,
    Expression<String>? nameCoptic,
    Expression<String>? type,
    Expression<String>? location,
    Expression<String>? founded,
    Expression<String>? founder,
    Expression<String>? description,
    Expression<int>? copticMonth,
    Expression<int>? copticDay,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? patronSaints,
    Expression<String>? visitingHours,
    Expression<String>? architecturalDescription,
    Expression<String>? feastDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameAr != null) 'name_ar': nameAr,
      if (nameEn != null) 'name_en': nameEn,
      if (nameCoptic != null) 'name_coptic': nameCoptic,
      if (type != null) 'type': type,
      if (location != null) 'location': location,
      if (founded != null) 'founded': founded,
      if (founder != null) 'founder': founder,
      if (description != null) 'description': description,
      if (copticMonth != null) 'coptic_month': copticMonth,
      if (copticDay != null) 'coptic_day': copticDay,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (patronSaints != null) 'patron_saints': patronSaints,
      if (visitingHours != null) 'visiting_hours': visitingHours,
      if (architecturalDescription != null)
        'architectural_description': architecturalDescription,
      if (feastDate != null) 'feast_date': feastDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MonasteriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? nameAr,
      Value<String?>? nameEn,
      Value<String?>? nameCoptic,
      Value<String>? type,
      Value<String>? location,
      Value<String>? founded,
      Value<String>? founder,
      Value<String>? description,
      Value<int?>? copticMonth,
      Value<int?>? copticDay,
      Value<double?>? latitude,
      Value<double?>? longitude,
      Value<String?>? patronSaints,
      Value<String?>? visitingHours,
      Value<String?>? architecturalDescription,
      Value<String?>? feastDate,
      Value<int>? rowid}) {
    return MonasteriesCompanion(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      nameCoptic: nameCoptic ?? this.nameCoptic,
      type: type ?? this.type,
      location: location ?? this.location,
      founded: founded ?? this.founded,
      founder: founder ?? this.founder,
      description: description ?? this.description,
      copticMonth: copticMonth ?? this.copticMonth,
      copticDay: copticDay ?? this.copticDay,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      patronSaints: patronSaints ?? this.patronSaints,
      visitingHours: visitingHours ?? this.visitingHours,
      architecturalDescription:
          architecturalDescription ?? this.architecturalDescription,
      feastDate: feastDate ?? this.feastDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nameAr.present) {
      map['name_ar'] = Variable<String>(nameAr.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameCoptic.present) {
      map['name_coptic'] = Variable<String>(nameCoptic.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (founded.present) {
      map['founded'] = Variable<String>(founded.value);
    }
    if (founder.present) {
      map['founder'] = Variable<String>(founder.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (copticMonth.present) {
      map['coptic_month'] = Variable<int>(copticMonth.value);
    }
    if (copticDay.present) {
      map['coptic_day'] = Variable<int>(copticDay.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (patronSaints.present) {
      map['patron_saints'] = Variable<String>(patronSaints.value);
    }
    if (visitingHours.present) {
      map['visiting_hours'] = Variable<String>(visitingHours.value);
    }
    if (architecturalDescription.present) {
      map['architectural_description'] =
          Variable<String>(architecturalDescription.value);
    }
    if (feastDate.present) {
      map['feast_date'] = Variable<String>(feastDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MonasteriesCompanion(')
          ..write('id: $id, ')
          ..write('nameAr: $nameAr, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameCoptic: $nameCoptic, ')
          ..write('type: $type, ')
          ..write('location: $location, ')
          ..write('founded: $founded, ')
          ..write('founder: $founder, ')
          ..write('description: $description, ')
          ..write('copticMonth: $copticMonth, ')
          ..write('copticDay: $copticDay, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('patronSaints: $patronSaints, ')
          ..write('visitingHours: $visitingHours, ')
          ..write('architecturalDescription: $architecturalDescription, ')
          ..write('feastDate: $feastDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BibleCommentariesTable extends BibleCommentaries
    with TableInfo<$BibleCommentariesTable, BibleCommentary> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BibleCommentariesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
      'book_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _chapterMeta =
      const VerificationMeta('chapter');
  @override
  late final GeneratedColumn<int> chapter = GeneratedColumn<int>(
      'chapter', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _verseStartMeta =
      const VerificationMeta('verseStart');
  @override
  late final GeneratedColumn<int> verseStart = GeneratedColumn<int>(
      'verse_start', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _verseEndMeta =
      const VerificationMeta('verseEnd');
  @override
  late final GeneratedColumn<int> verseEnd = GeneratedColumn<int>(
      'verse_end', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
      'author', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _summaryMeta =
      const VerificationMeta('summary');
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
      'summary', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        bookId,
        chapter,
        verseStart,
        verseEnd,
        source,
        author,
        content,
        summary
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bible_commentaries';
  @override
  VerificationContext validateIntegrity(Insertable<BibleCommentary> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('book_id')) {
      context.handle(_bookIdMeta,
          bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta));
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('chapter')) {
      context.handle(_chapterMeta,
          chapter.isAcceptableOrUnknown(data['chapter']!, _chapterMeta));
    } else if (isInserting) {
      context.missing(_chapterMeta);
    }
    if (data.containsKey('verse_start')) {
      context.handle(
          _verseStartMeta,
          verseStart.isAcceptableOrUnknown(
              data['verse_start']!, _verseStartMeta));
    }
    if (data.containsKey('verse_end')) {
      context.handle(_verseEndMeta,
          verseEnd.isAcceptableOrUnknown(data['verse_end']!, _verseEndMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author']!, _authorMeta));
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (data.containsKey('text')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['text']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('summary')) {
      context.handle(_summaryMeta,
          summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta));
    } else if (isInserting) {
      context.missing(_summaryMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BibleCommentary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BibleCommentary(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      bookId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}book_id'])!,
      chapter: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chapter'])!,
      verseStart: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}verse_start']),
      verseEnd: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}verse_end']),
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      author: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text'])!,
      summary: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}summary'])!,
    );
  }

  @override
  $BibleCommentariesTable createAlias(String alias) {
    return $BibleCommentariesTable(attachedDatabase, alias);
  }
}

class BibleCommentary extends DataClass implements Insertable<BibleCommentary> {
  final int id;
  final int bookId;
  final int chapter;
  final int? verseStart;
  final int? verseEnd;
  final String source;
  final String author;
  final String content;
  final String summary;
  const BibleCommentary(
      {required this.id,
      required this.bookId,
      required this.chapter,
      this.verseStart,
      this.verseEnd,
      required this.source,
      required this.author,
      required this.content,
      required this.summary});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['book_id'] = Variable<int>(bookId);
    map['chapter'] = Variable<int>(chapter);
    if (!nullToAbsent || verseStart != null) {
      map['verse_start'] = Variable<int>(verseStart);
    }
    if (!nullToAbsent || verseEnd != null) {
      map['verse_end'] = Variable<int>(verseEnd);
    }
    map['source'] = Variable<String>(source);
    map['author'] = Variable<String>(author);
    map['text'] = Variable<String>(content);
    map['summary'] = Variable<String>(summary);
    return map;
  }

  BibleCommentariesCompanion toCompanion(bool nullToAbsent) {
    return BibleCommentariesCompanion(
      id: Value(id),
      bookId: Value(bookId),
      chapter: Value(chapter),
      verseStart: verseStart == null && nullToAbsent
          ? const Value.absent()
          : Value(verseStart),
      verseEnd: verseEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(verseEnd),
      source: Value(source),
      author: Value(author),
      content: Value(content),
      summary: Value(summary),
    );
  }

  factory BibleCommentary.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BibleCommentary(
      id: serializer.fromJson<int>(json['id']),
      bookId: serializer.fromJson<int>(json['bookId']),
      chapter: serializer.fromJson<int>(json['chapter']),
      verseStart: serializer.fromJson<int?>(json['verseStart']),
      verseEnd: serializer.fromJson<int?>(json['verseEnd']),
      source: serializer.fromJson<String>(json['source']),
      author: serializer.fromJson<String>(json['author']),
      content: serializer.fromJson<String>(json['content']),
      summary: serializer.fromJson<String>(json['summary']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bookId': serializer.toJson<int>(bookId),
      'chapter': serializer.toJson<int>(chapter),
      'verseStart': serializer.toJson<int?>(verseStart),
      'verseEnd': serializer.toJson<int?>(verseEnd),
      'source': serializer.toJson<String>(source),
      'author': serializer.toJson<String>(author),
      'content': serializer.toJson<String>(content),
      'summary': serializer.toJson<String>(summary),
    };
  }

  BibleCommentary copyWith(
          {int? id,
          int? bookId,
          int? chapter,
          Value<int?> verseStart = const Value.absent(),
          Value<int?> verseEnd = const Value.absent(),
          String? source,
          String? author,
          String? content,
          String? summary}) =>
      BibleCommentary(
        id: id ?? this.id,
        bookId: bookId ?? this.bookId,
        chapter: chapter ?? this.chapter,
        verseStart: verseStart.present ? verseStart.value : this.verseStart,
        verseEnd: verseEnd.present ? verseEnd.value : this.verseEnd,
        source: source ?? this.source,
        author: author ?? this.author,
        content: content ?? this.content,
        summary: summary ?? this.summary,
      );
  BibleCommentary copyWithCompanion(BibleCommentariesCompanion data) {
    return BibleCommentary(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      chapter: data.chapter.present ? data.chapter.value : this.chapter,
      verseStart:
          data.verseStart.present ? data.verseStart.value : this.verseStart,
      verseEnd: data.verseEnd.present ? data.verseEnd.value : this.verseEnd,
      source: data.source.present ? data.source.value : this.source,
      author: data.author.present ? data.author.value : this.author,
      content: data.content.present ? data.content.value : this.content,
      summary: data.summary.present ? data.summary.value : this.summary,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BibleCommentary(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('verseStart: $verseStart, ')
          ..write('verseEnd: $verseEnd, ')
          ..write('source: $source, ')
          ..write('author: $author, ')
          ..write('content: $content, ')
          ..write('summary: $summary')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bookId, chapter, verseStart, verseEnd,
      source, author, content, summary);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BibleCommentary &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.chapter == this.chapter &&
          other.verseStart == this.verseStart &&
          other.verseEnd == this.verseEnd &&
          other.source == this.source &&
          other.author == this.author &&
          other.content == this.content &&
          other.summary == this.summary);
}

class BibleCommentariesCompanion extends UpdateCompanion<BibleCommentary> {
  final Value<int> id;
  final Value<int> bookId;
  final Value<int> chapter;
  final Value<int?> verseStart;
  final Value<int?> verseEnd;
  final Value<String> source;
  final Value<String> author;
  final Value<String> content;
  final Value<String> summary;
  const BibleCommentariesCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.chapter = const Value.absent(),
    this.verseStart = const Value.absent(),
    this.verseEnd = const Value.absent(),
    this.source = const Value.absent(),
    this.author = const Value.absent(),
    this.content = const Value.absent(),
    this.summary = const Value.absent(),
  });
  BibleCommentariesCompanion.insert({
    this.id = const Value.absent(),
    required int bookId,
    required int chapter,
    this.verseStart = const Value.absent(),
    this.verseEnd = const Value.absent(),
    required String source,
    required String author,
    required String content,
    required String summary,
  })  : bookId = Value(bookId),
        chapter = Value(chapter),
        source = Value(source),
        author = Value(author),
        content = Value(content),
        summary = Value(summary);
  static Insertable<BibleCommentary> custom({
    Expression<int>? id,
    Expression<int>? bookId,
    Expression<int>? chapter,
    Expression<int>? verseStart,
    Expression<int>? verseEnd,
    Expression<String>? source,
    Expression<String>? author,
    Expression<String>? content,
    Expression<String>? summary,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (chapter != null) 'chapter': chapter,
      if (verseStart != null) 'verse_start': verseStart,
      if (verseEnd != null) 'verse_end': verseEnd,
      if (source != null) 'source': source,
      if (author != null) 'author': author,
      if (content != null) 'text': content,
      if (summary != null) 'summary': summary,
    });
  }

  BibleCommentariesCompanion copyWith(
      {Value<int>? id,
      Value<int>? bookId,
      Value<int>? chapter,
      Value<int?>? verseStart,
      Value<int?>? verseEnd,
      Value<String>? source,
      Value<String>? author,
      Value<String>? content,
      Value<String>? summary}) {
    return BibleCommentariesCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      chapter: chapter ?? this.chapter,
      verseStart: verseStart ?? this.verseStart,
      verseEnd: verseEnd ?? this.verseEnd,
      source: source ?? this.source,
      author: author ?? this.author,
      content: content ?? this.content,
      summary: summary ?? this.summary,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<int>(bookId.value);
    }
    if (chapter.present) {
      map['chapter'] = Variable<int>(chapter.value);
    }
    if (verseStart.present) {
      map['verse_start'] = Variable<int>(verseStart.value);
    }
    if (verseEnd.present) {
      map['verse_end'] = Variable<int>(verseEnd.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (content.present) {
      map['text'] = Variable<String>(content.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BibleCommentariesCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('verseStart: $verseStart, ')
          ..write('verseEnd: $verseEnd, ')
          ..write('source: $source, ')
          ..write('author: $author, ')
          ..write('content: $content, ')
          ..write('summary: $summary')
          ..write(')'))
        .toString();
  }
}

class $CopticDictionaryTable extends CopticDictionary
    with TableInfo<$CopticDictionaryTable, CopticDictionaryEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CopticDictionaryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _copticMeta = const VerificationMeta('coptic');
  @override
  late final GeneratedColumn<String> coptic = GeneratedColumn<String>(
      'coptic', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneticMeta =
      const VerificationMeta('phonetic');
  @override
  late final GeneratedColumn<String> phonetic = GeneratedColumn<String>(
      'phonetic', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _arabicMeta = const VerificationMeta('arabic');
  @override
  late final GeneratedColumn<String> arabic = GeneratedColumn<String>(
      'arabic', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _englishMeta =
      const VerificationMeta('english');
  @override
  late final GeneratedColumn<String> english = GeneratedColumn<String>(
      'english', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _partOfSpeechMeta =
      const VerificationMeta('partOfSpeech');
  @override
  late final GeneratedColumn<String> partOfSpeech = GeneratedColumn<String>(
      'part_of_speech', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('noun'));
  static const VerificationMeta _usageMeta = const VerificationMeta('usage');
  @override
  late final GeneratedColumn<String> usage = GeneratedColumn<String>(
      'usage', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _hymnReferenceMeta =
      const VerificationMeta('hymnReference');
  @override
  late final GeneratedColumn<String> hymnReference = GeneratedColumn<String>(
      'hymn_reference', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        coptic,
        phonetic,
        arabic,
        english,
        partOfSpeech,
        usage,
        hymnReference
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'coptic_dictionary';
  @override
  VerificationContext validateIntegrity(
      Insertable<CopticDictionaryEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('coptic')) {
      context.handle(_copticMeta,
          coptic.isAcceptableOrUnknown(data['coptic']!, _copticMeta));
    } else if (isInserting) {
      context.missing(_copticMeta);
    }
    if (data.containsKey('phonetic')) {
      context.handle(_phoneticMeta,
          phonetic.isAcceptableOrUnknown(data['phonetic']!, _phoneticMeta));
    } else if (isInserting) {
      context.missing(_phoneticMeta);
    }
    if (data.containsKey('arabic')) {
      context.handle(_arabicMeta,
          arabic.isAcceptableOrUnknown(data['arabic']!, _arabicMeta));
    } else if (isInserting) {
      context.missing(_arabicMeta);
    }
    if (data.containsKey('english')) {
      context.handle(_englishMeta,
          english.isAcceptableOrUnknown(data['english']!, _englishMeta));
    }
    if (data.containsKey('part_of_speech')) {
      context.handle(
          _partOfSpeechMeta,
          partOfSpeech.isAcceptableOrUnknown(
              data['part_of_speech']!, _partOfSpeechMeta));
    }
    if (data.containsKey('usage')) {
      context.handle(
          _usageMeta, usage.isAcceptableOrUnknown(data['usage']!, _usageMeta));
    }
    if (data.containsKey('hymn_reference')) {
      context.handle(
          _hymnReferenceMeta,
          hymnReference.isAcceptableOrUnknown(
              data['hymn_reference']!, _hymnReferenceMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CopticDictionaryEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CopticDictionaryEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      coptic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}coptic'])!,
      phonetic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phonetic'])!,
      arabic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}arabic'])!,
      english: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}english']),
      partOfSpeech: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}part_of_speech'])!,
      usage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}usage']),
      hymnReference: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hymn_reference']),
    );
  }

  @override
  $CopticDictionaryTable createAlias(String alias) {
    return $CopticDictionaryTable(attachedDatabase, alias);
  }
}

class CopticDictionaryEntry extends DataClass
    implements Insertable<CopticDictionaryEntry> {
  final int id;
  final String coptic;
  final String phonetic;
  final String arabic;
  final String? english;
  final String partOfSpeech;
  final String? usage;
  final String? hymnReference;
  const CopticDictionaryEntry(
      {required this.id,
      required this.coptic,
      required this.phonetic,
      required this.arabic,
      this.english,
      required this.partOfSpeech,
      this.usage,
      this.hymnReference});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['coptic'] = Variable<String>(coptic);
    map['phonetic'] = Variable<String>(phonetic);
    map['arabic'] = Variable<String>(arabic);
    if (!nullToAbsent || english != null) {
      map['english'] = Variable<String>(english);
    }
    map['part_of_speech'] = Variable<String>(partOfSpeech);
    if (!nullToAbsent || usage != null) {
      map['usage'] = Variable<String>(usage);
    }
    if (!nullToAbsent || hymnReference != null) {
      map['hymn_reference'] = Variable<String>(hymnReference);
    }
    return map;
  }

  CopticDictionaryCompanion toCompanion(bool nullToAbsent) {
    return CopticDictionaryCompanion(
      id: Value(id),
      coptic: Value(coptic),
      phonetic: Value(phonetic),
      arabic: Value(arabic),
      english: english == null && nullToAbsent
          ? const Value.absent()
          : Value(english),
      partOfSpeech: Value(partOfSpeech),
      usage:
          usage == null && nullToAbsent ? const Value.absent() : Value(usage),
      hymnReference: hymnReference == null && nullToAbsent
          ? const Value.absent()
          : Value(hymnReference),
    );
  }

  factory CopticDictionaryEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CopticDictionaryEntry(
      id: serializer.fromJson<int>(json['id']),
      coptic: serializer.fromJson<String>(json['coptic']),
      phonetic: serializer.fromJson<String>(json['phonetic']),
      arabic: serializer.fromJson<String>(json['arabic']),
      english: serializer.fromJson<String?>(json['english']),
      partOfSpeech: serializer.fromJson<String>(json['partOfSpeech']),
      usage: serializer.fromJson<String?>(json['usage']),
      hymnReference: serializer.fromJson<String?>(json['hymnReference']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'coptic': serializer.toJson<String>(coptic),
      'phonetic': serializer.toJson<String>(phonetic),
      'arabic': serializer.toJson<String>(arabic),
      'english': serializer.toJson<String?>(english),
      'partOfSpeech': serializer.toJson<String>(partOfSpeech),
      'usage': serializer.toJson<String?>(usage),
      'hymnReference': serializer.toJson<String?>(hymnReference),
    };
  }

  CopticDictionaryEntry copyWith(
          {int? id,
          String? coptic,
          String? phonetic,
          String? arabic,
          Value<String?> english = const Value.absent(),
          String? partOfSpeech,
          Value<String?> usage = const Value.absent(),
          Value<String?> hymnReference = const Value.absent()}) =>
      CopticDictionaryEntry(
        id: id ?? this.id,
        coptic: coptic ?? this.coptic,
        phonetic: phonetic ?? this.phonetic,
        arabic: arabic ?? this.arabic,
        english: english.present ? english.value : this.english,
        partOfSpeech: partOfSpeech ?? this.partOfSpeech,
        usage: usage.present ? usage.value : this.usage,
        hymnReference:
            hymnReference.present ? hymnReference.value : this.hymnReference,
      );
  CopticDictionaryEntry copyWithCompanion(CopticDictionaryCompanion data) {
    return CopticDictionaryEntry(
      id: data.id.present ? data.id.value : this.id,
      coptic: data.coptic.present ? data.coptic.value : this.coptic,
      phonetic: data.phonetic.present ? data.phonetic.value : this.phonetic,
      arabic: data.arabic.present ? data.arabic.value : this.arabic,
      english: data.english.present ? data.english.value : this.english,
      partOfSpeech: data.partOfSpeech.present
          ? data.partOfSpeech.value
          : this.partOfSpeech,
      usage: data.usage.present ? data.usage.value : this.usage,
      hymnReference: data.hymnReference.present
          ? data.hymnReference.value
          : this.hymnReference,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CopticDictionaryEntry(')
          ..write('id: $id, ')
          ..write('coptic: $coptic, ')
          ..write('phonetic: $phonetic, ')
          ..write('arabic: $arabic, ')
          ..write('english: $english, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('usage: $usage, ')
          ..write('hymnReference: $hymnReference')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, coptic, phonetic, arabic, english,
      partOfSpeech, usage, hymnReference);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CopticDictionaryEntry &&
          other.id == this.id &&
          other.coptic == this.coptic &&
          other.phonetic == this.phonetic &&
          other.arabic == this.arabic &&
          other.english == this.english &&
          other.partOfSpeech == this.partOfSpeech &&
          other.usage == this.usage &&
          other.hymnReference == this.hymnReference);
}

class CopticDictionaryCompanion extends UpdateCompanion<CopticDictionaryEntry> {
  final Value<int> id;
  final Value<String> coptic;
  final Value<String> phonetic;
  final Value<String> arabic;
  final Value<String?> english;
  final Value<String> partOfSpeech;
  final Value<String?> usage;
  final Value<String?> hymnReference;
  const CopticDictionaryCompanion({
    this.id = const Value.absent(),
    this.coptic = const Value.absent(),
    this.phonetic = const Value.absent(),
    this.arabic = const Value.absent(),
    this.english = const Value.absent(),
    this.partOfSpeech = const Value.absent(),
    this.usage = const Value.absent(),
    this.hymnReference = const Value.absent(),
  });
  CopticDictionaryCompanion.insert({
    this.id = const Value.absent(),
    required String coptic,
    required String phonetic,
    required String arabic,
    this.english = const Value.absent(),
    this.partOfSpeech = const Value.absent(),
    this.usage = const Value.absent(),
    this.hymnReference = const Value.absent(),
  })  : coptic = Value(coptic),
        phonetic = Value(phonetic),
        arabic = Value(arabic);
  static Insertable<CopticDictionaryEntry> custom({
    Expression<int>? id,
    Expression<String>? coptic,
    Expression<String>? phonetic,
    Expression<String>? arabic,
    Expression<String>? english,
    Expression<String>? partOfSpeech,
    Expression<String>? usage,
    Expression<String>? hymnReference,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (coptic != null) 'coptic': coptic,
      if (phonetic != null) 'phonetic': phonetic,
      if (arabic != null) 'arabic': arabic,
      if (english != null) 'english': english,
      if (partOfSpeech != null) 'part_of_speech': partOfSpeech,
      if (usage != null) 'usage': usage,
      if (hymnReference != null) 'hymn_reference': hymnReference,
    });
  }

  CopticDictionaryCompanion copyWith(
      {Value<int>? id,
      Value<String>? coptic,
      Value<String>? phonetic,
      Value<String>? arabic,
      Value<String?>? english,
      Value<String>? partOfSpeech,
      Value<String?>? usage,
      Value<String?>? hymnReference}) {
    return CopticDictionaryCompanion(
      id: id ?? this.id,
      coptic: coptic ?? this.coptic,
      phonetic: phonetic ?? this.phonetic,
      arabic: arabic ?? this.arabic,
      english: english ?? this.english,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      usage: usage ?? this.usage,
      hymnReference: hymnReference ?? this.hymnReference,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (coptic.present) {
      map['coptic'] = Variable<String>(coptic.value);
    }
    if (phonetic.present) {
      map['phonetic'] = Variable<String>(phonetic.value);
    }
    if (arabic.present) {
      map['arabic'] = Variable<String>(arabic.value);
    }
    if (english.present) {
      map['english'] = Variable<String>(english.value);
    }
    if (partOfSpeech.present) {
      map['part_of_speech'] = Variable<String>(partOfSpeech.value);
    }
    if (usage.present) {
      map['usage'] = Variable<String>(usage.value);
    }
    if (hymnReference.present) {
      map['hymn_reference'] = Variable<String>(hymnReference.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CopticDictionaryCompanion(')
          ..write('id: $id, ')
          ..write('coptic: $coptic, ')
          ..write('phonetic: $phonetic, ')
          ..write('arabic: $arabic, ')
          ..write('english: $english, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('usage: $usage, ')
          ..write('hymnReference: $hymnReference')
          ..write(')'))
        .toString();
  }
}

class $BibleCrossReferencesTable extends BibleCrossReferences
    with TableInfo<$BibleCrossReferencesTable, BibleCrossReference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BibleCrossReferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _sourceBookIdMeta =
      const VerificationMeta('sourceBookId');
  @override
  late final GeneratedColumn<int> sourceBookId = GeneratedColumn<int>(
      'source_book_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _sourceChapterMeta =
      const VerificationMeta('sourceChapter');
  @override
  late final GeneratedColumn<int> sourceChapter = GeneratedColumn<int>(
      'source_chapter', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _sourceVerseMeta =
      const VerificationMeta('sourceVerse');
  @override
  late final GeneratedColumn<int> sourceVerse = GeneratedColumn<int>(
      'source_verse', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _targetBookIdMeta =
      const VerificationMeta('targetBookId');
  @override
  late final GeneratedColumn<int> targetBookId = GeneratedColumn<int>(
      'target_book_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _targetChapterMeta =
      const VerificationMeta('targetChapter');
  @override
  late final GeneratedColumn<int> targetChapter = GeneratedColumn<int>(
      'target_chapter', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _targetVerseMeta =
      const VerificationMeta('targetVerse');
  @override
  late final GeneratedColumn<int> targetVerse = GeneratedColumn<int>(
      'target_verse', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _relationTypeMeta =
      const VerificationMeta('relationType');
  @override
  late final GeneratedColumn<String> relationType = GeneratedColumn<String>(
      'relation_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('related'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sourceBookId,
        sourceChapter,
        sourceVerse,
        targetBookId,
        targetChapter,
        targetVerse,
        relationType
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bible_cross_references';
  @override
  VerificationContext validateIntegrity(
      Insertable<BibleCrossReference> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('source_book_id')) {
      context.handle(
          _sourceBookIdMeta,
          sourceBookId.isAcceptableOrUnknown(
              data['source_book_id']!, _sourceBookIdMeta));
    } else if (isInserting) {
      context.missing(_sourceBookIdMeta);
    }
    if (data.containsKey('source_chapter')) {
      context.handle(
          _sourceChapterMeta,
          sourceChapter.isAcceptableOrUnknown(
              data['source_chapter']!, _sourceChapterMeta));
    } else if (isInserting) {
      context.missing(_sourceChapterMeta);
    }
    if (data.containsKey('source_verse')) {
      context.handle(
          _sourceVerseMeta,
          sourceVerse.isAcceptableOrUnknown(
              data['source_verse']!, _sourceVerseMeta));
    } else if (isInserting) {
      context.missing(_sourceVerseMeta);
    }
    if (data.containsKey('target_book_id')) {
      context.handle(
          _targetBookIdMeta,
          targetBookId.isAcceptableOrUnknown(
              data['target_book_id']!, _targetBookIdMeta));
    } else if (isInserting) {
      context.missing(_targetBookIdMeta);
    }
    if (data.containsKey('target_chapter')) {
      context.handle(
          _targetChapterMeta,
          targetChapter.isAcceptableOrUnknown(
              data['target_chapter']!, _targetChapterMeta));
    } else if (isInserting) {
      context.missing(_targetChapterMeta);
    }
    if (data.containsKey('target_verse')) {
      context.handle(
          _targetVerseMeta,
          targetVerse.isAcceptableOrUnknown(
              data['target_verse']!, _targetVerseMeta));
    } else if (isInserting) {
      context.missing(_targetVerseMeta);
    }
    if (data.containsKey('relation_type')) {
      context.handle(
          _relationTypeMeta,
          relationType.isAcceptableOrUnknown(
              data['relation_type']!, _relationTypeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BibleCrossReference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BibleCrossReference(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sourceBookId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}source_book_id'])!,
      sourceChapter: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}source_chapter'])!,
      sourceVerse: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}source_verse'])!,
      targetBookId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}target_book_id'])!,
      targetChapter: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}target_chapter'])!,
      targetVerse: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}target_verse'])!,
      relationType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}relation_type'])!,
    );
  }

  @override
  $BibleCrossReferencesTable createAlias(String alias) {
    return $BibleCrossReferencesTable(attachedDatabase, alias);
  }
}

class BibleCrossReference extends DataClass
    implements Insertable<BibleCrossReference> {
  final int id;
  final int sourceBookId;
  final int sourceChapter;
  final int sourceVerse;
  final int targetBookId;
  final int targetChapter;
  final int targetVerse;
  final String relationType;
  const BibleCrossReference(
      {required this.id,
      required this.sourceBookId,
      required this.sourceChapter,
      required this.sourceVerse,
      required this.targetBookId,
      required this.targetChapter,
      required this.targetVerse,
      required this.relationType});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['source_book_id'] = Variable<int>(sourceBookId);
    map['source_chapter'] = Variable<int>(sourceChapter);
    map['source_verse'] = Variable<int>(sourceVerse);
    map['target_book_id'] = Variable<int>(targetBookId);
    map['target_chapter'] = Variable<int>(targetChapter);
    map['target_verse'] = Variable<int>(targetVerse);
    map['relation_type'] = Variable<String>(relationType);
    return map;
  }

  BibleCrossReferencesCompanion toCompanion(bool nullToAbsent) {
    return BibleCrossReferencesCompanion(
      id: Value(id),
      sourceBookId: Value(sourceBookId),
      sourceChapter: Value(sourceChapter),
      sourceVerse: Value(sourceVerse),
      targetBookId: Value(targetBookId),
      targetChapter: Value(targetChapter),
      targetVerse: Value(targetVerse),
      relationType: Value(relationType),
    );
  }

  factory BibleCrossReference.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BibleCrossReference(
      id: serializer.fromJson<int>(json['id']),
      sourceBookId: serializer.fromJson<int>(json['sourceBookId']),
      sourceChapter: serializer.fromJson<int>(json['sourceChapter']),
      sourceVerse: serializer.fromJson<int>(json['sourceVerse']),
      targetBookId: serializer.fromJson<int>(json['targetBookId']),
      targetChapter: serializer.fromJson<int>(json['targetChapter']),
      targetVerse: serializer.fromJson<int>(json['targetVerse']),
      relationType: serializer.fromJson<String>(json['relationType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sourceBookId': serializer.toJson<int>(sourceBookId),
      'sourceChapter': serializer.toJson<int>(sourceChapter),
      'sourceVerse': serializer.toJson<int>(sourceVerse),
      'targetBookId': serializer.toJson<int>(targetBookId),
      'targetChapter': serializer.toJson<int>(targetChapter),
      'targetVerse': serializer.toJson<int>(targetVerse),
      'relationType': serializer.toJson<String>(relationType),
    };
  }

  BibleCrossReference copyWith(
          {int? id,
          int? sourceBookId,
          int? sourceChapter,
          int? sourceVerse,
          int? targetBookId,
          int? targetChapter,
          int? targetVerse,
          String? relationType}) =>
      BibleCrossReference(
        id: id ?? this.id,
        sourceBookId: sourceBookId ?? this.sourceBookId,
        sourceChapter: sourceChapter ?? this.sourceChapter,
        sourceVerse: sourceVerse ?? this.sourceVerse,
        targetBookId: targetBookId ?? this.targetBookId,
        targetChapter: targetChapter ?? this.targetChapter,
        targetVerse: targetVerse ?? this.targetVerse,
        relationType: relationType ?? this.relationType,
      );
  BibleCrossReference copyWithCompanion(BibleCrossReferencesCompanion data) {
    return BibleCrossReference(
      id: data.id.present ? data.id.value : this.id,
      sourceBookId: data.sourceBookId.present
          ? data.sourceBookId.value
          : this.sourceBookId,
      sourceChapter: data.sourceChapter.present
          ? data.sourceChapter.value
          : this.sourceChapter,
      sourceVerse:
          data.sourceVerse.present ? data.sourceVerse.value : this.sourceVerse,
      targetBookId: data.targetBookId.present
          ? data.targetBookId.value
          : this.targetBookId,
      targetChapter: data.targetChapter.present
          ? data.targetChapter.value
          : this.targetChapter,
      targetVerse:
          data.targetVerse.present ? data.targetVerse.value : this.targetVerse,
      relationType: data.relationType.present
          ? data.relationType.value
          : this.relationType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BibleCrossReference(')
          ..write('id: $id, ')
          ..write('sourceBookId: $sourceBookId, ')
          ..write('sourceChapter: $sourceChapter, ')
          ..write('sourceVerse: $sourceVerse, ')
          ..write('targetBookId: $targetBookId, ')
          ..write('targetChapter: $targetChapter, ')
          ..write('targetVerse: $targetVerse, ')
          ..write('relationType: $relationType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sourceBookId, sourceChapter, sourceVerse,
      targetBookId, targetChapter, targetVerse, relationType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BibleCrossReference &&
          other.id == this.id &&
          other.sourceBookId == this.sourceBookId &&
          other.sourceChapter == this.sourceChapter &&
          other.sourceVerse == this.sourceVerse &&
          other.targetBookId == this.targetBookId &&
          other.targetChapter == this.targetChapter &&
          other.targetVerse == this.targetVerse &&
          other.relationType == this.relationType);
}

class BibleCrossReferencesCompanion
    extends UpdateCompanion<BibleCrossReference> {
  final Value<int> id;
  final Value<int> sourceBookId;
  final Value<int> sourceChapter;
  final Value<int> sourceVerse;
  final Value<int> targetBookId;
  final Value<int> targetChapter;
  final Value<int> targetVerse;
  final Value<String> relationType;
  const BibleCrossReferencesCompanion({
    this.id = const Value.absent(),
    this.sourceBookId = const Value.absent(),
    this.sourceChapter = const Value.absent(),
    this.sourceVerse = const Value.absent(),
    this.targetBookId = const Value.absent(),
    this.targetChapter = const Value.absent(),
    this.targetVerse = const Value.absent(),
    this.relationType = const Value.absent(),
  });
  BibleCrossReferencesCompanion.insert({
    this.id = const Value.absent(),
    required int sourceBookId,
    required int sourceChapter,
    required int sourceVerse,
    required int targetBookId,
    required int targetChapter,
    required int targetVerse,
    this.relationType = const Value.absent(),
  })  : sourceBookId = Value(sourceBookId),
        sourceChapter = Value(sourceChapter),
        sourceVerse = Value(sourceVerse),
        targetBookId = Value(targetBookId),
        targetChapter = Value(targetChapter),
        targetVerse = Value(targetVerse);
  static Insertable<BibleCrossReference> custom({
    Expression<int>? id,
    Expression<int>? sourceBookId,
    Expression<int>? sourceChapter,
    Expression<int>? sourceVerse,
    Expression<int>? targetBookId,
    Expression<int>? targetChapter,
    Expression<int>? targetVerse,
    Expression<String>? relationType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceBookId != null) 'source_book_id': sourceBookId,
      if (sourceChapter != null) 'source_chapter': sourceChapter,
      if (sourceVerse != null) 'source_verse': sourceVerse,
      if (targetBookId != null) 'target_book_id': targetBookId,
      if (targetChapter != null) 'target_chapter': targetChapter,
      if (targetVerse != null) 'target_verse': targetVerse,
      if (relationType != null) 'relation_type': relationType,
    });
  }

  BibleCrossReferencesCompanion copyWith(
      {Value<int>? id,
      Value<int>? sourceBookId,
      Value<int>? sourceChapter,
      Value<int>? sourceVerse,
      Value<int>? targetBookId,
      Value<int>? targetChapter,
      Value<int>? targetVerse,
      Value<String>? relationType}) {
    return BibleCrossReferencesCompanion(
      id: id ?? this.id,
      sourceBookId: sourceBookId ?? this.sourceBookId,
      sourceChapter: sourceChapter ?? this.sourceChapter,
      sourceVerse: sourceVerse ?? this.sourceVerse,
      targetBookId: targetBookId ?? this.targetBookId,
      targetChapter: targetChapter ?? this.targetChapter,
      targetVerse: targetVerse ?? this.targetVerse,
      relationType: relationType ?? this.relationType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sourceBookId.present) {
      map['source_book_id'] = Variable<int>(sourceBookId.value);
    }
    if (sourceChapter.present) {
      map['source_chapter'] = Variable<int>(sourceChapter.value);
    }
    if (sourceVerse.present) {
      map['source_verse'] = Variable<int>(sourceVerse.value);
    }
    if (targetBookId.present) {
      map['target_book_id'] = Variable<int>(targetBookId.value);
    }
    if (targetChapter.present) {
      map['target_chapter'] = Variable<int>(targetChapter.value);
    }
    if (targetVerse.present) {
      map['target_verse'] = Variable<int>(targetVerse.value);
    }
    if (relationType.present) {
      map['relation_type'] = Variable<String>(relationType.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BibleCrossReferencesCompanion(')
          ..write('id: $id, ')
          ..write('sourceBookId: $sourceBookId, ')
          ..write('sourceChapter: $sourceChapter, ')
          ..write('sourceVerse: $sourceVerse, ')
          ..write('targetBookId: $targetBookId, ')
          ..write('targetChapter: $targetChapter, ')
          ..write('targetVerse: $targetVerse, ')
          ..write('relationType: $relationType')
          ..write(')'))
        .toString();
  }
}

class $PsalisTable extends Psalis with TableInfo<$PsalisTable, Psali> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PsalisTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _psaliIdMeta =
      const VerificationMeta('psaliId');
  @override
  late final GeneratedColumn<String> psaliId = GeneratedColumn<String>(
      'psali_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameArMeta = const VerificationMeta('nameAr');
  @override
  late final GeneratedColumn<String> nameAr = GeneratedColumn<String>(
      'name_ar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameCopticMeta =
      const VerificationMeta('nameCoptic');
  @override
  late final GeneratedColumn<String> nameCoptic = GeneratedColumn<String>(
      'name_coptic', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _namePhoneticMeta =
      const VerificationMeta('namePhonetic');
  @override
  late final GeneratedColumn<String> namePhonetic = GeneratedColumn<String>(
      'name_phonetic', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _occasionMeta =
      const VerificationMeta('occasion');
  @override
  late final GeneratedColumn<String> occasion = GeneratedColumn<String>(
      'occasion', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dayOfWeekMeta =
      const VerificationMeta('dayOfWeek');
  @override
  late final GeneratedColumn<String> dayOfWeek = GeneratedColumn<String>(
      'day_of_week', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _seasonMeta = const VerificationMeta('season');
  @override
  late final GeneratedColumn<String> season = GeneratedColumn<String>(
      'season', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
      'order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        psaliId,
        type,
        nameAr,
        nameCoptic,
        namePhonetic,
        occasion,
        dayOfWeek,
        season,
        order
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'psalis';
  @override
  VerificationContext validateIntegrity(Insertable<Psali> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('psali_id')) {
      context.handle(_psaliIdMeta,
          psaliId.isAcceptableOrUnknown(data['psali_id']!, _psaliIdMeta));
    } else if (isInserting) {
      context.missing(_psaliIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('name_ar')) {
      context.handle(_nameArMeta,
          nameAr.isAcceptableOrUnknown(data['name_ar']!, _nameArMeta));
    } else if (isInserting) {
      context.missing(_nameArMeta);
    }
    if (data.containsKey('name_coptic')) {
      context.handle(
          _nameCopticMeta,
          nameCoptic.isAcceptableOrUnknown(
              data['name_coptic']!, _nameCopticMeta));
    }
    if (data.containsKey('name_phonetic')) {
      context.handle(
          _namePhoneticMeta,
          namePhonetic.isAcceptableOrUnknown(
              data['name_phonetic']!, _namePhoneticMeta));
    }
    if (data.containsKey('occasion')) {
      context.handle(_occasionMeta,
          occasion.isAcceptableOrUnknown(data['occasion']!, _occasionMeta));
    } else if (isInserting) {
      context.missing(_occasionMeta);
    }
    if (data.containsKey('day_of_week')) {
      context.handle(
          _dayOfWeekMeta,
          dayOfWeek.isAcceptableOrUnknown(
              data['day_of_week']!, _dayOfWeekMeta));
    }
    if (data.containsKey('season')) {
      context.handle(_seasonMeta,
          season.isAcceptableOrUnknown(data['season']!, _seasonMeta));
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Psali map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Psali(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      psaliId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}psali_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      nameAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_ar'])!,
      nameCoptic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_coptic']),
      namePhonetic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_phonetic']),
      occasion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}occasion'])!,
      dayOfWeek: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}day_of_week']),
      season: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}season']),
      order: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order'])!,
    );
  }

  @override
  $PsalisTable createAlias(String alias) {
    return $PsalisTable(attachedDatabase, alias);
  }
}

class Psali extends DataClass implements Insertable<Psali> {
  final int id;
  final String psaliId;
  final String type;
  final String nameAr;
  final String? nameCoptic;
  final String? namePhonetic;
  final String occasion;
  final String? dayOfWeek;
  final String? season;
  final int order;
  const Psali(
      {required this.id,
      required this.psaliId,
      required this.type,
      required this.nameAr,
      this.nameCoptic,
      this.namePhonetic,
      required this.occasion,
      this.dayOfWeek,
      this.season,
      required this.order});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['psali_id'] = Variable<String>(psaliId);
    map['type'] = Variable<String>(type);
    map['name_ar'] = Variable<String>(nameAr);
    if (!nullToAbsent || nameCoptic != null) {
      map['name_coptic'] = Variable<String>(nameCoptic);
    }
    if (!nullToAbsent || namePhonetic != null) {
      map['name_phonetic'] = Variable<String>(namePhonetic);
    }
    map['occasion'] = Variable<String>(occasion);
    if (!nullToAbsent || dayOfWeek != null) {
      map['day_of_week'] = Variable<String>(dayOfWeek);
    }
    if (!nullToAbsent || season != null) {
      map['season'] = Variable<String>(season);
    }
    map['order'] = Variable<int>(order);
    return map;
  }

  PsalisCompanion toCompanion(bool nullToAbsent) {
    return PsalisCompanion(
      id: Value(id),
      psaliId: Value(psaliId),
      type: Value(type),
      nameAr: Value(nameAr),
      nameCoptic: nameCoptic == null && nullToAbsent
          ? const Value.absent()
          : Value(nameCoptic),
      namePhonetic: namePhonetic == null && nullToAbsent
          ? const Value.absent()
          : Value(namePhonetic),
      occasion: Value(occasion),
      dayOfWeek: dayOfWeek == null && nullToAbsent
          ? const Value.absent()
          : Value(dayOfWeek),
      season:
          season == null && nullToAbsent ? const Value.absent() : Value(season),
      order: Value(order),
    );
  }

  factory Psali.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Psali(
      id: serializer.fromJson<int>(json['id']),
      psaliId: serializer.fromJson<String>(json['psaliId']),
      type: serializer.fromJson<String>(json['type']),
      nameAr: serializer.fromJson<String>(json['nameAr']),
      nameCoptic: serializer.fromJson<String?>(json['nameCoptic']),
      namePhonetic: serializer.fromJson<String?>(json['namePhonetic']),
      occasion: serializer.fromJson<String>(json['occasion']),
      dayOfWeek: serializer.fromJson<String?>(json['dayOfWeek']),
      season: serializer.fromJson<String?>(json['season']),
      order: serializer.fromJson<int>(json['order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'psaliId': serializer.toJson<String>(psaliId),
      'type': serializer.toJson<String>(type),
      'nameAr': serializer.toJson<String>(nameAr),
      'nameCoptic': serializer.toJson<String?>(nameCoptic),
      'namePhonetic': serializer.toJson<String?>(namePhonetic),
      'occasion': serializer.toJson<String>(occasion),
      'dayOfWeek': serializer.toJson<String?>(dayOfWeek),
      'season': serializer.toJson<String?>(season),
      'order': serializer.toJson<int>(order),
    };
  }

  Psali copyWith(
          {int? id,
          String? psaliId,
          String? type,
          String? nameAr,
          Value<String?> nameCoptic = const Value.absent(),
          Value<String?> namePhonetic = const Value.absent(),
          String? occasion,
          Value<String?> dayOfWeek = const Value.absent(),
          Value<String?> season = const Value.absent(),
          int? order}) =>
      Psali(
        id: id ?? this.id,
        psaliId: psaliId ?? this.psaliId,
        type: type ?? this.type,
        nameAr: nameAr ?? this.nameAr,
        nameCoptic: nameCoptic.present ? nameCoptic.value : this.nameCoptic,
        namePhonetic:
            namePhonetic.present ? namePhonetic.value : this.namePhonetic,
        occasion: occasion ?? this.occasion,
        dayOfWeek: dayOfWeek.present ? dayOfWeek.value : this.dayOfWeek,
        season: season.present ? season.value : this.season,
        order: order ?? this.order,
      );
  Psali copyWithCompanion(PsalisCompanion data) {
    return Psali(
      id: data.id.present ? data.id.value : this.id,
      psaliId: data.psaliId.present ? data.psaliId.value : this.psaliId,
      type: data.type.present ? data.type.value : this.type,
      nameAr: data.nameAr.present ? data.nameAr.value : this.nameAr,
      nameCoptic:
          data.nameCoptic.present ? data.nameCoptic.value : this.nameCoptic,
      namePhonetic: data.namePhonetic.present
          ? data.namePhonetic.value
          : this.namePhonetic,
      occasion: data.occasion.present ? data.occasion.value : this.occasion,
      dayOfWeek: data.dayOfWeek.present ? data.dayOfWeek.value : this.dayOfWeek,
      season: data.season.present ? data.season.value : this.season,
      order: data.order.present ? data.order.value : this.order,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Psali(')
          ..write('id: $id, ')
          ..write('psaliId: $psaliId, ')
          ..write('type: $type, ')
          ..write('nameAr: $nameAr, ')
          ..write('nameCoptic: $nameCoptic, ')
          ..write('namePhonetic: $namePhonetic, ')
          ..write('occasion: $occasion, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('season: $season, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, psaliId, type, nameAr, nameCoptic,
      namePhonetic, occasion, dayOfWeek, season, order);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Psali &&
          other.id == this.id &&
          other.psaliId == this.psaliId &&
          other.type == this.type &&
          other.nameAr == this.nameAr &&
          other.nameCoptic == this.nameCoptic &&
          other.namePhonetic == this.namePhonetic &&
          other.occasion == this.occasion &&
          other.dayOfWeek == this.dayOfWeek &&
          other.season == this.season &&
          other.order == this.order);
}

class PsalisCompanion extends UpdateCompanion<Psali> {
  final Value<int> id;
  final Value<String> psaliId;
  final Value<String> type;
  final Value<String> nameAr;
  final Value<String?> nameCoptic;
  final Value<String?> namePhonetic;
  final Value<String> occasion;
  final Value<String?> dayOfWeek;
  final Value<String?> season;
  final Value<int> order;
  const PsalisCompanion({
    this.id = const Value.absent(),
    this.psaliId = const Value.absent(),
    this.type = const Value.absent(),
    this.nameAr = const Value.absent(),
    this.nameCoptic = const Value.absent(),
    this.namePhonetic = const Value.absent(),
    this.occasion = const Value.absent(),
    this.dayOfWeek = const Value.absent(),
    this.season = const Value.absent(),
    this.order = const Value.absent(),
  });
  PsalisCompanion.insert({
    this.id = const Value.absent(),
    required String psaliId,
    required String type,
    required String nameAr,
    this.nameCoptic = const Value.absent(),
    this.namePhonetic = const Value.absent(),
    required String occasion,
    this.dayOfWeek = const Value.absent(),
    this.season = const Value.absent(),
    required int order,
  })  : psaliId = Value(psaliId),
        type = Value(type),
        nameAr = Value(nameAr),
        occasion = Value(occasion),
        order = Value(order);
  static Insertable<Psali> custom({
    Expression<int>? id,
    Expression<String>? psaliId,
    Expression<String>? type,
    Expression<String>? nameAr,
    Expression<String>? nameCoptic,
    Expression<String>? namePhonetic,
    Expression<String>? occasion,
    Expression<String>? dayOfWeek,
    Expression<String>? season,
    Expression<int>? order,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (psaliId != null) 'psali_id': psaliId,
      if (type != null) 'type': type,
      if (nameAr != null) 'name_ar': nameAr,
      if (nameCoptic != null) 'name_coptic': nameCoptic,
      if (namePhonetic != null) 'name_phonetic': namePhonetic,
      if (occasion != null) 'occasion': occasion,
      if (dayOfWeek != null) 'day_of_week': dayOfWeek,
      if (season != null) 'season': season,
      if (order != null) 'order': order,
    });
  }

  PsalisCompanion copyWith(
      {Value<int>? id,
      Value<String>? psaliId,
      Value<String>? type,
      Value<String>? nameAr,
      Value<String?>? nameCoptic,
      Value<String?>? namePhonetic,
      Value<String>? occasion,
      Value<String?>? dayOfWeek,
      Value<String?>? season,
      Value<int>? order}) {
    return PsalisCompanion(
      id: id ?? this.id,
      psaliId: psaliId ?? this.psaliId,
      type: type ?? this.type,
      nameAr: nameAr ?? this.nameAr,
      nameCoptic: nameCoptic ?? this.nameCoptic,
      namePhonetic: namePhonetic ?? this.namePhonetic,
      occasion: occasion ?? this.occasion,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      season: season ?? this.season,
      order: order ?? this.order,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (psaliId.present) {
      map['psali_id'] = Variable<String>(psaliId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (nameAr.present) {
      map['name_ar'] = Variable<String>(nameAr.value);
    }
    if (nameCoptic.present) {
      map['name_coptic'] = Variable<String>(nameCoptic.value);
    }
    if (namePhonetic.present) {
      map['name_phonetic'] = Variable<String>(namePhonetic.value);
    }
    if (occasion.present) {
      map['occasion'] = Variable<String>(occasion.value);
    }
    if (dayOfWeek.present) {
      map['day_of_week'] = Variable<String>(dayOfWeek.value);
    }
    if (season.present) {
      map['season'] = Variable<String>(season.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PsalisCompanion(')
          ..write('id: $id, ')
          ..write('psaliId: $psaliId, ')
          ..write('type: $type, ')
          ..write('nameAr: $nameAr, ')
          ..write('nameCoptic: $nameCoptic, ')
          ..write('namePhonetic: $namePhonetic, ')
          ..write('occasion: $occasion, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('season: $season, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }
}

class $PsaliSectionsTable extends PsaliSections
    with TableInfo<$PsaliSectionsTable, PsaliSection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PsaliSectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _psaliIdMeta =
      const VerificationMeta('psaliId');
  @override
  late final GeneratedColumn<String> psaliId = GeneratedColumn<String>(
      'psali_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sectionOrderMeta =
      const VerificationMeta('sectionOrder');
  @override
  late final GeneratedColumn<int> sectionOrder = GeneratedColumn<int>(
      'section_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _textCopticMeta =
      const VerificationMeta('textCoptic');
  @override
  late final GeneratedColumn<String> textCoptic = GeneratedColumn<String>(
      'text_coptic', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _textPhoneticMeta =
      const VerificationMeta('textPhonetic');
  @override
  late final GeneratedColumn<String> textPhonetic = GeneratedColumn<String>(
      'text_phonetic', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _textArabicMeta =
      const VerificationMeta('textArabic');
  @override
  late final GeneratedColumn<String> textArabic = GeneratedColumn<String>(
      'text_arabic', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _rubricMeta = const VerificationMeta('rubric');
  @override
  late final GeneratedColumn<String> rubric = GeneratedColumn<String>(
      'rubric', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _responseMeta =
      const VerificationMeta('response');
  @override
  late final GeneratedColumn<String> response = GeneratedColumn<String>(
      'response', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        psaliId,
        sectionOrder,
        textCoptic,
        textPhonetic,
        textArabic,
        rubric,
        response
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'psali_sections';
  @override
  VerificationContext validateIntegrity(Insertable<PsaliSection> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('psali_id')) {
      context.handle(_psaliIdMeta,
          psaliId.isAcceptableOrUnknown(data['psali_id']!, _psaliIdMeta));
    } else if (isInserting) {
      context.missing(_psaliIdMeta);
    }
    if (data.containsKey('section_order')) {
      context.handle(
          _sectionOrderMeta,
          sectionOrder.isAcceptableOrUnknown(
              data['section_order']!, _sectionOrderMeta));
    } else if (isInserting) {
      context.missing(_sectionOrderMeta);
    }
    if (data.containsKey('text_coptic')) {
      context.handle(
          _textCopticMeta,
          textCoptic.isAcceptableOrUnknown(
              data['text_coptic']!, _textCopticMeta));
    } else if (isInserting) {
      context.missing(_textCopticMeta);
    }
    if (data.containsKey('text_phonetic')) {
      context.handle(
          _textPhoneticMeta,
          textPhonetic.isAcceptableOrUnknown(
              data['text_phonetic']!, _textPhoneticMeta));
    } else if (isInserting) {
      context.missing(_textPhoneticMeta);
    }
    if (data.containsKey('text_arabic')) {
      context.handle(
          _textArabicMeta,
          textArabic.isAcceptableOrUnknown(
              data['text_arabic']!, _textArabicMeta));
    } else if (isInserting) {
      context.missing(_textArabicMeta);
    }
    if (data.containsKey('rubric')) {
      context.handle(_rubricMeta,
          rubric.isAcceptableOrUnknown(data['rubric']!, _rubricMeta));
    }
    if (data.containsKey('response')) {
      context.handle(_responseMeta,
          response.isAcceptableOrUnknown(data['response']!, _responseMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PsaliSection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PsaliSection(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      psaliId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}psali_id'])!,
      sectionOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}section_order'])!,
      textCoptic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_coptic'])!,
      textPhonetic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_phonetic'])!,
      textArabic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_arabic'])!,
      rubric: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rubric']),
      response: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}response']),
    );
  }

  @override
  $PsaliSectionsTable createAlias(String alias) {
    return $PsaliSectionsTable(attachedDatabase, alias);
  }
}

class PsaliSection extends DataClass implements Insertable<PsaliSection> {
  final int id;
  final String psaliId;
  final int sectionOrder;
  final String textCoptic;
  final String textPhonetic;
  final String textArabic;
  final String? rubric;
  final String? response;
  const PsaliSection(
      {required this.id,
      required this.psaliId,
      required this.sectionOrder,
      required this.textCoptic,
      required this.textPhonetic,
      required this.textArabic,
      this.rubric,
      this.response});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['psali_id'] = Variable<String>(psaliId);
    map['section_order'] = Variable<int>(sectionOrder);
    map['text_coptic'] = Variable<String>(textCoptic);
    map['text_phonetic'] = Variable<String>(textPhonetic);
    map['text_arabic'] = Variable<String>(textArabic);
    if (!nullToAbsent || rubric != null) {
      map['rubric'] = Variable<String>(rubric);
    }
    if (!nullToAbsent || response != null) {
      map['response'] = Variable<String>(response);
    }
    return map;
  }

  PsaliSectionsCompanion toCompanion(bool nullToAbsent) {
    return PsaliSectionsCompanion(
      id: Value(id),
      psaliId: Value(psaliId),
      sectionOrder: Value(sectionOrder),
      textCoptic: Value(textCoptic),
      textPhonetic: Value(textPhonetic),
      textArabic: Value(textArabic),
      rubric:
          rubric == null && nullToAbsent ? const Value.absent() : Value(rubric),
      response: response == null && nullToAbsent
          ? const Value.absent()
          : Value(response),
    );
  }

  factory PsaliSection.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PsaliSection(
      id: serializer.fromJson<int>(json['id']),
      psaliId: serializer.fromJson<String>(json['psaliId']),
      sectionOrder: serializer.fromJson<int>(json['sectionOrder']),
      textCoptic: serializer.fromJson<String>(json['textCoptic']),
      textPhonetic: serializer.fromJson<String>(json['textPhonetic']),
      textArabic: serializer.fromJson<String>(json['textArabic']),
      rubric: serializer.fromJson<String?>(json['rubric']),
      response: serializer.fromJson<String?>(json['response']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'psaliId': serializer.toJson<String>(psaliId),
      'sectionOrder': serializer.toJson<int>(sectionOrder),
      'textCoptic': serializer.toJson<String>(textCoptic),
      'textPhonetic': serializer.toJson<String>(textPhonetic),
      'textArabic': serializer.toJson<String>(textArabic),
      'rubric': serializer.toJson<String?>(rubric),
      'response': serializer.toJson<String?>(response),
    };
  }

  PsaliSection copyWith(
          {int? id,
          String? psaliId,
          int? sectionOrder,
          String? textCoptic,
          String? textPhonetic,
          String? textArabic,
          Value<String?> rubric = const Value.absent(),
          Value<String?> response = const Value.absent()}) =>
      PsaliSection(
        id: id ?? this.id,
        psaliId: psaliId ?? this.psaliId,
        sectionOrder: sectionOrder ?? this.sectionOrder,
        textCoptic: textCoptic ?? this.textCoptic,
        textPhonetic: textPhonetic ?? this.textPhonetic,
        textArabic: textArabic ?? this.textArabic,
        rubric: rubric.present ? rubric.value : this.rubric,
        response: response.present ? response.value : this.response,
      );
  PsaliSection copyWithCompanion(PsaliSectionsCompanion data) {
    return PsaliSection(
      id: data.id.present ? data.id.value : this.id,
      psaliId: data.psaliId.present ? data.psaliId.value : this.psaliId,
      sectionOrder: data.sectionOrder.present
          ? data.sectionOrder.value
          : this.sectionOrder,
      textCoptic:
          data.textCoptic.present ? data.textCoptic.value : this.textCoptic,
      textPhonetic: data.textPhonetic.present
          ? data.textPhonetic.value
          : this.textPhonetic,
      textArabic:
          data.textArabic.present ? data.textArabic.value : this.textArabic,
      rubric: data.rubric.present ? data.rubric.value : this.rubric,
      response: data.response.present ? data.response.value : this.response,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PsaliSection(')
          ..write('id: $id, ')
          ..write('psaliId: $psaliId, ')
          ..write('sectionOrder: $sectionOrder, ')
          ..write('textCoptic: $textCoptic, ')
          ..write('textPhonetic: $textPhonetic, ')
          ..write('textArabic: $textArabic, ')
          ..write('rubric: $rubric, ')
          ..write('response: $response')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, psaliId, sectionOrder, textCoptic,
      textPhonetic, textArabic, rubric, response);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PsaliSection &&
          other.id == this.id &&
          other.psaliId == this.psaliId &&
          other.sectionOrder == this.sectionOrder &&
          other.textCoptic == this.textCoptic &&
          other.textPhonetic == this.textPhonetic &&
          other.textArabic == this.textArabic &&
          other.rubric == this.rubric &&
          other.response == this.response);
}

class PsaliSectionsCompanion extends UpdateCompanion<PsaliSection> {
  final Value<int> id;
  final Value<String> psaliId;
  final Value<int> sectionOrder;
  final Value<String> textCoptic;
  final Value<String> textPhonetic;
  final Value<String> textArabic;
  final Value<String?> rubric;
  final Value<String?> response;
  const PsaliSectionsCompanion({
    this.id = const Value.absent(),
    this.psaliId = const Value.absent(),
    this.sectionOrder = const Value.absent(),
    this.textCoptic = const Value.absent(),
    this.textPhonetic = const Value.absent(),
    this.textArabic = const Value.absent(),
    this.rubric = const Value.absent(),
    this.response = const Value.absent(),
  });
  PsaliSectionsCompanion.insert({
    this.id = const Value.absent(),
    required String psaliId,
    required int sectionOrder,
    required String textCoptic,
    required String textPhonetic,
    required String textArabic,
    this.rubric = const Value.absent(),
    this.response = const Value.absent(),
  })  : psaliId = Value(psaliId),
        sectionOrder = Value(sectionOrder),
        textCoptic = Value(textCoptic),
        textPhonetic = Value(textPhonetic),
        textArabic = Value(textArabic);
  static Insertable<PsaliSection> custom({
    Expression<int>? id,
    Expression<String>? psaliId,
    Expression<int>? sectionOrder,
    Expression<String>? textCoptic,
    Expression<String>? textPhonetic,
    Expression<String>? textArabic,
    Expression<String>? rubric,
    Expression<String>? response,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (psaliId != null) 'psali_id': psaliId,
      if (sectionOrder != null) 'section_order': sectionOrder,
      if (textCoptic != null) 'text_coptic': textCoptic,
      if (textPhonetic != null) 'text_phonetic': textPhonetic,
      if (textArabic != null) 'text_arabic': textArabic,
      if (rubric != null) 'rubric': rubric,
      if (response != null) 'response': response,
    });
  }

  PsaliSectionsCompanion copyWith(
      {Value<int>? id,
      Value<String>? psaliId,
      Value<int>? sectionOrder,
      Value<String>? textCoptic,
      Value<String>? textPhonetic,
      Value<String>? textArabic,
      Value<String?>? rubric,
      Value<String?>? response}) {
    return PsaliSectionsCompanion(
      id: id ?? this.id,
      psaliId: psaliId ?? this.psaliId,
      sectionOrder: sectionOrder ?? this.sectionOrder,
      textCoptic: textCoptic ?? this.textCoptic,
      textPhonetic: textPhonetic ?? this.textPhonetic,
      textArabic: textArabic ?? this.textArabic,
      rubric: rubric ?? this.rubric,
      response: response ?? this.response,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (psaliId.present) {
      map['psali_id'] = Variable<String>(psaliId.value);
    }
    if (sectionOrder.present) {
      map['section_order'] = Variable<int>(sectionOrder.value);
    }
    if (textCoptic.present) {
      map['text_coptic'] = Variable<String>(textCoptic.value);
    }
    if (textPhonetic.present) {
      map['text_phonetic'] = Variable<String>(textPhonetic.value);
    }
    if (textArabic.present) {
      map['text_arabic'] = Variable<String>(textArabic.value);
    }
    if (rubric.present) {
      map['rubric'] = Variable<String>(rubric.value);
    }
    if (response.present) {
      map['response'] = Variable<String>(response.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PsaliSectionsCompanion(')
          ..write('id: $id, ')
          ..write('psaliId: $psaliId, ')
          ..write('sectionOrder: $sectionOrder, ')
          ..write('textCoptic: $textCoptic, ')
          ..write('textPhonetic: $textPhonetic, ')
          ..write('textArabic: $textArabic, ')
          ..write('rubric: $rubric, ')
          ..write('response: $response')
          ..write(')'))
        .toString();
  }
}

class $RitesTable extends Rites with TableInfo<$RitesTable, Rite> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RitesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameArMeta = const VerificationMeta('nameAr');
  @override
  late final GeneratedColumn<String> nameAr = GeneratedColumn<String>(
      'name_ar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
      'name_en', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameCopticMeta =
      const VerificationMeta('nameCoptic');
  @override
  late final GeneratedColumn<String> nameCoptic = GeneratedColumn<String>(
      'name_coptic', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, nameAr, nameEn, nameCoptic, category, description, sortOrder, icon];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rites';
  @override
  VerificationContext validateIntegrity(Insertable<Rite> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name_ar')) {
      context.handle(_nameArMeta,
          nameAr.isAcceptableOrUnknown(data['name_ar']!, _nameArMeta));
    } else if (isInserting) {
      context.missing(_nameArMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(_nameEnMeta,
          nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta));
    }
    if (data.containsKey('name_coptic')) {
      context.handle(
          _nameCopticMeta,
          nameCoptic.isAcceptableOrUnknown(
              data['name_coptic']!, _nameCopticMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Rite map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Rite(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nameAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_ar'])!,
      nameEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_en']),
      nameCoptic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_coptic']),
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon']),
    );
  }

  @override
  $RitesTable createAlias(String alias) {
    return $RitesTable(attachedDatabase, alias);
  }
}

class Rite extends DataClass implements Insertable<Rite> {
  final int id;
  final String nameAr;
  final String? nameEn;
  final String? nameCoptic;
  final String category;
  final String? description;
  final int sortOrder;
  final String? icon;
  const Rite(
      {required this.id,
      required this.nameAr,
      this.nameEn,
      this.nameCoptic,
      required this.category,
      this.description,
      required this.sortOrder,
      this.icon});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name_ar'] = Variable<String>(nameAr);
    if (!nullToAbsent || nameEn != null) {
      map['name_en'] = Variable<String>(nameEn);
    }
    if (!nullToAbsent || nameCoptic != null) {
      map['name_coptic'] = Variable<String>(nameCoptic);
    }
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    return map;
  }

  RitesCompanion toCompanion(bool nullToAbsent) {
    return RitesCompanion(
      id: Value(id),
      nameAr: Value(nameAr),
      nameEn:
          nameEn == null && nullToAbsent ? const Value.absent() : Value(nameEn),
      nameCoptic: nameCoptic == null && nullToAbsent
          ? const Value.absent()
          : Value(nameCoptic),
      category: Value(category),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      sortOrder: Value(sortOrder),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
    );
  }

  factory Rite.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Rite(
      id: serializer.fromJson<int>(json['id']),
      nameAr: serializer.fromJson<String>(json['nameAr']),
      nameEn: serializer.fromJson<String?>(json['nameEn']),
      nameCoptic: serializer.fromJson<String?>(json['nameCoptic']),
      category: serializer.fromJson<String>(json['category']),
      description: serializer.fromJson<String?>(json['description']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      icon: serializer.fromJson<String?>(json['icon']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nameAr': serializer.toJson<String>(nameAr),
      'nameEn': serializer.toJson<String?>(nameEn),
      'nameCoptic': serializer.toJson<String?>(nameCoptic),
      'category': serializer.toJson<String>(category),
      'description': serializer.toJson<String?>(description),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'icon': serializer.toJson<String?>(icon),
    };
  }

  Rite copyWith(
          {int? id,
          String? nameAr,
          Value<String?> nameEn = const Value.absent(),
          Value<String?> nameCoptic = const Value.absent(),
          String? category,
          Value<String?> description = const Value.absent(),
          int? sortOrder,
          Value<String?> icon = const Value.absent()}) =>
      Rite(
        id: id ?? this.id,
        nameAr: nameAr ?? this.nameAr,
        nameEn: nameEn.present ? nameEn.value : this.nameEn,
        nameCoptic: nameCoptic.present ? nameCoptic.value : this.nameCoptic,
        category: category ?? this.category,
        description: description.present ? description.value : this.description,
        sortOrder: sortOrder ?? this.sortOrder,
        icon: icon.present ? icon.value : this.icon,
      );
  Rite copyWithCompanion(RitesCompanion data) {
    return Rite(
      id: data.id.present ? data.id.value : this.id,
      nameAr: data.nameAr.present ? data.nameAr.value : this.nameAr,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameCoptic:
          data.nameCoptic.present ? data.nameCoptic.value : this.nameCoptic,
      category: data.category.present ? data.category.value : this.category,
      description:
          data.description.present ? data.description.value : this.description,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      icon: data.icon.present ? data.icon.value : this.icon,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Rite(')
          ..write('id: $id, ')
          ..write('nameAr: $nameAr, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameCoptic: $nameCoptic, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('icon: $icon')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, nameAr, nameEn, nameCoptic, category, description, sortOrder, icon);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Rite &&
          other.id == this.id &&
          other.nameAr == this.nameAr &&
          other.nameEn == this.nameEn &&
          other.nameCoptic == this.nameCoptic &&
          other.category == this.category &&
          other.description == this.description &&
          other.sortOrder == this.sortOrder &&
          other.icon == this.icon);
}

class RitesCompanion extends UpdateCompanion<Rite> {
  final Value<int> id;
  final Value<String> nameAr;
  final Value<String?> nameEn;
  final Value<String?> nameCoptic;
  final Value<String> category;
  final Value<String?> description;
  final Value<int> sortOrder;
  final Value<String?> icon;
  const RitesCompanion({
    this.id = const Value.absent(),
    this.nameAr = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameCoptic = const Value.absent(),
    this.category = const Value.absent(),
    this.description = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.icon = const Value.absent(),
  });
  RitesCompanion.insert({
    this.id = const Value.absent(),
    required String nameAr,
    this.nameEn = const Value.absent(),
    this.nameCoptic = const Value.absent(),
    required String category,
    this.description = const Value.absent(),
    required int sortOrder,
    this.icon = const Value.absent(),
  })  : nameAr = Value(nameAr),
        category = Value(category),
        sortOrder = Value(sortOrder);
  static Insertable<Rite> custom({
    Expression<int>? id,
    Expression<String>? nameAr,
    Expression<String>? nameEn,
    Expression<String>? nameCoptic,
    Expression<String>? category,
    Expression<String>? description,
    Expression<int>? sortOrder,
    Expression<String>? icon,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameAr != null) 'name_ar': nameAr,
      if (nameEn != null) 'name_en': nameEn,
      if (nameCoptic != null) 'name_coptic': nameCoptic,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (icon != null) 'icon': icon,
    });
  }

  RitesCompanion copyWith(
      {Value<int>? id,
      Value<String>? nameAr,
      Value<String?>? nameEn,
      Value<String?>? nameCoptic,
      Value<String>? category,
      Value<String?>? description,
      Value<int>? sortOrder,
      Value<String?>? icon}) {
    return RitesCompanion(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      nameCoptic: nameCoptic ?? this.nameCoptic,
      category: category ?? this.category,
      description: description ?? this.description,
      sortOrder: sortOrder ?? this.sortOrder,
      icon: icon ?? this.icon,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nameAr.present) {
      map['name_ar'] = Variable<String>(nameAr.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameCoptic.present) {
      map['name_coptic'] = Variable<String>(nameCoptic.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RitesCompanion(')
          ..write('id: $id, ')
          ..write('nameAr: $nameAr, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameCoptic: $nameCoptic, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('icon: $icon')
          ..write(')'))
        .toString();
  }
}

class $RiteSectionsTable extends RiteSections
    with TableInfo<$RiteSectionsTable, RiteSection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RiteSectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _riteIdMeta = const VerificationMeta('riteId');
  @override
  late final GeneratedColumn<int> riteId = GeneratedColumn<int>(
      'rite_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES rites (id)'));
  static const VerificationMeta _titleArMeta =
      const VerificationMeta('titleAr');
  @override
  late final GeneratedColumn<String> titleAr = GeneratedColumn<String>(
      'title_ar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _textArMeta = const VerificationMeta('textAr');
  @override
  late final GeneratedColumn<String> textAr = GeneratedColumn<String>(
      'text_ar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _copticTextMeta =
      const VerificationMeta('copticText');
  @override
  late final GeneratedColumn<String> copticText = GeneratedColumn<String>(
      'coptic_text', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _copticArabicTextMeta =
      const VerificationMeta('copticArabicText');
  @override
  late final GeneratedColumn<String> copticArabicText = GeneratedColumn<String>(
      'coptic_arabic_text', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _rubricMeta = const VerificationMeta('rubric');
  @override
  late final GeneratedColumn<String> rubric = GeneratedColumn<String>(
      'rubric', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _responseMeta =
      const VerificationMeta('response');
  @override
  late final GeneratedColumn<String> response = GeneratedColumn<String>(
      'response', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        riteId,
        titleAr,
        textAr,
        copticText,
        copticArabicText,
        rubric,
        response,
        sortOrder
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rite_sections';
  @override
  VerificationContext validateIntegrity(Insertable<RiteSection> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('rite_id')) {
      context.handle(_riteIdMeta,
          riteId.isAcceptableOrUnknown(data['rite_id']!, _riteIdMeta));
    } else if (isInserting) {
      context.missing(_riteIdMeta);
    }
    if (data.containsKey('title_ar')) {
      context.handle(_titleArMeta,
          titleAr.isAcceptableOrUnknown(data['title_ar']!, _titleArMeta));
    } else if (isInserting) {
      context.missing(_titleArMeta);
    }
    if (data.containsKey('text_ar')) {
      context.handle(_textArMeta,
          textAr.isAcceptableOrUnknown(data['text_ar']!, _textArMeta));
    } else if (isInserting) {
      context.missing(_textArMeta);
    }
    if (data.containsKey('coptic_text')) {
      context.handle(
          _copticTextMeta,
          copticText.isAcceptableOrUnknown(
              data['coptic_text']!, _copticTextMeta));
    }
    if (data.containsKey('coptic_arabic_text')) {
      context.handle(
          _copticArabicTextMeta,
          copticArabicText.isAcceptableOrUnknown(
              data['coptic_arabic_text']!, _copticArabicTextMeta));
    }
    if (data.containsKey('rubric')) {
      context.handle(_rubricMeta,
          rubric.isAcceptableOrUnknown(data['rubric']!, _rubricMeta));
    }
    if (data.containsKey('response')) {
      context.handle(_responseMeta,
          response.isAcceptableOrUnknown(data['response']!, _responseMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RiteSection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RiteSection(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      riteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rite_id'])!,
      titleAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title_ar'])!,
      textAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_ar'])!,
      copticText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}coptic_text']),
      copticArabicText: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}coptic_arabic_text']),
      rubric: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rubric']),
      response: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}response']),
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
    );
  }

  @override
  $RiteSectionsTable createAlias(String alias) {
    return $RiteSectionsTable(attachedDatabase, alias);
  }
}

class RiteSection extends DataClass implements Insertable<RiteSection> {
  final int id;
  final int riteId;
  final String titleAr;
  final String textAr;
  final String? copticText;
  final String? copticArabicText;
  final String? rubric;
  final String? response;
  final int sortOrder;
  const RiteSection(
      {required this.id,
      required this.riteId,
      required this.titleAr,
      required this.textAr,
      this.copticText,
      this.copticArabicText,
      this.rubric,
      this.response,
      required this.sortOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['rite_id'] = Variable<int>(riteId);
    map['title_ar'] = Variable<String>(titleAr);
    map['text_ar'] = Variable<String>(textAr);
    if (!nullToAbsent || copticText != null) {
      map['coptic_text'] = Variable<String>(copticText);
    }
    if (!nullToAbsent || copticArabicText != null) {
      map['coptic_arabic_text'] = Variable<String>(copticArabicText);
    }
    if (!nullToAbsent || rubric != null) {
      map['rubric'] = Variable<String>(rubric);
    }
    if (!nullToAbsent || response != null) {
      map['response'] = Variable<String>(response);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  RiteSectionsCompanion toCompanion(bool nullToAbsent) {
    return RiteSectionsCompanion(
      id: Value(id),
      riteId: Value(riteId),
      titleAr: Value(titleAr),
      textAr: Value(textAr),
      copticText: copticText == null && nullToAbsent
          ? const Value.absent()
          : Value(copticText),
      copticArabicText: copticArabicText == null && nullToAbsent
          ? const Value.absent()
          : Value(copticArabicText),
      rubric:
          rubric == null && nullToAbsent ? const Value.absent() : Value(rubric),
      response: response == null && nullToAbsent
          ? const Value.absent()
          : Value(response),
      sortOrder: Value(sortOrder),
    );
  }

  factory RiteSection.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RiteSection(
      id: serializer.fromJson<int>(json['id']),
      riteId: serializer.fromJson<int>(json['riteId']),
      titleAr: serializer.fromJson<String>(json['titleAr']),
      textAr: serializer.fromJson<String>(json['textAr']),
      copticText: serializer.fromJson<String?>(json['copticText']),
      copticArabicText: serializer.fromJson<String?>(json['copticArabicText']),
      rubric: serializer.fromJson<String?>(json['rubric']),
      response: serializer.fromJson<String?>(json['response']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'riteId': serializer.toJson<int>(riteId),
      'titleAr': serializer.toJson<String>(titleAr),
      'textAr': serializer.toJson<String>(textAr),
      'copticText': serializer.toJson<String?>(copticText),
      'copticArabicText': serializer.toJson<String?>(copticArabicText),
      'rubric': serializer.toJson<String?>(rubric),
      'response': serializer.toJson<String?>(response),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  RiteSection copyWith(
          {int? id,
          int? riteId,
          String? titleAr,
          String? textAr,
          Value<String?> copticText = const Value.absent(),
          Value<String?> copticArabicText = const Value.absent(),
          Value<String?> rubric = const Value.absent(),
          Value<String?> response = const Value.absent(),
          int? sortOrder}) =>
      RiteSection(
        id: id ?? this.id,
        riteId: riteId ?? this.riteId,
        titleAr: titleAr ?? this.titleAr,
        textAr: textAr ?? this.textAr,
        copticText: copticText.present ? copticText.value : this.copticText,
        copticArabicText: copticArabicText.present
            ? copticArabicText.value
            : this.copticArabicText,
        rubric: rubric.present ? rubric.value : this.rubric,
        response: response.present ? response.value : this.response,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  RiteSection copyWithCompanion(RiteSectionsCompanion data) {
    return RiteSection(
      id: data.id.present ? data.id.value : this.id,
      riteId: data.riteId.present ? data.riteId.value : this.riteId,
      titleAr: data.titleAr.present ? data.titleAr.value : this.titleAr,
      textAr: data.textAr.present ? data.textAr.value : this.textAr,
      copticText:
          data.copticText.present ? data.copticText.value : this.copticText,
      copticArabicText: data.copticArabicText.present
          ? data.copticArabicText.value
          : this.copticArabicText,
      rubric: data.rubric.present ? data.rubric.value : this.rubric,
      response: data.response.present ? data.response.value : this.response,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RiteSection(')
          ..write('id: $id, ')
          ..write('riteId: $riteId, ')
          ..write('titleAr: $titleAr, ')
          ..write('textAr: $textAr, ')
          ..write('copticText: $copticText, ')
          ..write('copticArabicText: $copticArabicText, ')
          ..write('rubric: $rubric, ')
          ..write('response: $response, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, riteId, titleAr, textAr, copticText,
      copticArabicText, rubric, response, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RiteSection &&
          other.id == this.id &&
          other.riteId == this.riteId &&
          other.titleAr == this.titleAr &&
          other.textAr == this.textAr &&
          other.copticText == this.copticText &&
          other.copticArabicText == this.copticArabicText &&
          other.rubric == this.rubric &&
          other.response == this.response &&
          other.sortOrder == this.sortOrder);
}

class RiteSectionsCompanion extends UpdateCompanion<RiteSection> {
  final Value<int> id;
  final Value<int> riteId;
  final Value<String> titleAr;
  final Value<String> textAr;
  final Value<String?> copticText;
  final Value<String?> copticArabicText;
  final Value<String?> rubric;
  final Value<String?> response;
  final Value<int> sortOrder;
  const RiteSectionsCompanion({
    this.id = const Value.absent(),
    this.riteId = const Value.absent(),
    this.titleAr = const Value.absent(),
    this.textAr = const Value.absent(),
    this.copticText = const Value.absent(),
    this.copticArabicText = const Value.absent(),
    this.rubric = const Value.absent(),
    this.response = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  RiteSectionsCompanion.insert({
    this.id = const Value.absent(),
    required int riteId,
    required String titleAr,
    required String textAr,
    this.copticText = const Value.absent(),
    this.copticArabicText = const Value.absent(),
    this.rubric = const Value.absent(),
    this.response = const Value.absent(),
    required int sortOrder,
  })  : riteId = Value(riteId),
        titleAr = Value(titleAr),
        textAr = Value(textAr),
        sortOrder = Value(sortOrder);
  static Insertable<RiteSection> custom({
    Expression<int>? id,
    Expression<int>? riteId,
    Expression<String>? titleAr,
    Expression<String>? textAr,
    Expression<String>? copticText,
    Expression<String>? copticArabicText,
    Expression<String>? rubric,
    Expression<String>? response,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (riteId != null) 'rite_id': riteId,
      if (titleAr != null) 'title_ar': titleAr,
      if (textAr != null) 'text_ar': textAr,
      if (copticText != null) 'coptic_text': copticText,
      if (copticArabicText != null) 'coptic_arabic_text': copticArabicText,
      if (rubric != null) 'rubric': rubric,
      if (response != null) 'response': response,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  RiteSectionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? riteId,
      Value<String>? titleAr,
      Value<String>? textAr,
      Value<String?>? copticText,
      Value<String?>? copticArabicText,
      Value<String?>? rubric,
      Value<String?>? response,
      Value<int>? sortOrder}) {
    return RiteSectionsCompanion(
      id: id ?? this.id,
      riteId: riteId ?? this.riteId,
      titleAr: titleAr ?? this.titleAr,
      textAr: textAr ?? this.textAr,
      copticText: copticText ?? this.copticText,
      copticArabicText: copticArabicText ?? this.copticArabicText,
      rubric: rubric ?? this.rubric,
      response: response ?? this.response,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (riteId.present) {
      map['rite_id'] = Variable<int>(riteId.value);
    }
    if (titleAr.present) {
      map['title_ar'] = Variable<String>(titleAr.value);
    }
    if (textAr.present) {
      map['text_ar'] = Variable<String>(textAr.value);
    }
    if (copticText.present) {
      map['coptic_text'] = Variable<String>(copticText.value);
    }
    if (copticArabicText.present) {
      map['coptic_arabic_text'] = Variable<String>(copticArabicText.value);
    }
    if (rubric.present) {
      map['rubric'] = Variable<String>(rubric.value);
    }
    if (response.present) {
      map['response'] = Variable<String>(response.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RiteSectionsCompanion(')
          ..write('id: $id, ')
          ..write('riteId: $riteId, ')
          ..write('titleAr: $titleAr, ')
          ..write('textAr: $textAr, ')
          ..write('copticText: $copticText, ')
          ..write('copticArabicText: $copticArabicText, ')
          ..write('rubric: $rubric, ')
          ..write('response: $response, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $HolyPlacesTable extends HolyPlaces
    with TableInfo<$HolyPlacesTable, HolyPlace> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HolyPlacesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameArMeta = const VerificationMeta('nameAr');
  @override
  late final GeneratedColumn<String> nameAr = GeneratedColumn<String>(
      'name_ar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameCopticMeta =
      const VerificationMeta('nameCoptic');
  @override
  late final GeneratedColumn<String> nameCoptic = GeneratedColumn<String>(
      'name_coptic', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _governorateMeta =
      const VerificationMeta('governorate');
  @override
  late final GeneratedColumn<String> governorate = GeneratedColumn<String>(
      'governorate', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _locationDescriptionMeta =
      const VerificationMeta('locationDescription');
  @override
  late final GeneratedColumn<String> locationDescription =
      GeneratedColumn<String>('location_description', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _centuryMeta =
      const VerificationMeta('century');
  @override
  late final GeneratedColumn<String> century = GeneratedColumn<String>(
      'century', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _patronSaintMeta =
      const VerificationMeta('patronSaint');
  @override
  late final GeneratedColumn<String> patronSaint = GeneratedColumn<String>(
      'patron_saint', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _historyMeta =
      const VerificationMeta('history');
  @override
  late final GeneratedColumn<String> history = GeneratedColumn<String>(
      'history', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _feastDayMeta =
      const VerificationMeta('feastDay');
  @override
  late final GeneratedColumn<String> feastDay = GeneratedColumn<String>(
      'feast_day', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _visitingRulesMeta =
      const VerificationMeta('visitingRules');
  @override
  late final GeneratedColumn<String> visitingRules = GeneratedColumn<String>(
      'visiting_rules', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        nameAr,
        nameCoptic,
        type,
        governorate,
        locationDescription,
        latitude,
        longitude,
        century,
        patronSaint,
        history,
        feastDay,
        visitingRules,
        sortOrder
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'holy_places';
  @override
  VerificationContext validateIntegrity(Insertable<HolyPlace> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name_ar')) {
      context.handle(_nameArMeta,
          nameAr.isAcceptableOrUnknown(data['name_ar']!, _nameArMeta));
    } else if (isInserting) {
      context.missing(_nameArMeta);
    }
    if (data.containsKey('name_coptic')) {
      context.handle(
          _nameCopticMeta,
          nameCoptic.isAcceptableOrUnknown(
              data['name_coptic']!, _nameCopticMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('governorate')) {
      context.handle(
          _governorateMeta,
          governorate.isAcceptableOrUnknown(
              data['governorate']!, _governorateMeta));
    } else if (isInserting) {
      context.missing(_governorateMeta);
    }
    if (data.containsKey('location_description')) {
      context.handle(
          _locationDescriptionMeta,
          locationDescription.isAcceptableOrUnknown(
              data['location_description']!, _locationDescriptionMeta));
    } else if (isInserting) {
      context.missing(_locationDescriptionMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    }
    if (data.containsKey('century')) {
      context.handle(_centuryMeta,
          century.isAcceptableOrUnknown(data['century']!, _centuryMeta));
    }
    if (data.containsKey('patron_saint')) {
      context.handle(
          _patronSaintMeta,
          patronSaint.isAcceptableOrUnknown(
              data['patron_saint']!, _patronSaintMeta));
    }
    if (data.containsKey('history')) {
      context.handle(_historyMeta,
          history.isAcceptableOrUnknown(data['history']!, _historyMeta));
    } else if (isInserting) {
      context.missing(_historyMeta);
    }
    if (data.containsKey('feast_day')) {
      context.handle(_feastDayMeta,
          feastDay.isAcceptableOrUnknown(data['feast_day']!, _feastDayMeta));
    }
    if (data.containsKey('visiting_rules')) {
      context.handle(
          _visitingRulesMeta,
          visitingRules.isAcceptableOrUnknown(
              data['visiting_rules']!, _visitingRulesMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HolyPlace map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HolyPlace(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nameAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_ar'])!,
      nameCoptic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_coptic']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      governorate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}governorate'])!,
      locationDescription: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}location_description'])!,
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude']),
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude']),
      century: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}century']),
      patronSaint: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}patron_saint']),
      history: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}history'])!,
      feastDay: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}feast_day']),
      visitingRules: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}visiting_rules']),
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
    );
  }

  @override
  $HolyPlacesTable createAlias(String alias) {
    return $HolyPlacesTable(attachedDatabase, alias);
  }
}

class HolyPlace extends DataClass implements Insertable<HolyPlace> {
  final int id;
  final String nameAr;
  final String? nameCoptic;
  final String type;
  final String governorate;
  final String locationDescription;
  final double? latitude;
  final double? longitude;
  final String? century;
  final String? patronSaint;
  final String history;
  final String? feastDay;
  final String? visitingRules;
  final int sortOrder;
  const HolyPlace(
      {required this.id,
      required this.nameAr,
      this.nameCoptic,
      required this.type,
      required this.governorate,
      required this.locationDescription,
      this.latitude,
      this.longitude,
      this.century,
      this.patronSaint,
      required this.history,
      this.feastDay,
      this.visitingRules,
      required this.sortOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name_ar'] = Variable<String>(nameAr);
    if (!nullToAbsent || nameCoptic != null) {
      map['name_coptic'] = Variable<String>(nameCoptic);
    }
    map['type'] = Variable<String>(type);
    map['governorate'] = Variable<String>(governorate);
    map['location_description'] = Variable<String>(locationDescription);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || century != null) {
      map['century'] = Variable<String>(century);
    }
    if (!nullToAbsent || patronSaint != null) {
      map['patron_saint'] = Variable<String>(patronSaint);
    }
    map['history'] = Variable<String>(history);
    if (!nullToAbsent || feastDay != null) {
      map['feast_day'] = Variable<String>(feastDay);
    }
    if (!nullToAbsent || visitingRules != null) {
      map['visiting_rules'] = Variable<String>(visitingRules);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  HolyPlacesCompanion toCompanion(bool nullToAbsent) {
    return HolyPlacesCompanion(
      id: Value(id),
      nameAr: Value(nameAr),
      nameCoptic: nameCoptic == null && nullToAbsent
          ? const Value.absent()
          : Value(nameCoptic),
      type: Value(type),
      governorate: Value(governorate),
      locationDescription: Value(locationDescription),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      century: century == null && nullToAbsent
          ? const Value.absent()
          : Value(century),
      patronSaint: patronSaint == null && nullToAbsent
          ? const Value.absent()
          : Value(patronSaint),
      history: Value(history),
      feastDay: feastDay == null && nullToAbsent
          ? const Value.absent()
          : Value(feastDay),
      visitingRules: visitingRules == null && nullToAbsent
          ? const Value.absent()
          : Value(visitingRules),
      sortOrder: Value(sortOrder),
    );
  }

  factory HolyPlace.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HolyPlace(
      id: serializer.fromJson<int>(json['id']),
      nameAr: serializer.fromJson<String>(json['nameAr']),
      nameCoptic: serializer.fromJson<String?>(json['nameCoptic']),
      type: serializer.fromJson<String>(json['type']),
      governorate: serializer.fromJson<String>(json['governorate']),
      locationDescription:
          serializer.fromJson<String>(json['locationDescription']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      century: serializer.fromJson<String?>(json['century']),
      patronSaint: serializer.fromJson<String?>(json['patronSaint']),
      history: serializer.fromJson<String>(json['history']),
      feastDay: serializer.fromJson<String?>(json['feastDay']),
      visitingRules: serializer.fromJson<String?>(json['visitingRules']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nameAr': serializer.toJson<String>(nameAr),
      'nameCoptic': serializer.toJson<String?>(nameCoptic),
      'type': serializer.toJson<String>(type),
      'governorate': serializer.toJson<String>(governorate),
      'locationDescription': serializer.toJson<String>(locationDescription),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'century': serializer.toJson<String?>(century),
      'patronSaint': serializer.toJson<String?>(patronSaint),
      'history': serializer.toJson<String>(history),
      'feastDay': serializer.toJson<String?>(feastDay),
      'visitingRules': serializer.toJson<String?>(visitingRules),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  HolyPlace copyWith(
          {int? id,
          String? nameAr,
          Value<String?> nameCoptic = const Value.absent(),
          String? type,
          String? governorate,
          String? locationDescription,
          Value<double?> latitude = const Value.absent(),
          Value<double?> longitude = const Value.absent(),
          Value<String?> century = const Value.absent(),
          Value<String?> patronSaint = const Value.absent(),
          String? history,
          Value<String?> feastDay = const Value.absent(),
          Value<String?> visitingRules = const Value.absent(),
          int? sortOrder}) =>
      HolyPlace(
        id: id ?? this.id,
        nameAr: nameAr ?? this.nameAr,
        nameCoptic: nameCoptic.present ? nameCoptic.value : this.nameCoptic,
        type: type ?? this.type,
        governorate: governorate ?? this.governorate,
        locationDescription: locationDescription ?? this.locationDescription,
        latitude: latitude.present ? latitude.value : this.latitude,
        longitude: longitude.present ? longitude.value : this.longitude,
        century: century.present ? century.value : this.century,
        patronSaint: patronSaint.present ? patronSaint.value : this.patronSaint,
        history: history ?? this.history,
        feastDay: feastDay.present ? feastDay.value : this.feastDay,
        visitingRules:
            visitingRules.present ? visitingRules.value : this.visitingRules,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  HolyPlace copyWithCompanion(HolyPlacesCompanion data) {
    return HolyPlace(
      id: data.id.present ? data.id.value : this.id,
      nameAr: data.nameAr.present ? data.nameAr.value : this.nameAr,
      nameCoptic:
          data.nameCoptic.present ? data.nameCoptic.value : this.nameCoptic,
      type: data.type.present ? data.type.value : this.type,
      governorate:
          data.governorate.present ? data.governorate.value : this.governorate,
      locationDescription: data.locationDescription.present
          ? data.locationDescription.value
          : this.locationDescription,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      century: data.century.present ? data.century.value : this.century,
      patronSaint:
          data.patronSaint.present ? data.patronSaint.value : this.patronSaint,
      history: data.history.present ? data.history.value : this.history,
      feastDay: data.feastDay.present ? data.feastDay.value : this.feastDay,
      visitingRules: data.visitingRules.present
          ? data.visitingRules.value
          : this.visitingRules,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HolyPlace(')
          ..write('id: $id, ')
          ..write('nameAr: $nameAr, ')
          ..write('nameCoptic: $nameCoptic, ')
          ..write('type: $type, ')
          ..write('governorate: $governorate, ')
          ..write('locationDescription: $locationDescription, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('century: $century, ')
          ..write('patronSaint: $patronSaint, ')
          ..write('history: $history, ')
          ..write('feastDay: $feastDay, ')
          ..write('visitingRules: $visitingRules, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      nameAr,
      nameCoptic,
      type,
      governorate,
      locationDescription,
      latitude,
      longitude,
      century,
      patronSaint,
      history,
      feastDay,
      visitingRules,
      sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HolyPlace &&
          other.id == this.id &&
          other.nameAr == this.nameAr &&
          other.nameCoptic == this.nameCoptic &&
          other.type == this.type &&
          other.governorate == this.governorate &&
          other.locationDescription == this.locationDescription &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.century == this.century &&
          other.patronSaint == this.patronSaint &&
          other.history == this.history &&
          other.feastDay == this.feastDay &&
          other.visitingRules == this.visitingRules &&
          other.sortOrder == this.sortOrder);
}

class HolyPlacesCompanion extends UpdateCompanion<HolyPlace> {
  final Value<int> id;
  final Value<String> nameAr;
  final Value<String?> nameCoptic;
  final Value<String> type;
  final Value<String> governorate;
  final Value<String> locationDescription;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String?> century;
  final Value<String?> patronSaint;
  final Value<String> history;
  final Value<String?> feastDay;
  final Value<String?> visitingRules;
  final Value<int> sortOrder;
  const HolyPlacesCompanion({
    this.id = const Value.absent(),
    this.nameAr = const Value.absent(),
    this.nameCoptic = const Value.absent(),
    this.type = const Value.absent(),
    this.governorate = const Value.absent(),
    this.locationDescription = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.century = const Value.absent(),
    this.patronSaint = const Value.absent(),
    this.history = const Value.absent(),
    this.feastDay = const Value.absent(),
    this.visitingRules = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  HolyPlacesCompanion.insert({
    this.id = const Value.absent(),
    required String nameAr,
    this.nameCoptic = const Value.absent(),
    required String type,
    required String governorate,
    required String locationDescription,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.century = const Value.absent(),
    this.patronSaint = const Value.absent(),
    required String history,
    this.feastDay = const Value.absent(),
    this.visitingRules = const Value.absent(),
    required int sortOrder,
  })  : nameAr = Value(nameAr),
        type = Value(type),
        governorate = Value(governorate),
        locationDescription = Value(locationDescription),
        history = Value(history),
        sortOrder = Value(sortOrder);
  static Insertable<HolyPlace> custom({
    Expression<int>? id,
    Expression<String>? nameAr,
    Expression<String>? nameCoptic,
    Expression<String>? type,
    Expression<String>? governorate,
    Expression<String>? locationDescription,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? century,
    Expression<String>? patronSaint,
    Expression<String>? history,
    Expression<String>? feastDay,
    Expression<String>? visitingRules,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameAr != null) 'name_ar': nameAr,
      if (nameCoptic != null) 'name_coptic': nameCoptic,
      if (type != null) 'type': type,
      if (governorate != null) 'governorate': governorate,
      if (locationDescription != null)
        'location_description': locationDescription,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (century != null) 'century': century,
      if (patronSaint != null) 'patron_saint': patronSaint,
      if (history != null) 'history': history,
      if (feastDay != null) 'feast_day': feastDay,
      if (visitingRules != null) 'visiting_rules': visitingRules,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  HolyPlacesCompanion copyWith(
      {Value<int>? id,
      Value<String>? nameAr,
      Value<String?>? nameCoptic,
      Value<String>? type,
      Value<String>? governorate,
      Value<String>? locationDescription,
      Value<double?>? latitude,
      Value<double?>? longitude,
      Value<String?>? century,
      Value<String?>? patronSaint,
      Value<String>? history,
      Value<String?>? feastDay,
      Value<String?>? visitingRules,
      Value<int>? sortOrder}) {
    return HolyPlacesCompanion(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      nameCoptic: nameCoptic ?? this.nameCoptic,
      type: type ?? this.type,
      governorate: governorate ?? this.governorate,
      locationDescription: locationDescription ?? this.locationDescription,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      century: century ?? this.century,
      patronSaint: patronSaint ?? this.patronSaint,
      history: history ?? this.history,
      feastDay: feastDay ?? this.feastDay,
      visitingRules: visitingRules ?? this.visitingRules,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nameAr.present) {
      map['name_ar'] = Variable<String>(nameAr.value);
    }
    if (nameCoptic.present) {
      map['name_coptic'] = Variable<String>(nameCoptic.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (governorate.present) {
      map['governorate'] = Variable<String>(governorate.value);
    }
    if (locationDescription.present) {
      map['location_description'] = Variable<String>(locationDescription.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (century.present) {
      map['century'] = Variable<String>(century.value);
    }
    if (patronSaint.present) {
      map['patron_saint'] = Variable<String>(patronSaint.value);
    }
    if (history.present) {
      map['history'] = Variable<String>(history.value);
    }
    if (feastDay.present) {
      map['feast_day'] = Variable<String>(feastDay.value);
    }
    if (visitingRules.present) {
      map['visiting_rules'] = Variable<String>(visitingRules.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HolyPlacesCompanion(')
          ..write('id: $id, ')
          ..write('nameAr: $nameAr, ')
          ..write('nameCoptic: $nameCoptic, ')
          ..write('type: $type, ')
          ..write('governorate: $governorate, ')
          ..write('locationDescription: $locationDescription, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('century: $century, ')
          ..write('patronSaint: $patronSaint, ')
          ..write('history: $history, ')
          ..write('feastDay: $feastDay, ')
          ..write('visitingRules: $visitingRules, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $EmotionPrayersTable extends EmotionPrayers
    with TableInfo<$EmotionPrayersTable, EmotionPrayer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmotionPrayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _verseTextMeta =
      const VerificationMeta('verseText');
  @override
  late final GeneratedColumn<String> verseText = GeneratedColumn<String>(
      'verse_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _verseReferenceMeta =
      const VerificationMeta('verseReference');
  @override
  late final GeneratedColumn<String> verseReference = GeneratedColumn<String>(
      'verse_reference', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _psalmTextMeta =
      const VerificationMeta('psalmText');
  @override
  late final GeneratedColumn<String> psalmText = GeneratedColumn<String>(
      'psalm_text', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _psalmReferenceMeta =
      const VerificationMeta('psalmReference');
  @override
  late final GeneratedColumn<String> psalmReference = GeneratedColumn<String>(
      'psalm_reference', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _agpeyaPrayerMeta =
      const VerificationMeta('agpeyaPrayer');
  @override
  late final GeneratedColumn<String> agpeyaPrayer = GeneratedColumn<String>(
      'agpeya_prayer', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _agpeyaReferenceMeta =
      const VerificationMeta('agpeyaReference');
  @override
  late final GeneratedColumn<String> agpeyaReference = GeneratedColumn<String>(
      'agpeya_reference', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _meditationMeta =
      const VerificationMeta('meditation');
  @override
  late final GeneratedColumn<String> meditation = GeneratedColumn<String>(
      'meditation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        category,
        title,
        verseText,
        verseReference,
        psalmText,
        psalmReference,
        agpeyaPrayer,
        agpeyaReference,
        meditation,
        sortOrder
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'emotion_prayers';
  @override
  VerificationContext validateIntegrity(Insertable<EmotionPrayer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('verse_text')) {
      context.handle(_verseTextMeta,
          verseText.isAcceptableOrUnknown(data['verse_text']!, _verseTextMeta));
    } else if (isInserting) {
      context.missing(_verseTextMeta);
    }
    if (data.containsKey('verse_reference')) {
      context.handle(
          _verseReferenceMeta,
          verseReference.isAcceptableOrUnknown(
              data['verse_reference']!, _verseReferenceMeta));
    } else if (isInserting) {
      context.missing(_verseReferenceMeta);
    }
    if (data.containsKey('psalm_text')) {
      context.handle(_psalmTextMeta,
          psalmText.isAcceptableOrUnknown(data['psalm_text']!, _psalmTextMeta));
    }
    if (data.containsKey('psalm_reference')) {
      context.handle(
          _psalmReferenceMeta,
          psalmReference.isAcceptableOrUnknown(
              data['psalm_reference']!, _psalmReferenceMeta));
    }
    if (data.containsKey('agpeya_prayer')) {
      context.handle(
          _agpeyaPrayerMeta,
          agpeyaPrayer.isAcceptableOrUnknown(
              data['agpeya_prayer']!, _agpeyaPrayerMeta));
    }
    if (data.containsKey('agpeya_reference')) {
      context.handle(
          _agpeyaReferenceMeta,
          agpeyaReference.isAcceptableOrUnknown(
              data['agpeya_reference']!, _agpeyaReferenceMeta));
    }
    if (data.containsKey('meditation')) {
      context.handle(
          _meditationMeta,
          meditation.isAcceptableOrUnknown(
              data['meditation']!, _meditationMeta));
    } else if (isInserting) {
      context.missing(_meditationMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EmotionPrayer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmotionPrayer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      verseText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}verse_text'])!,
      verseReference: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}verse_reference'])!,
      psalmText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}psalm_text']),
      psalmReference: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}psalm_reference']),
      agpeyaPrayer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}agpeya_prayer']),
      agpeyaReference: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}agpeya_reference']),
      meditation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}meditation'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
    );
  }

  @override
  $EmotionPrayersTable createAlias(String alias) {
    return $EmotionPrayersTable(attachedDatabase, alias);
  }
}

class EmotionPrayer extends DataClass implements Insertable<EmotionPrayer> {
  final int id;
  final String category;
  final String title;
  final String verseText;
  final String verseReference;
  final String? psalmText;
  final String? psalmReference;
  final String? agpeyaPrayer;
  final String? agpeyaReference;
  final String meditation;
  final int sortOrder;
  const EmotionPrayer(
      {required this.id,
      required this.category,
      required this.title,
      required this.verseText,
      required this.verseReference,
      this.psalmText,
      this.psalmReference,
      this.agpeyaPrayer,
      this.agpeyaReference,
      required this.meditation,
      required this.sortOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category'] = Variable<String>(category);
    map['title'] = Variable<String>(title);
    map['verse_text'] = Variable<String>(verseText);
    map['verse_reference'] = Variable<String>(verseReference);
    if (!nullToAbsent || psalmText != null) {
      map['psalm_text'] = Variable<String>(psalmText);
    }
    if (!nullToAbsent || psalmReference != null) {
      map['psalm_reference'] = Variable<String>(psalmReference);
    }
    if (!nullToAbsent || agpeyaPrayer != null) {
      map['agpeya_prayer'] = Variable<String>(agpeyaPrayer);
    }
    if (!nullToAbsent || agpeyaReference != null) {
      map['agpeya_reference'] = Variable<String>(agpeyaReference);
    }
    map['meditation'] = Variable<String>(meditation);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  EmotionPrayersCompanion toCompanion(bool nullToAbsent) {
    return EmotionPrayersCompanion(
      id: Value(id),
      category: Value(category),
      title: Value(title),
      verseText: Value(verseText),
      verseReference: Value(verseReference),
      psalmText: psalmText == null && nullToAbsent
          ? const Value.absent()
          : Value(psalmText),
      psalmReference: psalmReference == null && nullToAbsent
          ? const Value.absent()
          : Value(psalmReference),
      agpeyaPrayer: agpeyaPrayer == null && nullToAbsent
          ? const Value.absent()
          : Value(agpeyaPrayer),
      agpeyaReference: agpeyaReference == null && nullToAbsent
          ? const Value.absent()
          : Value(agpeyaReference),
      meditation: Value(meditation),
      sortOrder: Value(sortOrder),
    );
  }

  factory EmotionPrayer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmotionPrayer(
      id: serializer.fromJson<int>(json['id']),
      category: serializer.fromJson<String>(json['category']),
      title: serializer.fromJson<String>(json['title']),
      verseText: serializer.fromJson<String>(json['verseText']),
      verseReference: serializer.fromJson<String>(json['verseReference']),
      psalmText: serializer.fromJson<String?>(json['psalmText']),
      psalmReference: serializer.fromJson<String?>(json['psalmReference']),
      agpeyaPrayer: serializer.fromJson<String?>(json['agpeyaPrayer']),
      agpeyaReference: serializer.fromJson<String?>(json['agpeyaReference']),
      meditation: serializer.fromJson<String>(json['meditation']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category': serializer.toJson<String>(category),
      'title': serializer.toJson<String>(title),
      'verseText': serializer.toJson<String>(verseText),
      'verseReference': serializer.toJson<String>(verseReference),
      'psalmText': serializer.toJson<String?>(psalmText),
      'psalmReference': serializer.toJson<String?>(psalmReference),
      'agpeyaPrayer': serializer.toJson<String?>(agpeyaPrayer),
      'agpeyaReference': serializer.toJson<String?>(agpeyaReference),
      'meditation': serializer.toJson<String>(meditation),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  EmotionPrayer copyWith(
          {int? id,
          String? category,
          String? title,
          String? verseText,
          String? verseReference,
          Value<String?> psalmText = const Value.absent(),
          Value<String?> psalmReference = const Value.absent(),
          Value<String?> agpeyaPrayer = const Value.absent(),
          Value<String?> agpeyaReference = const Value.absent(),
          String? meditation,
          int? sortOrder}) =>
      EmotionPrayer(
        id: id ?? this.id,
        category: category ?? this.category,
        title: title ?? this.title,
        verseText: verseText ?? this.verseText,
        verseReference: verseReference ?? this.verseReference,
        psalmText: psalmText.present ? psalmText.value : this.psalmText,
        psalmReference:
            psalmReference.present ? psalmReference.value : this.psalmReference,
        agpeyaPrayer:
            agpeyaPrayer.present ? agpeyaPrayer.value : this.agpeyaPrayer,
        agpeyaReference: agpeyaReference.present
            ? agpeyaReference.value
            : this.agpeyaReference,
        meditation: meditation ?? this.meditation,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  EmotionPrayer copyWithCompanion(EmotionPrayersCompanion data) {
    return EmotionPrayer(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
      title: data.title.present ? data.title.value : this.title,
      verseText: data.verseText.present ? data.verseText.value : this.verseText,
      verseReference: data.verseReference.present
          ? data.verseReference.value
          : this.verseReference,
      psalmText: data.psalmText.present ? data.psalmText.value : this.psalmText,
      psalmReference: data.psalmReference.present
          ? data.psalmReference.value
          : this.psalmReference,
      agpeyaPrayer: data.agpeyaPrayer.present
          ? data.agpeyaPrayer.value
          : this.agpeyaPrayer,
      agpeyaReference: data.agpeyaReference.present
          ? data.agpeyaReference.value
          : this.agpeyaReference,
      meditation:
          data.meditation.present ? data.meditation.value : this.meditation,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmotionPrayer(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('title: $title, ')
          ..write('verseText: $verseText, ')
          ..write('verseReference: $verseReference, ')
          ..write('psalmText: $psalmText, ')
          ..write('psalmReference: $psalmReference, ')
          ..write('agpeyaPrayer: $agpeyaPrayer, ')
          ..write('agpeyaReference: $agpeyaReference, ')
          ..write('meditation: $meditation, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      category,
      title,
      verseText,
      verseReference,
      psalmText,
      psalmReference,
      agpeyaPrayer,
      agpeyaReference,
      meditation,
      sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmotionPrayer &&
          other.id == this.id &&
          other.category == this.category &&
          other.title == this.title &&
          other.verseText == this.verseText &&
          other.verseReference == this.verseReference &&
          other.psalmText == this.psalmText &&
          other.psalmReference == this.psalmReference &&
          other.agpeyaPrayer == this.agpeyaPrayer &&
          other.agpeyaReference == this.agpeyaReference &&
          other.meditation == this.meditation &&
          other.sortOrder == this.sortOrder);
}

class EmotionPrayersCompanion extends UpdateCompanion<EmotionPrayer> {
  final Value<int> id;
  final Value<String> category;
  final Value<String> title;
  final Value<String> verseText;
  final Value<String> verseReference;
  final Value<String?> psalmText;
  final Value<String?> psalmReference;
  final Value<String?> agpeyaPrayer;
  final Value<String?> agpeyaReference;
  final Value<String> meditation;
  final Value<int> sortOrder;
  const EmotionPrayersCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.title = const Value.absent(),
    this.verseText = const Value.absent(),
    this.verseReference = const Value.absent(),
    this.psalmText = const Value.absent(),
    this.psalmReference = const Value.absent(),
    this.agpeyaPrayer = const Value.absent(),
    this.agpeyaReference = const Value.absent(),
    this.meditation = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  EmotionPrayersCompanion.insert({
    this.id = const Value.absent(),
    required String category,
    required String title,
    required String verseText,
    required String verseReference,
    this.psalmText = const Value.absent(),
    this.psalmReference = const Value.absent(),
    this.agpeyaPrayer = const Value.absent(),
    this.agpeyaReference = const Value.absent(),
    required String meditation,
    required int sortOrder,
  })  : category = Value(category),
        title = Value(title),
        verseText = Value(verseText),
        verseReference = Value(verseReference),
        meditation = Value(meditation),
        sortOrder = Value(sortOrder);
  static Insertable<EmotionPrayer> custom({
    Expression<int>? id,
    Expression<String>? category,
    Expression<String>? title,
    Expression<String>? verseText,
    Expression<String>? verseReference,
    Expression<String>? psalmText,
    Expression<String>? psalmReference,
    Expression<String>? agpeyaPrayer,
    Expression<String>? agpeyaReference,
    Expression<String>? meditation,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (title != null) 'title': title,
      if (verseText != null) 'verse_text': verseText,
      if (verseReference != null) 'verse_reference': verseReference,
      if (psalmText != null) 'psalm_text': psalmText,
      if (psalmReference != null) 'psalm_reference': psalmReference,
      if (agpeyaPrayer != null) 'agpeya_prayer': agpeyaPrayer,
      if (agpeyaReference != null) 'agpeya_reference': agpeyaReference,
      if (meditation != null) 'meditation': meditation,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  EmotionPrayersCompanion copyWith(
      {Value<int>? id,
      Value<String>? category,
      Value<String>? title,
      Value<String>? verseText,
      Value<String>? verseReference,
      Value<String?>? psalmText,
      Value<String?>? psalmReference,
      Value<String?>? agpeyaPrayer,
      Value<String?>? agpeyaReference,
      Value<String>? meditation,
      Value<int>? sortOrder}) {
    return EmotionPrayersCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      title: title ?? this.title,
      verseText: verseText ?? this.verseText,
      verseReference: verseReference ?? this.verseReference,
      psalmText: psalmText ?? this.psalmText,
      psalmReference: psalmReference ?? this.psalmReference,
      agpeyaPrayer: agpeyaPrayer ?? this.agpeyaPrayer,
      agpeyaReference: agpeyaReference ?? this.agpeyaReference,
      meditation: meditation ?? this.meditation,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (verseText.present) {
      map['verse_text'] = Variable<String>(verseText.value);
    }
    if (verseReference.present) {
      map['verse_reference'] = Variable<String>(verseReference.value);
    }
    if (psalmText.present) {
      map['psalm_text'] = Variable<String>(psalmText.value);
    }
    if (psalmReference.present) {
      map['psalm_reference'] = Variable<String>(psalmReference.value);
    }
    if (agpeyaPrayer.present) {
      map['agpeya_prayer'] = Variable<String>(agpeyaPrayer.value);
    }
    if (agpeyaReference.present) {
      map['agpeya_reference'] = Variable<String>(agpeyaReference.value);
    }
    if (meditation.present) {
      map['meditation'] = Variable<String>(meditation.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmotionPrayersCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('title: $title, ')
          ..write('verseText: $verseText, ')
          ..write('verseReference: $verseReference, ')
          ..write('psalmText: $psalmText, ')
          ..write('psalmReference: $psalmReference, ')
          ..write('agpeyaPrayer: $agpeyaPrayer, ')
          ..write('agpeyaReference: $agpeyaReference, ')
          ..write('meditation: $meditation, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BibleBooksTable bibleBooks = $BibleBooksTable(this);
  late final $BibleVersesTable bibleVerses = $BibleVersesTable(this);
  late final $AgpeyaHoursTable agpeyaHours = $AgpeyaHoursTable(this);
  late final $AgpeyaSectionsTable agpeyaSections = $AgpeyaSectionsTable(this);
  late final $LiturgiesTable liturgies = $LiturgiesTable(this);
  late final $LiturgySectionsTable liturgySections =
      $LiturgySectionsTable(this);
  late final $LiturgyPartsTable liturgyParts = $LiturgyPartsTable(this);
  late final $HymnBooksTable hymnBooks = $HymnBooksTable(this);
  late final $HymnsTable hymns = $HymnsTable(this);
  late final $HymnSegmentsTable hymnSegments = $HymnSegmentsTable(this);
  late final $SynaxariumEntriesTable synaxariumEntries =
      $SynaxariumEntriesTable(this);
  late final $KatamerosReadingsTable katamerosReadings =
      $KatamerosReadingsTable(this);
  late final $SaintsTable saints = $SaintsTable(this);
  late final $DifnarEntriesTable difnarEntries = $DifnarEntriesTable(this);
  late final $PaschaReadingsTable paschaReadings = $PaschaReadingsTable(this);
  late final $FeastsAndFastsTable feastsAndFasts = $FeastsAndFastsTable(this);
  late final $OccasionalPrayersTable occasionalPrayers =
      $OccasionalPrayersTable(this);
  late final $TheologyArticlesTable theologyArticles =
      $TheologyArticlesTable(this);
  late final $DailyVersesTable dailyVerses = $DailyVersesTable(this);
  late final $BookmarksTable bookmarks = $BookmarksTable(this);
  late final $SacramentsTable sacraments = $SacramentsTable(this);
  late final $SacramentSectionsTable sacramentSections =
      $SacramentSectionsTable(this);
  late final $MonasteriesTable monasteries = $MonasteriesTable(this);
  late final $BibleCommentariesTable bibleCommentaries =
      $BibleCommentariesTable(this);
  late final $CopticDictionaryTable copticDictionary =
      $CopticDictionaryTable(this);
  late final $BibleCrossReferencesTable bibleCrossReferences =
      $BibleCrossReferencesTable(this);
  late final $PsalisTable psalis = $PsalisTable(this);
  late final $PsaliSectionsTable psaliSections = $PsaliSectionsTable(this);
  late final $RitesTable rites = $RitesTable(this);
  late final $RiteSectionsTable riteSections = $RiteSectionsTable(this);
  late final $HolyPlacesTable holyPlaces = $HolyPlacesTable(this);
  late final $EmotionPrayersTable emotionPrayers = $EmotionPrayersTable(this);
  late final BibleDao bibleDao = BibleDao(this as AppDatabase);
  late final CommentaryDao commentaryDao = CommentaryDao(this as AppDatabase);
  late final DictionaryDao dictionaryDao = DictionaryDao(this as AppDatabase);
  late final CrossReferenceDao crossReferenceDao =
      CrossReferenceDao(this as AppDatabase);
  late final PsaliDao psaliDao = PsaliDao(this as AppDatabase);
  late final RiteDao riteDao = RiteDao(this as AppDatabase);
  late final HolyPlaceDao holyPlaceDao = HolyPlaceDao(this as AppDatabase);
  late final EmotionPrayerDao emotionPrayerDao =
      EmotionPrayerDao(this as AppDatabase);
  late final AgpeyaDao agpeyaDao = AgpeyaDao(this as AppDatabase);
  late final DailyVerseDao dailyVerseDao = DailyVerseDao(this as AppDatabase);
  late final LiturgyDao liturgyDao = LiturgyDao(this as AppDatabase);
  late final HymnsDao hymnsDao = HymnsDao(this as AppDatabase);
  late final SynaxariumDao synaxariumDao = SynaxariumDao(this as AppDatabase);
  late final KatamerosDao katamerosDao = KatamerosDao(this as AppDatabase);
  late final PaschaDao paschaDao = PaschaDao(this as AppDatabase);
  late final FeastsDao feastsDao = FeastsDao(this as AppDatabase);
  late final PrayersDao prayersDao = PrayersDao(this as AppDatabase);
  late final SacramentsDao sacramentsDao = SacramentsDao(this as AppDatabase);
  late final SaintsDao saintsDao = SaintsDao(this as AppDatabase);
  late final DifnarDao difnarDao = DifnarDao(this as AppDatabase);
  late final TheologyDao theologyDao = TheologyDao(this as AppDatabase);
  late final SearchDao searchDao = SearchDao(this as AppDatabase);
  late final BookmarksDao bookmarksDao = BookmarksDao(this as AppDatabase);
  late final MonasteriesDao monasteriesDao =
      MonasteriesDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        bibleBooks,
        bibleVerses,
        agpeyaHours,
        agpeyaSections,
        liturgies,
        liturgySections,
        liturgyParts,
        hymnBooks,
        hymns,
        hymnSegments,
        synaxariumEntries,
        katamerosReadings,
        saints,
        difnarEntries,
        paschaReadings,
        feastsAndFasts,
        occasionalPrayers,
        theologyArticles,
        dailyVerses,
        bookmarks,
        sacraments,
        sacramentSections,
        monasteries,
        bibleCommentaries,
        copticDictionary,
        bibleCrossReferences,
        psalis,
        psaliSections,
        rites,
        riteSections,
        holyPlaces,
        emotionPrayers
      ];
}

typedef $$BibleBooksTableCreateCompanionBuilder = BibleBooksCompanion Function({
  Value<int> id,
  required String nameAr,
  required String nameEn,
  Value<String?> nameCoptic,
  required String testament,
  required String testamentAr,
  required String category,
  required String categoryAr,
  required int bookOrder,
  required int chapterCount,
});
typedef $$BibleBooksTableUpdateCompanionBuilder = BibleBooksCompanion Function({
  Value<int> id,
  Value<String> nameAr,
  Value<String> nameEn,
  Value<String?> nameCoptic,
  Value<String> testament,
  Value<String> testamentAr,
  Value<String> category,
  Value<String> categoryAr,
  Value<int> bookOrder,
  Value<int> chapterCount,
});

final class $$BibleBooksTableReferences
    extends BaseReferences<_$AppDatabase, $BibleBooksTable, BibleBook> {
  $$BibleBooksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BibleVersesTable, List<BibleVerse>>
      _bibleVersesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.bibleVerses,
              aliasName: 'bible_books__id__bible_verses__book_id');

  $$BibleVersesTableProcessedTableManager get bibleVersesRefs {
    final manager = $$BibleVersesTableTableManager($_db, $_db.bibleVerses)
        .filter((f) => f.bookId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_bibleVersesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$BibleBooksTableFilterComposer
    extends Composer<_$AppDatabase, $BibleBooksTable> {
  $$BibleBooksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameCoptic => $composableBuilder(
      column: $table.nameCoptic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get testament => $composableBuilder(
      column: $table.testament, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get testamentAr => $composableBuilder(
      column: $table.testamentAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoryAr => $composableBuilder(
      column: $table.categoryAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get bookOrder => $composableBuilder(
      column: $table.bookOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get chapterCount => $composableBuilder(
      column: $table.chapterCount, builder: (column) => ColumnFilters(column));

  Expression<bool> bibleVersesRefs(
      Expression<bool> Function($$BibleVersesTableFilterComposer f) f) {
    final $$BibleVersesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.bibleVerses,
        getReferencedColumn: (t) => t.bookId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BibleVersesTableFilterComposer(
              $db: $db,
              $table: $db.bibleVerses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BibleBooksTableOrderingComposer
    extends Composer<_$AppDatabase, $BibleBooksTable> {
  $$BibleBooksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameCoptic => $composableBuilder(
      column: $table.nameCoptic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get testament => $composableBuilder(
      column: $table.testament, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get testamentAr => $composableBuilder(
      column: $table.testamentAr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoryAr => $composableBuilder(
      column: $table.categoryAr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get bookOrder => $composableBuilder(
      column: $table.bookOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get chapterCount => $composableBuilder(
      column: $table.chapterCount,
      builder: (column) => ColumnOrderings(column));
}

class $$BibleBooksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BibleBooksTable> {
  $$BibleBooksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameAr =>
      $composableBuilder(column: $table.nameAr, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameCoptic => $composableBuilder(
      column: $table.nameCoptic, builder: (column) => column);

  GeneratedColumn<String> get testament =>
      $composableBuilder(column: $table.testament, builder: (column) => column);

  GeneratedColumn<String> get testamentAr => $composableBuilder(
      column: $table.testamentAr, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get categoryAr => $composableBuilder(
      column: $table.categoryAr, builder: (column) => column);

  GeneratedColumn<int> get bookOrder =>
      $composableBuilder(column: $table.bookOrder, builder: (column) => column);

  GeneratedColumn<int> get chapterCount => $composableBuilder(
      column: $table.chapterCount, builder: (column) => column);

  Expression<T> bibleVersesRefs<T extends Object>(
      Expression<T> Function($$BibleVersesTableAnnotationComposer a) f) {
    final $$BibleVersesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.bibleVerses,
        getReferencedColumn: (t) => t.bookId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BibleVersesTableAnnotationComposer(
              $db: $db,
              $table: $db.bibleVerses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BibleBooksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BibleBooksTable,
    BibleBook,
    $$BibleBooksTableFilterComposer,
    $$BibleBooksTableOrderingComposer,
    $$BibleBooksTableAnnotationComposer,
    $$BibleBooksTableCreateCompanionBuilder,
    $$BibleBooksTableUpdateCompanionBuilder,
    (BibleBook, $$BibleBooksTableReferences),
    BibleBook,
    PrefetchHooks Function({bool bibleVersesRefs})> {
  $$BibleBooksTableTableManager(_$AppDatabase db, $BibleBooksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BibleBooksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BibleBooksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BibleBooksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nameAr = const Value.absent(),
            Value<String> nameEn = const Value.absent(),
            Value<String?> nameCoptic = const Value.absent(),
            Value<String> testament = const Value.absent(),
            Value<String> testamentAr = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> categoryAr = const Value.absent(),
            Value<int> bookOrder = const Value.absent(),
            Value<int> chapterCount = const Value.absent(),
          }) =>
              BibleBooksCompanion(
            id: id,
            nameAr: nameAr,
            nameEn: nameEn,
            nameCoptic: nameCoptic,
            testament: testament,
            testamentAr: testamentAr,
            category: category,
            categoryAr: categoryAr,
            bookOrder: bookOrder,
            chapterCount: chapterCount,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nameAr,
            required String nameEn,
            Value<String?> nameCoptic = const Value.absent(),
            required String testament,
            required String testamentAr,
            required String category,
            required String categoryAr,
            required int bookOrder,
            required int chapterCount,
          }) =>
              BibleBooksCompanion.insert(
            id: id,
            nameAr: nameAr,
            nameEn: nameEn,
            nameCoptic: nameCoptic,
            testament: testament,
            testamentAr: testamentAr,
            category: category,
            categoryAr: categoryAr,
            bookOrder: bookOrder,
            chapterCount: chapterCount,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$BibleBooksTable, BibleBook>(table),
                    $$BibleBooksTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({bibleVersesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (bibleVersesRefs) db.bibleVerses],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (bibleVersesRefs)
                    await $_getPrefetchedData<BibleBook, $BibleBooksTable,
                            BibleVerse>(
                        currentTable: table,
                        referencedTable: $$BibleBooksTableReferences
                            ._bibleVersesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BibleBooksTableReferences(db, table, p0)
                                .bibleVersesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.bookId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$BibleBooksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BibleBooksTable,
    BibleBook,
    $$BibleBooksTableFilterComposer,
    $$BibleBooksTableOrderingComposer,
    $$BibleBooksTableAnnotationComposer,
    $$BibleBooksTableCreateCompanionBuilder,
    $$BibleBooksTableUpdateCompanionBuilder,
    (BibleBook, $$BibleBooksTableReferences),
    BibleBook,
    PrefetchHooks Function({bool bibleVersesRefs})>;
typedef $$BibleVersesTableCreateCompanionBuilder = BibleVersesCompanion
    Function({
  Value<int> id,
  required int bookId,
  required int chapter,
  required int verseNumber,
  required String content,
  Value<String?> textWithTashkeel,
});
typedef $$BibleVersesTableUpdateCompanionBuilder = BibleVersesCompanion
    Function({
  Value<int> id,
  Value<int> bookId,
  Value<int> chapter,
  Value<int> verseNumber,
  Value<String> content,
  Value<String?> textWithTashkeel,
});

final class $$BibleVersesTableReferences
    extends BaseReferences<_$AppDatabase, $BibleVersesTable, BibleVerse> {
  $$BibleVersesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BibleBooksTable _bookIdTable(_$AppDatabase db) =>
      db.bibleBooks.createAlias('bible_verses__book_id__bible_books__id');

  $$BibleBooksTableProcessedTableManager get bookId {
    final $_column = $_itemColumn<int>('book_id')!;

    final manager = $$BibleBooksTableTableManager($_db, $_db.bibleBooks)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$BibleVersesTableFilterComposer
    extends Composer<_$AppDatabase, $BibleVersesTable> {
  $$BibleVersesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get chapter => $composableBuilder(
      column: $table.chapter, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get verseNumber => $composableBuilder(
      column: $table.verseNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get textWithTashkeel => $composableBuilder(
      column: $table.textWithTashkeel,
      builder: (column) => ColumnFilters(column));

  $$BibleBooksTableFilterComposer get bookId {
    final $$BibleBooksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.bibleBooks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BibleBooksTableFilterComposer(
              $db: $db,
              $table: $db.bibleBooks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BibleVersesTableOrderingComposer
    extends Composer<_$AppDatabase, $BibleVersesTable> {
  $$BibleVersesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get chapter => $composableBuilder(
      column: $table.chapter, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get verseNumber => $composableBuilder(
      column: $table.verseNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get textWithTashkeel => $composableBuilder(
      column: $table.textWithTashkeel,
      builder: (column) => ColumnOrderings(column));

  $$BibleBooksTableOrderingComposer get bookId {
    final $$BibleBooksTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.bibleBooks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BibleBooksTableOrderingComposer(
              $db: $db,
              $table: $db.bibleBooks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BibleVersesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BibleVersesTable> {
  $$BibleVersesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get chapter =>
      $composableBuilder(column: $table.chapter, builder: (column) => column);

  GeneratedColumn<int> get verseNumber => $composableBuilder(
      column: $table.verseNumber, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get textWithTashkeel => $composableBuilder(
      column: $table.textWithTashkeel, builder: (column) => column);

  $$BibleBooksTableAnnotationComposer get bookId {
    final $$BibleBooksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.bibleBooks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BibleBooksTableAnnotationComposer(
              $db: $db,
              $table: $db.bibleBooks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BibleVersesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BibleVersesTable,
    BibleVerse,
    $$BibleVersesTableFilterComposer,
    $$BibleVersesTableOrderingComposer,
    $$BibleVersesTableAnnotationComposer,
    $$BibleVersesTableCreateCompanionBuilder,
    $$BibleVersesTableUpdateCompanionBuilder,
    (BibleVerse, $$BibleVersesTableReferences),
    BibleVerse,
    PrefetchHooks Function({bool bookId})> {
  $$BibleVersesTableTableManager(_$AppDatabase db, $BibleVersesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BibleVersesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BibleVersesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BibleVersesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> bookId = const Value.absent(),
            Value<int> chapter = const Value.absent(),
            Value<int> verseNumber = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String?> textWithTashkeel = const Value.absent(),
          }) =>
              BibleVersesCompanion(
            id: id,
            bookId: bookId,
            chapter: chapter,
            verseNumber: verseNumber,
            content: content,
            textWithTashkeel: textWithTashkeel,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int bookId,
            required int chapter,
            required int verseNumber,
            required String content,
            Value<String?> textWithTashkeel = const Value.absent(),
          }) =>
              BibleVersesCompanion.insert(
            id: id,
            bookId: bookId,
            chapter: chapter,
            verseNumber: verseNumber,
            content: content,
            textWithTashkeel: textWithTashkeel,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$BibleVersesTable, BibleVerse>(table),
                    $$BibleVersesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({bookId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (bookId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bookId,
                    referencedTable:
                        $$BibleVersesTableReferences._bookIdTable(db),
                    referencedColumn:
                        $$BibleVersesTableReferences._bookIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$BibleVersesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BibleVersesTable,
    BibleVerse,
    $$BibleVersesTableFilterComposer,
    $$BibleVersesTableOrderingComposer,
    $$BibleVersesTableAnnotationComposer,
    $$BibleVersesTableCreateCompanionBuilder,
    $$BibleVersesTableUpdateCompanionBuilder,
    (BibleVerse, $$BibleVersesTableReferences),
    BibleVerse,
    PrefetchHooks Function({bool bookId})>;
typedef $$AgpeyaHoursTableCreateCompanionBuilder = AgpeyaHoursCompanion
    Function({
  required String id,
  required String nameAr,
  required String nameEn,
  required int hourOrder,
  Value<String?> description,
  Value<int> rowid,
});
typedef $$AgpeyaHoursTableUpdateCompanionBuilder = AgpeyaHoursCompanion
    Function({
  Value<String> id,
  Value<String> nameAr,
  Value<String> nameEn,
  Value<int> hourOrder,
  Value<String?> description,
  Value<int> rowid,
});

final class $$AgpeyaHoursTableReferences
    extends BaseReferences<_$AppDatabase, $AgpeyaHoursTable, AgpeyaHour> {
  $$AgpeyaHoursTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AgpeyaSectionsTable, List<AgpeyaSection>>
      _agpeyaSectionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.agpeyaSections,
              aliasName: 'agpeya_hours__id__agpeya_sections__hour_id');

  $$AgpeyaSectionsTableProcessedTableManager get agpeyaSectionsRefs {
    final manager = $$AgpeyaSectionsTableTableManager($_db, $_db.agpeyaSections)
        .filter((f) => f.hourId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_agpeyaSectionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$AgpeyaHoursTableFilterComposer
    extends Composer<_$AppDatabase, $AgpeyaHoursTable> {
  $$AgpeyaHoursTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get hourOrder => $composableBuilder(
      column: $table.hourOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  Expression<bool> agpeyaSectionsRefs(
      Expression<bool> Function($$AgpeyaSectionsTableFilterComposer f) f) {
    final $$AgpeyaSectionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.agpeyaSections,
        getReferencedColumn: (t) => t.hourId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AgpeyaSectionsTableFilterComposer(
              $db: $db,
              $table: $db.agpeyaSections,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AgpeyaHoursTableOrderingComposer
    extends Composer<_$AppDatabase, $AgpeyaHoursTable> {
  $$AgpeyaHoursTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get hourOrder => $composableBuilder(
      column: $table.hourOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));
}

class $$AgpeyaHoursTableAnnotationComposer
    extends Composer<_$AppDatabase, $AgpeyaHoursTable> {
  $$AgpeyaHoursTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameAr =>
      $composableBuilder(column: $table.nameAr, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<int> get hourOrder =>
      $composableBuilder(column: $table.hourOrder, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  Expression<T> agpeyaSectionsRefs<T extends Object>(
      Expression<T> Function($$AgpeyaSectionsTableAnnotationComposer a) f) {
    final $$AgpeyaSectionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.agpeyaSections,
        getReferencedColumn: (t) => t.hourId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AgpeyaSectionsTableAnnotationComposer(
              $db: $db,
              $table: $db.agpeyaSections,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AgpeyaHoursTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AgpeyaHoursTable,
    AgpeyaHour,
    $$AgpeyaHoursTableFilterComposer,
    $$AgpeyaHoursTableOrderingComposer,
    $$AgpeyaHoursTableAnnotationComposer,
    $$AgpeyaHoursTableCreateCompanionBuilder,
    $$AgpeyaHoursTableUpdateCompanionBuilder,
    (AgpeyaHour, $$AgpeyaHoursTableReferences),
    AgpeyaHour,
    PrefetchHooks Function({bool agpeyaSectionsRefs})> {
  $$AgpeyaHoursTableTableManager(_$AppDatabase db, $AgpeyaHoursTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AgpeyaHoursTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AgpeyaHoursTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AgpeyaHoursTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> nameAr = const Value.absent(),
            Value<String> nameEn = const Value.absent(),
            Value<int> hourOrder = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AgpeyaHoursCompanion(
            id: id,
            nameAr: nameAr,
            nameEn: nameEn,
            hourOrder: hourOrder,
            description: description,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String nameAr,
            required String nameEn,
            required int hourOrder,
            Value<String?> description = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AgpeyaHoursCompanion.insert(
            id: id,
            nameAr: nameAr,
            nameEn: nameEn,
            hourOrder: hourOrder,
            description: description,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$AgpeyaHoursTable, AgpeyaHour>(table),
                    $$AgpeyaHoursTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({agpeyaSectionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (agpeyaSectionsRefs) db.agpeyaSections
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (agpeyaSectionsRefs)
                    await $_getPrefetchedData<AgpeyaHour, $AgpeyaHoursTable,
                            AgpeyaSection>(
                        currentTable: table,
                        referencedTable: $$AgpeyaHoursTableReferences
                            ._agpeyaSectionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AgpeyaHoursTableReferences(db, table, p0)
                                .agpeyaSectionsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.hourId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$AgpeyaHoursTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AgpeyaHoursTable,
    AgpeyaHour,
    $$AgpeyaHoursTableFilterComposer,
    $$AgpeyaHoursTableOrderingComposer,
    $$AgpeyaHoursTableAnnotationComposer,
    $$AgpeyaHoursTableCreateCompanionBuilder,
    $$AgpeyaHoursTableUpdateCompanionBuilder,
    (AgpeyaHour, $$AgpeyaHoursTableReferences),
    AgpeyaHour,
    PrefetchHooks Function({bool agpeyaSectionsRefs})>;
typedef $$AgpeyaSectionsTableCreateCompanionBuilder = AgpeyaSectionsCompanion
    Function({
  Value<int> id,
  required String hourId,
  required int sectionOrder,
  required String type,
  required String title,
  required String role,
  required String textAr,
  Value<String?> textCoptic,
  Value<String?> textPhonetic,
  Value<String?> reference,
});
typedef $$AgpeyaSectionsTableUpdateCompanionBuilder = AgpeyaSectionsCompanion
    Function({
  Value<int> id,
  Value<String> hourId,
  Value<int> sectionOrder,
  Value<String> type,
  Value<String> title,
  Value<String> role,
  Value<String> textAr,
  Value<String?> textCoptic,
  Value<String?> textPhonetic,
  Value<String?> reference,
});

final class $$AgpeyaSectionsTableReferences
    extends BaseReferences<_$AppDatabase, $AgpeyaSectionsTable, AgpeyaSection> {
  $$AgpeyaSectionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $AgpeyaHoursTable _hourIdTable(_$AppDatabase db) =>
      db.agpeyaHours.createAlias('agpeya_sections__hour_id__agpeya_hours__id');

  $$AgpeyaHoursTableProcessedTableManager get hourId {
    final $_column = $_itemColumn<String>('hour_id')!;

    final manager = $$AgpeyaHoursTableTableManager($_db, $_db.agpeyaHours)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_hourIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$AgpeyaSectionsTableFilterComposer
    extends Composer<_$AppDatabase, $AgpeyaSectionsTable> {
  $$AgpeyaSectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sectionOrder => $composableBuilder(
      column: $table.sectionOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get textAr => $composableBuilder(
      column: $table.textAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get textCoptic => $composableBuilder(
      column: $table.textCoptic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get textPhonetic => $composableBuilder(
      column: $table.textPhonetic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reference => $composableBuilder(
      column: $table.reference, builder: (column) => ColumnFilters(column));

  $$AgpeyaHoursTableFilterComposer get hourId {
    final $$AgpeyaHoursTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.hourId,
        referencedTable: $db.agpeyaHours,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AgpeyaHoursTableFilterComposer(
              $db: $db,
              $table: $db.agpeyaHours,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AgpeyaSectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $AgpeyaSectionsTable> {
  $$AgpeyaSectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sectionOrder => $composableBuilder(
      column: $table.sectionOrder,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get textAr => $composableBuilder(
      column: $table.textAr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get textCoptic => $composableBuilder(
      column: $table.textCoptic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get textPhonetic => $composableBuilder(
      column: $table.textPhonetic,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reference => $composableBuilder(
      column: $table.reference, builder: (column) => ColumnOrderings(column));

  $$AgpeyaHoursTableOrderingComposer get hourId {
    final $$AgpeyaHoursTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.hourId,
        referencedTable: $db.agpeyaHours,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AgpeyaHoursTableOrderingComposer(
              $db: $db,
              $table: $db.agpeyaHours,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AgpeyaSectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AgpeyaSectionsTable> {
  $$AgpeyaSectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sectionOrder => $composableBuilder(
      column: $table.sectionOrder, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get textAr =>
      $composableBuilder(column: $table.textAr, builder: (column) => column);

  GeneratedColumn<String> get textCoptic => $composableBuilder(
      column: $table.textCoptic, builder: (column) => column);

  GeneratedColumn<String> get textPhonetic => $composableBuilder(
      column: $table.textPhonetic, builder: (column) => column);

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  $$AgpeyaHoursTableAnnotationComposer get hourId {
    final $$AgpeyaHoursTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.hourId,
        referencedTable: $db.agpeyaHours,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AgpeyaHoursTableAnnotationComposer(
              $db: $db,
              $table: $db.agpeyaHours,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AgpeyaSectionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AgpeyaSectionsTable,
    AgpeyaSection,
    $$AgpeyaSectionsTableFilterComposer,
    $$AgpeyaSectionsTableOrderingComposer,
    $$AgpeyaSectionsTableAnnotationComposer,
    $$AgpeyaSectionsTableCreateCompanionBuilder,
    $$AgpeyaSectionsTableUpdateCompanionBuilder,
    (AgpeyaSection, $$AgpeyaSectionsTableReferences),
    AgpeyaSection,
    PrefetchHooks Function({bool hourId})> {
  $$AgpeyaSectionsTableTableManager(
      _$AppDatabase db, $AgpeyaSectionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AgpeyaSectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AgpeyaSectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AgpeyaSectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> hourId = const Value.absent(),
            Value<int> sectionOrder = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<String> textAr = const Value.absent(),
            Value<String?> textCoptic = const Value.absent(),
            Value<String?> textPhonetic = const Value.absent(),
            Value<String?> reference = const Value.absent(),
          }) =>
              AgpeyaSectionsCompanion(
            id: id,
            hourId: hourId,
            sectionOrder: sectionOrder,
            type: type,
            title: title,
            role: role,
            textAr: textAr,
            textCoptic: textCoptic,
            textPhonetic: textPhonetic,
            reference: reference,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String hourId,
            required int sectionOrder,
            required String type,
            required String title,
            required String role,
            required String textAr,
            Value<String?> textCoptic = const Value.absent(),
            Value<String?> textPhonetic = const Value.absent(),
            Value<String?> reference = const Value.absent(),
          }) =>
              AgpeyaSectionsCompanion.insert(
            id: id,
            hourId: hourId,
            sectionOrder: sectionOrder,
            type: type,
            title: title,
            role: role,
            textAr: textAr,
            textCoptic: textCoptic,
            textPhonetic: textPhonetic,
            reference: reference,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$AgpeyaSectionsTable, AgpeyaSection>(table),
                    $$AgpeyaSectionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({hourId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (hourId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.hourId,
                    referencedTable:
                        $$AgpeyaSectionsTableReferences._hourIdTable(db),
                    referencedColumn:
                        $$AgpeyaSectionsTableReferences._hourIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$AgpeyaSectionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AgpeyaSectionsTable,
    AgpeyaSection,
    $$AgpeyaSectionsTableFilterComposer,
    $$AgpeyaSectionsTableOrderingComposer,
    $$AgpeyaSectionsTableAnnotationComposer,
    $$AgpeyaSectionsTableCreateCompanionBuilder,
    $$AgpeyaSectionsTableUpdateCompanionBuilder,
    (AgpeyaSection, $$AgpeyaSectionsTableReferences),
    AgpeyaSection,
    PrefetchHooks Function({bool hourId})>;
typedef $$LiturgiesTableCreateCompanionBuilder = LiturgiesCompanion Function({
  required String id,
  required String nameAr,
  required String nameEn,
  required int liturgyOrder,
  Value<int> rowid,
});
typedef $$LiturgiesTableUpdateCompanionBuilder = LiturgiesCompanion Function({
  Value<String> id,
  Value<String> nameAr,
  Value<String> nameEn,
  Value<int> liturgyOrder,
  Value<int> rowid,
});

final class $$LiturgiesTableReferences
    extends BaseReferences<_$AppDatabase, $LiturgiesTable, Liturgy> {
  $$LiturgiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$LiturgySectionsTable, List<LiturgySection>>
      _liturgySectionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.liturgySections,
              aliasName: 'liturgies__id__liturgy_sections__liturgy_id');

  $$LiturgySectionsTableProcessedTableManager get liturgySectionsRefs {
    final manager = $$LiturgySectionsTableTableManager(
            $_db, $_db.liturgySections)
        .filter((f) => f.liturgyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_liturgySectionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$LiturgiesTableFilterComposer
    extends Composer<_$AppDatabase, $LiturgiesTable> {
  $$LiturgiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get liturgyOrder => $composableBuilder(
      column: $table.liturgyOrder, builder: (column) => ColumnFilters(column));

  Expression<bool> liturgySectionsRefs(
      Expression<bool> Function($$LiturgySectionsTableFilterComposer f) f) {
    final $$LiturgySectionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.liturgySections,
        getReferencedColumn: (t) => t.liturgyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LiturgySectionsTableFilterComposer(
              $db: $db,
              $table: $db.liturgySections,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LiturgiesTableOrderingComposer
    extends Composer<_$AppDatabase, $LiturgiesTable> {
  $$LiturgiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get liturgyOrder => $composableBuilder(
      column: $table.liturgyOrder,
      builder: (column) => ColumnOrderings(column));
}

class $$LiturgiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LiturgiesTable> {
  $$LiturgiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameAr =>
      $composableBuilder(column: $table.nameAr, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<int> get liturgyOrder => $composableBuilder(
      column: $table.liturgyOrder, builder: (column) => column);

  Expression<T> liturgySectionsRefs<T extends Object>(
      Expression<T> Function($$LiturgySectionsTableAnnotationComposer a) f) {
    final $$LiturgySectionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.liturgySections,
        getReferencedColumn: (t) => t.liturgyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LiturgySectionsTableAnnotationComposer(
              $db: $db,
              $table: $db.liturgySections,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LiturgiesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LiturgiesTable,
    Liturgy,
    $$LiturgiesTableFilterComposer,
    $$LiturgiesTableOrderingComposer,
    $$LiturgiesTableAnnotationComposer,
    $$LiturgiesTableCreateCompanionBuilder,
    $$LiturgiesTableUpdateCompanionBuilder,
    (Liturgy, $$LiturgiesTableReferences),
    Liturgy,
    PrefetchHooks Function({bool liturgySectionsRefs})> {
  $$LiturgiesTableTableManager(_$AppDatabase db, $LiturgiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LiturgiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LiturgiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LiturgiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> nameAr = const Value.absent(),
            Value<String> nameEn = const Value.absent(),
            Value<int> liturgyOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LiturgiesCompanion(
            id: id,
            nameAr: nameAr,
            nameEn: nameEn,
            liturgyOrder: liturgyOrder,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String nameAr,
            required String nameEn,
            required int liturgyOrder,
            Value<int> rowid = const Value.absent(),
          }) =>
              LiturgiesCompanion.insert(
            id: id,
            nameAr: nameAr,
            nameEn: nameEn,
            liturgyOrder: liturgyOrder,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$LiturgiesTable, Liturgy>(table),
                    $$LiturgiesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({liturgySectionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (liturgySectionsRefs) db.liturgySections
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (liturgySectionsRefs)
                    await $_getPrefetchedData<Liturgy, $LiturgiesTable,
                            LiturgySection>(
                        currentTable: table,
                        referencedTable: $$LiturgiesTableReferences
                            ._liturgySectionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LiturgiesTableReferences(db, table, p0)
                                .liturgySectionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.liturgyId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$LiturgiesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LiturgiesTable,
    Liturgy,
    $$LiturgiesTableFilterComposer,
    $$LiturgiesTableOrderingComposer,
    $$LiturgiesTableAnnotationComposer,
    $$LiturgiesTableCreateCompanionBuilder,
    $$LiturgiesTableUpdateCompanionBuilder,
    (Liturgy, $$LiturgiesTableReferences),
    Liturgy,
    PrefetchHooks Function({bool liturgySectionsRefs})>;
typedef $$LiturgySectionsTableCreateCompanionBuilder = LiturgySectionsCompanion
    Function({
  required String id,
  required String liturgyId,
  required String nameAr,
  required int sectionOrder,
  Value<int> rowid,
});
typedef $$LiturgySectionsTableUpdateCompanionBuilder = LiturgySectionsCompanion
    Function({
  Value<String> id,
  Value<String> liturgyId,
  Value<String> nameAr,
  Value<int> sectionOrder,
  Value<int> rowid,
});

final class $$LiturgySectionsTableReferences extends BaseReferences<
    _$AppDatabase, $LiturgySectionsTable, LiturgySection> {
  $$LiturgySectionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $LiturgiesTable _liturgyIdTable(_$AppDatabase db) =>
      db.liturgies.createAlias('liturgy_sections__liturgy_id__liturgies__id');

  $$LiturgiesTableProcessedTableManager get liturgyId {
    final $_column = $_itemColumn<String>('liturgy_id')!;

    final manager = $$LiturgiesTableTableManager($_db, $_db.liturgies)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_liturgyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$LiturgyPartsTable, List<LiturgyPart>>
      _liturgyPartsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.liturgyParts,
              aliasName: 'liturgy_sections__id__liturgy_parts__section_id');

  $$LiturgyPartsTableProcessedTableManager get liturgyPartsRefs {
    final manager = $$LiturgyPartsTableTableManager($_db, $_db.liturgyParts)
        .filter((f) => f.sectionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_liturgyPartsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$LiturgySectionsTableFilterComposer
    extends Composer<_$AppDatabase, $LiturgySectionsTable> {
  $$LiturgySectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sectionOrder => $composableBuilder(
      column: $table.sectionOrder, builder: (column) => ColumnFilters(column));

  $$LiturgiesTableFilterComposer get liturgyId {
    final $$LiturgiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.liturgyId,
        referencedTable: $db.liturgies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LiturgiesTableFilterComposer(
              $db: $db,
              $table: $db.liturgies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> liturgyPartsRefs(
      Expression<bool> Function($$LiturgyPartsTableFilterComposer f) f) {
    final $$LiturgyPartsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.liturgyParts,
        getReferencedColumn: (t) => t.sectionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LiturgyPartsTableFilterComposer(
              $db: $db,
              $table: $db.liturgyParts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LiturgySectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $LiturgySectionsTable> {
  $$LiturgySectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sectionOrder => $composableBuilder(
      column: $table.sectionOrder,
      builder: (column) => ColumnOrderings(column));

  $$LiturgiesTableOrderingComposer get liturgyId {
    final $$LiturgiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.liturgyId,
        referencedTable: $db.liturgies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LiturgiesTableOrderingComposer(
              $db: $db,
              $table: $db.liturgies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LiturgySectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LiturgySectionsTable> {
  $$LiturgySectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameAr =>
      $composableBuilder(column: $table.nameAr, builder: (column) => column);

  GeneratedColumn<int> get sectionOrder => $composableBuilder(
      column: $table.sectionOrder, builder: (column) => column);

  $$LiturgiesTableAnnotationComposer get liturgyId {
    final $$LiturgiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.liturgyId,
        referencedTable: $db.liturgies,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LiturgiesTableAnnotationComposer(
              $db: $db,
              $table: $db.liturgies,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> liturgyPartsRefs<T extends Object>(
      Expression<T> Function($$LiturgyPartsTableAnnotationComposer a) f) {
    final $$LiturgyPartsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.liturgyParts,
        getReferencedColumn: (t) => t.sectionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LiturgyPartsTableAnnotationComposer(
              $db: $db,
              $table: $db.liturgyParts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LiturgySectionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LiturgySectionsTable,
    LiturgySection,
    $$LiturgySectionsTableFilterComposer,
    $$LiturgySectionsTableOrderingComposer,
    $$LiturgySectionsTableAnnotationComposer,
    $$LiturgySectionsTableCreateCompanionBuilder,
    $$LiturgySectionsTableUpdateCompanionBuilder,
    (LiturgySection, $$LiturgySectionsTableReferences),
    LiturgySection,
    PrefetchHooks Function({bool liturgyId, bool liturgyPartsRefs})> {
  $$LiturgySectionsTableTableManager(
      _$AppDatabase db, $LiturgySectionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LiturgySectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LiturgySectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LiturgySectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> liturgyId = const Value.absent(),
            Value<String> nameAr = const Value.absent(),
            Value<int> sectionOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LiturgySectionsCompanion(
            id: id,
            liturgyId: liturgyId,
            nameAr: nameAr,
            sectionOrder: sectionOrder,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String liturgyId,
            required String nameAr,
            required int sectionOrder,
            Value<int> rowid = const Value.absent(),
          }) =>
              LiturgySectionsCompanion.insert(
            id: id,
            liturgyId: liturgyId,
            nameAr: nameAr,
            sectionOrder: sectionOrder,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$LiturgySectionsTable, LiturgySection>(table),
                    $$LiturgySectionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {liturgyId = false, liturgyPartsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (liturgyPartsRefs) db.liturgyParts],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (liturgyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.liturgyId,
                    referencedTable:
                        $$LiturgySectionsTableReferences._liturgyIdTable(db),
                    referencedColumn:
                        $$LiturgySectionsTableReferences._liturgyIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (liturgyPartsRefs)
                    await $_getPrefetchedData<LiturgySection,
                            $LiturgySectionsTable, LiturgyPart>(
                        currentTable: table,
                        referencedTable: $$LiturgySectionsTableReferences
                            ._liturgyPartsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LiturgySectionsTableReferences(db, table, p0)
                                .liturgyPartsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.sectionId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$LiturgySectionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LiturgySectionsTable,
    LiturgySection,
    $$LiturgySectionsTableFilterComposer,
    $$LiturgySectionsTableOrderingComposer,
    $$LiturgySectionsTableAnnotationComposer,
    $$LiturgySectionsTableCreateCompanionBuilder,
    $$LiturgySectionsTableUpdateCompanionBuilder,
    (LiturgySection, $$LiturgySectionsTableReferences),
    LiturgySection,
    PrefetchHooks Function({bool liturgyId, bool liturgyPartsRefs})>;
typedef $$LiturgyPartsTableCreateCompanionBuilder = LiturgyPartsCompanion
    Function({
  Value<int> id,
  required String sectionId,
  required int partOrder,
  required String role,
  required String type,
  required String textAr,
  Value<String?> textCoptic,
  Value<String?> textPhonetic,
  Value<String?> rubric,
  Value<bool> isSecret,
});
typedef $$LiturgyPartsTableUpdateCompanionBuilder = LiturgyPartsCompanion
    Function({
  Value<int> id,
  Value<String> sectionId,
  Value<int> partOrder,
  Value<String> role,
  Value<String> type,
  Value<String> textAr,
  Value<String?> textCoptic,
  Value<String?> textPhonetic,
  Value<String?> rubric,
  Value<bool> isSecret,
});

final class $$LiturgyPartsTableReferences
    extends BaseReferences<_$AppDatabase, $LiturgyPartsTable, LiturgyPart> {
  $$LiturgyPartsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LiturgySectionsTable _sectionIdTable(_$AppDatabase db) =>
      db.liturgySections
          .createAlias('liturgy_parts__section_id__liturgy_sections__id');

  $$LiturgySectionsTableProcessedTableManager get sectionId {
    final $_column = $_itemColumn<String>('section_id')!;

    final manager =
        $$LiturgySectionsTableTableManager($_db, $_db.liturgySections)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$LiturgyPartsTableFilterComposer
    extends Composer<_$AppDatabase, $LiturgyPartsTable> {
  $$LiturgyPartsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get partOrder => $composableBuilder(
      column: $table.partOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get textAr => $composableBuilder(
      column: $table.textAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get textCoptic => $composableBuilder(
      column: $table.textCoptic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get textPhonetic => $composableBuilder(
      column: $table.textPhonetic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rubric => $composableBuilder(
      column: $table.rubric, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSecret => $composableBuilder(
      column: $table.isSecret, builder: (column) => ColumnFilters(column));

  $$LiturgySectionsTableFilterComposer get sectionId {
    final $$LiturgySectionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sectionId,
        referencedTable: $db.liturgySections,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LiturgySectionsTableFilterComposer(
              $db: $db,
              $table: $db.liturgySections,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LiturgyPartsTableOrderingComposer
    extends Composer<_$AppDatabase, $LiturgyPartsTable> {
  $$LiturgyPartsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get partOrder => $composableBuilder(
      column: $table.partOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get textAr => $composableBuilder(
      column: $table.textAr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get textCoptic => $composableBuilder(
      column: $table.textCoptic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get textPhonetic => $composableBuilder(
      column: $table.textPhonetic,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rubric => $composableBuilder(
      column: $table.rubric, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSecret => $composableBuilder(
      column: $table.isSecret, builder: (column) => ColumnOrderings(column));

  $$LiturgySectionsTableOrderingComposer get sectionId {
    final $$LiturgySectionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sectionId,
        referencedTable: $db.liturgySections,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LiturgySectionsTableOrderingComposer(
              $db: $db,
              $table: $db.liturgySections,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LiturgyPartsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LiturgyPartsTable> {
  $$LiturgyPartsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get partOrder =>
      $composableBuilder(column: $table.partOrder, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get textAr =>
      $composableBuilder(column: $table.textAr, builder: (column) => column);

  GeneratedColumn<String> get textCoptic => $composableBuilder(
      column: $table.textCoptic, builder: (column) => column);

  GeneratedColumn<String> get textPhonetic => $composableBuilder(
      column: $table.textPhonetic, builder: (column) => column);

  GeneratedColumn<String> get rubric =>
      $composableBuilder(column: $table.rubric, builder: (column) => column);

  GeneratedColumn<bool> get isSecret =>
      $composableBuilder(column: $table.isSecret, builder: (column) => column);

  $$LiturgySectionsTableAnnotationComposer get sectionId {
    final $$LiturgySectionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sectionId,
        referencedTable: $db.liturgySections,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LiturgySectionsTableAnnotationComposer(
              $db: $db,
              $table: $db.liturgySections,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LiturgyPartsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LiturgyPartsTable,
    LiturgyPart,
    $$LiturgyPartsTableFilterComposer,
    $$LiturgyPartsTableOrderingComposer,
    $$LiturgyPartsTableAnnotationComposer,
    $$LiturgyPartsTableCreateCompanionBuilder,
    $$LiturgyPartsTableUpdateCompanionBuilder,
    (LiturgyPart, $$LiturgyPartsTableReferences),
    LiturgyPart,
    PrefetchHooks Function({bool sectionId})> {
  $$LiturgyPartsTableTableManager(_$AppDatabase db, $LiturgyPartsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LiturgyPartsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LiturgyPartsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LiturgyPartsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> sectionId = const Value.absent(),
            Value<int> partOrder = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> textAr = const Value.absent(),
            Value<String?> textCoptic = const Value.absent(),
            Value<String?> textPhonetic = const Value.absent(),
            Value<String?> rubric = const Value.absent(),
            Value<bool> isSecret = const Value.absent(),
          }) =>
              LiturgyPartsCompanion(
            id: id,
            sectionId: sectionId,
            partOrder: partOrder,
            role: role,
            type: type,
            textAr: textAr,
            textCoptic: textCoptic,
            textPhonetic: textPhonetic,
            rubric: rubric,
            isSecret: isSecret,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String sectionId,
            required int partOrder,
            required String role,
            required String type,
            required String textAr,
            Value<String?> textCoptic = const Value.absent(),
            Value<String?> textPhonetic = const Value.absent(),
            Value<String?> rubric = const Value.absent(),
            Value<bool> isSecret = const Value.absent(),
          }) =>
              LiturgyPartsCompanion.insert(
            id: id,
            sectionId: sectionId,
            partOrder: partOrder,
            role: role,
            type: type,
            textAr: textAr,
            textCoptic: textCoptic,
            textPhonetic: textPhonetic,
            rubric: rubric,
            isSecret: isSecret,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$LiturgyPartsTable, LiturgyPart>(table),
                    $$LiturgyPartsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({sectionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (sectionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.sectionId,
                    referencedTable:
                        $$LiturgyPartsTableReferences._sectionIdTable(db),
                    referencedColumn:
                        $$LiturgyPartsTableReferences._sectionIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$LiturgyPartsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LiturgyPartsTable,
    LiturgyPart,
    $$LiturgyPartsTableFilterComposer,
    $$LiturgyPartsTableOrderingComposer,
    $$LiturgyPartsTableAnnotationComposer,
    $$LiturgyPartsTableCreateCompanionBuilder,
    $$LiturgyPartsTableUpdateCompanionBuilder,
    (LiturgyPart, $$LiturgyPartsTableReferences),
    LiturgyPart,
    PrefetchHooks Function({bool sectionId})>;
typedef $$HymnBooksTableCreateCompanionBuilder = HymnBooksCompanion Function({
  required String id,
  required String nameAr,
  required int bookOrder,
  Value<int> rowid,
});
typedef $$HymnBooksTableUpdateCompanionBuilder = HymnBooksCompanion Function({
  Value<String> id,
  Value<String> nameAr,
  Value<int> bookOrder,
  Value<int> rowid,
});

final class $$HymnBooksTableReferences
    extends BaseReferences<_$AppDatabase, $HymnBooksTable, HymnBook> {
  $$HymnBooksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$HymnsTable, List<Hymn>> _hymnsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.hymns,
          aliasName: 'hymn_books__id__hymns__book_id');

  $$HymnsTableProcessedTableManager get hymnsRefs {
    final manager = $$HymnsTableTableManager($_db, $_db.hymns)
        .filter((f) => f.bookId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_hymnsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$HymnBooksTableFilterComposer
    extends Composer<_$AppDatabase, $HymnBooksTable> {
  $$HymnBooksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get bookOrder => $composableBuilder(
      column: $table.bookOrder, builder: (column) => ColumnFilters(column));

  Expression<bool> hymnsRefs(
      Expression<bool> Function($$HymnsTableFilterComposer f) f) {
    final $$HymnsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.hymns,
        getReferencedColumn: (t) => t.bookId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HymnsTableFilterComposer(
              $db: $db,
              $table: $db.hymns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$HymnBooksTableOrderingComposer
    extends Composer<_$AppDatabase, $HymnBooksTable> {
  $$HymnBooksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get bookOrder => $composableBuilder(
      column: $table.bookOrder, builder: (column) => ColumnOrderings(column));
}

class $$HymnBooksTableAnnotationComposer
    extends Composer<_$AppDatabase, $HymnBooksTable> {
  $$HymnBooksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameAr =>
      $composableBuilder(column: $table.nameAr, builder: (column) => column);

  GeneratedColumn<int> get bookOrder =>
      $composableBuilder(column: $table.bookOrder, builder: (column) => column);

  Expression<T> hymnsRefs<T extends Object>(
      Expression<T> Function($$HymnsTableAnnotationComposer a) f) {
    final $$HymnsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.hymns,
        getReferencedColumn: (t) => t.bookId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HymnsTableAnnotationComposer(
              $db: $db,
              $table: $db.hymns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$HymnBooksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HymnBooksTable,
    HymnBook,
    $$HymnBooksTableFilterComposer,
    $$HymnBooksTableOrderingComposer,
    $$HymnBooksTableAnnotationComposer,
    $$HymnBooksTableCreateCompanionBuilder,
    $$HymnBooksTableUpdateCompanionBuilder,
    (HymnBook, $$HymnBooksTableReferences),
    HymnBook,
    PrefetchHooks Function({bool hymnsRefs})> {
  $$HymnBooksTableTableManager(_$AppDatabase db, $HymnBooksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HymnBooksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HymnBooksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HymnBooksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> nameAr = const Value.absent(),
            Value<int> bookOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HymnBooksCompanion(
            id: id,
            nameAr: nameAr,
            bookOrder: bookOrder,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String nameAr,
            required int bookOrder,
            Value<int> rowid = const Value.absent(),
          }) =>
              HymnBooksCompanion.insert(
            id: id,
            nameAr: nameAr,
            bookOrder: bookOrder,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$HymnBooksTable, HymnBook>(table),
                    $$HymnBooksTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({hymnsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (hymnsRefs) db.hymns],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (hymnsRefs)
                    await $_getPrefetchedData<HymnBook, $HymnBooksTable, Hymn>(
                        currentTable: table,
                        referencedTable:
                            $$HymnBooksTableReferences._hymnsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$HymnBooksTableReferences(db, table, p0).hymnsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.bookId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$HymnBooksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HymnBooksTable,
    HymnBook,
    $$HymnBooksTableFilterComposer,
    $$HymnBooksTableOrderingComposer,
    $$HymnBooksTableAnnotationComposer,
    $$HymnBooksTableCreateCompanionBuilder,
    $$HymnBooksTableUpdateCompanionBuilder,
    (HymnBook, $$HymnBooksTableReferences),
    HymnBook,
    PrefetchHooks Function({bool hymnsRefs})>;
typedef $$HymnsTableCreateCompanionBuilder = HymnsCompanion Function({
  required String id,
  required String bookId,
  required String nameAr,
  Value<String?> nameCoptic,
  required String occasion,
  required String tone,
  required int hymnOrder,
  Value<int> rowid,
});
typedef $$HymnsTableUpdateCompanionBuilder = HymnsCompanion Function({
  Value<String> id,
  Value<String> bookId,
  Value<String> nameAr,
  Value<String?> nameCoptic,
  Value<String> occasion,
  Value<String> tone,
  Value<int> hymnOrder,
  Value<int> rowid,
});

final class $$HymnsTableReferences
    extends BaseReferences<_$AppDatabase, $HymnsTable, Hymn> {
  $$HymnsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HymnBooksTable _bookIdTable(_$AppDatabase db) =>
      db.hymnBooks.createAlias('hymns__book_id__hymn_books__id');

  $$HymnBooksTableProcessedTableManager get bookId {
    final $_column = $_itemColumn<String>('book_id')!;

    final manager = $$HymnBooksTableTableManager($_db, $_db.hymnBooks)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$HymnSegmentsTable, List<HymnSegment>>
      _hymnSegmentsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.hymnSegments,
              aliasName: 'hymns__id__hymn_segments__hymn_id');

  $$HymnSegmentsTableProcessedTableManager get hymnSegmentsRefs {
    final manager = $$HymnSegmentsTableTableManager($_db, $_db.hymnSegments)
        .filter((f) => f.hymnId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_hymnSegmentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$HymnsTableFilterComposer extends Composer<_$AppDatabase, $HymnsTable> {
  $$HymnsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameCoptic => $composableBuilder(
      column: $table.nameCoptic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get occasion => $composableBuilder(
      column: $table.occasion, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tone => $composableBuilder(
      column: $table.tone, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get hymnOrder => $composableBuilder(
      column: $table.hymnOrder, builder: (column) => ColumnFilters(column));

  $$HymnBooksTableFilterComposer get bookId {
    final $$HymnBooksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.hymnBooks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HymnBooksTableFilterComposer(
              $db: $db,
              $table: $db.hymnBooks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> hymnSegmentsRefs(
      Expression<bool> Function($$HymnSegmentsTableFilterComposer f) f) {
    final $$HymnSegmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.hymnSegments,
        getReferencedColumn: (t) => t.hymnId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HymnSegmentsTableFilterComposer(
              $db: $db,
              $table: $db.hymnSegments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$HymnsTableOrderingComposer
    extends Composer<_$AppDatabase, $HymnsTable> {
  $$HymnsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameCoptic => $composableBuilder(
      column: $table.nameCoptic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get occasion => $composableBuilder(
      column: $table.occasion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tone => $composableBuilder(
      column: $table.tone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get hymnOrder => $composableBuilder(
      column: $table.hymnOrder, builder: (column) => ColumnOrderings(column));

  $$HymnBooksTableOrderingComposer get bookId {
    final $$HymnBooksTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.hymnBooks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HymnBooksTableOrderingComposer(
              $db: $db,
              $table: $db.hymnBooks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$HymnsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HymnsTable> {
  $$HymnsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameAr =>
      $composableBuilder(column: $table.nameAr, builder: (column) => column);

  GeneratedColumn<String> get nameCoptic => $composableBuilder(
      column: $table.nameCoptic, builder: (column) => column);

  GeneratedColumn<String> get occasion =>
      $composableBuilder(column: $table.occasion, builder: (column) => column);

  GeneratedColumn<String> get tone =>
      $composableBuilder(column: $table.tone, builder: (column) => column);

  GeneratedColumn<int> get hymnOrder =>
      $composableBuilder(column: $table.hymnOrder, builder: (column) => column);

  $$HymnBooksTableAnnotationComposer get bookId {
    final $$HymnBooksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bookId,
        referencedTable: $db.hymnBooks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HymnBooksTableAnnotationComposer(
              $db: $db,
              $table: $db.hymnBooks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> hymnSegmentsRefs<T extends Object>(
      Expression<T> Function($$HymnSegmentsTableAnnotationComposer a) f) {
    final $$HymnSegmentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.hymnSegments,
        getReferencedColumn: (t) => t.hymnId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HymnSegmentsTableAnnotationComposer(
              $db: $db,
              $table: $db.hymnSegments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$HymnsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HymnsTable,
    Hymn,
    $$HymnsTableFilterComposer,
    $$HymnsTableOrderingComposer,
    $$HymnsTableAnnotationComposer,
    $$HymnsTableCreateCompanionBuilder,
    $$HymnsTableUpdateCompanionBuilder,
    (Hymn, $$HymnsTableReferences),
    Hymn,
    PrefetchHooks Function({bool bookId, bool hymnSegmentsRefs})> {
  $$HymnsTableTableManager(_$AppDatabase db, $HymnsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HymnsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HymnsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HymnsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> bookId = const Value.absent(),
            Value<String> nameAr = const Value.absent(),
            Value<String?> nameCoptic = const Value.absent(),
            Value<String> occasion = const Value.absent(),
            Value<String> tone = const Value.absent(),
            Value<int> hymnOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HymnsCompanion(
            id: id,
            bookId: bookId,
            nameAr: nameAr,
            nameCoptic: nameCoptic,
            occasion: occasion,
            tone: tone,
            hymnOrder: hymnOrder,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String bookId,
            required String nameAr,
            Value<String?> nameCoptic = const Value.absent(),
            required String occasion,
            required String tone,
            required int hymnOrder,
            Value<int> rowid = const Value.absent(),
          }) =>
              HymnsCompanion.insert(
            id: id,
            bookId: bookId,
            nameAr: nameAr,
            nameCoptic: nameCoptic,
            occasion: occasion,
            tone: tone,
            hymnOrder: hymnOrder,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$HymnsTable, Hymn>(table),
                    $$HymnsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({bookId = false, hymnSegmentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (hymnSegmentsRefs) db.hymnSegments],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (bookId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bookId,
                    referencedTable: $$HymnsTableReferences._bookIdTable(db),
                    referencedColumn:
                        $$HymnsTableReferences._bookIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (hymnSegmentsRefs)
                    await $_getPrefetchedData<Hymn, $HymnsTable, HymnSegment>(
                        currentTable: table,
                        referencedTable:
                            $$HymnsTableReferences._hymnSegmentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$HymnsTableReferences(db, table, p0)
                                .hymnSegmentsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.hymnId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$HymnsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HymnsTable,
    Hymn,
    $$HymnsTableFilterComposer,
    $$HymnsTableOrderingComposer,
    $$HymnsTableAnnotationComposer,
    $$HymnsTableCreateCompanionBuilder,
    $$HymnsTableUpdateCompanionBuilder,
    (Hymn, $$HymnsTableReferences),
    Hymn,
    PrefetchHooks Function({bool bookId, bool hymnSegmentsRefs})>;
typedef $$HymnSegmentsTableCreateCompanionBuilder = HymnSegmentsCompanion
    Function({
  Value<int> id,
  required String hymnId,
  required int segmentOrder,
  required int lineNumber,
  required String coptic,
  required String phonetic,
  required String arabic,
  Value<String?> syllablesJson,
});
typedef $$HymnSegmentsTableUpdateCompanionBuilder = HymnSegmentsCompanion
    Function({
  Value<int> id,
  Value<String> hymnId,
  Value<int> segmentOrder,
  Value<int> lineNumber,
  Value<String> coptic,
  Value<String> phonetic,
  Value<String> arabic,
  Value<String?> syllablesJson,
});

final class $$HymnSegmentsTableReferences
    extends BaseReferences<_$AppDatabase, $HymnSegmentsTable, HymnSegment> {
  $$HymnSegmentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HymnsTable _hymnIdTable(_$AppDatabase db) =>
      db.hymns.createAlias('hymn_segments__hymn_id__hymns__id');

  $$HymnsTableProcessedTableManager get hymnId {
    final $_column = $_itemColumn<String>('hymn_id')!;

    final manager = $$HymnsTableTableManager($_db, $_db.hymns)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_hymnIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$HymnSegmentsTableFilterComposer
    extends Composer<_$AppDatabase, $HymnSegmentsTable> {
  $$HymnSegmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get segmentOrder => $composableBuilder(
      column: $table.segmentOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lineNumber => $composableBuilder(
      column: $table.lineNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get coptic => $composableBuilder(
      column: $table.coptic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phonetic => $composableBuilder(
      column: $table.phonetic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get arabic => $composableBuilder(
      column: $table.arabic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syllablesJson => $composableBuilder(
      column: $table.syllablesJson, builder: (column) => ColumnFilters(column));

  $$HymnsTableFilterComposer get hymnId {
    final $$HymnsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.hymnId,
        referencedTable: $db.hymns,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HymnsTableFilterComposer(
              $db: $db,
              $table: $db.hymns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$HymnSegmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $HymnSegmentsTable> {
  $$HymnSegmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get segmentOrder => $composableBuilder(
      column: $table.segmentOrder,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lineNumber => $composableBuilder(
      column: $table.lineNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get coptic => $composableBuilder(
      column: $table.coptic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phonetic => $composableBuilder(
      column: $table.phonetic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get arabic => $composableBuilder(
      column: $table.arabic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syllablesJson => $composableBuilder(
      column: $table.syllablesJson,
      builder: (column) => ColumnOrderings(column));

  $$HymnsTableOrderingComposer get hymnId {
    final $$HymnsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.hymnId,
        referencedTable: $db.hymns,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HymnsTableOrderingComposer(
              $db: $db,
              $table: $db.hymns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$HymnSegmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HymnSegmentsTable> {
  $$HymnSegmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get segmentOrder => $composableBuilder(
      column: $table.segmentOrder, builder: (column) => column);

  GeneratedColumn<int> get lineNumber => $composableBuilder(
      column: $table.lineNumber, builder: (column) => column);

  GeneratedColumn<String> get coptic =>
      $composableBuilder(column: $table.coptic, builder: (column) => column);

  GeneratedColumn<String> get phonetic =>
      $composableBuilder(column: $table.phonetic, builder: (column) => column);

  GeneratedColumn<String> get arabic =>
      $composableBuilder(column: $table.arabic, builder: (column) => column);

  GeneratedColumn<String> get syllablesJson => $composableBuilder(
      column: $table.syllablesJson, builder: (column) => column);

  $$HymnsTableAnnotationComposer get hymnId {
    final $$HymnsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.hymnId,
        referencedTable: $db.hymns,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HymnsTableAnnotationComposer(
              $db: $db,
              $table: $db.hymns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$HymnSegmentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HymnSegmentsTable,
    HymnSegment,
    $$HymnSegmentsTableFilterComposer,
    $$HymnSegmentsTableOrderingComposer,
    $$HymnSegmentsTableAnnotationComposer,
    $$HymnSegmentsTableCreateCompanionBuilder,
    $$HymnSegmentsTableUpdateCompanionBuilder,
    (HymnSegment, $$HymnSegmentsTableReferences),
    HymnSegment,
    PrefetchHooks Function({bool hymnId})> {
  $$HymnSegmentsTableTableManager(_$AppDatabase db, $HymnSegmentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HymnSegmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HymnSegmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HymnSegmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> hymnId = const Value.absent(),
            Value<int> segmentOrder = const Value.absent(),
            Value<int> lineNumber = const Value.absent(),
            Value<String> coptic = const Value.absent(),
            Value<String> phonetic = const Value.absent(),
            Value<String> arabic = const Value.absent(),
            Value<String?> syllablesJson = const Value.absent(),
          }) =>
              HymnSegmentsCompanion(
            id: id,
            hymnId: hymnId,
            segmentOrder: segmentOrder,
            lineNumber: lineNumber,
            coptic: coptic,
            phonetic: phonetic,
            arabic: arabic,
            syllablesJson: syllablesJson,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String hymnId,
            required int segmentOrder,
            required int lineNumber,
            required String coptic,
            required String phonetic,
            required String arabic,
            Value<String?> syllablesJson = const Value.absent(),
          }) =>
              HymnSegmentsCompanion.insert(
            id: id,
            hymnId: hymnId,
            segmentOrder: segmentOrder,
            lineNumber: lineNumber,
            coptic: coptic,
            phonetic: phonetic,
            arabic: arabic,
            syllablesJson: syllablesJson,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$HymnSegmentsTable, HymnSegment>(table),
                    $$HymnSegmentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({hymnId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (hymnId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.hymnId,
                    referencedTable:
                        $$HymnSegmentsTableReferences._hymnIdTable(db),
                    referencedColumn:
                        $$HymnSegmentsTableReferences._hymnIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$HymnSegmentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HymnSegmentsTable,
    HymnSegment,
    $$HymnSegmentsTableFilterComposer,
    $$HymnSegmentsTableOrderingComposer,
    $$HymnSegmentsTableAnnotationComposer,
    $$HymnSegmentsTableCreateCompanionBuilder,
    $$HymnSegmentsTableUpdateCompanionBuilder,
    (HymnSegment, $$HymnSegmentsTableReferences),
    HymnSegment,
    PrefetchHooks Function({bool hymnId})>;
typedef $$SynaxariumEntriesTableCreateCompanionBuilder
    = SynaxariumEntriesCompanion Function({
  required String id,
  required int copticMonth,
  required int copticDay,
  required int entryOrder,
  required String title,
  required String type,
  required String shortText,
  required String fullText,
  Value<int> rowid,
});
typedef $$SynaxariumEntriesTableUpdateCompanionBuilder
    = SynaxariumEntriesCompanion Function({
  Value<String> id,
  Value<int> copticMonth,
  Value<int> copticDay,
  Value<int> entryOrder,
  Value<String> title,
  Value<String> type,
  Value<String> shortText,
  Value<String> fullText,
  Value<int> rowid,
});

class $$SynaxariumEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $SynaxariumEntriesTable> {
  $$SynaxariumEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get copticMonth => $composableBuilder(
      column: $table.copticMonth, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get copticDay => $composableBuilder(
      column: $table.copticDay, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get entryOrder => $composableBuilder(
      column: $table.entryOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get shortText => $composableBuilder(
      column: $table.shortText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fullText => $composableBuilder(
      column: $table.fullText, builder: (column) => ColumnFilters(column));
}

class $$SynaxariumEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SynaxariumEntriesTable> {
  $$SynaxariumEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get copticMonth => $composableBuilder(
      column: $table.copticMonth, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get copticDay => $composableBuilder(
      column: $table.copticDay, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get entryOrder => $composableBuilder(
      column: $table.entryOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get shortText => $composableBuilder(
      column: $table.shortText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fullText => $composableBuilder(
      column: $table.fullText, builder: (column) => ColumnOrderings(column));
}

class $$SynaxariumEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SynaxariumEntriesTable> {
  $$SynaxariumEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get copticMonth => $composableBuilder(
      column: $table.copticMonth, builder: (column) => column);

  GeneratedColumn<int> get copticDay =>
      $composableBuilder(column: $table.copticDay, builder: (column) => column);

  GeneratedColumn<int> get entryOrder => $composableBuilder(
      column: $table.entryOrder, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get shortText =>
      $composableBuilder(column: $table.shortText, builder: (column) => column);

  GeneratedColumn<String> get fullText =>
      $composableBuilder(column: $table.fullText, builder: (column) => column);
}

class $$SynaxariumEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SynaxariumEntriesTable,
    SynaxariumEntry,
    $$SynaxariumEntriesTableFilterComposer,
    $$SynaxariumEntriesTableOrderingComposer,
    $$SynaxariumEntriesTableAnnotationComposer,
    $$SynaxariumEntriesTableCreateCompanionBuilder,
    $$SynaxariumEntriesTableUpdateCompanionBuilder,
    (
      SynaxariumEntry,
      BaseReferences<_$AppDatabase, $SynaxariumEntriesTable, SynaxariumEntry>
    ),
    SynaxariumEntry,
    PrefetchHooks Function()> {
  $$SynaxariumEntriesTableTableManager(
      _$AppDatabase db, $SynaxariumEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SynaxariumEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SynaxariumEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SynaxariumEntriesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<int> copticMonth = const Value.absent(),
            Value<int> copticDay = const Value.absent(),
            Value<int> entryOrder = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> shortText = const Value.absent(),
            Value<String> fullText = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SynaxariumEntriesCompanion(
            id: id,
            copticMonth: copticMonth,
            copticDay: copticDay,
            entryOrder: entryOrder,
            title: title,
            type: type,
            shortText: shortText,
            fullText: fullText,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required int copticMonth,
            required int copticDay,
            required int entryOrder,
            required String title,
            required String type,
            required String shortText,
            required String fullText,
            Value<int> rowid = const Value.absent(),
          }) =>
              SynaxariumEntriesCompanion.insert(
            id: id,
            copticMonth: copticMonth,
            copticDay: copticDay,
            entryOrder: entryOrder,
            title: title,
            type: type,
            shortText: shortText,
            fullText: fullText,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$SynaxariumEntriesTable, SynaxariumEntry>(
                        table),
                    BaseReferences<_$AppDatabase, $SynaxariumEntriesTable,
                        SynaxariumEntry>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SynaxariumEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SynaxariumEntriesTable,
    SynaxariumEntry,
    $$SynaxariumEntriesTableFilterComposer,
    $$SynaxariumEntriesTableOrderingComposer,
    $$SynaxariumEntriesTableAnnotationComposer,
    $$SynaxariumEntriesTableCreateCompanionBuilder,
    $$SynaxariumEntriesTableUpdateCompanionBuilder,
    (
      SynaxariumEntry,
      BaseReferences<_$AppDatabase, $SynaxariumEntriesTable, SynaxariumEntry>
    ),
    SynaxariumEntry,
    PrefetchHooks Function()>;
typedef $$KatamerosReadingsTableCreateCompanionBuilder
    = KatamerosReadingsCompanion Function({
  Value<int> id,
  required int copticMonth,
  required int copticDay,
  required String periodType,
  required String rite,
  required String serviceType,
  required String readingType,
  required String reference,
  required String content,
  Value<String?> synaxariumId,
});
typedef $$KatamerosReadingsTableUpdateCompanionBuilder
    = KatamerosReadingsCompanion Function({
  Value<int> id,
  Value<int> copticMonth,
  Value<int> copticDay,
  Value<String> periodType,
  Value<String> rite,
  Value<String> serviceType,
  Value<String> readingType,
  Value<String> reference,
  Value<String> content,
  Value<String?> synaxariumId,
});

class $$KatamerosReadingsTableFilterComposer
    extends Composer<_$AppDatabase, $KatamerosReadingsTable> {
  $$KatamerosReadingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get copticMonth => $composableBuilder(
      column: $table.copticMonth, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get copticDay => $composableBuilder(
      column: $table.copticDay, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get periodType => $composableBuilder(
      column: $table.periodType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rite => $composableBuilder(
      column: $table.rite, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get serviceType => $composableBuilder(
      column: $table.serviceType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get readingType => $composableBuilder(
      column: $table.readingType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reference => $composableBuilder(
      column: $table.reference, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get synaxariumId => $composableBuilder(
      column: $table.synaxariumId, builder: (column) => ColumnFilters(column));
}

class $$KatamerosReadingsTableOrderingComposer
    extends Composer<_$AppDatabase, $KatamerosReadingsTable> {
  $$KatamerosReadingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get copticMonth => $composableBuilder(
      column: $table.copticMonth, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get copticDay => $composableBuilder(
      column: $table.copticDay, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get periodType => $composableBuilder(
      column: $table.periodType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rite => $composableBuilder(
      column: $table.rite, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get serviceType => $composableBuilder(
      column: $table.serviceType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get readingType => $composableBuilder(
      column: $table.readingType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reference => $composableBuilder(
      column: $table.reference, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get synaxariumId => $composableBuilder(
      column: $table.synaxariumId,
      builder: (column) => ColumnOrderings(column));
}

class $$KatamerosReadingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $KatamerosReadingsTable> {
  $$KatamerosReadingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get copticMonth => $composableBuilder(
      column: $table.copticMonth, builder: (column) => column);

  GeneratedColumn<int> get copticDay =>
      $composableBuilder(column: $table.copticDay, builder: (column) => column);

  GeneratedColumn<String> get periodType => $composableBuilder(
      column: $table.periodType, builder: (column) => column);

  GeneratedColumn<String> get rite =>
      $composableBuilder(column: $table.rite, builder: (column) => column);

  GeneratedColumn<String> get serviceType => $composableBuilder(
      column: $table.serviceType, builder: (column) => column);

  GeneratedColumn<String> get readingType => $composableBuilder(
      column: $table.readingType, builder: (column) => column);

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get synaxariumId => $composableBuilder(
      column: $table.synaxariumId, builder: (column) => column);
}

class $$KatamerosReadingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $KatamerosReadingsTable,
    KatamerosReading,
    $$KatamerosReadingsTableFilterComposer,
    $$KatamerosReadingsTableOrderingComposer,
    $$KatamerosReadingsTableAnnotationComposer,
    $$KatamerosReadingsTableCreateCompanionBuilder,
    $$KatamerosReadingsTableUpdateCompanionBuilder,
    (
      KatamerosReading,
      BaseReferences<_$AppDatabase, $KatamerosReadingsTable, KatamerosReading>
    ),
    KatamerosReading,
    PrefetchHooks Function()> {
  $$KatamerosReadingsTableTableManager(
      _$AppDatabase db, $KatamerosReadingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KatamerosReadingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KatamerosReadingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KatamerosReadingsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> copticMonth = const Value.absent(),
            Value<int> copticDay = const Value.absent(),
            Value<String> periodType = const Value.absent(),
            Value<String> rite = const Value.absent(),
            Value<String> serviceType = const Value.absent(),
            Value<String> readingType = const Value.absent(),
            Value<String> reference = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String?> synaxariumId = const Value.absent(),
          }) =>
              KatamerosReadingsCompanion(
            id: id,
            copticMonth: copticMonth,
            copticDay: copticDay,
            periodType: periodType,
            rite: rite,
            serviceType: serviceType,
            readingType: readingType,
            reference: reference,
            content: content,
            synaxariumId: synaxariumId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int copticMonth,
            required int copticDay,
            required String periodType,
            required String rite,
            required String serviceType,
            required String readingType,
            required String reference,
            required String content,
            Value<String?> synaxariumId = const Value.absent(),
          }) =>
              KatamerosReadingsCompanion.insert(
            id: id,
            copticMonth: copticMonth,
            copticDay: copticDay,
            periodType: periodType,
            rite: rite,
            serviceType: serviceType,
            readingType: readingType,
            reference: reference,
            content: content,
            synaxariumId: synaxariumId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$KatamerosReadingsTable, KatamerosReading>(
                        table),
                    BaseReferences<_$AppDatabase, $KatamerosReadingsTable,
                        KatamerosReading>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$KatamerosReadingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $KatamerosReadingsTable,
    KatamerosReading,
    $$KatamerosReadingsTableFilterComposer,
    $$KatamerosReadingsTableOrderingComposer,
    $$KatamerosReadingsTableAnnotationComposer,
    $$KatamerosReadingsTableCreateCompanionBuilder,
    $$KatamerosReadingsTableUpdateCompanionBuilder,
    (
      KatamerosReading,
      BaseReferences<_$AppDatabase, $KatamerosReadingsTable, KatamerosReading>
    ),
    KatamerosReading,
    PrefetchHooks Function()>;
typedef $$SaintsTableCreateCompanionBuilder = SaintsCompanion Function({
  required String id,
  required String nameAr,
  Value<String?> nameCoptic,
  Value<String?> nameEn,
  required String type,
  Value<int?> feastMonth,
  Value<int?> feastDay,
  required String biography,
  required String shortBio,
  Value<int> rowid,
});
typedef $$SaintsTableUpdateCompanionBuilder = SaintsCompanion Function({
  Value<String> id,
  Value<String> nameAr,
  Value<String?> nameCoptic,
  Value<String?> nameEn,
  Value<String> type,
  Value<int?> feastMonth,
  Value<int?> feastDay,
  Value<String> biography,
  Value<String> shortBio,
  Value<int> rowid,
});

class $$SaintsTableFilterComposer
    extends Composer<_$AppDatabase, $SaintsTable> {
  $$SaintsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameCoptic => $composableBuilder(
      column: $table.nameCoptic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get feastMonth => $composableBuilder(
      column: $table.feastMonth, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get feastDay => $composableBuilder(
      column: $table.feastDay, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get biography => $composableBuilder(
      column: $table.biography, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get shortBio => $composableBuilder(
      column: $table.shortBio, builder: (column) => ColumnFilters(column));
}

class $$SaintsTableOrderingComposer
    extends Composer<_$AppDatabase, $SaintsTable> {
  $$SaintsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameCoptic => $composableBuilder(
      column: $table.nameCoptic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get feastMonth => $composableBuilder(
      column: $table.feastMonth, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get feastDay => $composableBuilder(
      column: $table.feastDay, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get biography => $composableBuilder(
      column: $table.biography, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get shortBio => $composableBuilder(
      column: $table.shortBio, builder: (column) => ColumnOrderings(column));
}

class $$SaintsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SaintsTable> {
  $$SaintsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameAr =>
      $composableBuilder(column: $table.nameAr, builder: (column) => column);

  GeneratedColumn<String> get nameCoptic => $composableBuilder(
      column: $table.nameCoptic, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get feastMonth => $composableBuilder(
      column: $table.feastMonth, builder: (column) => column);

  GeneratedColumn<int> get feastDay =>
      $composableBuilder(column: $table.feastDay, builder: (column) => column);

  GeneratedColumn<String> get biography =>
      $composableBuilder(column: $table.biography, builder: (column) => column);

  GeneratedColumn<String> get shortBio =>
      $composableBuilder(column: $table.shortBio, builder: (column) => column);
}

class $$SaintsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SaintsTable,
    Saint,
    $$SaintsTableFilterComposer,
    $$SaintsTableOrderingComposer,
    $$SaintsTableAnnotationComposer,
    $$SaintsTableCreateCompanionBuilder,
    $$SaintsTableUpdateCompanionBuilder,
    (Saint, BaseReferences<_$AppDatabase, $SaintsTable, Saint>),
    Saint,
    PrefetchHooks Function()> {
  $$SaintsTableTableManager(_$AppDatabase db, $SaintsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SaintsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SaintsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SaintsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> nameAr = const Value.absent(),
            Value<String?> nameCoptic = const Value.absent(),
            Value<String?> nameEn = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<int?> feastMonth = const Value.absent(),
            Value<int?> feastDay = const Value.absent(),
            Value<String> biography = const Value.absent(),
            Value<String> shortBio = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SaintsCompanion(
            id: id,
            nameAr: nameAr,
            nameCoptic: nameCoptic,
            nameEn: nameEn,
            type: type,
            feastMonth: feastMonth,
            feastDay: feastDay,
            biography: biography,
            shortBio: shortBio,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String nameAr,
            Value<String?> nameCoptic = const Value.absent(),
            Value<String?> nameEn = const Value.absent(),
            required String type,
            Value<int?> feastMonth = const Value.absent(),
            Value<int?> feastDay = const Value.absent(),
            required String biography,
            required String shortBio,
            Value<int> rowid = const Value.absent(),
          }) =>
              SaintsCompanion.insert(
            id: id,
            nameAr: nameAr,
            nameCoptic: nameCoptic,
            nameEn: nameEn,
            type: type,
            feastMonth: feastMonth,
            feastDay: feastDay,
            biography: biography,
            shortBio: shortBio,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$SaintsTable, Saint>(table),
                    BaseReferences<_$AppDatabase, $SaintsTable, Saint>(
                        db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SaintsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SaintsTable,
    Saint,
    $$SaintsTableFilterComposer,
    $$SaintsTableOrderingComposer,
    $$SaintsTableAnnotationComposer,
    $$SaintsTableCreateCompanionBuilder,
    $$SaintsTableUpdateCompanionBuilder,
    (Saint, BaseReferences<_$AppDatabase, $SaintsTable, Saint>),
    Saint,
    PrefetchHooks Function()>;
typedef $$DifnarEntriesTableCreateCompanionBuilder = DifnarEntriesCompanion
    Function({
  required String id,
  required int copticMonth,
  required int copticDay,
  required String textCoptic,
  required String textPhonetic,
  required String textAr,
  Value<int> rowid,
});
typedef $$DifnarEntriesTableUpdateCompanionBuilder = DifnarEntriesCompanion
    Function({
  Value<String> id,
  Value<int> copticMonth,
  Value<int> copticDay,
  Value<String> textCoptic,
  Value<String> textPhonetic,
  Value<String> textAr,
  Value<int> rowid,
});

class $$DifnarEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $DifnarEntriesTable> {
  $$DifnarEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get copticMonth => $composableBuilder(
      column: $table.copticMonth, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get copticDay => $composableBuilder(
      column: $table.copticDay, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get textCoptic => $composableBuilder(
      column: $table.textCoptic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get textPhonetic => $composableBuilder(
      column: $table.textPhonetic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get textAr => $composableBuilder(
      column: $table.textAr, builder: (column) => ColumnFilters(column));
}

class $$DifnarEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $DifnarEntriesTable> {
  $$DifnarEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get copticMonth => $composableBuilder(
      column: $table.copticMonth, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get copticDay => $composableBuilder(
      column: $table.copticDay, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get textCoptic => $composableBuilder(
      column: $table.textCoptic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get textPhonetic => $composableBuilder(
      column: $table.textPhonetic,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get textAr => $composableBuilder(
      column: $table.textAr, builder: (column) => ColumnOrderings(column));
}

class $$DifnarEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DifnarEntriesTable> {
  $$DifnarEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get copticMonth => $composableBuilder(
      column: $table.copticMonth, builder: (column) => column);

  GeneratedColumn<int> get copticDay =>
      $composableBuilder(column: $table.copticDay, builder: (column) => column);

  GeneratedColumn<String> get textCoptic => $composableBuilder(
      column: $table.textCoptic, builder: (column) => column);

  GeneratedColumn<String> get textPhonetic => $composableBuilder(
      column: $table.textPhonetic, builder: (column) => column);

  GeneratedColumn<String> get textAr =>
      $composableBuilder(column: $table.textAr, builder: (column) => column);
}

class $$DifnarEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DifnarEntriesTable,
    DifnarEntry,
    $$DifnarEntriesTableFilterComposer,
    $$DifnarEntriesTableOrderingComposer,
    $$DifnarEntriesTableAnnotationComposer,
    $$DifnarEntriesTableCreateCompanionBuilder,
    $$DifnarEntriesTableUpdateCompanionBuilder,
    (
      DifnarEntry,
      BaseReferences<_$AppDatabase, $DifnarEntriesTable, DifnarEntry>
    ),
    DifnarEntry,
    PrefetchHooks Function()> {
  $$DifnarEntriesTableTableManager(_$AppDatabase db, $DifnarEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DifnarEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DifnarEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DifnarEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<int> copticMonth = const Value.absent(),
            Value<int> copticDay = const Value.absent(),
            Value<String> textCoptic = const Value.absent(),
            Value<String> textPhonetic = const Value.absent(),
            Value<String> textAr = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DifnarEntriesCompanion(
            id: id,
            copticMonth: copticMonth,
            copticDay: copticDay,
            textCoptic: textCoptic,
            textPhonetic: textPhonetic,
            textAr: textAr,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required int copticMonth,
            required int copticDay,
            required String textCoptic,
            required String textPhonetic,
            required String textAr,
            Value<int> rowid = const Value.absent(),
          }) =>
              DifnarEntriesCompanion.insert(
            id: id,
            copticMonth: copticMonth,
            copticDay: copticDay,
            textCoptic: textCoptic,
            textPhonetic: textPhonetic,
            textAr: textAr,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$DifnarEntriesTable, DifnarEntry>(table),
                    BaseReferences<_$AppDatabase, $DifnarEntriesTable,
                        DifnarEntry>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DifnarEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DifnarEntriesTable,
    DifnarEntry,
    $$DifnarEntriesTableFilterComposer,
    $$DifnarEntriesTableOrderingComposer,
    $$DifnarEntriesTableAnnotationComposer,
    $$DifnarEntriesTableCreateCompanionBuilder,
    $$DifnarEntriesTableUpdateCompanionBuilder,
    (
      DifnarEntry,
      BaseReferences<_$AppDatabase, $DifnarEntriesTable, DifnarEntry>
    ),
    DifnarEntry,
    PrefetchHooks Function()>;
typedef $$PaschaReadingsTableCreateCompanionBuilder = PaschaReadingsCompanion
    Function({
  Value<int> id,
  required String dayId,
  required String dayNameAr,
  required int hourNumber,
  required String hourNameAr,
  required String readingType,
  Value<String?> reference,
  required String content,
  required int readingOrder,
});
typedef $$PaschaReadingsTableUpdateCompanionBuilder = PaschaReadingsCompanion
    Function({
  Value<int> id,
  Value<String> dayId,
  Value<String> dayNameAr,
  Value<int> hourNumber,
  Value<String> hourNameAr,
  Value<String> readingType,
  Value<String?> reference,
  Value<String> content,
  Value<int> readingOrder,
});

class $$PaschaReadingsTableFilterComposer
    extends Composer<_$AppDatabase, $PaschaReadingsTable> {
  $$PaschaReadingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dayId => $composableBuilder(
      column: $table.dayId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dayNameAr => $composableBuilder(
      column: $table.dayNameAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get hourNumber => $composableBuilder(
      column: $table.hourNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get hourNameAr => $composableBuilder(
      column: $table.hourNameAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get readingType => $composableBuilder(
      column: $table.readingType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reference => $composableBuilder(
      column: $table.reference, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get readingOrder => $composableBuilder(
      column: $table.readingOrder, builder: (column) => ColumnFilters(column));
}

class $$PaschaReadingsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaschaReadingsTable> {
  $$PaschaReadingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dayId => $composableBuilder(
      column: $table.dayId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dayNameAr => $composableBuilder(
      column: $table.dayNameAr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get hourNumber => $composableBuilder(
      column: $table.hourNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get hourNameAr => $composableBuilder(
      column: $table.hourNameAr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get readingType => $composableBuilder(
      column: $table.readingType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reference => $composableBuilder(
      column: $table.reference, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get readingOrder => $composableBuilder(
      column: $table.readingOrder,
      builder: (column) => ColumnOrderings(column));
}

class $$PaschaReadingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaschaReadingsTable> {
  $$PaschaReadingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get dayId =>
      $composableBuilder(column: $table.dayId, builder: (column) => column);

  GeneratedColumn<String> get dayNameAr =>
      $composableBuilder(column: $table.dayNameAr, builder: (column) => column);

  GeneratedColumn<int> get hourNumber => $composableBuilder(
      column: $table.hourNumber, builder: (column) => column);

  GeneratedColumn<String> get hourNameAr => $composableBuilder(
      column: $table.hourNameAr, builder: (column) => column);

  GeneratedColumn<String> get readingType => $composableBuilder(
      column: $table.readingType, builder: (column) => column);

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<int> get readingOrder => $composableBuilder(
      column: $table.readingOrder, builder: (column) => column);
}

class $$PaschaReadingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PaschaReadingsTable,
    PaschaReading,
    $$PaschaReadingsTableFilterComposer,
    $$PaschaReadingsTableOrderingComposer,
    $$PaschaReadingsTableAnnotationComposer,
    $$PaschaReadingsTableCreateCompanionBuilder,
    $$PaschaReadingsTableUpdateCompanionBuilder,
    (
      PaschaReading,
      BaseReferences<_$AppDatabase, $PaschaReadingsTable, PaschaReading>
    ),
    PaschaReading,
    PrefetchHooks Function()> {
  $$PaschaReadingsTableTableManager(
      _$AppDatabase db, $PaschaReadingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaschaReadingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaschaReadingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaschaReadingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> dayId = const Value.absent(),
            Value<String> dayNameAr = const Value.absent(),
            Value<int> hourNumber = const Value.absent(),
            Value<String> hourNameAr = const Value.absent(),
            Value<String> readingType = const Value.absent(),
            Value<String?> reference = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<int> readingOrder = const Value.absent(),
          }) =>
              PaschaReadingsCompanion(
            id: id,
            dayId: dayId,
            dayNameAr: dayNameAr,
            hourNumber: hourNumber,
            hourNameAr: hourNameAr,
            readingType: readingType,
            reference: reference,
            content: content,
            readingOrder: readingOrder,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String dayId,
            required String dayNameAr,
            required int hourNumber,
            required String hourNameAr,
            required String readingType,
            Value<String?> reference = const Value.absent(),
            required String content,
            required int readingOrder,
          }) =>
              PaschaReadingsCompanion.insert(
            id: id,
            dayId: dayId,
            dayNameAr: dayNameAr,
            hourNumber: hourNumber,
            hourNameAr: hourNameAr,
            readingType: readingType,
            reference: reference,
            content: content,
            readingOrder: readingOrder,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$PaschaReadingsTable, PaschaReading>(table),
                    BaseReferences<_$AppDatabase, $PaschaReadingsTable,
                        PaschaReading>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PaschaReadingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PaschaReadingsTable,
    PaschaReading,
    $$PaschaReadingsTableFilterComposer,
    $$PaschaReadingsTableOrderingComposer,
    $$PaschaReadingsTableAnnotationComposer,
    $$PaschaReadingsTableCreateCompanionBuilder,
    $$PaschaReadingsTableUpdateCompanionBuilder,
    (
      PaschaReading,
      BaseReferences<_$AppDatabase, $PaschaReadingsTable, PaschaReading>
    ),
    PaschaReading,
    PrefetchHooks Function()>;
typedef $$FeastsAndFastsTableCreateCompanionBuilder = FeastsAndFastsCompanion
    Function({
  required String id,
  required String nameAr,
  required String type,
  Value<int?> copticMonth,
  Value<int?> copticDay,
  Value<bool> isMovable,
  Value<String?> calculationRule,
  required String rite,
  required String description,
  Value<int?> durationDays,
  Value<int> rowid,
});
typedef $$FeastsAndFastsTableUpdateCompanionBuilder = FeastsAndFastsCompanion
    Function({
  Value<String> id,
  Value<String> nameAr,
  Value<String> type,
  Value<int?> copticMonth,
  Value<int?> copticDay,
  Value<bool> isMovable,
  Value<String?> calculationRule,
  Value<String> rite,
  Value<String> description,
  Value<int?> durationDays,
  Value<int> rowid,
});

class $$FeastsAndFastsTableFilterComposer
    extends Composer<_$AppDatabase, $FeastsAndFastsTable> {
  $$FeastsAndFastsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get copticMonth => $composableBuilder(
      column: $table.copticMonth, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get copticDay => $composableBuilder(
      column: $table.copticDay, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isMovable => $composableBuilder(
      column: $table.isMovable, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get calculationRule => $composableBuilder(
      column: $table.calculationRule,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rite => $composableBuilder(
      column: $table.rite, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationDays => $composableBuilder(
      column: $table.durationDays, builder: (column) => ColumnFilters(column));
}

class $$FeastsAndFastsTableOrderingComposer
    extends Composer<_$AppDatabase, $FeastsAndFastsTable> {
  $$FeastsAndFastsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get copticMonth => $composableBuilder(
      column: $table.copticMonth, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get copticDay => $composableBuilder(
      column: $table.copticDay, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isMovable => $composableBuilder(
      column: $table.isMovable, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get calculationRule => $composableBuilder(
      column: $table.calculationRule,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rite => $composableBuilder(
      column: $table.rite, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationDays => $composableBuilder(
      column: $table.durationDays,
      builder: (column) => ColumnOrderings(column));
}

class $$FeastsAndFastsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeastsAndFastsTable> {
  $$FeastsAndFastsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameAr =>
      $composableBuilder(column: $table.nameAr, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get copticMonth => $composableBuilder(
      column: $table.copticMonth, builder: (column) => column);

  GeneratedColumn<int> get copticDay =>
      $composableBuilder(column: $table.copticDay, builder: (column) => column);

  GeneratedColumn<bool> get isMovable =>
      $composableBuilder(column: $table.isMovable, builder: (column) => column);

  GeneratedColumn<String> get calculationRule => $composableBuilder(
      column: $table.calculationRule, builder: (column) => column);

  GeneratedColumn<String> get rite =>
      $composableBuilder(column: $table.rite, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<int> get durationDays => $composableBuilder(
      column: $table.durationDays, builder: (column) => column);
}

class $$FeastsAndFastsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FeastsAndFastsTable,
    FeastsAndFast,
    $$FeastsAndFastsTableFilterComposer,
    $$FeastsAndFastsTableOrderingComposer,
    $$FeastsAndFastsTableAnnotationComposer,
    $$FeastsAndFastsTableCreateCompanionBuilder,
    $$FeastsAndFastsTableUpdateCompanionBuilder,
    (
      FeastsAndFast,
      BaseReferences<_$AppDatabase, $FeastsAndFastsTable, FeastsAndFast>
    ),
    FeastsAndFast,
    PrefetchHooks Function()> {
  $$FeastsAndFastsTableTableManager(
      _$AppDatabase db, $FeastsAndFastsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeastsAndFastsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeastsAndFastsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeastsAndFastsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> nameAr = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<int?> copticMonth = const Value.absent(),
            Value<int?> copticDay = const Value.absent(),
            Value<bool> isMovable = const Value.absent(),
            Value<String?> calculationRule = const Value.absent(),
            Value<String> rite = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<int?> durationDays = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FeastsAndFastsCompanion(
            id: id,
            nameAr: nameAr,
            type: type,
            copticMonth: copticMonth,
            copticDay: copticDay,
            isMovable: isMovable,
            calculationRule: calculationRule,
            rite: rite,
            description: description,
            durationDays: durationDays,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String nameAr,
            required String type,
            Value<int?> copticMonth = const Value.absent(),
            Value<int?> copticDay = const Value.absent(),
            Value<bool> isMovable = const Value.absent(),
            Value<String?> calculationRule = const Value.absent(),
            required String rite,
            required String description,
            Value<int?> durationDays = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FeastsAndFastsCompanion.insert(
            id: id,
            nameAr: nameAr,
            type: type,
            copticMonth: copticMonth,
            copticDay: copticDay,
            isMovable: isMovable,
            calculationRule: calculationRule,
            rite: rite,
            description: description,
            durationDays: durationDays,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$FeastsAndFastsTable, FeastsAndFast>(table),
                    BaseReferences<_$AppDatabase, $FeastsAndFastsTable,
                        FeastsAndFast>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FeastsAndFastsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FeastsAndFastsTable,
    FeastsAndFast,
    $$FeastsAndFastsTableFilterComposer,
    $$FeastsAndFastsTableOrderingComposer,
    $$FeastsAndFastsTableAnnotationComposer,
    $$FeastsAndFastsTableCreateCompanionBuilder,
    $$FeastsAndFastsTableUpdateCompanionBuilder,
    (
      FeastsAndFast,
      BaseReferences<_$AppDatabase, $FeastsAndFastsTable, FeastsAndFast>
    ),
    FeastsAndFast,
    PrefetchHooks Function()>;
typedef $$OccasionalPrayersTableCreateCompanionBuilder
    = OccasionalPrayersCompanion Function({
  required String id,
  required String category,
  required String categoryAr,
  required String title,
  required String content,
  required int prayerOrder,
  Value<int> rowid,
});
typedef $$OccasionalPrayersTableUpdateCompanionBuilder
    = OccasionalPrayersCompanion Function({
  Value<String> id,
  Value<String> category,
  Value<String> categoryAr,
  Value<String> title,
  Value<String> content,
  Value<int> prayerOrder,
  Value<int> rowid,
});

class $$OccasionalPrayersTableFilterComposer
    extends Composer<_$AppDatabase, $OccasionalPrayersTable> {
  $$OccasionalPrayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoryAr => $composableBuilder(
      column: $table.categoryAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get prayerOrder => $composableBuilder(
      column: $table.prayerOrder, builder: (column) => ColumnFilters(column));
}

class $$OccasionalPrayersTableOrderingComposer
    extends Composer<_$AppDatabase, $OccasionalPrayersTable> {
  $$OccasionalPrayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoryAr => $composableBuilder(
      column: $table.categoryAr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get prayerOrder => $composableBuilder(
      column: $table.prayerOrder, builder: (column) => ColumnOrderings(column));
}

class $$OccasionalPrayersTableAnnotationComposer
    extends Composer<_$AppDatabase, $OccasionalPrayersTable> {
  $$OccasionalPrayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get categoryAr => $composableBuilder(
      column: $table.categoryAr, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<int> get prayerOrder => $composableBuilder(
      column: $table.prayerOrder, builder: (column) => column);
}

class $$OccasionalPrayersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OccasionalPrayersTable,
    OccasionalPrayer,
    $$OccasionalPrayersTableFilterComposer,
    $$OccasionalPrayersTableOrderingComposer,
    $$OccasionalPrayersTableAnnotationComposer,
    $$OccasionalPrayersTableCreateCompanionBuilder,
    $$OccasionalPrayersTableUpdateCompanionBuilder,
    (
      OccasionalPrayer,
      BaseReferences<_$AppDatabase, $OccasionalPrayersTable, OccasionalPrayer>
    ),
    OccasionalPrayer,
    PrefetchHooks Function()> {
  $$OccasionalPrayersTableTableManager(
      _$AppDatabase db, $OccasionalPrayersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OccasionalPrayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OccasionalPrayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OccasionalPrayersTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> categoryAr = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<int> prayerOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OccasionalPrayersCompanion(
            id: id,
            category: category,
            categoryAr: categoryAr,
            title: title,
            content: content,
            prayerOrder: prayerOrder,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String category,
            required String categoryAr,
            required String title,
            required String content,
            required int prayerOrder,
            Value<int> rowid = const Value.absent(),
          }) =>
              OccasionalPrayersCompanion.insert(
            id: id,
            category: category,
            categoryAr: categoryAr,
            title: title,
            content: content,
            prayerOrder: prayerOrder,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$OccasionalPrayersTable, OccasionalPrayer>(
                        table),
                    BaseReferences<_$AppDatabase, $OccasionalPrayersTable,
                        OccasionalPrayer>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OccasionalPrayersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OccasionalPrayersTable,
    OccasionalPrayer,
    $$OccasionalPrayersTableFilterComposer,
    $$OccasionalPrayersTableOrderingComposer,
    $$OccasionalPrayersTableAnnotationComposer,
    $$OccasionalPrayersTableCreateCompanionBuilder,
    $$OccasionalPrayersTableUpdateCompanionBuilder,
    (
      OccasionalPrayer,
      BaseReferences<_$AppDatabase, $OccasionalPrayersTable, OccasionalPrayer>
    ),
    OccasionalPrayer,
    PrefetchHooks Function()>;
typedef $$TheologyArticlesTableCreateCompanionBuilder
    = TheologyArticlesCompanion Function({
  required String id,
  required String category,
  required String categoryAr,
  required String title,
  required String content,
  required int articleOrder,
  Value<int> rowid,
});
typedef $$TheologyArticlesTableUpdateCompanionBuilder
    = TheologyArticlesCompanion Function({
  Value<String> id,
  Value<String> category,
  Value<String> categoryAr,
  Value<String> title,
  Value<String> content,
  Value<int> articleOrder,
  Value<int> rowid,
});

class $$TheologyArticlesTableFilterComposer
    extends Composer<_$AppDatabase, $TheologyArticlesTable> {
  $$TheologyArticlesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoryAr => $composableBuilder(
      column: $table.categoryAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get articleOrder => $composableBuilder(
      column: $table.articleOrder, builder: (column) => ColumnFilters(column));
}

class $$TheologyArticlesTableOrderingComposer
    extends Composer<_$AppDatabase, $TheologyArticlesTable> {
  $$TheologyArticlesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoryAr => $composableBuilder(
      column: $table.categoryAr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get articleOrder => $composableBuilder(
      column: $table.articleOrder,
      builder: (column) => ColumnOrderings(column));
}

class $$TheologyArticlesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TheologyArticlesTable> {
  $$TheologyArticlesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get categoryAr => $composableBuilder(
      column: $table.categoryAr, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<int> get articleOrder => $composableBuilder(
      column: $table.articleOrder, builder: (column) => column);
}

class $$TheologyArticlesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TheologyArticlesTable,
    TheologyArticle,
    $$TheologyArticlesTableFilterComposer,
    $$TheologyArticlesTableOrderingComposer,
    $$TheologyArticlesTableAnnotationComposer,
    $$TheologyArticlesTableCreateCompanionBuilder,
    $$TheologyArticlesTableUpdateCompanionBuilder,
    (
      TheologyArticle,
      BaseReferences<_$AppDatabase, $TheologyArticlesTable, TheologyArticle>
    ),
    TheologyArticle,
    PrefetchHooks Function()> {
  $$TheologyArticlesTableTableManager(
      _$AppDatabase db, $TheologyArticlesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TheologyArticlesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TheologyArticlesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TheologyArticlesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> categoryAr = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<int> articleOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TheologyArticlesCompanion(
            id: id,
            category: category,
            categoryAr: categoryAr,
            title: title,
            content: content,
            articleOrder: articleOrder,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String category,
            required String categoryAr,
            required String title,
            required String content,
            required int articleOrder,
            Value<int> rowid = const Value.absent(),
          }) =>
              TheologyArticlesCompanion.insert(
            id: id,
            category: category,
            categoryAr: categoryAr,
            title: title,
            content: content,
            articleOrder: articleOrder,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$TheologyArticlesTable, TheologyArticle>(table),
                    BaseReferences<_$AppDatabase, $TheologyArticlesTable,
                        TheologyArticle>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TheologyArticlesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TheologyArticlesTable,
    TheologyArticle,
    $$TheologyArticlesTableFilterComposer,
    $$TheologyArticlesTableOrderingComposer,
    $$TheologyArticlesTableAnnotationComposer,
    $$TheologyArticlesTableCreateCompanionBuilder,
    $$TheologyArticlesTableUpdateCompanionBuilder,
    (
      TheologyArticle,
      BaseReferences<_$AppDatabase, $TheologyArticlesTable, TheologyArticle>
    ),
    TheologyArticle,
    PrefetchHooks Function()>;
typedef $$DailyVersesTableCreateCompanionBuilder = DailyVersesCompanion
    Function({
  Value<int> id,
  required int dayOfYear,
  required String reference,
  required String content,
});
typedef $$DailyVersesTableUpdateCompanionBuilder = DailyVersesCompanion
    Function({
  Value<int> id,
  Value<int> dayOfYear,
  Value<String> reference,
  Value<String> content,
});

class $$DailyVersesTableFilterComposer
    extends Composer<_$AppDatabase, $DailyVersesTable> {
  $$DailyVersesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dayOfYear => $composableBuilder(
      column: $table.dayOfYear, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reference => $composableBuilder(
      column: $table.reference, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));
}

class $$DailyVersesTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyVersesTable> {
  $$DailyVersesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dayOfYear => $composableBuilder(
      column: $table.dayOfYear, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reference => $composableBuilder(
      column: $table.reference, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));
}

class $$DailyVersesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyVersesTable> {
  $$DailyVersesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get dayOfYear =>
      $composableBuilder(column: $table.dayOfYear, builder: (column) => column);

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);
}

class $$DailyVersesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DailyVersesTable,
    DailyVerse,
    $$DailyVersesTableFilterComposer,
    $$DailyVersesTableOrderingComposer,
    $$DailyVersesTableAnnotationComposer,
    $$DailyVersesTableCreateCompanionBuilder,
    $$DailyVersesTableUpdateCompanionBuilder,
    (DailyVerse, BaseReferences<_$AppDatabase, $DailyVersesTable, DailyVerse>),
    DailyVerse,
    PrefetchHooks Function()> {
  $$DailyVersesTableTableManager(_$AppDatabase db, $DailyVersesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyVersesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyVersesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyVersesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> dayOfYear = const Value.absent(),
            Value<String> reference = const Value.absent(),
            Value<String> content = const Value.absent(),
          }) =>
              DailyVersesCompanion(
            id: id,
            dayOfYear: dayOfYear,
            reference: reference,
            content: content,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int dayOfYear,
            required String reference,
            required String content,
          }) =>
              DailyVersesCompanion.insert(
            id: id,
            dayOfYear: dayOfYear,
            reference: reference,
            content: content,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$DailyVersesTable, DailyVerse>(table),
                    BaseReferences<_$AppDatabase, $DailyVersesTable,
                        DailyVerse>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DailyVersesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DailyVersesTable,
    DailyVerse,
    $$DailyVersesTableFilterComposer,
    $$DailyVersesTableOrderingComposer,
    $$DailyVersesTableAnnotationComposer,
    $$DailyVersesTableCreateCompanionBuilder,
    $$DailyVersesTableUpdateCompanionBuilder,
    (DailyVerse, BaseReferences<_$AppDatabase, $DailyVersesTable, DailyVerse>),
    DailyVerse,
    PrefetchHooks Function()>;
typedef $$BookmarksTableCreateCompanionBuilder = BookmarksCompanion Function({
  Value<int> id,
  required String contentType,
  required String contentId,
  required String displayTitle,
  Value<String?> note,
  Value<DateTime> createdAt,
});
typedef $$BookmarksTableUpdateCompanionBuilder = BookmarksCompanion Function({
  Value<int> id,
  Value<String> contentType,
  Value<String> contentId,
  Value<String> displayTitle,
  Value<String?> note,
  Value<DateTime> createdAt,
});

class $$BookmarksTableFilterComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentType => $composableBuilder(
      column: $table.contentType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentId => $composableBuilder(
      column: $table.contentId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get displayTitle => $composableBuilder(
      column: $table.displayTitle, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$BookmarksTableOrderingComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentType => $composableBuilder(
      column: $table.contentType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentId => $composableBuilder(
      column: $table.contentId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get displayTitle => $composableBuilder(
      column: $table.displayTitle,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$BookmarksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get contentType => $composableBuilder(
      column: $table.contentType, builder: (column) => column);

  GeneratedColumn<String> get contentId =>
      $composableBuilder(column: $table.contentId, builder: (column) => column);

  GeneratedColumn<String> get displayTitle => $composableBuilder(
      column: $table.displayTitle, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$BookmarksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BookmarksTable,
    Bookmark,
    $$BookmarksTableFilterComposer,
    $$BookmarksTableOrderingComposer,
    $$BookmarksTableAnnotationComposer,
    $$BookmarksTableCreateCompanionBuilder,
    $$BookmarksTableUpdateCompanionBuilder,
    (Bookmark, BaseReferences<_$AppDatabase, $BookmarksTable, Bookmark>),
    Bookmark,
    PrefetchHooks Function()> {
  $$BookmarksTableTableManager(_$AppDatabase db, $BookmarksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookmarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookmarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookmarksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> contentType = const Value.absent(),
            Value<String> contentId = const Value.absent(),
            Value<String> displayTitle = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              BookmarksCompanion(
            id: id,
            contentType: contentType,
            contentId: contentId,
            displayTitle: displayTitle,
            note: note,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String contentType,
            required String contentId,
            required String displayTitle,
            Value<String?> note = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              BookmarksCompanion.insert(
            id: id,
            contentType: contentType,
            contentId: contentId,
            displayTitle: displayTitle,
            note: note,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$BookmarksTable, Bookmark>(table),
                    BaseReferences<_$AppDatabase, $BookmarksTable, Bookmark>(
                        db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BookmarksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BookmarksTable,
    Bookmark,
    $$BookmarksTableFilterComposer,
    $$BookmarksTableOrderingComposer,
    $$BookmarksTableAnnotationComposer,
    $$BookmarksTableCreateCompanionBuilder,
    $$BookmarksTableUpdateCompanionBuilder,
    (Bookmark, BaseReferences<_$AppDatabase, $BookmarksTable, Bookmark>),
    Bookmark,
    PrefetchHooks Function()>;
typedef $$SacramentsTableCreateCompanionBuilder = SacramentsCompanion Function({
  required String id,
  required String nameAr,
  required int sacramentOrder,
  Value<int> rowid,
});
typedef $$SacramentsTableUpdateCompanionBuilder = SacramentsCompanion Function({
  Value<String> id,
  Value<String> nameAr,
  Value<int> sacramentOrder,
  Value<int> rowid,
});

final class $$SacramentsTableReferences
    extends BaseReferences<_$AppDatabase, $SacramentsTable, Sacrament> {
  $$SacramentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SacramentSectionsTable, List<SacramentSection>>
      _sacramentSectionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.sacramentSections,
              aliasName: 'sacraments__id__sacrament_sections__sacrament_id');

  $$SacramentSectionsTableProcessedTableManager get sacramentSectionsRefs {
    final manager = $$SacramentSectionsTableTableManager(
            $_db, $_db.sacramentSections)
        .filter((f) => f.sacramentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_sacramentSectionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SacramentsTableFilterComposer
    extends Composer<_$AppDatabase, $SacramentsTable> {
  $$SacramentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sacramentOrder => $composableBuilder(
      column: $table.sacramentOrder,
      builder: (column) => ColumnFilters(column));

  Expression<bool> sacramentSectionsRefs(
      Expression<bool> Function($$SacramentSectionsTableFilterComposer f) f) {
    final $$SacramentSectionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.sacramentSections,
        getReferencedColumn: (t) => t.sacramentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SacramentSectionsTableFilterComposer(
              $db: $db,
              $table: $db.sacramentSections,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SacramentsTableOrderingComposer
    extends Composer<_$AppDatabase, $SacramentsTable> {
  $$SacramentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sacramentOrder => $composableBuilder(
      column: $table.sacramentOrder,
      builder: (column) => ColumnOrderings(column));
}

class $$SacramentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SacramentsTable> {
  $$SacramentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameAr =>
      $composableBuilder(column: $table.nameAr, builder: (column) => column);

  GeneratedColumn<int> get sacramentOrder => $composableBuilder(
      column: $table.sacramentOrder, builder: (column) => column);

  Expression<T> sacramentSectionsRefs<T extends Object>(
      Expression<T> Function($$SacramentSectionsTableAnnotationComposer a) f) {
    final $$SacramentSectionsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.sacramentSections,
            getReferencedColumn: (t) => t.sacramentId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SacramentSectionsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.sacramentSections,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$SacramentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SacramentsTable,
    Sacrament,
    $$SacramentsTableFilterComposer,
    $$SacramentsTableOrderingComposer,
    $$SacramentsTableAnnotationComposer,
    $$SacramentsTableCreateCompanionBuilder,
    $$SacramentsTableUpdateCompanionBuilder,
    (Sacrament, $$SacramentsTableReferences),
    Sacrament,
    PrefetchHooks Function({bool sacramentSectionsRefs})> {
  $$SacramentsTableTableManager(_$AppDatabase db, $SacramentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SacramentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SacramentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SacramentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> nameAr = const Value.absent(),
            Value<int> sacramentOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SacramentsCompanion(
            id: id,
            nameAr: nameAr,
            sacramentOrder: sacramentOrder,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String nameAr,
            required int sacramentOrder,
            Value<int> rowid = const Value.absent(),
          }) =>
              SacramentsCompanion.insert(
            id: id,
            nameAr: nameAr,
            sacramentOrder: sacramentOrder,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$SacramentsTable, Sacrament>(table),
                    $$SacramentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({sacramentSectionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (sacramentSectionsRefs) db.sacramentSections
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (sacramentSectionsRefs)
                    await $_getPrefetchedData<Sacrament, $SacramentsTable,
                            SacramentSection>(
                        currentTable: table,
                        referencedTable: $$SacramentsTableReferences
                            ._sacramentSectionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SacramentsTableReferences(db, table, p0)
                                .sacramentSectionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.sacramentId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SacramentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SacramentsTable,
    Sacrament,
    $$SacramentsTableFilterComposer,
    $$SacramentsTableOrderingComposer,
    $$SacramentsTableAnnotationComposer,
    $$SacramentsTableCreateCompanionBuilder,
    $$SacramentsTableUpdateCompanionBuilder,
    (Sacrament, $$SacramentsTableReferences),
    Sacrament,
    PrefetchHooks Function({bool sacramentSectionsRefs})>;
typedef $$SacramentSectionsTableCreateCompanionBuilder
    = SacramentSectionsCompanion Function({
  Value<int> id,
  required String sacramentId,
  required String title,
  required String content,
  Value<String?> scriptures,
  required int sectionOrder,
});
typedef $$SacramentSectionsTableUpdateCompanionBuilder
    = SacramentSectionsCompanion Function({
  Value<int> id,
  Value<String> sacramentId,
  Value<String> title,
  Value<String> content,
  Value<String?> scriptures,
  Value<int> sectionOrder,
});

final class $$SacramentSectionsTableReferences extends BaseReferences<
    _$AppDatabase, $SacramentSectionsTable, SacramentSection> {
  $$SacramentSectionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $SacramentsTable _sacramentIdTable(_$AppDatabase db) => db.sacraments
      .createAlias('sacrament_sections__sacrament_id__sacraments__id');

  $$SacramentsTableProcessedTableManager get sacramentId {
    final $_column = $_itemColumn<String>('sacrament_id')!;

    final manager = $$SacramentsTableTableManager($_db, $_db.sacraments)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sacramentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SacramentSectionsTableFilterComposer
    extends Composer<_$AppDatabase, $SacramentSectionsTable> {
  $$SacramentSectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get scriptures => $composableBuilder(
      column: $table.scriptures, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sectionOrder => $composableBuilder(
      column: $table.sectionOrder, builder: (column) => ColumnFilters(column));

  $$SacramentsTableFilterComposer get sacramentId {
    final $$SacramentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sacramentId,
        referencedTable: $db.sacraments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SacramentsTableFilterComposer(
              $db: $db,
              $table: $db.sacraments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SacramentSectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SacramentSectionsTable> {
  $$SacramentSectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get scriptures => $composableBuilder(
      column: $table.scriptures, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sectionOrder => $composableBuilder(
      column: $table.sectionOrder,
      builder: (column) => ColumnOrderings(column));

  $$SacramentsTableOrderingComposer get sacramentId {
    final $$SacramentsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sacramentId,
        referencedTable: $db.sacraments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SacramentsTableOrderingComposer(
              $db: $db,
              $table: $db.sacraments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SacramentSectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SacramentSectionsTable> {
  $$SacramentSectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get scriptures => $composableBuilder(
      column: $table.scriptures, builder: (column) => column);

  GeneratedColumn<int> get sectionOrder => $composableBuilder(
      column: $table.sectionOrder, builder: (column) => column);

  $$SacramentsTableAnnotationComposer get sacramentId {
    final $$SacramentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sacramentId,
        referencedTable: $db.sacraments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SacramentsTableAnnotationComposer(
              $db: $db,
              $table: $db.sacraments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SacramentSectionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SacramentSectionsTable,
    SacramentSection,
    $$SacramentSectionsTableFilterComposer,
    $$SacramentSectionsTableOrderingComposer,
    $$SacramentSectionsTableAnnotationComposer,
    $$SacramentSectionsTableCreateCompanionBuilder,
    $$SacramentSectionsTableUpdateCompanionBuilder,
    (SacramentSection, $$SacramentSectionsTableReferences),
    SacramentSection,
    PrefetchHooks Function({bool sacramentId})> {
  $$SacramentSectionsTableTableManager(
      _$AppDatabase db, $SacramentSectionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SacramentSectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SacramentSectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SacramentSectionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> sacramentId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String?> scriptures = const Value.absent(),
            Value<int> sectionOrder = const Value.absent(),
          }) =>
              SacramentSectionsCompanion(
            id: id,
            sacramentId: sacramentId,
            title: title,
            content: content,
            scriptures: scriptures,
            sectionOrder: sectionOrder,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String sacramentId,
            required String title,
            required String content,
            Value<String?> scriptures = const Value.absent(),
            required int sectionOrder,
          }) =>
              SacramentSectionsCompanion.insert(
            id: id,
            sacramentId: sacramentId,
            title: title,
            content: content,
            scriptures: scriptures,
            sectionOrder: sectionOrder,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$SacramentSectionsTable, SacramentSection>(
                        table),
                    $$SacramentSectionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({sacramentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (sacramentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.sacramentId,
                    referencedTable: $$SacramentSectionsTableReferences
                        ._sacramentIdTable(db),
                    referencedColumn: $$SacramentSectionsTableReferences
                        ._sacramentIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SacramentSectionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SacramentSectionsTable,
    SacramentSection,
    $$SacramentSectionsTableFilterComposer,
    $$SacramentSectionsTableOrderingComposer,
    $$SacramentSectionsTableAnnotationComposer,
    $$SacramentSectionsTableCreateCompanionBuilder,
    $$SacramentSectionsTableUpdateCompanionBuilder,
    (SacramentSection, $$SacramentSectionsTableReferences),
    SacramentSection,
    PrefetchHooks Function({bool sacramentId})>;
typedef $$MonasteriesTableCreateCompanionBuilder = MonasteriesCompanion
    Function({
  required String id,
  required String nameAr,
  Value<String?> nameEn,
  Value<String?> nameCoptic,
  Value<String> type,
  required String location,
  required String founded,
  required String founder,
  required String description,
  Value<int?> copticMonth,
  Value<int?> copticDay,
  Value<double?> latitude,
  Value<double?> longitude,
  Value<String?> patronSaints,
  Value<String?> visitingHours,
  Value<String?> architecturalDescription,
  Value<String?> feastDate,
  Value<int> rowid,
});
typedef $$MonasteriesTableUpdateCompanionBuilder = MonasteriesCompanion
    Function({
  Value<String> id,
  Value<String> nameAr,
  Value<String?> nameEn,
  Value<String?> nameCoptic,
  Value<String> type,
  Value<String> location,
  Value<String> founded,
  Value<String> founder,
  Value<String> description,
  Value<int?> copticMonth,
  Value<int?> copticDay,
  Value<double?> latitude,
  Value<double?> longitude,
  Value<String?> patronSaints,
  Value<String?> visitingHours,
  Value<String?> architecturalDescription,
  Value<String?> feastDate,
  Value<int> rowid,
});

class $$MonasteriesTableFilterComposer
    extends Composer<_$AppDatabase, $MonasteriesTable> {
  $$MonasteriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameCoptic => $composableBuilder(
      column: $table.nameCoptic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get founded => $composableBuilder(
      column: $table.founded, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get founder => $composableBuilder(
      column: $table.founder, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get copticMonth => $composableBuilder(
      column: $table.copticMonth, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get copticDay => $composableBuilder(
      column: $table.copticDay, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get patronSaints => $composableBuilder(
      column: $table.patronSaints, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get visitingHours => $composableBuilder(
      column: $table.visitingHours, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get architecturalDescription => $composableBuilder(
      column: $table.architecturalDescription,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get feastDate => $composableBuilder(
      column: $table.feastDate, builder: (column) => ColumnFilters(column));
}

class $$MonasteriesTableOrderingComposer
    extends Composer<_$AppDatabase, $MonasteriesTable> {
  $$MonasteriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameCoptic => $composableBuilder(
      column: $table.nameCoptic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get founded => $composableBuilder(
      column: $table.founded, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get founder => $composableBuilder(
      column: $table.founder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get copticMonth => $composableBuilder(
      column: $table.copticMonth, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get copticDay => $composableBuilder(
      column: $table.copticDay, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get patronSaints => $composableBuilder(
      column: $table.patronSaints,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get visitingHours => $composableBuilder(
      column: $table.visitingHours,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get architecturalDescription => $composableBuilder(
      column: $table.architecturalDescription,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get feastDate => $composableBuilder(
      column: $table.feastDate, builder: (column) => ColumnOrderings(column));
}

class $$MonasteriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MonasteriesTable> {
  $$MonasteriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameAr =>
      $composableBuilder(column: $table.nameAr, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameCoptic => $composableBuilder(
      column: $table.nameCoptic, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get founded =>
      $composableBuilder(column: $table.founded, builder: (column) => column);

  GeneratedColumn<String> get founder =>
      $composableBuilder(column: $table.founder, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<int> get copticMonth => $composableBuilder(
      column: $table.copticMonth, builder: (column) => column);

  GeneratedColumn<int> get copticDay =>
      $composableBuilder(column: $table.copticDay, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get patronSaints => $composableBuilder(
      column: $table.patronSaints, builder: (column) => column);

  GeneratedColumn<String> get visitingHours => $composableBuilder(
      column: $table.visitingHours, builder: (column) => column);

  GeneratedColumn<String> get architecturalDescription => $composableBuilder(
      column: $table.architecturalDescription, builder: (column) => column);

  GeneratedColumn<String> get feastDate =>
      $composableBuilder(column: $table.feastDate, builder: (column) => column);
}

class $$MonasteriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MonasteriesTable,
    MonasteryEntry,
    $$MonasteriesTableFilterComposer,
    $$MonasteriesTableOrderingComposer,
    $$MonasteriesTableAnnotationComposer,
    $$MonasteriesTableCreateCompanionBuilder,
    $$MonasteriesTableUpdateCompanionBuilder,
    (
      MonasteryEntry,
      BaseReferences<_$AppDatabase, $MonasteriesTable, MonasteryEntry>
    ),
    MonasteryEntry,
    PrefetchHooks Function()> {
  $$MonasteriesTableTableManager(_$AppDatabase db, $MonasteriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MonasteriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MonasteriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MonasteriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> nameAr = const Value.absent(),
            Value<String?> nameEn = const Value.absent(),
            Value<String?> nameCoptic = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> location = const Value.absent(),
            Value<String> founded = const Value.absent(),
            Value<String> founder = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<int?> copticMonth = const Value.absent(),
            Value<int?> copticDay = const Value.absent(),
            Value<double?> latitude = const Value.absent(),
            Value<double?> longitude = const Value.absent(),
            Value<String?> patronSaints = const Value.absent(),
            Value<String?> visitingHours = const Value.absent(),
            Value<String?> architecturalDescription = const Value.absent(),
            Value<String?> feastDate = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MonasteriesCompanion(
            id: id,
            nameAr: nameAr,
            nameEn: nameEn,
            nameCoptic: nameCoptic,
            type: type,
            location: location,
            founded: founded,
            founder: founder,
            description: description,
            copticMonth: copticMonth,
            copticDay: copticDay,
            latitude: latitude,
            longitude: longitude,
            patronSaints: patronSaints,
            visitingHours: visitingHours,
            architecturalDescription: architecturalDescription,
            feastDate: feastDate,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String nameAr,
            Value<String?> nameEn = const Value.absent(),
            Value<String?> nameCoptic = const Value.absent(),
            Value<String> type = const Value.absent(),
            required String location,
            required String founded,
            required String founder,
            required String description,
            Value<int?> copticMonth = const Value.absent(),
            Value<int?> copticDay = const Value.absent(),
            Value<double?> latitude = const Value.absent(),
            Value<double?> longitude = const Value.absent(),
            Value<String?> patronSaints = const Value.absent(),
            Value<String?> visitingHours = const Value.absent(),
            Value<String?> architecturalDescription = const Value.absent(),
            Value<String?> feastDate = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MonasteriesCompanion.insert(
            id: id,
            nameAr: nameAr,
            nameEn: nameEn,
            nameCoptic: nameCoptic,
            type: type,
            location: location,
            founded: founded,
            founder: founder,
            description: description,
            copticMonth: copticMonth,
            copticDay: copticDay,
            latitude: latitude,
            longitude: longitude,
            patronSaints: patronSaints,
            visitingHours: visitingHours,
            architecturalDescription: architecturalDescription,
            feastDate: feastDate,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$MonasteriesTable, MonasteryEntry>(table),
                    BaseReferences<_$AppDatabase, $MonasteriesTable,
                        MonasteryEntry>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MonasteriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MonasteriesTable,
    MonasteryEntry,
    $$MonasteriesTableFilterComposer,
    $$MonasteriesTableOrderingComposer,
    $$MonasteriesTableAnnotationComposer,
    $$MonasteriesTableCreateCompanionBuilder,
    $$MonasteriesTableUpdateCompanionBuilder,
    (
      MonasteryEntry,
      BaseReferences<_$AppDatabase, $MonasteriesTable, MonasteryEntry>
    ),
    MonasteryEntry,
    PrefetchHooks Function()>;
typedef $$BibleCommentariesTableCreateCompanionBuilder
    = BibleCommentariesCompanion Function({
  Value<int> id,
  required int bookId,
  required int chapter,
  Value<int?> verseStart,
  Value<int?> verseEnd,
  required String source,
  required String author,
  required String content,
  required String summary,
});
typedef $$BibleCommentariesTableUpdateCompanionBuilder
    = BibleCommentariesCompanion Function({
  Value<int> id,
  Value<int> bookId,
  Value<int> chapter,
  Value<int?> verseStart,
  Value<int?> verseEnd,
  Value<String> source,
  Value<String> author,
  Value<String> content,
  Value<String> summary,
});

class $$BibleCommentariesTableFilterComposer
    extends Composer<_$AppDatabase, $BibleCommentariesTable> {
  $$BibleCommentariesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get bookId => $composableBuilder(
      column: $table.bookId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get chapter => $composableBuilder(
      column: $table.chapter, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get verseStart => $composableBuilder(
      column: $table.verseStart, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get verseEnd => $composableBuilder(
      column: $table.verseEnd, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get author => $composableBuilder(
      column: $table.author, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get summary => $composableBuilder(
      column: $table.summary, builder: (column) => ColumnFilters(column));
}

class $$BibleCommentariesTableOrderingComposer
    extends Composer<_$AppDatabase, $BibleCommentariesTable> {
  $$BibleCommentariesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get bookId => $composableBuilder(
      column: $table.bookId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get chapter => $composableBuilder(
      column: $table.chapter, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get verseStart => $composableBuilder(
      column: $table.verseStart, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get verseEnd => $composableBuilder(
      column: $table.verseEnd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get author => $composableBuilder(
      column: $table.author, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get summary => $composableBuilder(
      column: $table.summary, builder: (column) => ColumnOrderings(column));
}

class $$BibleCommentariesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BibleCommentariesTable> {
  $$BibleCommentariesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get bookId =>
      $composableBuilder(column: $table.bookId, builder: (column) => column);

  GeneratedColumn<int> get chapter =>
      $composableBuilder(column: $table.chapter, builder: (column) => column);

  GeneratedColumn<int> get verseStart => $composableBuilder(
      column: $table.verseStart, builder: (column) => column);

  GeneratedColumn<int> get verseEnd =>
      $composableBuilder(column: $table.verseEnd, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);
}

class $$BibleCommentariesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BibleCommentariesTable,
    BibleCommentary,
    $$BibleCommentariesTableFilterComposer,
    $$BibleCommentariesTableOrderingComposer,
    $$BibleCommentariesTableAnnotationComposer,
    $$BibleCommentariesTableCreateCompanionBuilder,
    $$BibleCommentariesTableUpdateCompanionBuilder,
    (
      BibleCommentary,
      BaseReferences<_$AppDatabase, $BibleCommentariesTable, BibleCommentary>
    ),
    BibleCommentary,
    PrefetchHooks Function()> {
  $$BibleCommentariesTableTableManager(
      _$AppDatabase db, $BibleCommentariesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BibleCommentariesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BibleCommentariesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BibleCommentariesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> bookId = const Value.absent(),
            Value<int> chapter = const Value.absent(),
            Value<int?> verseStart = const Value.absent(),
            Value<int?> verseEnd = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String> author = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> summary = const Value.absent(),
          }) =>
              BibleCommentariesCompanion(
            id: id,
            bookId: bookId,
            chapter: chapter,
            verseStart: verseStart,
            verseEnd: verseEnd,
            source: source,
            author: author,
            content: content,
            summary: summary,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int bookId,
            required int chapter,
            Value<int?> verseStart = const Value.absent(),
            Value<int?> verseEnd = const Value.absent(),
            required String source,
            required String author,
            required String content,
            required String summary,
          }) =>
              BibleCommentariesCompanion.insert(
            id: id,
            bookId: bookId,
            chapter: chapter,
            verseStart: verseStart,
            verseEnd: verseEnd,
            source: source,
            author: author,
            content: content,
            summary: summary,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$BibleCommentariesTable, BibleCommentary>(
                        table),
                    BaseReferences<_$AppDatabase, $BibleCommentariesTable,
                        BibleCommentary>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BibleCommentariesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BibleCommentariesTable,
    BibleCommentary,
    $$BibleCommentariesTableFilterComposer,
    $$BibleCommentariesTableOrderingComposer,
    $$BibleCommentariesTableAnnotationComposer,
    $$BibleCommentariesTableCreateCompanionBuilder,
    $$BibleCommentariesTableUpdateCompanionBuilder,
    (
      BibleCommentary,
      BaseReferences<_$AppDatabase, $BibleCommentariesTable, BibleCommentary>
    ),
    BibleCommentary,
    PrefetchHooks Function()>;
typedef $$CopticDictionaryTableCreateCompanionBuilder
    = CopticDictionaryCompanion Function({
  Value<int> id,
  required String coptic,
  required String phonetic,
  required String arabic,
  Value<String?> english,
  Value<String> partOfSpeech,
  Value<String?> usage,
  Value<String?> hymnReference,
});
typedef $$CopticDictionaryTableUpdateCompanionBuilder
    = CopticDictionaryCompanion Function({
  Value<int> id,
  Value<String> coptic,
  Value<String> phonetic,
  Value<String> arabic,
  Value<String?> english,
  Value<String> partOfSpeech,
  Value<String?> usage,
  Value<String?> hymnReference,
});

class $$CopticDictionaryTableFilterComposer
    extends Composer<_$AppDatabase, $CopticDictionaryTable> {
  $$CopticDictionaryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get coptic => $composableBuilder(
      column: $table.coptic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phonetic => $composableBuilder(
      column: $table.phonetic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get arabic => $composableBuilder(
      column: $table.arabic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get english => $composableBuilder(
      column: $table.english, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get partOfSpeech => $composableBuilder(
      column: $table.partOfSpeech, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get usage => $composableBuilder(
      column: $table.usage, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get hymnReference => $composableBuilder(
      column: $table.hymnReference, builder: (column) => ColumnFilters(column));
}

class $$CopticDictionaryTableOrderingComposer
    extends Composer<_$AppDatabase, $CopticDictionaryTable> {
  $$CopticDictionaryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get coptic => $composableBuilder(
      column: $table.coptic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phonetic => $composableBuilder(
      column: $table.phonetic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get arabic => $composableBuilder(
      column: $table.arabic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get english => $composableBuilder(
      column: $table.english, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get partOfSpeech => $composableBuilder(
      column: $table.partOfSpeech,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get usage => $composableBuilder(
      column: $table.usage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get hymnReference => $composableBuilder(
      column: $table.hymnReference,
      builder: (column) => ColumnOrderings(column));
}

class $$CopticDictionaryTableAnnotationComposer
    extends Composer<_$AppDatabase, $CopticDictionaryTable> {
  $$CopticDictionaryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get coptic =>
      $composableBuilder(column: $table.coptic, builder: (column) => column);

  GeneratedColumn<String> get phonetic =>
      $composableBuilder(column: $table.phonetic, builder: (column) => column);

  GeneratedColumn<String> get arabic =>
      $composableBuilder(column: $table.arabic, builder: (column) => column);

  GeneratedColumn<String> get english =>
      $composableBuilder(column: $table.english, builder: (column) => column);

  GeneratedColumn<String> get partOfSpeech => $composableBuilder(
      column: $table.partOfSpeech, builder: (column) => column);

  GeneratedColumn<String> get usage =>
      $composableBuilder(column: $table.usage, builder: (column) => column);

  GeneratedColumn<String> get hymnReference => $composableBuilder(
      column: $table.hymnReference, builder: (column) => column);
}

class $$CopticDictionaryTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CopticDictionaryTable,
    CopticDictionaryEntry,
    $$CopticDictionaryTableFilterComposer,
    $$CopticDictionaryTableOrderingComposer,
    $$CopticDictionaryTableAnnotationComposer,
    $$CopticDictionaryTableCreateCompanionBuilder,
    $$CopticDictionaryTableUpdateCompanionBuilder,
    (
      CopticDictionaryEntry,
      BaseReferences<_$AppDatabase, $CopticDictionaryTable,
          CopticDictionaryEntry>
    ),
    CopticDictionaryEntry,
    PrefetchHooks Function()> {
  $$CopticDictionaryTableTableManager(
      _$AppDatabase db, $CopticDictionaryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CopticDictionaryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CopticDictionaryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CopticDictionaryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> coptic = const Value.absent(),
            Value<String> phonetic = const Value.absent(),
            Value<String> arabic = const Value.absent(),
            Value<String?> english = const Value.absent(),
            Value<String> partOfSpeech = const Value.absent(),
            Value<String?> usage = const Value.absent(),
            Value<String?> hymnReference = const Value.absent(),
          }) =>
              CopticDictionaryCompanion(
            id: id,
            coptic: coptic,
            phonetic: phonetic,
            arabic: arabic,
            english: english,
            partOfSpeech: partOfSpeech,
            usage: usage,
            hymnReference: hymnReference,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String coptic,
            required String phonetic,
            required String arabic,
            Value<String?> english = const Value.absent(),
            Value<String> partOfSpeech = const Value.absent(),
            Value<String?> usage = const Value.absent(),
            Value<String?> hymnReference = const Value.absent(),
          }) =>
              CopticDictionaryCompanion.insert(
            id: id,
            coptic: coptic,
            phonetic: phonetic,
            arabic: arabic,
            english: english,
            partOfSpeech: partOfSpeech,
            usage: usage,
            hymnReference: hymnReference,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$CopticDictionaryTable, CopticDictionaryEntry>(
                        table),
                    BaseReferences<_$AppDatabase, $CopticDictionaryTable,
                        CopticDictionaryEntry>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CopticDictionaryTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CopticDictionaryTable,
    CopticDictionaryEntry,
    $$CopticDictionaryTableFilterComposer,
    $$CopticDictionaryTableOrderingComposer,
    $$CopticDictionaryTableAnnotationComposer,
    $$CopticDictionaryTableCreateCompanionBuilder,
    $$CopticDictionaryTableUpdateCompanionBuilder,
    (
      CopticDictionaryEntry,
      BaseReferences<_$AppDatabase, $CopticDictionaryTable,
          CopticDictionaryEntry>
    ),
    CopticDictionaryEntry,
    PrefetchHooks Function()>;
typedef $$BibleCrossReferencesTableCreateCompanionBuilder
    = BibleCrossReferencesCompanion Function({
  Value<int> id,
  required int sourceBookId,
  required int sourceChapter,
  required int sourceVerse,
  required int targetBookId,
  required int targetChapter,
  required int targetVerse,
  Value<String> relationType,
});
typedef $$BibleCrossReferencesTableUpdateCompanionBuilder
    = BibleCrossReferencesCompanion Function({
  Value<int> id,
  Value<int> sourceBookId,
  Value<int> sourceChapter,
  Value<int> sourceVerse,
  Value<int> targetBookId,
  Value<int> targetChapter,
  Value<int> targetVerse,
  Value<String> relationType,
});

class $$BibleCrossReferencesTableFilterComposer
    extends Composer<_$AppDatabase, $BibleCrossReferencesTable> {
  $$BibleCrossReferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sourceBookId => $composableBuilder(
      column: $table.sourceBookId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sourceChapter => $composableBuilder(
      column: $table.sourceChapter, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sourceVerse => $composableBuilder(
      column: $table.sourceVerse, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get targetBookId => $composableBuilder(
      column: $table.targetBookId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get targetChapter => $composableBuilder(
      column: $table.targetChapter, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get targetVerse => $composableBuilder(
      column: $table.targetVerse, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get relationType => $composableBuilder(
      column: $table.relationType, builder: (column) => ColumnFilters(column));
}

class $$BibleCrossReferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $BibleCrossReferencesTable> {
  $$BibleCrossReferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sourceBookId => $composableBuilder(
      column: $table.sourceBookId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sourceChapter => $composableBuilder(
      column: $table.sourceChapter,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sourceVerse => $composableBuilder(
      column: $table.sourceVerse, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get targetBookId => $composableBuilder(
      column: $table.targetBookId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get targetChapter => $composableBuilder(
      column: $table.targetChapter,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get targetVerse => $composableBuilder(
      column: $table.targetVerse, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get relationType => $composableBuilder(
      column: $table.relationType,
      builder: (column) => ColumnOrderings(column));
}

class $$BibleCrossReferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BibleCrossReferencesTable> {
  $$BibleCrossReferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sourceBookId => $composableBuilder(
      column: $table.sourceBookId, builder: (column) => column);

  GeneratedColumn<int> get sourceChapter => $composableBuilder(
      column: $table.sourceChapter, builder: (column) => column);

  GeneratedColumn<int> get sourceVerse => $composableBuilder(
      column: $table.sourceVerse, builder: (column) => column);

  GeneratedColumn<int> get targetBookId => $composableBuilder(
      column: $table.targetBookId, builder: (column) => column);

  GeneratedColumn<int> get targetChapter => $composableBuilder(
      column: $table.targetChapter, builder: (column) => column);

  GeneratedColumn<int> get targetVerse => $composableBuilder(
      column: $table.targetVerse, builder: (column) => column);

  GeneratedColumn<String> get relationType => $composableBuilder(
      column: $table.relationType, builder: (column) => column);
}

class $$BibleCrossReferencesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BibleCrossReferencesTable,
    BibleCrossReference,
    $$BibleCrossReferencesTableFilterComposer,
    $$BibleCrossReferencesTableOrderingComposer,
    $$BibleCrossReferencesTableAnnotationComposer,
    $$BibleCrossReferencesTableCreateCompanionBuilder,
    $$BibleCrossReferencesTableUpdateCompanionBuilder,
    (
      BibleCrossReference,
      BaseReferences<_$AppDatabase, $BibleCrossReferencesTable,
          BibleCrossReference>
    ),
    BibleCrossReference,
    PrefetchHooks Function()> {
  $$BibleCrossReferencesTableTableManager(
      _$AppDatabase db, $BibleCrossReferencesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BibleCrossReferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BibleCrossReferencesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BibleCrossReferencesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> sourceBookId = const Value.absent(),
            Value<int> sourceChapter = const Value.absent(),
            Value<int> sourceVerse = const Value.absent(),
            Value<int> targetBookId = const Value.absent(),
            Value<int> targetChapter = const Value.absent(),
            Value<int> targetVerse = const Value.absent(),
            Value<String> relationType = const Value.absent(),
          }) =>
              BibleCrossReferencesCompanion(
            id: id,
            sourceBookId: sourceBookId,
            sourceChapter: sourceChapter,
            sourceVerse: sourceVerse,
            targetBookId: targetBookId,
            targetChapter: targetChapter,
            targetVerse: targetVerse,
            relationType: relationType,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int sourceBookId,
            required int sourceChapter,
            required int sourceVerse,
            required int targetBookId,
            required int targetChapter,
            required int targetVerse,
            Value<String> relationType = const Value.absent(),
          }) =>
              BibleCrossReferencesCompanion.insert(
            id: id,
            sourceBookId: sourceBookId,
            sourceChapter: sourceChapter,
            sourceVerse: sourceVerse,
            targetBookId: targetBookId,
            targetChapter: targetChapter,
            targetVerse: targetVerse,
            relationType: relationType,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$BibleCrossReferencesTable,
                        BibleCrossReference>(table),
                    BaseReferences<_$AppDatabase, $BibleCrossReferencesTable,
                        BibleCrossReference>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BibleCrossReferencesTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $BibleCrossReferencesTable,
        BibleCrossReference,
        $$BibleCrossReferencesTableFilterComposer,
        $$BibleCrossReferencesTableOrderingComposer,
        $$BibleCrossReferencesTableAnnotationComposer,
        $$BibleCrossReferencesTableCreateCompanionBuilder,
        $$BibleCrossReferencesTableUpdateCompanionBuilder,
        (
          BibleCrossReference,
          BaseReferences<_$AppDatabase, $BibleCrossReferencesTable,
              BibleCrossReference>
        ),
        BibleCrossReference,
        PrefetchHooks Function()>;
typedef $$PsalisTableCreateCompanionBuilder = PsalisCompanion Function({
  Value<int> id,
  required String psaliId,
  required String type,
  required String nameAr,
  Value<String?> nameCoptic,
  Value<String?> namePhonetic,
  required String occasion,
  Value<String?> dayOfWeek,
  Value<String?> season,
  required int order,
});
typedef $$PsalisTableUpdateCompanionBuilder = PsalisCompanion Function({
  Value<int> id,
  Value<String> psaliId,
  Value<String> type,
  Value<String> nameAr,
  Value<String?> nameCoptic,
  Value<String?> namePhonetic,
  Value<String> occasion,
  Value<String?> dayOfWeek,
  Value<String?> season,
  Value<int> order,
});

class $$PsalisTableFilterComposer
    extends Composer<_$AppDatabase, $PsalisTable> {
  $$PsalisTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get psaliId => $composableBuilder(
      column: $table.psaliId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameCoptic => $composableBuilder(
      column: $table.nameCoptic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get namePhonetic => $composableBuilder(
      column: $table.namePhonetic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get occasion => $composableBuilder(
      column: $table.occasion, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dayOfWeek => $composableBuilder(
      column: $table.dayOfWeek, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get season => $composableBuilder(
      column: $table.season, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnFilters(column));
}

class $$PsalisTableOrderingComposer
    extends Composer<_$AppDatabase, $PsalisTable> {
  $$PsalisTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get psaliId => $composableBuilder(
      column: $table.psaliId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameCoptic => $composableBuilder(
      column: $table.nameCoptic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get namePhonetic => $composableBuilder(
      column: $table.namePhonetic,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get occasion => $composableBuilder(
      column: $table.occasion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dayOfWeek => $composableBuilder(
      column: $table.dayOfWeek, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get season => $composableBuilder(
      column: $table.season, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnOrderings(column));
}

class $$PsalisTableAnnotationComposer
    extends Composer<_$AppDatabase, $PsalisTable> {
  $$PsalisTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get psaliId =>
      $composableBuilder(column: $table.psaliId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get nameAr =>
      $composableBuilder(column: $table.nameAr, builder: (column) => column);

  GeneratedColumn<String> get nameCoptic => $composableBuilder(
      column: $table.nameCoptic, builder: (column) => column);

  GeneratedColumn<String> get namePhonetic => $composableBuilder(
      column: $table.namePhonetic, builder: (column) => column);

  GeneratedColumn<String> get occasion =>
      $composableBuilder(column: $table.occasion, builder: (column) => column);

  GeneratedColumn<String> get dayOfWeek =>
      $composableBuilder(column: $table.dayOfWeek, builder: (column) => column);

  GeneratedColumn<String> get season =>
      $composableBuilder(column: $table.season, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);
}

class $$PsalisTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PsalisTable,
    Psali,
    $$PsalisTableFilterComposer,
    $$PsalisTableOrderingComposer,
    $$PsalisTableAnnotationComposer,
    $$PsalisTableCreateCompanionBuilder,
    $$PsalisTableUpdateCompanionBuilder,
    (Psali, BaseReferences<_$AppDatabase, $PsalisTable, Psali>),
    Psali,
    PrefetchHooks Function()> {
  $$PsalisTableTableManager(_$AppDatabase db, $PsalisTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PsalisTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PsalisTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PsalisTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> psaliId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> nameAr = const Value.absent(),
            Value<String?> nameCoptic = const Value.absent(),
            Value<String?> namePhonetic = const Value.absent(),
            Value<String> occasion = const Value.absent(),
            Value<String?> dayOfWeek = const Value.absent(),
            Value<String?> season = const Value.absent(),
            Value<int> order = const Value.absent(),
          }) =>
              PsalisCompanion(
            id: id,
            psaliId: psaliId,
            type: type,
            nameAr: nameAr,
            nameCoptic: nameCoptic,
            namePhonetic: namePhonetic,
            occasion: occasion,
            dayOfWeek: dayOfWeek,
            season: season,
            order: order,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String psaliId,
            required String type,
            required String nameAr,
            Value<String?> nameCoptic = const Value.absent(),
            Value<String?> namePhonetic = const Value.absent(),
            required String occasion,
            Value<String?> dayOfWeek = const Value.absent(),
            Value<String?> season = const Value.absent(),
            required int order,
          }) =>
              PsalisCompanion.insert(
            id: id,
            psaliId: psaliId,
            type: type,
            nameAr: nameAr,
            nameCoptic: nameCoptic,
            namePhonetic: namePhonetic,
            occasion: occasion,
            dayOfWeek: dayOfWeek,
            season: season,
            order: order,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$PsalisTable, Psali>(table),
                    BaseReferences<_$AppDatabase, $PsalisTable, Psali>(
                        db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PsalisTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PsalisTable,
    Psali,
    $$PsalisTableFilterComposer,
    $$PsalisTableOrderingComposer,
    $$PsalisTableAnnotationComposer,
    $$PsalisTableCreateCompanionBuilder,
    $$PsalisTableUpdateCompanionBuilder,
    (Psali, BaseReferences<_$AppDatabase, $PsalisTable, Psali>),
    Psali,
    PrefetchHooks Function()>;
typedef $$PsaliSectionsTableCreateCompanionBuilder = PsaliSectionsCompanion
    Function({
  Value<int> id,
  required String psaliId,
  required int sectionOrder,
  required String textCoptic,
  required String textPhonetic,
  required String textArabic,
  Value<String?> rubric,
  Value<String?> response,
});
typedef $$PsaliSectionsTableUpdateCompanionBuilder = PsaliSectionsCompanion
    Function({
  Value<int> id,
  Value<String> psaliId,
  Value<int> sectionOrder,
  Value<String> textCoptic,
  Value<String> textPhonetic,
  Value<String> textArabic,
  Value<String?> rubric,
  Value<String?> response,
});

class $$PsaliSectionsTableFilterComposer
    extends Composer<_$AppDatabase, $PsaliSectionsTable> {
  $$PsaliSectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get psaliId => $composableBuilder(
      column: $table.psaliId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sectionOrder => $composableBuilder(
      column: $table.sectionOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get textCoptic => $composableBuilder(
      column: $table.textCoptic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get textPhonetic => $composableBuilder(
      column: $table.textPhonetic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get textArabic => $composableBuilder(
      column: $table.textArabic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rubric => $composableBuilder(
      column: $table.rubric, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get response => $composableBuilder(
      column: $table.response, builder: (column) => ColumnFilters(column));
}

class $$PsaliSectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $PsaliSectionsTable> {
  $$PsaliSectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get psaliId => $composableBuilder(
      column: $table.psaliId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sectionOrder => $composableBuilder(
      column: $table.sectionOrder,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get textCoptic => $composableBuilder(
      column: $table.textCoptic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get textPhonetic => $composableBuilder(
      column: $table.textPhonetic,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get textArabic => $composableBuilder(
      column: $table.textArabic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rubric => $composableBuilder(
      column: $table.rubric, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get response => $composableBuilder(
      column: $table.response, builder: (column) => ColumnOrderings(column));
}

class $$PsaliSectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PsaliSectionsTable> {
  $$PsaliSectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get psaliId =>
      $composableBuilder(column: $table.psaliId, builder: (column) => column);

  GeneratedColumn<int> get sectionOrder => $composableBuilder(
      column: $table.sectionOrder, builder: (column) => column);

  GeneratedColumn<String> get textCoptic => $composableBuilder(
      column: $table.textCoptic, builder: (column) => column);

  GeneratedColumn<String> get textPhonetic => $composableBuilder(
      column: $table.textPhonetic, builder: (column) => column);

  GeneratedColumn<String> get textArabic => $composableBuilder(
      column: $table.textArabic, builder: (column) => column);

  GeneratedColumn<String> get rubric =>
      $composableBuilder(column: $table.rubric, builder: (column) => column);

  GeneratedColumn<String> get response =>
      $composableBuilder(column: $table.response, builder: (column) => column);
}

class $$PsaliSectionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PsaliSectionsTable,
    PsaliSection,
    $$PsaliSectionsTableFilterComposer,
    $$PsaliSectionsTableOrderingComposer,
    $$PsaliSectionsTableAnnotationComposer,
    $$PsaliSectionsTableCreateCompanionBuilder,
    $$PsaliSectionsTableUpdateCompanionBuilder,
    (
      PsaliSection,
      BaseReferences<_$AppDatabase, $PsaliSectionsTable, PsaliSection>
    ),
    PsaliSection,
    PrefetchHooks Function()> {
  $$PsaliSectionsTableTableManager(_$AppDatabase db, $PsaliSectionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PsaliSectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PsaliSectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PsaliSectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> psaliId = const Value.absent(),
            Value<int> sectionOrder = const Value.absent(),
            Value<String> textCoptic = const Value.absent(),
            Value<String> textPhonetic = const Value.absent(),
            Value<String> textArabic = const Value.absent(),
            Value<String?> rubric = const Value.absent(),
            Value<String?> response = const Value.absent(),
          }) =>
              PsaliSectionsCompanion(
            id: id,
            psaliId: psaliId,
            sectionOrder: sectionOrder,
            textCoptic: textCoptic,
            textPhonetic: textPhonetic,
            textArabic: textArabic,
            rubric: rubric,
            response: response,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String psaliId,
            required int sectionOrder,
            required String textCoptic,
            required String textPhonetic,
            required String textArabic,
            Value<String?> rubric = const Value.absent(),
            Value<String?> response = const Value.absent(),
          }) =>
              PsaliSectionsCompanion.insert(
            id: id,
            psaliId: psaliId,
            sectionOrder: sectionOrder,
            textCoptic: textCoptic,
            textPhonetic: textPhonetic,
            textArabic: textArabic,
            rubric: rubric,
            response: response,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$PsaliSectionsTable, PsaliSection>(table),
                    BaseReferences<_$AppDatabase, $PsaliSectionsTable,
                        PsaliSection>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PsaliSectionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PsaliSectionsTable,
    PsaliSection,
    $$PsaliSectionsTableFilterComposer,
    $$PsaliSectionsTableOrderingComposer,
    $$PsaliSectionsTableAnnotationComposer,
    $$PsaliSectionsTableCreateCompanionBuilder,
    $$PsaliSectionsTableUpdateCompanionBuilder,
    (
      PsaliSection,
      BaseReferences<_$AppDatabase, $PsaliSectionsTable, PsaliSection>
    ),
    PsaliSection,
    PrefetchHooks Function()>;
typedef $$RitesTableCreateCompanionBuilder = RitesCompanion Function({
  Value<int> id,
  required String nameAr,
  Value<String?> nameEn,
  Value<String?> nameCoptic,
  required String category,
  Value<String?> description,
  required int sortOrder,
  Value<String?> icon,
});
typedef $$RitesTableUpdateCompanionBuilder = RitesCompanion Function({
  Value<int> id,
  Value<String> nameAr,
  Value<String?> nameEn,
  Value<String?> nameCoptic,
  Value<String> category,
  Value<String?> description,
  Value<int> sortOrder,
  Value<String?> icon,
});

final class $$RitesTableReferences
    extends BaseReferences<_$AppDatabase, $RitesTable, Rite> {
  $$RitesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RiteSectionsTable, List<RiteSection>>
      _riteSectionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.riteSections,
              aliasName: 'rites__id__rite_sections__rite_id');

  $$RiteSectionsTableProcessedTableManager get riteSectionsRefs {
    final manager = $$RiteSectionsTableTableManager($_db, $_db.riteSections)
        .filter((f) => f.riteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_riteSectionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$RitesTableFilterComposer extends Composer<_$AppDatabase, $RitesTable> {
  $$RitesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameCoptic => $composableBuilder(
      column: $table.nameCoptic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  Expression<bool> riteSectionsRefs(
      Expression<bool> Function($$RiteSectionsTableFilterComposer f) f) {
    final $$RiteSectionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.riteSections,
        getReferencedColumn: (t) => t.riteId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RiteSectionsTableFilterComposer(
              $db: $db,
              $table: $db.riteSections,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RitesTableOrderingComposer
    extends Composer<_$AppDatabase, $RitesTable> {
  $$RitesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameCoptic => $composableBuilder(
      column: $table.nameCoptic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));
}

class $$RitesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RitesTable> {
  $$RitesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameAr =>
      $composableBuilder(column: $table.nameAr, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameCoptic => $composableBuilder(
      column: $table.nameCoptic, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  Expression<T> riteSectionsRefs<T extends Object>(
      Expression<T> Function($$RiteSectionsTableAnnotationComposer a) f) {
    final $$RiteSectionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.riteSections,
        getReferencedColumn: (t) => t.riteId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RiteSectionsTableAnnotationComposer(
              $db: $db,
              $table: $db.riteSections,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RitesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RitesTable,
    Rite,
    $$RitesTableFilterComposer,
    $$RitesTableOrderingComposer,
    $$RitesTableAnnotationComposer,
    $$RitesTableCreateCompanionBuilder,
    $$RitesTableUpdateCompanionBuilder,
    (Rite, $$RitesTableReferences),
    Rite,
    PrefetchHooks Function({bool riteSectionsRefs})> {
  $$RitesTableTableManager(_$AppDatabase db, $RitesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RitesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RitesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RitesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nameAr = const Value.absent(),
            Value<String?> nameEn = const Value.absent(),
            Value<String?> nameCoptic = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<String?> icon = const Value.absent(),
          }) =>
              RitesCompanion(
            id: id,
            nameAr: nameAr,
            nameEn: nameEn,
            nameCoptic: nameCoptic,
            category: category,
            description: description,
            sortOrder: sortOrder,
            icon: icon,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nameAr,
            Value<String?> nameEn = const Value.absent(),
            Value<String?> nameCoptic = const Value.absent(),
            required String category,
            Value<String?> description = const Value.absent(),
            required int sortOrder,
            Value<String?> icon = const Value.absent(),
          }) =>
              RitesCompanion.insert(
            id: id,
            nameAr: nameAr,
            nameEn: nameEn,
            nameCoptic: nameCoptic,
            category: category,
            description: description,
            sortOrder: sortOrder,
            icon: icon,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$RitesTable, Rite>(table),
                    $$RitesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({riteSectionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (riteSectionsRefs) db.riteSections],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (riteSectionsRefs)
                    await $_getPrefetchedData<Rite, $RitesTable, RiteSection>(
                        currentTable: table,
                        referencedTable:
                            $$RitesTableReferences._riteSectionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RitesTableReferences(db, table, p0)
                                .riteSectionsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.riteId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$RitesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RitesTable,
    Rite,
    $$RitesTableFilterComposer,
    $$RitesTableOrderingComposer,
    $$RitesTableAnnotationComposer,
    $$RitesTableCreateCompanionBuilder,
    $$RitesTableUpdateCompanionBuilder,
    (Rite, $$RitesTableReferences),
    Rite,
    PrefetchHooks Function({bool riteSectionsRefs})>;
typedef $$RiteSectionsTableCreateCompanionBuilder = RiteSectionsCompanion
    Function({
  Value<int> id,
  required int riteId,
  required String titleAr,
  required String textAr,
  Value<String?> copticText,
  Value<String?> copticArabicText,
  Value<String?> rubric,
  Value<String?> response,
  required int sortOrder,
});
typedef $$RiteSectionsTableUpdateCompanionBuilder = RiteSectionsCompanion
    Function({
  Value<int> id,
  Value<int> riteId,
  Value<String> titleAr,
  Value<String> textAr,
  Value<String?> copticText,
  Value<String?> copticArabicText,
  Value<String?> rubric,
  Value<String?> response,
  Value<int> sortOrder,
});

final class $$RiteSectionsTableReferences
    extends BaseReferences<_$AppDatabase, $RiteSectionsTable, RiteSection> {
  $$RiteSectionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RitesTable _riteIdTable(_$AppDatabase db) =>
      db.rites.createAlias('rite_sections__rite_id__rites__id');

  $$RitesTableProcessedTableManager get riteId {
    final $_column = $_itemColumn<int>('rite_id')!;

    final manager = $$RitesTableTableManager($_db, $_db.rites)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_riteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$RiteSectionsTableFilterComposer
    extends Composer<_$AppDatabase, $RiteSectionsTable> {
  $$RiteSectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get titleAr => $composableBuilder(
      column: $table.titleAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get textAr => $composableBuilder(
      column: $table.textAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get copticText => $composableBuilder(
      column: $table.copticText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get copticArabicText => $composableBuilder(
      column: $table.copticArabicText,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rubric => $composableBuilder(
      column: $table.rubric, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get response => $composableBuilder(
      column: $table.response, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  $$RitesTableFilterComposer get riteId {
    final $$RitesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.riteId,
        referencedTable: $db.rites,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RitesTableFilterComposer(
              $db: $db,
              $table: $db.rites,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RiteSectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $RiteSectionsTable> {
  $$RiteSectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get titleAr => $composableBuilder(
      column: $table.titleAr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get textAr => $composableBuilder(
      column: $table.textAr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get copticText => $composableBuilder(
      column: $table.copticText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get copticArabicText => $composableBuilder(
      column: $table.copticArabicText,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rubric => $composableBuilder(
      column: $table.rubric, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get response => $composableBuilder(
      column: $table.response, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  $$RitesTableOrderingComposer get riteId {
    final $$RitesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.riteId,
        referencedTable: $db.rites,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RitesTableOrderingComposer(
              $db: $db,
              $table: $db.rites,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RiteSectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RiteSectionsTable> {
  $$RiteSectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get titleAr =>
      $composableBuilder(column: $table.titleAr, builder: (column) => column);

  GeneratedColumn<String> get textAr =>
      $composableBuilder(column: $table.textAr, builder: (column) => column);

  GeneratedColumn<String> get copticText => $composableBuilder(
      column: $table.copticText, builder: (column) => column);

  GeneratedColumn<String> get copticArabicText => $composableBuilder(
      column: $table.copticArabicText, builder: (column) => column);

  GeneratedColumn<String> get rubric =>
      $composableBuilder(column: $table.rubric, builder: (column) => column);

  GeneratedColumn<String> get response =>
      $composableBuilder(column: $table.response, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$RitesTableAnnotationComposer get riteId {
    final $$RitesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.riteId,
        referencedTable: $db.rites,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RitesTableAnnotationComposer(
              $db: $db,
              $table: $db.rites,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RiteSectionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RiteSectionsTable,
    RiteSection,
    $$RiteSectionsTableFilterComposer,
    $$RiteSectionsTableOrderingComposer,
    $$RiteSectionsTableAnnotationComposer,
    $$RiteSectionsTableCreateCompanionBuilder,
    $$RiteSectionsTableUpdateCompanionBuilder,
    (RiteSection, $$RiteSectionsTableReferences),
    RiteSection,
    PrefetchHooks Function({bool riteId})> {
  $$RiteSectionsTableTableManager(_$AppDatabase db, $RiteSectionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RiteSectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RiteSectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RiteSectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> riteId = const Value.absent(),
            Value<String> titleAr = const Value.absent(),
            Value<String> textAr = const Value.absent(),
            Value<String?> copticText = const Value.absent(),
            Value<String?> copticArabicText = const Value.absent(),
            Value<String?> rubric = const Value.absent(),
            Value<String?> response = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
          }) =>
              RiteSectionsCompanion(
            id: id,
            riteId: riteId,
            titleAr: titleAr,
            textAr: textAr,
            copticText: copticText,
            copticArabicText: copticArabicText,
            rubric: rubric,
            response: response,
            sortOrder: sortOrder,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int riteId,
            required String titleAr,
            required String textAr,
            Value<String?> copticText = const Value.absent(),
            Value<String?> copticArabicText = const Value.absent(),
            Value<String?> rubric = const Value.absent(),
            Value<String?> response = const Value.absent(),
            required int sortOrder,
          }) =>
              RiteSectionsCompanion.insert(
            id: id,
            riteId: riteId,
            titleAr: titleAr,
            textAr: textAr,
            copticText: copticText,
            copticArabicText: copticArabicText,
            rubric: rubric,
            response: response,
            sortOrder: sortOrder,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$RiteSectionsTable, RiteSection>(table),
                    $$RiteSectionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({riteId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (riteId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.riteId,
                    referencedTable:
                        $$RiteSectionsTableReferences._riteIdTable(db),
                    referencedColumn:
                        $$RiteSectionsTableReferences._riteIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$RiteSectionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RiteSectionsTable,
    RiteSection,
    $$RiteSectionsTableFilterComposer,
    $$RiteSectionsTableOrderingComposer,
    $$RiteSectionsTableAnnotationComposer,
    $$RiteSectionsTableCreateCompanionBuilder,
    $$RiteSectionsTableUpdateCompanionBuilder,
    (RiteSection, $$RiteSectionsTableReferences),
    RiteSection,
    PrefetchHooks Function({bool riteId})>;
typedef $$HolyPlacesTableCreateCompanionBuilder = HolyPlacesCompanion Function({
  Value<int> id,
  required String nameAr,
  Value<String?> nameCoptic,
  required String type,
  required String governorate,
  required String locationDescription,
  Value<double?> latitude,
  Value<double?> longitude,
  Value<String?> century,
  Value<String?> patronSaint,
  required String history,
  Value<String?> feastDay,
  Value<String?> visitingRules,
  required int sortOrder,
});
typedef $$HolyPlacesTableUpdateCompanionBuilder = HolyPlacesCompanion Function({
  Value<int> id,
  Value<String> nameAr,
  Value<String?> nameCoptic,
  Value<String> type,
  Value<String> governorate,
  Value<String> locationDescription,
  Value<double?> latitude,
  Value<double?> longitude,
  Value<String?> century,
  Value<String?> patronSaint,
  Value<String> history,
  Value<String?> feastDay,
  Value<String?> visitingRules,
  Value<int> sortOrder,
});

class $$HolyPlacesTableFilterComposer
    extends Composer<_$AppDatabase, $HolyPlacesTable> {
  $$HolyPlacesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameCoptic => $composableBuilder(
      column: $table.nameCoptic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get governorate => $composableBuilder(
      column: $table.governorate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locationDescription => $composableBuilder(
      column: $table.locationDescription,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get century => $composableBuilder(
      column: $table.century, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get patronSaint => $composableBuilder(
      column: $table.patronSaint, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get history => $composableBuilder(
      column: $table.history, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get feastDay => $composableBuilder(
      column: $table.feastDay, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get visitingRules => $composableBuilder(
      column: $table.visitingRules, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));
}

class $$HolyPlacesTableOrderingComposer
    extends Composer<_$AppDatabase, $HolyPlacesTable> {
  $$HolyPlacesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameCoptic => $composableBuilder(
      column: $table.nameCoptic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get governorate => $composableBuilder(
      column: $table.governorate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locationDescription => $composableBuilder(
      column: $table.locationDescription,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get century => $composableBuilder(
      column: $table.century, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get patronSaint => $composableBuilder(
      column: $table.patronSaint, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get history => $composableBuilder(
      column: $table.history, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get feastDay => $composableBuilder(
      column: $table.feastDay, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get visitingRules => $composableBuilder(
      column: $table.visitingRules,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));
}

class $$HolyPlacesTableAnnotationComposer
    extends Composer<_$AppDatabase, $HolyPlacesTable> {
  $$HolyPlacesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameAr =>
      $composableBuilder(column: $table.nameAr, builder: (column) => column);

  GeneratedColumn<String> get nameCoptic => $composableBuilder(
      column: $table.nameCoptic, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get governorate => $composableBuilder(
      column: $table.governorate, builder: (column) => column);

  GeneratedColumn<String> get locationDescription => $composableBuilder(
      column: $table.locationDescription, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get century =>
      $composableBuilder(column: $table.century, builder: (column) => column);

  GeneratedColumn<String> get patronSaint => $composableBuilder(
      column: $table.patronSaint, builder: (column) => column);

  GeneratedColumn<String> get history =>
      $composableBuilder(column: $table.history, builder: (column) => column);

  GeneratedColumn<String> get feastDay =>
      $composableBuilder(column: $table.feastDay, builder: (column) => column);

  GeneratedColumn<String> get visitingRules => $composableBuilder(
      column: $table.visitingRules, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$HolyPlacesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HolyPlacesTable,
    HolyPlace,
    $$HolyPlacesTableFilterComposer,
    $$HolyPlacesTableOrderingComposer,
    $$HolyPlacesTableAnnotationComposer,
    $$HolyPlacesTableCreateCompanionBuilder,
    $$HolyPlacesTableUpdateCompanionBuilder,
    (HolyPlace, BaseReferences<_$AppDatabase, $HolyPlacesTable, HolyPlace>),
    HolyPlace,
    PrefetchHooks Function()> {
  $$HolyPlacesTableTableManager(_$AppDatabase db, $HolyPlacesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HolyPlacesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HolyPlacesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HolyPlacesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nameAr = const Value.absent(),
            Value<String?> nameCoptic = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> governorate = const Value.absent(),
            Value<String> locationDescription = const Value.absent(),
            Value<double?> latitude = const Value.absent(),
            Value<double?> longitude = const Value.absent(),
            Value<String?> century = const Value.absent(),
            Value<String?> patronSaint = const Value.absent(),
            Value<String> history = const Value.absent(),
            Value<String?> feastDay = const Value.absent(),
            Value<String?> visitingRules = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
          }) =>
              HolyPlacesCompanion(
            id: id,
            nameAr: nameAr,
            nameCoptic: nameCoptic,
            type: type,
            governorate: governorate,
            locationDescription: locationDescription,
            latitude: latitude,
            longitude: longitude,
            century: century,
            patronSaint: patronSaint,
            history: history,
            feastDay: feastDay,
            visitingRules: visitingRules,
            sortOrder: sortOrder,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nameAr,
            Value<String?> nameCoptic = const Value.absent(),
            required String type,
            required String governorate,
            required String locationDescription,
            Value<double?> latitude = const Value.absent(),
            Value<double?> longitude = const Value.absent(),
            Value<String?> century = const Value.absent(),
            Value<String?> patronSaint = const Value.absent(),
            required String history,
            Value<String?> feastDay = const Value.absent(),
            Value<String?> visitingRules = const Value.absent(),
            required int sortOrder,
          }) =>
              HolyPlacesCompanion.insert(
            id: id,
            nameAr: nameAr,
            nameCoptic: nameCoptic,
            type: type,
            governorate: governorate,
            locationDescription: locationDescription,
            latitude: latitude,
            longitude: longitude,
            century: century,
            patronSaint: patronSaint,
            history: history,
            feastDay: feastDay,
            visitingRules: visitingRules,
            sortOrder: sortOrder,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$HolyPlacesTable, HolyPlace>(table),
                    BaseReferences<_$AppDatabase, $HolyPlacesTable, HolyPlace>(
                        db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HolyPlacesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HolyPlacesTable,
    HolyPlace,
    $$HolyPlacesTableFilterComposer,
    $$HolyPlacesTableOrderingComposer,
    $$HolyPlacesTableAnnotationComposer,
    $$HolyPlacesTableCreateCompanionBuilder,
    $$HolyPlacesTableUpdateCompanionBuilder,
    (HolyPlace, BaseReferences<_$AppDatabase, $HolyPlacesTable, HolyPlace>),
    HolyPlace,
    PrefetchHooks Function()>;
typedef $$EmotionPrayersTableCreateCompanionBuilder = EmotionPrayersCompanion
    Function({
  Value<int> id,
  required String category,
  required String title,
  required String verseText,
  required String verseReference,
  Value<String?> psalmText,
  Value<String?> psalmReference,
  Value<String?> agpeyaPrayer,
  Value<String?> agpeyaReference,
  required String meditation,
  required int sortOrder,
});
typedef $$EmotionPrayersTableUpdateCompanionBuilder = EmotionPrayersCompanion
    Function({
  Value<int> id,
  Value<String> category,
  Value<String> title,
  Value<String> verseText,
  Value<String> verseReference,
  Value<String?> psalmText,
  Value<String?> psalmReference,
  Value<String?> agpeyaPrayer,
  Value<String?> agpeyaReference,
  Value<String> meditation,
  Value<int> sortOrder,
});

class $$EmotionPrayersTableFilterComposer
    extends Composer<_$AppDatabase, $EmotionPrayersTable> {
  $$EmotionPrayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get verseText => $composableBuilder(
      column: $table.verseText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get verseReference => $composableBuilder(
      column: $table.verseReference,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get psalmText => $composableBuilder(
      column: $table.psalmText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get psalmReference => $composableBuilder(
      column: $table.psalmReference,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get agpeyaPrayer => $composableBuilder(
      column: $table.agpeyaPrayer, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get agpeyaReference => $composableBuilder(
      column: $table.agpeyaReference,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get meditation => $composableBuilder(
      column: $table.meditation, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));
}

class $$EmotionPrayersTableOrderingComposer
    extends Composer<_$AppDatabase, $EmotionPrayersTable> {
  $$EmotionPrayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get verseText => $composableBuilder(
      column: $table.verseText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get verseReference => $composableBuilder(
      column: $table.verseReference,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get psalmText => $composableBuilder(
      column: $table.psalmText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get psalmReference => $composableBuilder(
      column: $table.psalmReference,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get agpeyaPrayer => $composableBuilder(
      column: $table.agpeyaPrayer,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get agpeyaReference => $composableBuilder(
      column: $table.agpeyaReference,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get meditation => $composableBuilder(
      column: $table.meditation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));
}

class $$EmotionPrayersTableAnnotationComposer
    extends Composer<_$AppDatabase, $EmotionPrayersTable> {
  $$EmotionPrayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get verseText =>
      $composableBuilder(column: $table.verseText, builder: (column) => column);

  GeneratedColumn<String> get verseReference => $composableBuilder(
      column: $table.verseReference, builder: (column) => column);

  GeneratedColumn<String> get psalmText =>
      $composableBuilder(column: $table.psalmText, builder: (column) => column);

  GeneratedColumn<String> get psalmReference => $composableBuilder(
      column: $table.psalmReference, builder: (column) => column);

  GeneratedColumn<String> get agpeyaPrayer => $composableBuilder(
      column: $table.agpeyaPrayer, builder: (column) => column);

  GeneratedColumn<String> get agpeyaReference => $composableBuilder(
      column: $table.agpeyaReference, builder: (column) => column);

  GeneratedColumn<String> get meditation => $composableBuilder(
      column: $table.meditation, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$EmotionPrayersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EmotionPrayersTable,
    EmotionPrayer,
    $$EmotionPrayersTableFilterComposer,
    $$EmotionPrayersTableOrderingComposer,
    $$EmotionPrayersTableAnnotationComposer,
    $$EmotionPrayersTableCreateCompanionBuilder,
    $$EmotionPrayersTableUpdateCompanionBuilder,
    (
      EmotionPrayer,
      BaseReferences<_$AppDatabase, $EmotionPrayersTable, EmotionPrayer>
    ),
    EmotionPrayer,
    PrefetchHooks Function()> {
  $$EmotionPrayersTableTableManager(
      _$AppDatabase db, $EmotionPrayersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmotionPrayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmotionPrayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmotionPrayersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> verseText = const Value.absent(),
            Value<String> verseReference = const Value.absent(),
            Value<String?> psalmText = const Value.absent(),
            Value<String?> psalmReference = const Value.absent(),
            Value<String?> agpeyaPrayer = const Value.absent(),
            Value<String?> agpeyaReference = const Value.absent(),
            Value<String> meditation = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
          }) =>
              EmotionPrayersCompanion(
            id: id,
            category: category,
            title: title,
            verseText: verseText,
            verseReference: verseReference,
            psalmText: psalmText,
            psalmReference: psalmReference,
            agpeyaPrayer: agpeyaPrayer,
            agpeyaReference: agpeyaReference,
            meditation: meditation,
            sortOrder: sortOrder,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String category,
            required String title,
            required String verseText,
            required String verseReference,
            Value<String?> psalmText = const Value.absent(),
            Value<String?> psalmReference = const Value.absent(),
            Value<String?> agpeyaPrayer = const Value.absent(),
            Value<String?> agpeyaReference = const Value.absent(),
            required String meditation,
            required int sortOrder,
          }) =>
              EmotionPrayersCompanion.insert(
            id: id,
            category: category,
            title: title,
            verseText: verseText,
            verseReference: verseReference,
            psalmText: psalmText,
            psalmReference: psalmReference,
            agpeyaPrayer: agpeyaPrayer,
            agpeyaReference: agpeyaReference,
            meditation: meditation,
            sortOrder: sortOrder,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$EmotionPrayersTable, EmotionPrayer>(table),
                    BaseReferences<_$AppDatabase, $EmotionPrayersTable,
                        EmotionPrayer>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$EmotionPrayersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EmotionPrayersTable,
    EmotionPrayer,
    $$EmotionPrayersTableFilterComposer,
    $$EmotionPrayersTableOrderingComposer,
    $$EmotionPrayersTableAnnotationComposer,
    $$EmotionPrayersTableCreateCompanionBuilder,
    $$EmotionPrayersTableUpdateCompanionBuilder,
    (
      EmotionPrayer,
      BaseReferences<_$AppDatabase, $EmotionPrayersTable, EmotionPrayer>
    ),
    EmotionPrayer,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BibleBooksTableTableManager get bibleBooks =>
      $$BibleBooksTableTableManager(_db, _db.bibleBooks);
  $$BibleVersesTableTableManager get bibleVerses =>
      $$BibleVersesTableTableManager(_db, _db.bibleVerses);
  $$AgpeyaHoursTableTableManager get agpeyaHours =>
      $$AgpeyaHoursTableTableManager(_db, _db.agpeyaHours);
  $$AgpeyaSectionsTableTableManager get agpeyaSections =>
      $$AgpeyaSectionsTableTableManager(_db, _db.agpeyaSections);
  $$LiturgiesTableTableManager get liturgies =>
      $$LiturgiesTableTableManager(_db, _db.liturgies);
  $$LiturgySectionsTableTableManager get liturgySections =>
      $$LiturgySectionsTableTableManager(_db, _db.liturgySections);
  $$LiturgyPartsTableTableManager get liturgyParts =>
      $$LiturgyPartsTableTableManager(_db, _db.liturgyParts);
  $$HymnBooksTableTableManager get hymnBooks =>
      $$HymnBooksTableTableManager(_db, _db.hymnBooks);
  $$HymnsTableTableManager get hymns =>
      $$HymnsTableTableManager(_db, _db.hymns);
  $$HymnSegmentsTableTableManager get hymnSegments =>
      $$HymnSegmentsTableTableManager(_db, _db.hymnSegments);
  $$SynaxariumEntriesTableTableManager get synaxariumEntries =>
      $$SynaxariumEntriesTableTableManager(_db, _db.synaxariumEntries);
  $$KatamerosReadingsTableTableManager get katamerosReadings =>
      $$KatamerosReadingsTableTableManager(_db, _db.katamerosReadings);
  $$SaintsTableTableManager get saints =>
      $$SaintsTableTableManager(_db, _db.saints);
  $$DifnarEntriesTableTableManager get difnarEntries =>
      $$DifnarEntriesTableTableManager(_db, _db.difnarEntries);
  $$PaschaReadingsTableTableManager get paschaReadings =>
      $$PaschaReadingsTableTableManager(_db, _db.paschaReadings);
  $$FeastsAndFastsTableTableManager get feastsAndFasts =>
      $$FeastsAndFastsTableTableManager(_db, _db.feastsAndFasts);
  $$OccasionalPrayersTableTableManager get occasionalPrayers =>
      $$OccasionalPrayersTableTableManager(_db, _db.occasionalPrayers);
  $$TheologyArticlesTableTableManager get theologyArticles =>
      $$TheologyArticlesTableTableManager(_db, _db.theologyArticles);
  $$DailyVersesTableTableManager get dailyVerses =>
      $$DailyVersesTableTableManager(_db, _db.dailyVerses);
  $$BookmarksTableTableManager get bookmarks =>
      $$BookmarksTableTableManager(_db, _db.bookmarks);
  $$SacramentsTableTableManager get sacraments =>
      $$SacramentsTableTableManager(_db, _db.sacraments);
  $$SacramentSectionsTableTableManager get sacramentSections =>
      $$SacramentSectionsTableTableManager(_db, _db.sacramentSections);
  $$MonasteriesTableTableManager get monasteries =>
      $$MonasteriesTableTableManager(_db, _db.monasteries);
  $$BibleCommentariesTableTableManager get bibleCommentaries =>
      $$BibleCommentariesTableTableManager(_db, _db.bibleCommentaries);
  $$CopticDictionaryTableTableManager get copticDictionary =>
      $$CopticDictionaryTableTableManager(_db, _db.copticDictionary);
  $$BibleCrossReferencesTableTableManager get bibleCrossReferences =>
      $$BibleCrossReferencesTableTableManager(_db, _db.bibleCrossReferences);
  $$PsalisTableTableManager get psalis =>
      $$PsalisTableTableManager(_db, _db.psalis);
  $$PsaliSectionsTableTableManager get psaliSections =>
      $$PsaliSectionsTableTableManager(_db, _db.psaliSections);
  $$RitesTableTableManager get rites =>
      $$RitesTableTableManager(_db, _db.rites);
  $$RiteSectionsTableTableManager get riteSections =>
      $$RiteSectionsTableTableManager(_db, _db.riteSections);
  $$HolyPlacesTableTableManager get holyPlaces =>
      $$HolyPlacesTableTableManager(_db, _db.holyPlaces);
  $$EmotionPrayersTableTableManager get emotionPrayers =>
      $$EmotionPrayersTableTableManager(_db, _db.emotionPrayers);
}
