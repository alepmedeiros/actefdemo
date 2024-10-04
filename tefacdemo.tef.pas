unit tefacdemo.tef;

interface

uses
  System.Classes,
  System.DateUtils,
  ACBrBase,
  ACbrUtil,
  ACBrTEFD,
  ACBrTEFDClass,
  ACBrTEFPayGoWebComum,
  tefacdemo.interfaces, System.UITypes;

type
  TTef = class(TInterfacedObject, ITef)
  private
    FACBrTEFD: TACBrTEFD;


    procedure ExibeMsg(Operacao: TACBrTEFDOperacaoMensagem;
      Mensagem: String; var AModalResult: TModalResult);
    procedure PayGoWebExibeMensagem(Mensagem: String;
      Terminal: TACBrTEFPGWebAPITerminalMensagem; MilissegundosExibicao: Integer);
    procedure ComandaECF(Operacao: TACBrTEFDOperacaoECF;
      Resp: TACBrTEFDResp; var RetornoECF: Integer);
    procedure AguardaResp(Arquivo: String;
  SegundosTimeOut: Integer; var Interromper: Boolean);
  procedure AntesFinalizarRequisicao(Req: TACBrTEFDReq);
  procedure BloqueiaMouseTeclado(Bloqueia: Boolean; var Tratado: Boolean);
  procedure ComandaECFAbreVinculado(COO,
  IndiceECF: String; Valor: Double; var RetornoECF: Integer);
  procedure ComandaECFImprimeVia(
  TipoRelatorio: TACBrTEFDTipoRelatorio; Via: Integer;
  ImagemComprovante: TStringList; var RetornoECF: Integer);
  procedure ComandaECFPagamento(IndiceECF: String;
  Valor: Double; var RetornoECF: Integer);
  procedure ComandaECFSubtotaliza(DescAcre: Double;
  var RetornoECF: Integer);
  procedure DepoisCancelarTransacoes(
  RespostasPendentes: TACBrTEFDRespostasPendentes);
  procedure DepoisConfirmarTransacoes(
  RespostasPendentes: TACBrTEFDRespostasPendentes);
  procedure ExibeQRCode(const Dados: String);
  procedure GravarLog(const GP: TACBrTEFDTipo;
  ALogLine: String; var Tratado: Boolean);
  procedure InfoECF(Operacao: TACBrTEFDInfoECF;
  var RetornoECF: String);

    procedure AdicionarLinhaImpressao(Value:String);

    procedure MensagemTEF(const MsgOperador, MsgCliente: String);
    constructor Create;
    destructor Destroy; override;
  public
    class function New: ITef;
    function Inicializar(Value: Integer): ITef;
    function DesInicializar(Value: Integer): ITef;
    function ArqLOG(Value: string): ITef;
    function TrocoMaximo(Value: Double): ITef;
    function ImprimirViaClienteReduzida(Value: Boolean): ITef;
    function MultiplosCartoes(Value: Boolean): ITef;
    function ConfirmarAntesDosComprovantes(Value: Boolean): ITef;
    function NumeroMaximoCartoes(Value: Integer): ITef;
    function SuportaDesconto(Value: Boolean): ITef;
    function SuportaSaque(Value: Boolean): ITef;
    function SoftwareHouse(value: String): ITef;
    function RegistroCertificacao(Value: String): ITef;
    function NomeAplicacao(Value: String): ITef;
    function VersaoAplicacao(Value: String): ITef;
    function SuportaReajusteValor(Value: Boolean): ITef;
    function SuportaNSUEstendido(Value: Boolean): ITef;
    function SuportaViasDiferenciadas(Value: Boolean): ITef;
    function ExibicaoQrCode(Value: Integer): ITef;
    function AutoEfetuarPagamento(Value: Boolean): ITef;
    function AutoFinalizarCupom(Value: Boolean): ITef;
  end;

implementation

uses
  FMX.Forms, FMX.Dialogs, System.SysUtils;

{ TTef }

procedure TTef.AdicionarLinhaImpressao(Value: String);
begin
///
end;

procedure TTef.AguardaResp(Arquivo: String; SegundosTimeOut: Integer;
  var Interromper: Boolean);
begin
  Application.ProcessMessages;
end;

procedure TTef.AntesFinalizarRequisicao(Req: TACBrTEFDReq);
begin
//
end;

function TTef.ArqLOG(Value: string): ITef;
begin
  Result := Self;
  FACBrTEFD.ArqLOG := Value;
end;

function TTef.AutoEfetuarPagamento(Value: Boolean): ITef;
begin
  Result := Self;
  FACBrTEFD.AutoEfetuarPagamento := Value;
