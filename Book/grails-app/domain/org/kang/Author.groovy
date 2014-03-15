package org.kang

class Author {

  static hasMany = [books: Book]

  String name

  static constraints = {
    name size: 5..10
  }

  static mapping = {
    // id generator: 'org.hibernate.id.enhanced.TableGenerator', params:[table_name:"ids", segment_value:"author"]
  }
}
