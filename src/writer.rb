class Writer
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

  CONST = 'const'
  ARG = 'arg'
  LOCAL = 'local'
  STATIC = 'static'
  THIS = 'this'
  THAT = 'that'
  POINTER = 'pointer'
  TEMP = 'temp'

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

  ADD = 'add'
  SUB = 'sub'
  NEG = 'neg'
  EQ = 'eq'
  GT = 'gt'
  LT = 'lt'
  AND = 'and'
  OR = 'or'
  NOT = 'not'

  attr_reader :file_path

  def initialize(file_path)
    delete_if_exists(file_path)
    @file_path = file_path
  end

  def write_push(segment:, index:)
    raise "invalid segment is selected: #{segment}" unless(SEGMENTS.include? segment)

    File.write(file_path, "push #{segment} #{index}\n")
  end

  def write_pop(segment:, index:)
    raise "invalid segment is selected: #{segment}" unless(SEGMENTS.include? segment)

    File.write(file_path, "pop #{segment} #{index}\n")
  end

  def write_arithmetic(command)
    raise "invalid command is given: #{command}" unless(COMMANDS.include? command)

    File.write(file_path, "#{command}\n")
  end

  def write_label(label)

  end

  def execute
    File.write(file_path, content)
  end

  private

  def delete_if_exists(path)
    File.delete path if File.exist?(path)
  end
end