# coding: utf-8
# author: Adriano Chambel M. Lima <acmlima.softweb@gmail.com>
# subject: Dado um arquivo, o divide por linhas em arquivos menores de até N MB informados.

class Fixnum
  def to_MB
    self / (10**6) # 1MB = 1_000_000 bytes
  end
end

def save_file(content)
  $index += 1
  filename = "#{$index}-#{File.basename(ARGV[0])}"
  File.open(filename, "w") { |f| f.write(content) }
  puts "Salvo arquivo: #{filename} com #{content.size.to_MB} MB."
end

$index = 0
buffer = ''
file = File.open(ARGV[0])
file_size = file.size.to_MB
split_by = ARGV[1].to_i

puts "Arquivo: #{File.basename(file)} - #{file_size} MB."
puts "Dividindo em [#{file_size / split_by}] arquivos de até: #{split_by} MB."

file.each_line do |line|

  if buffer.size <= ((10**6) * split_by)
    buffer << line
  else
    save_file(buffer)
    buffer = line
  end

  if file.eof?
    save_file(buffer)
  end

end
