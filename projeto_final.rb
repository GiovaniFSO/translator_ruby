require 'rest-client'
require 'json'

class Translator

  def initialize(text, idiom)
    @url = 'https://translate.yandex.net/api/v1.5/tr.json/translate'
    @key = 'trnsl.1.1.20180924T124228Z.df3cce4c70c7f608.b58f2a3760fc82f5358992a5ff3ad3f76feee7a6'
    @text = text
    @lang = ('pt-' + idiom)
  end

  def translate
    @translated = RestClient.get(@url, params: {key: @key, text: @text, lang: @lang})
    JSON.parse(@translated)['text'][0]
  end

  def write_file
    time = Time.new
    filename = time.strftime('%d-%m-%y_%H:%M')
    File.open("#{filename}.txt", 'w') do |line|
      line.puts(@text+" | "+translate)
    end
  end
end


print 'Digite o texto a ser traduzido: '
text = gets.chomp
print 'Digite a sigla para qual linguagem traduzida: '
idiom = gets.chomp

result = Translator.new(text, idiom)
result.write_file




