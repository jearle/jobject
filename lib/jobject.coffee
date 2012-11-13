class Jobject
  @capitalizeFirstLetter: (string)->
    return string.charAt(0).toUpperCase() + string.slice(1);

  @invalidPropertyName: (name)->
    return Error 'Invalid property name: ' + name

  @regex:
    invalidPropertyName: /(^\d|\s|[^A-Za-z0-9$_])/g

  property: (name, intitialValue)->
    throw new Jobject.invalidPropertyName name if not @validPropertyName name

    privateName = @createPrivateName name
    @addPrivateProperty privateName, intitialValue

    setterName = @createSetterName name

    proto = Object.getPrototypeOf @

    Object.defineProperty proto, name, 
      get: @createGetter name, privateName
      set: @createSetter setterName, privateName
  
  createGetter: (name, privateName)->
    if not (@[name] is undefined)
      return @[name]
    else
      return -> return @[privateName]

  createSetter: (setterName, privateName)->
    if not (@[setterName] is undefined)
      return @[setterName]
    else
      return (value)-> @[privateName] = value

  addSetter: (setterName, privateName)->
    return if not (@[setterName] is undefined)
    @[setterName] = (arg)->
      @[privateName] = arg

  addPrivateProperty: (name, intitialValue)->
    intitialValue = null if intitialValue is undefined
    @[name] = intitialValue

  createSetterName: (name)->
    return 'set' + Jobject.capitalizeFirstLetter name

  createPrivateName: (name)->
    return '_' + name

  validPropertyName: (name)->
    validPropertyName = no
    if not name.match Jobject.regex.invalidPropertyName
      validPropertyName = yes
    return validPropertyName


module.exports = Jobject