end;

function TTef.AutoFinalizarCupom(Value: Boolean): ITef;
begin
  Result := Self;
  FACBrTEFD.AutoFinalizarCupom := Value;
end;

procedure TTef.BloqueiaMouseTeclado(Bloqueia: Boolean; var Tratado: Boolean);
begin
  Tratado := False ;  { Deixa executar o c�digo de Bloqueio do ACBrTEFD }
end;

procedure TTef.ComandaECF(Operacao: TACBrTEFDOperacaoECF; Resp: TACBrTEFDResp;
  var RetornoECF: Integer);
  procedure PularLinhasECortar;
  begin
    AdicionarLinhaImpressao('</pular_linhas>');
    AdicionarLinhaImpressao('</corte>');
  end;

begin
  try
    case Operacao of
      opeAbreGerencial:
        AdicionarLinhaImpressao('</zera>');

      opeSubTotalizaCupom:;
      opeCancelaCupom:;
      opeFechaCupom:;
      opePulaLinhas:;
      opeFechaGerencial, opeFechaVinculado:;
    end;

    RetornoECF := 1 ;
  except
    RetornoECF := 0 ;
  end;
end;

procedure TTef.ComandaECFAbreVinculado(COO, IndiceECF: String; Valor: Double;
  var RetornoECF: Integer);
begin
  RetornoECF := 1;
end;

procedure TTef.ComandaECFImprimeVia(TipoRelatorio: TACBrTEFDTipoRelatorio;
  Via: Integer; ImagemComprovante: TStringList; var RetornoECF: Integer);
begin
  RetornoECF := 1 ;
end;

procedure TTef.ComandaECFPagamento(IndiceECF: String; Valor: Double;
  var RetornoECF: Integer);
begin
RetornoECF := 1;
end;

procedure TTef.ComandaECFSubtotaliza(DescAcre: Double; var RetornoECF: Integer);
begin
//
end;

function TTef.ConfirmarAntesDosComprovantes(Value: Boolean): ITef;
begin
  Result := Self;
  FACBrTEFD.ConfirmarAntesDosComprovantes := Value;
end;

constructor TTef.Create;
begin
  FACBrTEFD := TACBrTEFD.Create(nil);
  FACBrTEFD.OnExibeMsg := ExibeMsg;
  FACBrTEFD.OnComandaECF := ComandaECF;
  FACBrTEFD.OnAguardaResp := AguardaResp;
  FACBrTEFD.OnAntesFinalizarRequisicao := AntesFinalizarRequisicao;
  FACBrTEFD.OnBloqueiaMouseTeclado := BloqueiaMouseTeclado;
  FACBrTEFD.OnComandaECFAbreVinculado := ComandaECFAbreVinculado;
  FACBrTEFD.OnComandaECFImprimeVia := ComandaECFImprimeVia;
  FACBrTEFD.OnComandaECFSubtotaliza := ComandaECFSubtotaliza;
  FACBrTEFD.OnDepoisCancelarTransacoes := DepoisCancelarTransacoes;
  FACBrTEFD.OnDepoisConfirmarTransacoes := DepoisConfirmarTransacoes;
  FACBrTEFD.OnGravarLog := GravarLog;
  FACBrTEFD.OnInfoECF := InfoECF;
end;

procedure TTef.DepoisCancelarTransacoes(
  RespostasPendentes: TACBrTEFDRespostasPendentes);
begin
//
end;

procedure TTef.DepoisConfirmarTransacoes(
  RespostasPendentes: TACBrTEFDRespostasPendentes);
begin
//
end;

function TTef.DesInicializar(Value: Integer): ITef;
begin
  Result := Self;
  FACBrTEFD.DesInicializar(TACBrTEFDTipo(Value));
end;

destructor TTef.Destroy;
begin
  FACBrTEFD.Free;
  inherited;
end;

procedure TTef.ExibeMsg(Operacao: TACBrTEFDOperacaoMensagem; Mensagem: String;
  var AModalResult: TModalResult);
var
   Fim : TDateTime;
   OldMensagem : String;
