require 'ostruct'

module FunctionTable
  module BuiltInMethods
    def self.create_row(klass_name:, method_type:, return_type:, method_name:)
      OpenStruct.new(
        klass_name: klass_name,
        method_type: method_type,
        return_type: return_type,
        method_name: method_name
      )
    end

    MATH_BUILT_INS = [
      create_row(klass_name: 'Math', method_type: 'function', return_type: 'int', method_name: 'abs'),
      create_row(klass_name: 'Math', method_type: 'function', return_type: 'int', method_name: 'multiply'),
      create_row(klass_name: 'Math', method_type: 'function', return_type: 'int', method_name: 'divide'),
      create_row(klass_name: 'Math', method_type: 'function', return_type: 'int', method_name: 'min'),
      create_row(klass_name: 'Math', method_type: 'function', return_type: 'int', method_name: 'max'),
      create_row(klass_name: 'Math', method_type: 'function', return_type: 'int', method_name: 'sqrt'),
      create_row(klass_name: 'Math', method_type: 'function', return_type: 'int', method_name: 'sqrt')
    ]

    STRING_BUILT_INS = [
      create_row(klass_name: 'String', method_type: 'constructor', return_type: 'String', method_name: 'new'),
      create_row(klass_name: 'String', method_type: 'method', return_type: 'void', method_name: 'dispose'),
      create_row(klass_name: 'String', method_type: 'method', return_type: 'int', method_name: 'length'),
      create_row(klass_name: 'String', method_type: 'method', return_type: 'char', method_name: 'charAt'),
      create_row(klass_name: 'String', method_type: 'method', return_type: 'void', method_name: 'setCharAt'),
      create_row(klass_name: 'String', method_type: 'method', return_type: 'String', method_name: 'appendChar'),
      create_row(klass_name: 'String', method_type: 'method', return_type: 'void', method_name: 'eraseLastChar'),
      create_row(klass_name: 'String', method_type: 'method', return_type: 'int', method_name: 'intValue'),
      create_row(klass_name: 'String', method_type: 'method', return_type: 'void', method_name: 'setInt'),
      create_row(klass_name: 'String', method_type: 'function', return_type: 'char', method_name: 'backSpace'),
      create_row(klass_name: 'String', method_type: 'function', return_type: 'char', method_name: 'doubleQuote'),
      create_row(klass_name: 'String', method_type: 'function', return_type: 'char', method_name: 'newLine'),
    ]

    ARRAY_BUILT_INS = [
      create_row(klass_name: 'Array', method_type: 'constructor', return_type: 'Array', method_name: 'new'),
      create_row(klass_name: 'Array', method_type: 'method', return_type: 'void', method_name: 'dispose'),
    ]

    OUTPUT_BUILT_INS = [
      create_row(klass_name: 'Output', method_type: 'function', return_type: 'void', method_name: 'moveCursor'),
      create_row(klass_name: 'Output', method_type: 'function', return_type: 'void', method_name: 'printChar'),
      create_row(klass_name: 'Output', method_type: 'function', return_type: 'void', method_name: 'printString'),
      create_row(klass_name: 'Output', method_type: 'function', return_type: 'void', method_name: 'printInt'),
      create_row(klass_name: 'Output', method_type: 'function', return_type: 'void', method_name: 'println'),
      create_row(klass_name: 'Output', method_type: 'function', return_type: 'void', method_name: 'backSpace'),
    ]

    SCREEN_BUILT_INS = [
      create_row(klass_name: 'Screen', method_type: 'function', return_type: 'void', method_name: 'clearScreen'),
      create_row(klass_name: 'Screen', method_type: 'function', return_type: 'void', method_name: 'setColor'),
      create_row(klass_name: 'Screen', method_type: 'function', return_type: 'void', method_name: 'drawPixel'),
      create_row(klass_name: 'Screen', method_type: 'function', return_type: 'void', method_name: 'drawLine'),
      create_row(klass_name: 'Screen', method_type: 'function', return_type: 'void', method_name: 'drawRectangle'),
      create_row(klass_name: 'Screen', method_type: 'function', return_type: 'void', method_name: 'drawCircle'),
    ]

    KEYBOARD_BUILT_INS = [
      create_row(klass_name: 'Keyboard', method_type: 'function', return_type: 'char', method_name: 'keyPressed'),
      create_row(klass_name: 'Keyboard', method_type: 'function', return_type: 'char', method_name: 'readChar'),
      create_row(klass_name: 'Keyboard', method_type: 'function', return_type: 'String', method_name: 'readLine'),
      create_row(klass_name: 'Keyboard', method_type: 'function', return_type: 'int', method_name: 'readInt'),
    ]

    MEMORY_BUILT_INS = [
      create_row(klass_name: 'Memory', method_type: 'function', return_type: 'int', method_name: 'peek'),
      create_row(klass_name: 'Memory', method_type: 'function', return_type: 'void', method_name: 'poke'),
      create_row(klass_name: 'Memory', method_type: 'function', return_type: 'Array', method_name: 'alloc'),
      create_row(klass_name: 'Memory', method_type: 'function', return_type: 'void', method_name: 'deAlloc'),
    ]

    Sys_BUILT_INS = [
      create_row(klass_name: 'Sys', method_type: 'function', return_type: 'void', method_name: 'halt'),
      create_row(klass_name: 'Sys', method_type: 'function', return_type: 'void', method_name: 'error'),
      create_row(klass_name: 'Sys', method_type: 'function', return_type: 'void', method_name: 'wait'),
    ]

    BUILT_INS = [
      MATH_BUILT_INS,
      STRING_BUILT_INS,
      ARRAY_BUILT_INS,
      OUTPUT_BUILT_INS,
      SCREEN_BUILT_INS,
      KEYBOARD_BUILT_INS,
      MEMORY_BUILT_INS,
      Sys_BUILT_INS
    ].flatten
  end
end