class Jobject
  @capitalizeFirstLetter: (string)->
    return string.charAt(0).toUpperCase() + string.slice(1);

  @invalidPropertyName: (name)->
    return Error 'Invalid property name: ' + name

  @regex:
    invalidPropertyName: /(^\d|\s|[^A-Za-z0-9$_])/g

  @property: (name, intitialValue, getterSetter)->
    throw new @invalidPropertyName name if not @validPropertyName name

    privateName = @createPrivateName name
    @addPrivateProperty privateName, intitialValue

    setterName = @createSetterName name
    
    setFunction = @createSetter privateName
    getFunction = @createGetter privateName

    if getterSetter
      if getterSetter.set
        setFunction = getterSetter.set
      if getterSetter.get
        getFunction = getterSetter.get

    Object.defineProperty @::, name, 
      get: getFunction
      set: setFunction
  
  @createGetter: (privateName)->
    return ()-> return @[privateName]

  @createSetter: (privateName)->
    return (value)-> @[privateName] = value

  @addPrivateProperty: (name, intitialValue)->
    intitialValue = null if intitialValue is undefined

    @::[name] = intitialValue

  @createSetterName: (name)->
    return 'set' + Jobject.capitalizeFirstLetter name

  @createPrivateName: (name)->
    return '_' + name

  @validPropertyName: (name)->
    validPropertyName = no
    if not name.match Jobject.regex.invalidPropertyName
      validPropertyName = yes
    return validPropertyName


module.exports = Jobject