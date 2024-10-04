unit tefacdemo.venda;

interface

const
  cPagamentos: array[0..6] of array [0..1] of String =
    (
      ('01', 'Dinheiro'),
      ('02', 'Cheque'),
      ('03', 'Cart�o de Cr�dito'),
      ('04', 'Cart�o de D�bito'),
      ('05', 'Carteira Digital'),
      ('06', 'Vale Rafei��o'),
      ('99', 'Outros')
    );

type
  TStatusVenda = (stLivre, stIniciada, stEmPagamento, stCancelada, stAguardandoTEF,
                stOperacaoTEF, stFinalizada);


  TPagamentos = class
  private
    FTipoPagamento: String;
    FValorPago: Currency;
    FHora: TDateTime;
    FRede: String;
    FNSU: String;
    FRedCNPJ: String;
    FAcrescimo: Double;
    FDesconto: Double;
    FSaque: Double;
    FConfirmada: Boolean;
    FCancelada: Boolean;
  public
    property TipoPagamento: String read FTipoPagamento write FTipoPagamento;
    property ValorPago: Currency read FValorPago write FValorPago;
    property Hora: TDateTime read FHora write FHora;
    property NSU: String read FNSU write FNSU;
    property Rede: String read FRede write FRede;
    property RedCNPJ: String read FRedCNPJ write FRedCNPJ;
    property Acrescimo: Double read FAcrescimo write FAcrescimo;
    property Desconto: Double read FDesconto write FDesconto;
    property Saque: Double read FSaque write FSaque;
    property Confirmada: Boolean read FConfirmada write FConfirmada;
    property Cancelada: Boolean read FCancelada write FCancelada;
  end;

  TVenda = class
  private
    FNumOperacao: Integer;
    FDHInicio: TDateTime;
    FStatus: TStatusVenda;
    FValorIncial: Currency;
    FTotalDesconto: Currency;
    FTotalAcrescimo: Currency;
    FPagamentos: TPagamentos;
    function GetTotalVenda: Currency;
    function GetTotalPago: Currency;
    function GetTroco: Currency;
  public
    constructor Create;
    destructor Destroy; override;

    property NumOperacao: Integer read FNumOperacao write FNumOperacao;
    property DHInicio: TDateTime read FDHInicio write FDHInicio;
    property Status: TStatusVenda read FStatus write FStatus;

    property ValorIncial: Currency read FValorIncial write FValorIncial;
    property TotalDesconto: Currency read FTotalDesconto write FTotalDesconto;
    property TotalAcrescimo: Currency read FTotalAcrescimo write FTotalAcrescimo;
    property TotalVenda: Currency read GetTotalVenda;

    property Pagamentos: TPagamentos read FPagamentos write FPagamentos;
    property TotalPago: Currency read GetTotalPago;
    property Troco: Currency read GetTroco;
  end;

function DEscricaoTipoPagamento(const aTipoPagamento: String): String;

implementation

uses
  System.SysUtils;

constructor TVenda.Create;
begin
  FDHInicio := now;
  FValorIncial := 0;
  FNumOperacao := 0;
  FTotalAcrescimo := 0;
  FTotalDesconto := 0;
  FPagamentos := TPagamentos.Create;
end;

destructor TVenda.Destroy;
begin

  inherited;
end;

function TVenda.GetTotalPago: Currency;
begin
  Result := Pagamentos.ValorPago;
end;

function TVenda.GetTotalVenda: Currency;
begin
  Result := FValorIncial - FTotalDesconto + FTotalAcrescimo;
end;

function TVenda.GetTroco: Currency;
begin
  REsult := TotalPago - TotalVenda;
end;

function DEscricaoTipoPagamento(const aTipoPagamento: String): String;
begin
  Result := '';
  var lTamanho := Length(aTipoPagamento) - 1;
  for var I := 0 to lTamanho do
  begin
    if aTipoPagamento = cPagamentos[I, 0] then
    begin
      Result := cPagamentos[I, 1];
      Break;
    end;
  end;
end;

end.
