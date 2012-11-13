Jobject = require './'

class MyClass extends Jobject
  constructor: ()->
    @property 'name'
    @property 'title'
    @property 'author'

  title: ()->
    return 'TITLE: ' + @_title

  setAuthor: (author)->
    @_author = 'AUTHOR: ' + author

  author: ()->
    return @_author + '!!!!'


myClass = new MyClass()
myClass.name = 'Jesse Earle'
myClass.title = 'Fruit Loop'
myClass.author = 'Stephen King'

console.log(myClass.name) # Jesse earle
console.log(myClass.title) # TITLE: Fruit Loop
console.log(myClass.author) #AUTHOR: Stephen King!!!!