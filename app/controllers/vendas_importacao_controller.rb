class VendasImportacaoController < ApplicationController
  def importacao
  end
  
  def upload
    arquivo_enviado = params[:arquivo]
    File.open(Rails.root.join('public', 'uploads', arquivo_enviado.original_filename), 'wb') do |arquivo|
      arquivo.write(arquivo_enviado.read)
    end
    
    @linhas_lidas = []
    File.open(Rails.root.join('public', 'uploads', arquivo_enviado.original_filename), 'rb') do |arquivo|
      arquivo.each do |linha| 
        @linhas_lidas << linha.force_encoding('utf-8')
      end
    end
  end
end
