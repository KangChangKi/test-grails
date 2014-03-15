import grails.util.Environment
import org.kang.*

class BootStrap {

  def init = { servletContext ->
    if (Environment.current == Environment.DEVELOPMENT) {
      def author = new Author(name: 'Kang CK')
      .addToBooks(new Book(title: 'C++'))
      .addToBooks(new Book(title: 'Groovy'))
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
