package org.kang

class Book {

  static belongsTo = [author: Author]

  String title

  static constraints = {
    title size:2..10
  }

  static mapping = {
    // id generator: 'org.hibernate.id.enhanced.TableGenerator', params:[table_name:"ids", segment_value:"book"]
  }

  /*
  String toString() {
    "aaa"
  }
  */
}
