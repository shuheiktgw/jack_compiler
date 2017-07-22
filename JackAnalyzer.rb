# Main File to use assemble asm file
# ex: ruby run.rb ~/vm/file/path.vm
require_relative './src/jack_compiler'

file_path = ARGV[0]

if file_path.nil?
  puts '[Fail] You have to specify the jack file path, like "ruby JackAnalyzer.rb ~/jack/file/path.jack"'
  exit(1)
end

compiler = JackCompiler.new(file_path)
compiler.execute

puts '[Success] Compilation completed.'
