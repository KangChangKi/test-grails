test-grails
===========

[hasMany]:(http://grails.org/doc/2.3.4/ref/Domain%20Classes/hasMany.html)
[belongsTo]:(http://grails.org/doc/2.3.4/ref/Domain%20Classes/belongsTo.html)
[addTo]:(http://grails.org/doc/latest/ref/Domain%20Classes/addTo.html)
[bootstrap]:(http://getbootstrap.com/)

test-grails

### create Book app

	grails create-app Book
	cd Book
	
### setup emacs projectile

	e .projectile
	
put below into .projectile file

```
-*.class
-.git
-.svn
-*.jar
-*~
```

### setup grails project

___TODO: externalize custom configurations___

Config.groovy:

	grails.gorm.failOnError = true

### interactive console on console 1

	grails							# enter the interactive mode
	grails> refresh-dependencies	# to use generate-* commands
	grails> install-template		# installs the artifact and scaffolding templates

### emacs on console 2

	e .				# emacs dired mode
	
### create domain classes

First, think about domain objects and their relationships. In here I need two objects: Author and Book. Their relationship is 1:N and strong, which means when the parent is deleted it's all child should be deleted too.

	grails> create-domain-class org.kang.Book
	grails> create-domain-class org.kang.Author
	
Open emacs and edit Author.groovy and Book.groovy files.

Author.groovy: [hasMany]

	static hasMany = [books: Book]
	
Book.groovy: [belongsTo]

	static belongsTo = [author: Author]
	
If your db doesn't support hibernate id generation append the following to each domain class.

	static mapping = {
	...
    id generator: 'org.hibernate.id.enhanced.TableGenerator', params:[table_name:"your_id_management_table_name", segment_value:"your_domain_class_name"]
    ...
    }
    
### integration tests

Objects have consistency, which means objects need storages like databases or files.

	grails> create-integration-test org.kang.Book
	| Created file test/integration/org/kang/BookSpec.groovy
	grails> create-integration-test org.kang.Author
	| Created file test/integration/org/kang/AuthorSpec.groovy
	
Think DDD. Author is the aggregate object. open AuthorSpec.groovy

___Be careful to open integration test file, not unit test file. It's all the same name: AuthorSpec.groovy___

AuthorSpec.groovy:

```
  void "spock specs should work"() {
    given:
    assert true

    when:
    assert true

    then:
    assert true // false
  }
```

```
grails> test-app integration: org.kang.*
| Completed 1 integration test, 0 failed in 0m 0s
| Tests PASSED - view reports in /Users/lenani/test/test-grails/Book/target/test-reports
```

You can open browser and check the test result and logs.

Remove the above spec and add other spec: [addTo]

addTo* method is useful because it links parent object and child object automatically.

```
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
```

```
grails> test-app integration: org.kang.*
| Completed 1 integration test, 0 failed in 0m 0s
| Tests PASSED - view reports in /Users/lenani/test/test-grails/Book/target/test-reports
```

### unit tests

Think about 'unit'.

domain objects' validations.

### generate controller and views for the domain object

```
grails> generate-all org.kang.Book
| Finished generation for domain class org.kang.Book
grails> generate-all org.kang.Author
| Finished generation for domain class org.kang.Author
```

### run app

```
grails> run-app
| Server running. Browse to http://localhost:8080/Book
| Application loaded in interactive mode. Type 'stop-app' to shutdown.
```

Open a browser and navigate to http://localhost:8080/Book

### bootstrap: prepare fixtures or intial data

BootStrap.groovy:

```
import grails.util.Environment
import org.kang.*

class BootStrap {

  def init = { servletContext ->
    if (Environment.current == Environment.DEVELOPMENT) {
      def author = new Author(name: 'Kang CK')
      .addToBooks(new Book(title: 'C++'))
      .addToBooks(new Book(title: 'Groovy'))
      .save()

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
```

### twitter [bootstrap]

BuildConfig.groovy:

```
# runtime ":jquery:1.10.2.2"			# comment out or remove jquery plugin
```

Merge main layout with twitter bootstrap template.


### modify scaffolding template

#### setting orders between fields

#### customization of navigation between parent and child

#### rest

### logging

### plugin: shiro

### plugin: searchable

#### plugin: quartz

#### plugin: rest

### converting an app to a plugin


