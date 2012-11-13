Jobject = require './'

class MyClass extends Jobject
  @property 'name'

  @property 'title', '', 
    get: ()->
      return 'TITLE: ' + @_title
  
  @property 'author', '', 
    get: ()->
      return @_author + '!!!!'
    set: (author)->
      @_author = 'AUTHOR: ' + author

myClass = new MyClass()
myClass.name = 'Jesse Earle'
myClass.title = 'Fruit Loop'
myClass.author = 'Stephen King'

console.log(myClass.name) # Jesse earle
console.log(myClass.title) # TITLE: Fruit Loop
console.log(myClass.author) #AUTHOR: Stephen King!!!!