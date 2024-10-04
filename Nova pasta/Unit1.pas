unit Unit1;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Layouts,
  FMX.Memo.Types,
  FMX.ScrollBox,
  FMX.Memo,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Edit,
  FMX.ListBox, tefacdemo.interfaces, tefacdemo.venda;

type
  TForm1 = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    Label1: TLabel;
    Layout5: TLayout;
    Memo1: TMemo;
    Label2: TLabel;
    Label3: TLabel;
    Layout6: TLayout;
    Label4: TLabel;
    Layout7: TLayout;
    Layout8: TLayout;
    btnCpf: TButton;
    btnPagamentos: TButton;
    btnAdm: TButton;
    Layout9: TLayout;
    Layout10: TLayout;
    Rectangle1: TRectangle;
    edtValorIncial: TEdit;
    Rectangle2: TRectangle;
    edtDesconto: TEdit;
    Rectangle3: TRectangle;
    edtacrescimo: TEdit;
    Layout11: TLayout;
    Rectangle4: TRectangle;
    edtTotalOperacao: TEdit;
    Rectangle5: TRectangle;
    edtTotalpago: TEdit;
    Rectangle6: TRectangle;
    edttroco: TEdit;
    Layout12: TLayout;
    Label5: TLabel;
    Rectangle7: TRectangle;
    ListBoxPagamentos: TListBox;
    ListBoxItem1: TListBoxItem;
    Layout13: TLayout;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    StyleBook1: TStyleBook;
    procedure FormCreate(Sender: TObject);
    procedure btnPagamentosClick(Sender: TObject);
  private
    FComponentes: IFactoryComponentes;
    FVenda: TVenda;

    procedure ConfigurarPosPrinter;
    procedure COnfigurarTef;

    procedure AdicionarPagamento(const aIndice: Integer; aValor: Double);
    procedure FinalizarVEnda;
    procedure AdicionarLinhaImpressao(LInha: String);

    procedure AtualizarVendaInterface;
    procedure AtualizarTotaisVendaInterface;
  public

  end;

var
  Form1: TForm1;

implementation

uses
  AcbrUtil,
  tefacdemo.factoryComponente,
  Unit2;

{$R *.fmx}

procedure TForm1.AdicionarLinhaImpressao(LInha: String);
begin
  Memo1.Lines.Add(LInha);
  if FComponentes.PosPrinter.Ativo then
    FComponentes.PosPrinter.Imprimir(LInha);
end;

procedure TForm1.AdicionarPagamento(const aIndice: Integer; aValor: Double);
begin
  case aIndice of
    0: FVenda.Pagamentos.TipoPagamento := '05';
    1: FVenda.Pagamentos.TipoPagamento := '04';
    2: FVenda.Pagamentos.TipoPagamento := '03';
    3: FVenda.Pagamentos.TipoPagamento := '01';
  end;

  FVenda.Pagamentos.ValorPago := aValor;
  FVenda.Pagamentos.Confirmada := True;
  FinalizarVEnda;
end;

procedure TForm1.AtualizarTotaisVendaInterface;
begin
  edtValorIncial.Text := FormatFloatBr(FVenda.ValorIncial);
  edtDesconto.Text := FormatFloatBr(FVenda.TotalDesconto);
  edtacrescimo.Text := FormatFloatBr(FVenda.TotalAcrescimo);
  edtTotalOperacao.Text := FormatFloatBr(FVenda.TotalVenda);
  edtTotalpago.Text := FormatFloatBr(FVenda.TotalPago);
  edttroco.Text := FormatFloatBr(FVenda.Troco);
end;

procedure TForm1.AtualizarVendaInterface;
begin
  edtValorIncial.Text := FormatFloatBr(FVenda.ValorIncial);
  Label3.Text := FormatFloat('000000', FVenda.NumOperacao);
end;

