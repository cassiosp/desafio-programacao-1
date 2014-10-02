require 'csv'

class VendasImportacaoController < ApplicationController
  def importacao
  end

  def upload
    
    salvar_arquivo_enviado
    
    processar_arquivo

    guardar_linhas_processadas

  end
  
  private
  
  def processar_arquivo
    
    caminho = Rails.root.join('public', 'uploads', @arquivo_enviado.original_filename)
    coluna = nil
    CSV.foreach caminho, {:col_sep => "\t"} do |linha|
      puts "Colunas => #{linha}" if linha.include? "purchaser name"
      puts "Linha => #{linha}" unless linha.include? "purchaser name"
      
      if coluna
        venda = Venda.new
        coluna.each_index do |index|
          puts coluna[index].class
          venda.send("#{coluna[index].gsub(" ", "_")}=".to_sym, venda[index])  
        end
        
      end

      coluna ||= linha

    end
    
  end
  
  def salvar_arquivo_enviado 
    @arquivo_enviado = params[:arquivo]
    File.open(Rails.root.join('public', 'uploads', Time.now.to_i.to_s.concat('_').concat(@arquivo_enviado.original_filename)), 'wb') do |arquivo|
      arquivo.write(@arquivo_enviado.read)
    end
  end
  
  def guardar_linhas_processadas
    @linhas_lidas = []
    File.open(Rails.root.join('public', 'uploads', @arquivo_enviado.original_filename), 'rb') do |arquivo|

      arquivo.each do |linha|
      # puts "linha.ascii_only? = #{linha.ascii_only?}"
        @linhas_lidas << linha.force_encoding('utf-8')
      # @linhas_lidas << linha.encode('utf-8', 'ASCII-8BIT', :undef => :replace)
      end

    end
  end
    
end
