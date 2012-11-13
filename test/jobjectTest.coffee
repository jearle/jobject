should = require 'should'
Jobject = require '../'

describe 'Jobject', ->
  
  class TestClass extends Jobject
    @property 'age', '12'

  testClass = new TestClass()
  testClass2 = new TestClass()

  describe 'Jobject.validPropertyName()', ->
    it 'should be a valid property name', ->
      for propName in ['a', '$', '_', 'a1']
        Jobject.validPropertyName(propName).should.be.true

    it 'should be an invalid property name', ->
      for propName in ['1', '^', '%', '(', ')', 'a&f']
        Jobject.validPropertyName(propName).should.be.false

  describe 'Jobject.property()', ->
    it 'should throw error', ->
      (->
        Jobject.property '%').should.throw /^Invalid property+/

    it 'should have private property', ->
      testClass.should.have.property '_age'

    it 'should have private property with initial value', ->
      testClass.should.have.property '_age', '12'

    it 'should have a property', ->
      testClass.should.have.property 'age'

    it 'should have a property with intial value', ->
      testClass.should.have.property 'age', '12'

    it 'should be able to take a value', ->
      testClass.age = '13'
      testClass.age.should.eql '13'

    it 'should not equal each other', ->
      testClass.age.should.not.be.eql testClass2.age

  class TestClassOverrides extends Jobject
    @property 'name', '',
      get: ()->
        return @_name + '!'
      set: (name)->
        @_name = '!' + name

  testClassOverrides = new TestClassOverrides()

  it 'should override setter and getter', ()->
    testClassOverrides.name = 'Jesse'
    testClassOverrides.name.should.eql '!Jesse!'