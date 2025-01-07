// data base ko path  hive .init le afai generate garcha
// phone ko location ko lagi com....

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shikshyadwar_mobile_application_project/app/constants/hive_table_constant.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/data/model/auth_hive_model.dart';
import 'package:shikshyadwar_mobile_application_project/features/batch/data/model/batch_hive_model.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/data/model/course_hive_model.dart';

// this is local data source
class HiveService {
  Future<void> init() async {
// Initialize the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}softwarica_student_management.db';

    Hive.init(path);

    // register adapter
    Hive.registerAdapter(CourseHiveModelAdapter());
    Hive.registerAdapter(BatchHiveModelAdapter());
    Hive.registerAdapter(AuthHiveModelAdapter());
  }

  // Batch Queries
  Future<void> addBatch(BatchHiveModel batch) async {
    var box = await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
    await box.put(batch.batchId, batch);
  }

  Future<void> deleteBatch(String id) async {
    var box = await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
    await box.delete(id);
  }

  Future<List<BatchHiveModel>> getAllBatches() async {
    var box = await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
    var batches = box.values.toList();
    return batches;
  }

  // Batch Queries
  Future<void> addCourse(CourseHiveModel courseHiveModel) async {
    var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
    await box.put(courseHiveModel.courseId, courseHiveModel);
  }

  Future<void> deleteCourse(String id) async {
    var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
    await box.delete(id);
  }

  Future<List<CourseHiveModel>> getAllCourses() async {
    var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
    var courses = box.values.toList();
    return courses;
  }

// Student Queries
  Future<void> addStudent(AuthHiveModel authHiveModel) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
    await box.put(authHiveModel.studentId, authHiveModel);
  }

  Future<void> deleteStudent(String id) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
    await box.delete(id);
  }

  Future<List<AuthHiveModel>> getAllStudent() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
    var student = box.values.toList();
    return student;
  }

  Future<AuthHiveModel?> login(String username, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
    var auth = box.values.firstWhere(
        (element) =>
            element.username == username && element.password == password,
        orElse: () => AuthHiveModel.initial());
  }

  // clear all boxes
  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.batchBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.courseBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.studentBox);
  }

  Future<void> close() async {
    await Hive.close();
  }
}
