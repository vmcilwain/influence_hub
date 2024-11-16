class CustomSystemTestGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def create_test_file
    template 'system_test.rb', File.join('test/system', class_path, "#{file_name}_test.rb")
  end

  private

  def file_name
    @file_name ||= remove_possible_suffix(super)
  end

  def remove_possible_suffix(name)
    name.sub(/_?system_?test$/i, '')
  end
end
