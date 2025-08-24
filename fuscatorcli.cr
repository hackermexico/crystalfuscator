#!/usr/bin/env crystal
# Crystalfuscator Ultra Simple - HTML con JS y CSS integrados

require "file_utils"

# Función simple para renombrar IDs y clases
def quick_hash(name : String) : String
  sum = 0
  name.each_byte { |b| sum += b }
  "_#{(sum % 100000).to_s.rjust(5, '0')}"  # '0' es Char, no String
end

# Ofuscar HTML (solo IDs y clases)
def obfuscate_html(html_code : String)
  id_map = {} of String => String
  class_map = {} of String => String

  # IDs
  html_code = html_code.gsub(/id="([A-Za-z0-9_-]+)"/) do
    id_map[$1] ||= quick_hash($1)
    "id=\"#{id_map[$1]}\""
  end

  # Clases
  html_code = html_code.gsub(/class="([A-Za-z0-9 _-]+)"/) do
    new_classes = $1.split(" ").map { |c| class_map[c] ||= quick_hash(c) }
    "class=\"#{new_classes.join(" ")}\""
  end

  html_code
end

# CLI ultra simple
if ARGV.size != 2
  puts "Uso: ./crystalfuscator_html_simple.cr input.html output.html"
  exit
end

input_file  = ARGV[0]
output_file = ARGV[1]

unless File.exists?(input_file)
  puts "Archivo de entrada no encontrado: #{input_file}"
  exit
end

html_content = File.read(input_file)
obfuscated   = obfuscate_html(html_content)
File.write(output_file, obfuscated)

puts "Archivo ofuscado generado: #{output_file}"

