package org.kang

class Book {

  static belongsTo = [author: Author]

  String isbn
  String title
  String desc

  static constraints = {
    title size:2..10
  }

  static mapping = {
    batchSize 10
  }

  String toString() {
    title
  }
}
