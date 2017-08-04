require 'pry-byebug'

class Writer
  CONST = 'constant'
  ARG = 'argument'
  LOCAL = 'local'
  STATIC = 'static'
  THIS = 'this'
  THAT = 'that'
  POINTER = 'pointer'
  TEMP = 'temp'

  SEGMENTS = [
    CONST,
    ARG,
    LOCAL,
    STATIC,
    THIS,
    THAT,
    POINTER,
    TEMP
  ]

  ADD = 'add'
  SUB = 'sub'
  NEG = 'neg'
  EQ = 'eq'
  GT = 'gt'
  LT = 'lt'
  AND = 'and'
  OR = 'or'
  NOT = 'not'

  COMMANDS = [
    ADD,
    SUB,
    NEG,
    EQ,
    GT,
    LT,
    AND,
    OR,
    NOT,
  ]

  attr_reader :file_path

  def initialize(file_path)
    delete_if_exists(file_path)
    @file_path = file_path
  end

  def write_push(segment:, index:)
    raise "invalid segment is selected: #{segment}" unless(SEGMENTS.include? segment)

    write "push #{segment} #{index}"
  end

  def write_pop(segment:, index:)
    raise "invalid segment is selected: #{segment}" unless(SEGMENTS.include? segment)

    write "pop #{segment} #{index}"
  end

  def write_command(command)
    raise "invalid command is given: #{command}" unless(COMMANDS.include? command)

    write command
  end

  def write_label(label)
    write"label #{label}"
  end

  def write_goto(label)
    write"goto #{label}"
  end

  def write_if(label)
    write"if-goto #{label}"
  end

  def write_call(name:, number:)
    write "call #{name} #{number}"
  end

  def write_function(name:, number:)
    write "function #{name} #{number}"
  end

  def write_return
    write 'return'
  end

  private

  def write(content)
    File.write(file_path, "#{content}\n", mode: 'a')
  end

  def delete_if_exists(path)
    File.delete path if File.exist?(path)
  end
end