class Writer
  FILE_TYPE = {file: 'file', directory: 'directory'}

  attr_reader :file_path, :content

  def initialize(file_path, content)
    @file_path = file_path
    @content = content
  end

  def execute
    delete_if_exists
    File.write(file_path, content)
  end

  private

  def delete_if_exists
    File.delete file_path if File.exist?(file_path)
  end
end