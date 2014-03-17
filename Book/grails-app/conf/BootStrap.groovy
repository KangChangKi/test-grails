import grails.util.Environment
import org.kang.*

class BootStrap {

  def init = { servletContext ->
    if (Environment.current == Environment.DEVELOPMENT) {
      def author = new Author(name: 'Kang CK')
      .addToBooks(new Book(title: 'C++', isbn: 'abcd', desc: 'a c++ book'))
      .addToBooks(new Book(title: 'Groovy', isbn: 'cdef', desc: 'a groovy book'))
      .save(flush: true)

    } else if (Environment.current == Environment.TEST) {

    } else if (Environment.current == Environment.PRODUCTION) {

    } 
  }

  def destroy = {
    if (Environment.current == Environment.DEVELOPMENT) {

    } else if (Environment.current == Environment.TEST) {

    } else if (Environment.current == Environment.PRODUCTION) {

    } 
  }
}
