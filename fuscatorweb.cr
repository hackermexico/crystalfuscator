#!/usr/bin/env crystal
require "http/server"
require "file_utils"

# Función rápida para renombrar IDs y clases
def quick_hash(name : String) : String
  sum = 0
  name.each_byte { |b| sum += b }
  "_#{(sum % 100000).to_s.rjust(5,'0')}"
end

# Función de ofuscación HTML
def obfuscate_html(html : String)
  id_map = {} of String => String
  class_map = {} of String => String

  html = html.gsub(/id="([A-Za-z0-9_-]+)"/) do
    id_map[$1] ||= quick_hash($1)
    "id=\"#{id_map[$1]}\""
  end

  html = html.gsub(/class="([A-Za-z0-9 _-]+)"/) do
    new_classes = $1.split(" ").map { |c| class_map[c] ||= quick_hash(c) }
    "class=\"#{new_classes.join(" ")}\""
  end

  html
end

upload_dir = "./uploads"
FileUtils.mkdir_p(upload_dir)
port = 8080

server = HTTP::Server.new do |ctx|
  case ctx.request.path
  when "/"
    ctx.response.content_type = "text/html"

    ctx.response.print "<html>\n"
    ctx.response.print "<head>\n"
    ctx.response.print "<title>Crystalfuscator Web Final</title>\n"
    ctx.response.print "<style>\n"
    ctx.response.print "body{background:#111;color:#eee;font-family:monospace;padding:20px;}\n"
    ctx.response.print "textarea{width:48%;height:300px;margin:1%;background:#222;color:#0f0;border:none;padding:10px;float:left;}\n"
    ctx.response.print "button{padding:10px 15px;margin:5px;}\n"
    ctx.response.print "#container{overflow:hidden;}\n"
    ctx.response.print "h2{clear:both;}\n"
    ctx.response.print "</style>\n"
    ctx.response.print "</head>\n"
    ctx.response.print "<body>\n"
    ctx.response.print "<h1>Crystalfuscator Web Final</h1>\n"
    ctx.response.print "<h2>Copiar / Pegar HTML</h2>\n"
    ctx.response.print "<textarea id='before' placeholder='HTML original'></textarea>\n"
    ctx.response.print "<textarea id='after' readonly placeholder='HTML ofuscado'></textarea>\n"
    ctx.response.print "<br>\n"
    ctx.response.print "<h2>O Subir Archivo HTML</h2>\n"
    ctx.response.print "<input type='file' id='fileInput'><br>\n"
    ctx.response.print "<button onclick='processHTML()'>Procesar</button>\n"
    ctx.response.print "<button onclick='downloadFile()'>Descargar HTML ofuscado</button>\n"

    ctx.response.print "<script>\n"
    ctx.response.print "let processedContent='';\n"
    ctx.response.print "async function processHTML(){\n"
    ctx.response.print " let original = document.getElementById('before').value;\n"
    ctx.response.print " const file = document.getElementById('fileInput').files[0];\n"
    ctx.response.print " if(file){ original = await file.text(); document.getElementById('before').value = original; }\n"
    ctx.response.print " if(!original){alert('Proporciona HTML');return;}\n"
    ctx.response.print " const resp = await fetch('/process',{method:'POST',headers:{'Content-Type':'text/plain'},body:original});\n"
    ctx.response.print " processedContent = await resp.text();\n"
    ctx.response.print " document.getElementById('after').value = processedContent;\n"
    ctx.response.print "}\n"
    ctx.response.print "function downloadFile(){\n"
    ctx.response.print " if(!processedContent){alert('Procesa primero');return;}\n"
    ctx.response.print " const blob = new Blob([processedContent],{type:'text/html'});\n"
    ctx.response.print " const url = URL.createObjectURL(blob);\n"
    ctx.response.print " const a = document.createElement('a'); a.href=url; a.download='obfuscated.html'; a.click();\n"
    ctx.response.print " URL.revokeObjectURL(url);\n"
    ctx.response.print "}\n"
    ctx.response.print "</script>\n"
    ctx.response.print "</body>\n"
    ctx.response.print "</html>\n"

  when "/process"
    ctx.response.content_type = "text/plain"
    # ⚡ Corregido: leer todo el cuerpo como String
    html_content = ctx.request.body.not_nil!.gets_to_end
    ctx.response.print obfuscate_html(html_content)

  else
    ctx.response.status_code = 404
    ctx.response.print "No encontrado"
  end
end

puts "Dashboard iniciado en http://0.0.0.0:#{port}"
server.bind_tcp("0.0.0.0", port)
server.listen

