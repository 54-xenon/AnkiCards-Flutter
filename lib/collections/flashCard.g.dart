// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashCard.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFlashCardCollection on Isar {
  IsarCollection<FlashCard> get flashCards => this.collection();
}

const FlashCardSchema = CollectionSchema(
  name: r'FlashCard',
  id: 2394645075128407362,
  properties: {
    r'answer': PropertySchema(
      id: 0,
      name: r'answer',
      type: IsarType.string,
    ),
    r'explanation': PropertySchema(
      id: 1,
      name: r'explanation',
      type: IsarType.string,
    ),
    r'isCorrect': PropertySchema(
      id: 2,
      name: r'isCorrect',
      type: IsarType.bool,
    ),
    r'question': PropertySchema(
      id: 3,
      name: r'question',
      type: IsarType.string,
    )
  },
  estimateSize: _flashCardEstimateSize,
  serialize: _flashCardSerialize,
  deserialize: _flashCardDeserialize,
  deserializeProp: _flashCardDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _flashCardGetId,
  getLinks: _flashCardGetLinks,
  attach: _flashCardAttach,
  version: '3.1.0+1',
);

int _flashCardEstimateSize(
  FlashCard object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.answer.length * 3;
  bytesCount += 3 + object.explanation.length * 3;
  bytesCount += 3 + object.question.length * 3;
  return bytesCount;
}

void _flashCardSerialize(
  FlashCard object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.answer);
  writer.writeString(offsets[1], object.explanation);
  writer.writeBool(offsets[2], object.isCorrect);
  writer.writeString(offsets[3], object.question);
}

FlashCard _flashCardDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FlashCard();
  object.answer = reader.readString(offsets[0]);
  object.explanation = reader.readString(offsets[1]);
  object.id = id;
  object.isCorrect = reader.readBoolOrNull(offsets[2]);
  object.question = reader.readString(offsets[3]);
  return object;
}

P _flashCardDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readBoolOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _flashCardGetId(FlashCard object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _flashCardGetLinks(FlashCard object) {
  return [];
}

void _flashCardAttach(IsarCollection<dynamic> col, Id id, FlashCard object) {
  object.id = id;
}

extension FlashCardQueryWhereSort
    on QueryBuilder<FlashCard, FlashCard, QWhere> {
  QueryBuilder<FlashCard, FlashCard, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FlashCardQueryWhere
    on QueryBuilder<FlashCard, FlashCard, QWhereClause> {
  QueryBuilder<FlashCard, FlashCard, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FlashCardQueryFilter
    on QueryBuilder<FlashCard, FlashCard, QFilterCondition> {
  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> answerEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'answer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> answerGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'answer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> answerLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'answer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> answerBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'answer',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> answerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'answer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> answerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'answer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> answerContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'answer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> answerMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'answer',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> answerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'answer',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> answerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'answer',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> explanationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'explanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition>
      explanationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'explanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> explanationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'explanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> explanationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'explanation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition>
      explanationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'explanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> explanationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'explanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> explanationContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'explanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> explanationMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'explanation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition>
      explanationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'explanation',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition>
      explanationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'explanation',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> isCorrectIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isCorrect',
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition>
      isCorrectIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isCorrect',
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> isCorrectEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCorrect',
        value: value,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> questionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> questionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> questionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> questionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'question',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> questionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> questionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> questionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> questionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'question',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition> questionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'question',
        value: '',
      ));
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterFilterCondition>
      questionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'question',
        value: '',
      ));
    });
  }
}

extension FlashCardQueryObject
    on QueryBuilder<FlashCard, FlashCard, QFilterCondition> {}

extension FlashCardQueryLinks
    on QueryBuilder<FlashCard, FlashCard, QFilterCondition> {}

extension FlashCardQuerySortBy on QueryBuilder<FlashCard, FlashCard, QSortBy> {
  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> sortByAnswer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answer', Sort.asc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> sortByAnswerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answer', Sort.desc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> sortByExplanation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explanation', Sort.asc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> sortByExplanationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explanation', Sort.desc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> sortByIsCorrect() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCorrect', Sort.asc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> sortByIsCorrectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCorrect', Sort.desc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> sortByQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.asc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> sortByQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.desc);
    });
  }
}

extension FlashCardQuerySortThenBy
    on QueryBuilder<FlashCard, FlashCard, QSortThenBy> {
  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> thenByAnswer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answer', Sort.asc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> thenByAnswerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answer', Sort.desc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> thenByExplanation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explanation', Sort.asc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> thenByExplanationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explanation', Sort.desc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> thenByIsCorrect() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCorrect', Sort.asc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> thenByIsCorrectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCorrect', Sort.desc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> thenByQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.asc);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QAfterSortBy> thenByQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.desc);
    });
  }
}

extension FlashCardQueryWhereDistinct
    on QueryBuilder<FlashCard, FlashCard, QDistinct> {
  QueryBuilder<FlashCard, FlashCard, QDistinct> distinctByAnswer(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'answer', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QDistinct> distinctByExplanation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'explanation', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FlashCard, FlashCard, QDistinct> distinctByIsCorrect() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCorrect');
    });
  }

  QueryBuilder<FlashCard, FlashCard, QDistinct> distinctByQuestion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'question', caseSensitive: caseSensitive);
    });
  }
}

extension FlashCardQueryProperty
    on QueryBuilder<FlashCard, FlashCard, QQueryProperty> {
  QueryBuilder<FlashCard, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FlashCard, String, QQueryOperations> answerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'answer');
    });
  }

  QueryBuilder<FlashCard, String, QQueryOperations> explanationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'explanation');
    });
  }

  QueryBuilder<FlashCard, bool?, QQueryOperations> isCorrectProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCorrect');
    });
  }

  QueryBuilder<FlashCard, String, QQueryOperations> questionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'question');
    });
  }
}
