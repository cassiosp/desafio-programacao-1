require 'csv'

class VendasImportacaoController < ApplicationController
  
  http_basic_authenticate_with name: "desafio", password: "passwd"
  
  def index
    @vendas = Venda.all
  end

  def importacao
  end

  def upload

    @vendas = []

    salvar_arquivo_enviado

    processar_arquivo

    mostrar_linhas_processadas

  end

  private

  def processar_arquivo

    caminho = Rails.root.join('public', 'uploads', @arquivo_enviado.original_filename)
    coluna = nil
    @receita = BigDecimal.new(0)
    CSV.foreach caminho, {:col_sep => "\t"} do |linha|
      puts "Colunas => #{linha}" if linha.include? "purchaser name"
      puts "Linha => #{linha}" unless linha.include? "purchaser name"

      if coluna
        venda = Venda.new
        coluna.each_index do |index|
          metodo = "#{coluna[index].gsub(" ", "_")}=".to_sym
          puts "#{metodo} => #{linha[index]} => #{index}"
          venda.send(metodo, linha[index])
        end
        if venda.save then
          @vendas << venda
          @receita += BigDecimal.new(venda.item_price) * BigDecimal.new(venda.purchase_count)
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

  def mostrar_linhas_processadas

    puts @vendas

    @linhas_lidas = []
    File.open(Rails.root.join('public', 'uploads', @arquivo_enviado.original_filename), 'rb') do |arquivo|

      arquivo.each do |linha|
        @linhas_lidas << linha.force_encoding('utf-8')
      end

    end
  end

end
