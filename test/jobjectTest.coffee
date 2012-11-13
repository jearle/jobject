should = require 'should'
Jobject = require '../'

describe 'Jobject', ->
  
  class TestClass extends Jobject
    constructor: ->
      @property 'age', '12'

  testClass = new TestClass()

  describe '#validPropertyName()', ->
    it 'should be a valid property name', ->
      for propName in ['a', '$', '_', 'a1']
        testClass.validPropertyName(propName).should.be.true

    it 'should be an invalid property name', ->
      for propName in ['1', '^', '%', '(', ')', 'a&f']
        testClass.validPropertyName(propName).should.be.false

  describe '#property()', ->
    it 'should throw error', ->
      (->
        testClass.property '%').should.throw /^Invalid property+/

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

  class TestClassOverrides extends Jobject
    constructor: ->
      @property 'name'

    name: ->
      if @_name is null
        @_name = ''
      return @_name + '!'

    setName: (name)->
      @_name = name + '!'

  testClassOverrides = new TestClassOverrides()
  
  describe '#property()', ->
    it 'should override property', ->
      testClassOverrides.name.should.eql '!'

    it 'should override the setter and the getter', ->
      testClassOverrides.name = 'Jesse'
      testClassOverrides.name.should.eql 'Jesse!!'