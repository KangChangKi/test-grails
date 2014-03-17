package org.kang

class Author {

  static hasMany = [books: Book]

  String name

  static constraints = {
    name size: 5..10
  }

  static mapping = {
    batchSize 10
  }

  String toString() {
    name
  }
}
