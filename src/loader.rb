class Loader
  FILE_TYPE = {file: 'file', directory: 'directory'}

  attr_reader :file_names, :file_idx

  def initialize(file_path)
    @file_names = get_files(file_path)
    @file_idx = 0
  end

  def load_next
    return if next_file_name.nil?
    content = File.read(next_file_name)

    @file_idx += 1

    content
  end

  def next_file_name
    file_names[file_idx]
  end

  def current_file_name
    file_names[file_idx - 1]
  end

  private

  def get_files(path)
    file_type = File::ftype(path)

    names = if file_type == FILE_TYPE[:file]
      [path]
    elsif file_type == FILE_TYPE[:directory]
      Dir.glob(path + '/*.jack')
    else
      raise "Invalid path, #{path} is given."
    end

    raise "The given path #{path} does not contain .jack files." if names.empty?
    names
  end
end