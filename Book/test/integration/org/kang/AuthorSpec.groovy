package org.kang



import spock.lang.*

/**
 *
 */
class AuthorSpec extends Specification {

  def setup() {
  }

  def cleanup() {
  }

  void "author should save well"() {
    given:
    assert Author.count() == 0
    assert Book.count() == 0

    when:
    def author = new Author(name: 'Kang CK')
    .addToBooks(new Book(title: 'C++'))
    .addToBooks(new Book(title: 'Groovy'))
    .save()

    then:
    assert Author.count() == 1
    assert Book.count() == 2
  }

}
