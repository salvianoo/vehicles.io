require 'pdfkit'

class RequestReport
  # ASSETS_DIR = File.join(File.dirname(__FILE__), "assets")

  def initialize(request)
    @request = request

    @lexicon = {
      "SERVICO"    => request.servico.capitalize,
      "HORA"       => request.hora,
      "DATA"       => request.data,
      "MOTIVO"     => request.motivo_da_viagem,
      "ENDERECO"   => request.endereco,
      "DESTINO"    => request.destino,
      "CIA_AREA"   => request.cia_area,
      "NUMERO_VOO" => request.numero_voo
    }
    @terms = @lexicon.keys.join("|")
  end

  def build
    doc = ""
    doc << title
    doc << content

    kit = PDFKit.new(doc, page_size: "Letter")
    # kit.stylesheets << "#{ASSETS_DIR}/print.css"
    kit
  end

  def to_pdf
    build.to_pdf
  end

  private
  def ocupantes
    if @request.passengers.size > 1
      "Motorista, #{passageiros}"
    else
      "Motorista e #{passageiros}"
    end
  end
  def passageiros
    @request.passengers.map {|p| p.name}.join(", ")
  end

  def title
    <<-title
      <h1><b align='center'>REQUISIÇÃO DE VEÍCULO PARA VIAGEM</b></h1>
      <p><b>(A REQUISIÇÃO DEVE SER ENCHAMINHADA COM, NO MÍNIMO, 14 (QUATORZE DIAS DE ANTECEDÊNCIA)</b></p>
    title
  end

  def content
    <<-content
      <table style="width:100%">
        <tr>
          <td>Unidade/Órgão Requisitante:</td>
          <td>Campus Catalão / #{@request.departamento}</td>
        </tr>
        <tr>
          <td>Destino:</td>
          <td>#{@request.destino}</td>
        </tr>
        <tr>
          <td>Ocupantes:</td>
          <td>#{ocupantes}</td>
        </tr>
        <tr>
          <td>Serviço a ser executado:</td>
          <td>#{servico}</td>
        </tr>
        <tr>
          <td>Periodo de afastamento:</td>
          <td></td>
        </tr>
        <tr>
          <td>Hora e Local de saída:</td>
          <td>Saída às __:__ horas do CAC/UFG</td>
        </tr>
      </table>
    content
  end

  def render(text)
    pattern = Regexp.new(@terms)
    text.gsub(pattern, @lexicon)
  end

  def servico
    case @request.servico
    when 'buscar'
      buscar_aeroporto
    when 'levar'
      levar_com_aeroporto
    when 'conduzir'
      # conduzir
    end
  end

  def buscar_aeroporto
    case @request.buscar_aeroporto
    when 'sim'
      render buscar_com_aeroporto
    when 'nao'
      render buscar_sem_aeroporto
    end
  end

  def buscar_sem_aeroporto
    <<-buscar
      SERVICO,
      às HORAh,
      no dia DATA,
      #{passageiros}
      que participará MOTIVO.
      Ao chegar os ocupantes deverão ser deixados na ENDERECO
    buscar
  end

  def buscar_com_aeroporto
    <<-buscar
      SERVICO,
      às HORAh,
      no dia DATA,
      no aeroporto de DESTINO (VOO CIA_AREA NUMERO_VOO),
      #{passageiros}
      que participará MOTIVO.
      Ao chegar os ocupantes deverão ser deixados na ENDERECO
    buscar
  end

  def levar_com_aeroporto
    <<-levar
      SERVICO,
      no dia DATA,
      às HORAh,
      no aeroporto de DESTINO (VOO CIA_AREA NUMERO_VOO),
      #{passageiros}
      que participou MOTIVO.
    levar
  end
end
