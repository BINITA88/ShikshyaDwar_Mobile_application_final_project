import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shikshyadwar_mobile_application_project/app/constants/hive_table_constant.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/data/model/auth_hive_model.dart';
import 'package:shikshyadwar_mobile_application_project/features/category/data/model/category_hive_model.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/data/model/course_hive_model.dart';

// this is local data source
class HiveService {
  static Future<void> init() async {
    // Initialize the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}shikshyadwar.db';

    Hive.init(path);

    // Register Adapters
    Hive.registerAdapter(CourseHiveModelAdapter());
    Hive.registerAdapter(CategoryHiveModelAdapter());
    Hive.registerAdapter(AuthHiveModelAdapter());
  }

/*
  register box
  {
    fname : "asd",
    lname : "asd",
    batch : {batchId : 1, batchName : "Batch 1"},
    courses : [{courseId : 1, courseName : "Course 1"}, {courseId : 2, courseName : "Course 2"}],
  }
*/

// OR

/*
 {
    fname : "asd",
    lname : "asd",
    batch : 1,
    courses : [1,3,4],
  }
*/

// Student Queries
  Future<void> addStudent(AuthHiveModel student) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
    await box.put(student.authId, student);
  }

  Future<void> deleteStudent(String id) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
    await box.delete(id);
  }

  Future<List<AuthHiveModel>> getAllStudents() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
    var students = box.values.toList();
    return students;
  }

  Future<AuthHiveModel?> loginStudent(String name, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);

    var auth = box.values.firstWhere(
        (element) => element.name == name && element.password == password,
        orElse: () => AuthHiveModel.initial());

    return auth;
  }

  Future<AuthHiveModel?> verifyOTP(String email, String otp) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);

    var auth = box.values.firstWhere(
        (element) => element.email == email && element.otp == otp,
        orElse: () => AuthHiveModel.initial());

    return auth;
  }

  // Course Queries
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

  // Update Course
  Future<void> updateCourse(CourseHiveModel updatedCourse) async {
    var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
    // Check if the course already exists
    if (box.containsKey(updatedCourse.courseId)) {
      await box.put(updatedCourse.courseId, updatedCourse); // Update the course
    } else {
      throw Exception("Course not found");
    }
  }

  // Category Queries
  Future<void> addCategory(CategoryHiveModel categoryHiveModel) async {
    var box =
        await Hive.openBox<CategoryHiveModel>(HiveTableConstant.categoryBox);
    await box.put(categoryHiveModel.categoryId, categoryHiveModel);
  }

  Future<void> deleteCategory(String id) async {
    var box =
        await Hive.openBox<CategoryHiveModel>(HiveTableConstant.categoryBox);
    await box.delete(id);
  }

  Future<List<CategoryHiveModel>> getAllCategories() async {
    var box =
        await Hive.openBox<CategoryHiveModel>(HiveTableConstant.categoryBox);
    var categories = box.values.toList();
    return categories;
  }

  // Update Category
  Future<void> updateCategory(CategoryHiveModel updatedCategory) async {
    var box =
        await Hive.openBox<CategoryHiveModel>(HiveTableConstant.categoryBox);
    // Check if the category already exists
    if (box.containsKey(updatedCategory.categoryId)) {
      await box.put(
          updatedCategory.categoryId, updatedCategory); // Update the category
    } else {
      throw Exception("Category not found");
    }
  }

  // Clear all boxes
  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.categoryBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.courseBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.studentBox);
    await Hive.deleteBoxFromDisk(
        HiveTableConstant.categoryBox); // Delete category box
  }

  // Clear Student Box
  Future<void> clearStudentBox() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.studentBox);
  }

  Future<void> close() async {
    await Hive.close();
  }
}
