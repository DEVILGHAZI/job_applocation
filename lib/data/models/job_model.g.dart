// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JobModelImpl _$$JobModelImplFromJson(Map<String, dynamic> json) =>
    _$JobModelImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      company: json['company'] as String,
      location: json['location'] as String,
      description: json['description'] as String,
      requirements: json['requirements'] as String,
      salary: json['salary'] as String,
      postedDate: json['postedDate'] as String,
      logoUrl: json['logoUrl'] as String?,
      isSaved: json['isSaved'] as bool? ?? false,
    );

Map<String, dynamic> _$$JobModelImplToJson(_$JobModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'company': instance.company,
      'location': instance.location,
      'description': instance.description,
      'requirements': instance.requirements,
      'salary': instance.salary,
      'postedDate': instance.postedDate,
      'logoUrl': instance.logoUrl,
      'isSaved': instance.isSaved,
    };
