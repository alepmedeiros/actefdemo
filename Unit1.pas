unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Objects, FMX.Edit, FMX.ListBox, ACBrTEFD, ACBrBase,
  ACBrPosPrinter, tefacdemo.interfaces,venda;

type
  TForm1 = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    Label1: TLabel;
    Layout5: TLayout;
    Memo1: TMemo;
    lblOperacao: TLabel;
    Label3: TLabel;
    Layout6: TLayout;
    Label4: TLabel;
    Layout7: TLayout;
    Layout8: TLayout;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
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
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    Layout13: TLayout;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    StyleBook1: TStyleBook;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure edtValorIncialChange(Sender: TObject);
  private
    FComponentes: IFactoryComponentes;
    FVenda: TVenda;

    procedure ConfigurarPosPrinter;
    procedure ConfigurarTef;

    procedure AdicionarPagamentos(const aIndice: Integer; aValor: Double);
    procedure FinalizarVenda;
    procedure AdicionarLinhaImpressao(ALinha: String);

    procedure AtualizarVendaInterface;
    procedure AtualizarTotaisVendaNaInterface;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  ACBrUtil,
  System.Math,
  tefacdem.factorycomponetes,
  Unit2;

{$R *.fmx}

procedure TForm1.AdicionarLinhaImpressao(ALinha: String);
begin
  Memo1.Lines.Add(ALinha);
  if FComponentes.PosPrinter.Ativo then
    FComponentes.PosPrinter.Imprimir(ALinha)
end;

procedure TForm1.AdicionarPagamentos(const aIndice: Integer; aValor: Double);
begin
  case aIndice of
    0: FVenda.Pagamentos.TipoPagamento := '05';
    1: FVenda.Pagamentos.TipoPagamento := '04';
    2: FVenda.Pagamentos.TipoPagamento := '03';
    3: FVenda.Pagamentos.TipoPagamento := '01';
  end;

  FVenda.Pagamentos.ValorPago := aValor;
  FVenda.Pagamentos.Confirmada := True;
  FinalizarVenda;
end;

procedure TForm1.AtualizarTotaisVendaNaInterface;
begin
  edtValorIncial.Text := FormatFloatBr(FVenda.ValorInicial);
  edtDesconto.Text := FormatFloatBr(FVenda.TotalDesconto);
  edtacrescimo.Text := FormatFloatBr(FVenda.TotalAcrescimo);
  edtTotalOperacao.Text := FormatFloatBr(FVenda.TotalVenda);
  edtTotalpago.Text := FormatFloatBr(FVenda.TotalPago);
  edttroco.Text := FormatFloatBr(max(FVenda.Troco,0));
end;

procedure TForm1.AtualizarVendaInterface;
begin
  edtValorIncial.Text := FormatFloatBr(FVenda.ValorInicial);
  lblOperacao.Text := FormatFloat('000000',FVenda.NumOperacao);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  var LIncluirPagamento := TForm2.Create(Self);
  try
    LIncluirPagamento.edtValor.Text := FormatFloatBr(StrToCurrDef(edtTotalOperacao.Text,0));
    if (LIncluirPagamento.ShowModal = mrOk) then
    begin
      var LValor := StrToIntDef(OnlyNumber(LIncluirPagamento.edtValor.Text), 0)/100;
      AdicionarPagamentos(LIncluirPagamento.Pagamento, LValor);
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
    .PaginaCodificacao(0)
    .Porta('c:\temp\ecf.txt')
    .ColunasFonteNormal(40)
    .LinhasEntreCupons(0)
    .EspacoEntreLinhas(0)
    .Ativar;
end;

procedure TForm1.ConfigurarTef;
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
    .SoftwareHouse('PROJETO ACBR')
    .RegistroCertificacao('123456')
    .NomeAplicacao('TEFDemoNF')
    .VersaoAplicacao('1.0')
    .SuportaReajusteValor(true)
    .SuportaNSUEstendido(true)
    .SuportaViasDiferenciadas(true)
    .ExibicaoQrCode(0)
    .AutoEfetuarPagamento(false)
    .AutoFinalizarCupom(false)
    .Inicializar(0);
end;


procedure TForm1.edtValorIncialChange(Sender: TObject);
begin
  var AValor := StrToIntDef(OnlyNumber(edtValorIncial.Text), 0)/100;
  edtValorIncial.Text := FormatFloatBr(AValor);
  edtValorIncial.SelStart := Length(edtValorIncial.Text);
end;

procedure TForm1.FinalizarVenda;
begin
  var SL := TStringList.Create;
  try
    // Ao inv�s do relat�rio abaixo, voc� deve enviar a impress�o de um DANFCE ou Extrato do SAT

    SL.Add(PadCenter( ' COMPROVANTE DE OPERA��O ', FComponentes.PosPrinter.Colunas, '-'));
    SL.Add('N�mero: <n>' + FormatFloat('000000',FVenda.NumOperacao) + '</n>');
    SL.Add('Data/Hora: <n>' + FormatDateTimeBr(FVenda.DHInicio) + '</n>');
    SL.Add('</linha_simples>');
    SL.Add('');
    SL.Add('Valor Inicial...: <n>' + FormatFloatBr(FVenda.ValorInicial) + '</n>');
    SL.Add('Total Descontos.: <n>' + FormatFloatBr(FVenda.TotalDesconto) + '</n>');
    SL.Add('Total Acr�scimos: <n>' + FormatFloatBr(FVenda.TotalAcrescimo) + '</n>');
    SL.Add('</linha_simples>');
    SL.Add('VALOR FINAL.....: <n>' + FormatFloatBr(FVenda.TotalVenda) + '</n>');
    SL.Add('');
    SL.Add(PadCenter( ' Pagamentos ', FComponentes.PosPrinter.Colunas, '-'));
    SL.Add(PadSpace( FVenda.Pagamentos.TipoPagamento+' - '+DescricaoTipoPagamento(FVenda.Pagamentos.TipoPagamento)+'|'+
                           FormatFloatBr(FVenda.Pagamentos.ValorPago)+'|'+FVenda.Pagamentos.Rede, FComponentes.PosPrinter.Colunas, '|') );
    SL.Add('</linha_simples>');

    SL.Add('Total Pago......: <n>' + FormatFloatBr(FVenda.TotalPago) + '</n>');
    if (FVenda.Troco > 0) then
      SL.Add('Troco...........: <n>' + FormatFloatBr(FVenda.Troco) + '</n>');

    SL.Add('</linha_dupla>');
    SL.Add('</corte>');
    AdicionarLinhaImpressao(SL.Text);
  finally
    SL.Free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ListBox1.Clear;
  FComponentes := TFactoryComponentes.NEw;
  ConfigurarPosPrinter;
  ConfigurarTef;
  FVenda := TVenda.Create;
end;

end.