procedure TForm1.btnPagamentosClick(Sender: TObject);
begin
  var LIncluirPagamento := TForm2.Create(Self);
  try
    LIncluirPagamento.edtValor.Text := FormatFloatBr(StrToCurrDef(edtTotalOperacao.Text,0));
    if LIncluirPagamento.ShowModal = mrOk then
    begin
      var LValor := StrToIntDef(OnlyNumber(LIncluirPagamento.edtValor.Text), 0)/100;
      AdicionarPagamento(LIncluirPagamento.Pagamento, LValor);
    end;
  finally
    LIncluirPagamento.Free;
  end;
end;

procedure TForm1.ConfigurarPosPrinter;
begin
  FComponentes.PosPrinter
    .Desativar
    .Modelo(0)
    .PaginaDeCodigo(0)
    .Porta('c:\temp\ecf.txt')
    .ColunasFonteNormal(40)
    .LinhasEntreCupons(0)
    .EspacoEntreLinhas(0)
    .Ativar;
end;

procedure TForm1.COnfigurarTef;
begin
  FComponentes.Tef
    .ArqLOG('')
    .TrocoMaximo(0)
    .ImprimirViaClienteReduzida(false)
    .MultiplosCartoes(true)
    .ConfirmarAntesDosComprovantes(true)
    .NumeroMaximoCartoes(5)
    .SuportaDesconto(true)
    .SuportaSaque(true)
    .SoftwareHouse('Academia do Código')
    .RegistroCertificacao('123456')
    .NomeAplicacao('TEFACDemo')
    .VersaoAplicacao('1.0')
    .SuportaReajusteValor(True)
    .SuportaNSUEstendido(true)
    .SuportaViasDiferenciadas(true)
    .ExibicaoQRCode(0)
    .AutoEfetuarPagamento(false)
    .AutoFinalizarCupom(false)
    .Inicializar(0);
end;

procedure TForm1.FinalizarVEnda;
begin
  var LRelatorio := TStringList.Create;
  try
    LRelatorio.Add('</linha_simples>');
    LRelatorio.Add(PadCenter(' COMPROVANTE DE OPERAÇÃO ', FComponentes.PosPrinter.Colunas, '-'));
    LRelatorio.Add('Número: <n>' + FormatFloat('000000', FVenda.NumOperacao) + '</n>');
    LRelatorio.Add('Data/Hora: <n>' + FormatDateTimeBr(FVenda.DHInicio) + '</n>');
    LRelatorio.Add('</linha_simples>');
    LRelatorio.Add('');
    LRelatorio.Add('Valor Inicial...: <n>' + FormatFloatBr(FVenda.ValorIncial) + '</n>');
    LRelatorio.Add('Total Desconto..: <n>' + FormatFloatBr(FVenda.TotalDesconto) + '</n>');
    LRelatorio.Add('Total Acrésimos.: <n>' + FormatFloatBr(FVenda.TotalAcrescimo) + '</n>');
    LRelatorio.Add('<linha_simples>');
    LRelatorio.Add('VALOR FINAL.....: <n>' + FormatFloatBr(FVenda.TotalVenda) + '</n>');
    LRelatorio.Add('');
    LRelatorio.Add(PadCenter(' Pagamentos ', FComponentes.PosPrinter.Colunas, '-'));
    LRelatorio.Add(PadSpace(FVenda.Pagamentos.TipoPagamento + ' - ' +
      DEscricaoTipoPagamento(FVenda.Pagamentos.TipoPagamento)+'|'+
          FormatFloatBr(FVenda.Pagamentos.ValorPago)+'|'+FVenda.Pagamentos.Rede, FComponentes.PosPrinter.Colunas,'|'));
    LRelatorio.Add('</linha_simples>');

    LRelatorio.Add('Total Pago......: <n>' + FormatFloatBr(FVenda.TotalPago) + '</n>');
    if FVenda.Troco > 0 then
      LRelatorio.Add('Troco...........: <n>' + FormatFloatBr(FVenda.Troco) + '</n>');

    LRelatorio.Add('</linha_dupla>');
    LRelatorio.Add('</corte>');
    AdicionarLinhaImpressao(LRelatorio.Text);
  finally
    LRelatorio.Free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ListBoxPagamentos.Clear;
  FComponentes := TFactoryComponentes.New;

  ConfigurarPosPrinter;
  COnfigurarTef;

  FVenda := TVenda.Create;
end;

end.