begin
  case Operacao of
    opmOK:
      begin
        if FACBrTEFD.GPAtual = gpPayGoWeb then
          PayGoWebExibeMensagem( Mensagem, tmOperador, CMilissegundosMensagem)
        else
          AModalResult := MessageDlg( Mensagem, TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
      end;

    opmYesNo:
       AModalResult := MessageDlg( Mensagem, TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0);

    opmExibirMsgOperador:
      MensagemTEF(Mensagem,'') ;

    opmRemoverMsgOperador:
      MensagemTEF(' ','') ;

    opmExibirMsgCliente:
      MensagemTEF('', Mensagem) ;

    opmRemoverMsgCliente:
      MensagemTEF('', ' ') ;

    opmDestaqueVia:
      begin
        try
          { Aguardando 3 segundos }
          Fim := IncSecond(now, 3)  ;
          repeat
            MensagemTEF(Mensagem + ' ' + IntToStr(SecondsBetween(Fim,now)), '');
            Sleep(200) ;
          until (now > Fim) ;
        finally
          MensagemTEF(OldMensagem, '');
        end;
      end;
  end;
end;

procedure TTef.ExibeQRCode(const Dados: String);
begin
//
end;

function TTef.ExibicaoQrCode(Value: Integer): ITef;
begin
  Result := Self;
  case value of
    0: FACBrTEFD.TEFPayGoWeb.ExibicaoQRCode := qreNaoSuportado;
    2: FACBrTEFD.TEFPayGoWeb.ExibicaoQRCode := qreExibirNoPinPad;
    3, 4: FACBrTEFD.TEFPayGoWeb.ExibicaoQRCode := qreExibirNoCheckOut;
  else
    FACBrTEFD.TEFPayGoWeb.ExibicaoQRCode := qreAuto;
  end;
end;

procedure TTef.GravarLog(const GP: TACBrTEFDTipo; ALogLine: String;
  var Tratado: Boolean);
begin
Tratado := False;
end;

function TTef.ImprimirViaClienteReduzida(Value: Boolean): ITef;
begin
  Result := Self;
  FACBrTEFD.ImprimirViaClienteReduzida := VAlue;
end;

procedure TTef.InfoECF(Operacao: TACBrTEFDInfoECF; var RetornoECF: String);
begin
//
end;

function TTef.Inicializar(Value: Integer): ITef;
begin
  Result := Self;
  FACBrTEFD.Inicializar(TACBrTEFDTipo(Value));
end;

procedure TTef.MensagemTEF(const MsgOperador, MsgCliente: String);
begin
  Application.ProcessMessages;
end;

function TTef.MultiplosCartoes(Value: Boolean): ITef;
begin
  Result := Self;
  FACBrTEFD.MultiplosCartoes := Value;
end;

class function TTef.New: ITef;
begin
  Result := Self.Create;
end;

function TTef.NomeAplicacao(Value: String): ITef;
begin
  Result := Self;
  FACBrTEFD.Identificacao.NomeAplicacao := Value;
end;

function TTef.NumeroMaximoCartoes(Value: Integer): ITef;
begin
  Result := Self;
  FACBrTEFD.NumeroMaximoCartoes := Value;
end;

procedure TTef.PayGoWebExibeMensagem(Mensagem: String;
  Terminal: TACBrTEFPGWebAPITerminalMensagem; MilissegundosExibicao: Integer);
begin
  if (Mensagem = '') then
     MensagemTEF(' ','')
end;

function TTef.RegistroCertificacao(Value: String): ITef;
begin
  Result := Self;
  FACBrTEFD.Identificacao.RegistroCertificacao := Value;
end;

function TTef.SoftwareHouse(value: String): ITef;
begin
  Result := Self;
  FACBrTEFD.Identificacao.SoftwareHouse := Value;
end;

function TTef.SuportaDesconto(Value: Boolean): ITef;
begin
  Result := Self;
  FACBrTEFD.SuportaDesconto := Value;
end;

function TTef.SuportaNSUEstendido(Value: Boolean): ITef;
begin
  Result := Self;
  FACBrTEFD.TEFPayGo.SuportaNSUEstendido := Value;
end;

function TTef.SuportaReajusteValor(Value: Boolean): ITef;
begin
  Result := Self;
  FACBrTEFD.TEFPayGo.SuportaReajusteValor := Value;
end;

function TTef.SuportaSaque(Value: Boolean): ITef;
begin
  Result := Self;
  FACBrTEFD.SuportaSaque := Value;
end;

function TTef.SuportaViasDiferenciadas(Value: Boolean): ITef;
begin
  Result := Self;
  FACBrTEFD.TEFPayGo.SuportaViasDiferenciadas := Value;
end;

function TTef.TrocoMaximo(Value: Double): ITef;
begin
  Result := Self;
  FACBrTEFD.TrocoMaximo := Value;
end;

function TTef.VersaoAplicacao(Value: String): ITef;
begin
  Result := Self;
  FACBrTEFD.Identificacao.VersaoAplicacao := Value;
end;

end.
