unit tefacdemo.tef;

interface

uses
  System.Classes,
  System.UITypes,
  ACBrBase,
  ACbrUtil,
  ACBrTEFD,
  ACBrTEFDClass,
  ACBrTEFPayGoWebComum,
  tefacdemo.interfaces;

type
  TTef = class(TInterfacedObject, ITef)
  private
    FACBrTEFD: TACBrTEFD;

    procedure AguardaResposta(Arquivo: String;
  SegundosTimeOut: Integer; var Interromper: Boolean);
    procedure AntesFinalizarRequisicao(Req: TACBrTEFDReq);
    procedure BloqueiaMouseTeclado(Bloqueia: Boolean; var Tratado: Boolean);
    procedure ComandECF(Operacao: TACBrTEFDOperacaoECF;
  Resp: TACBrTEFDResp; var RetornoECF: Integer);
    procedure AbreECFVinculado(COO,
  IndiceECF: String; Valor: Double; var RetornoECF: Integer);
    procedure ECFImprimeVia(
  TipoRelatorio: TACBrTEFDTipoRelatorio; Via: Integer;
  ImagemComprovante: TStringList; var RetornoECF: Integer);
    procedure ECFPagamento(IndiceECF: String;
  Valor: Double; var RetornoECF: Integer);
    procedure ECFSubtotaliza(DescAcre: Double;
  var RetornoECF: Integer);
    procedure DepoisCancelarTransacoes(RespostasPendentes: TACBrTEFDRespostasPendentes);
    procedure DepoisCOnfirmarTransacoes(
  RespostasPendentes: TACBrTEFDRespostasPendentes);
    procedure ExibeMSg(Operacao: TACBrTEFDOperacaoMensagem;
  Mensagem: String; var AModalResult: TModalResult);

    procedure AdicionarLinhaImpressao(Value: String);
    procedure PayGoWebExibeMensagem(Mensagem: String;
  Terminal: TACBrTEFPGWebAPITerminalMensagem; MilissegundosExibicao: Integer);
    procedure MensagemTEF(const MsgOperador, MsgCliente: String);
    procedure ExibeQRCode(const Dados: String);
    procedure GravarLog(const GP: TACBrTEFDTipo;
  ALogLine: String; var Tratado: Boolean);
    procedure InfoECF(Operacao: TACBrTEFDInfoECF;
  var RetornoECF: String);

    constructor Create;
    destructor Destroy; override;
  public
    class function New: ITef;

    function Inicializar(Value: INteger): ITef;
    function ArqLOG(Value: String): ITef;
    function TrocoMaximo(Value: Double): ITef;
    function ImprimirViaClienteReduzida(Value: Boolean): ITef;
    function MultiplosCartoes(Value: Boolean): ITef;
    function ConfirmarAntesDosComprovantes(Value: Boolean): ITef;
    function NumeroMaximoCartoes(Value: Integer): ITef;
    function SuportaDesconto(Value: Boolean): ITef;
    function SuportaSaque(Value: Boolean): ITef;
    function SoftwareHouse(Value: String): ITef;
    function RegistroCertificacao(Value: String): ITef;
    function NomeAplicacao(Value: String): ITef;
    function VersaoAplicacao(Value: String): ITef;
    function SuportaReajusteValor(Value: Boolean): ITef;
    function SuportaNSUEstendido(VAlue: Boolean): ITef;
    function SuportaViasDiferenciadas(Value: Boolean): ITef;
    function ExibicaoQRCode(Value: Integer): ITef;
    function AutoEfetuarPagamento(Value: Boolean): ITef;
    function AutoFinalizarCupom(Value: Boolean): ITef;
  end;

implementation

uses
  FMX.Forms, FMX.Dialogs, System.DateUtils, System.SysUtils;

{ TTef }

procedure TTef.AbreECFVinculado(COO, IndiceECF: String; Valor: Double;
  var RetornoECF: Integer);
begin
  RetornoECF := 1;
end;

procedure TTef.AdicionarLinhaImpressao(Value: String);
begin
  //
end;

procedure TTef.AguardaResposta(Arquivo: String; SegundosTimeOut: Integer;
  var Interromper: Boolean);
begin
  Application.ProcessMessages;
end;

procedure TTef.AntesFinalizarRequisicao(Req: TACBrTEFDReq);
begin
//
end;

function TTef.ArqLOG(Value: String): ITef;
begin
  REsult := SElf;
  FACBrTEFD.ArqLOG := Value;
end;

function TTef.AutoEfetuarPagamento(Value: Boolean): ITef;
begin
  REsult := SElf;
  FACBrTEFD.AutoEfetuarPagamento := Value;
end;

function TTef.AutoFinalizarCupom(Value: Boolean): ITef;
begin
  REsult := SElf;
  FACBrTEFD.AutoFinalizarCupom := Value;
end;

procedure TTef.BloqueiaMouseTeclado(Bloqueia: Boolean; var Tratado: Boolean);
begin
  Tratado := False;
end;

procedure TTef.ComandECF(Operacao: TACBrTEFDOperacaoECF; Resp: TACBrTEFDResp;
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

function TTef.ConfirmarAntesDosComprovantes(Value: Boolean): ITef;
begin
  REsult := SElf;
  FACBrTEFD.ConfirmarAntesDosComprovantes := VAlue;
end;

constructor TTef.Create;
begin
  FACBrTEFD:= TACBrTEFD.Create(nil);
  FACBrTEFD.OnExibeMsg := ExibeMSg;
  FACBrTEFD.OnComandaECF := ComandECF;
  FACBrTEFD.OnAguardaResp := AguardaResposta;
  FACBrTEFD.OnAntesFinalizarRequisicao := AntesFinalizarRequisicao;
  FACBrTEFD.OnBloqueiaMouseTeclado := BloqueiaMouseTeclado;
  FACBrTEFD.OnComandaECFSubtotaliza := ECFSubtotaliza;
  FACBrTEFD.OnComandaECFAbreVinculado := AbreECFVinculado;
  FACBrTEFD.OnComandaECFImprimeVia := ECFImprimeVia;
  FACBrTEFD.OnDepoisCancelarTransacoes := DepoisCancelarTransacoes;
  FACBrTEFD.OnDepoisConfirmarTransacoes := DepoisCOnfirmarTransacoes;
  FACBrTEFD.OnGravarLog := GravarLog;
  FACBrTEFD.OnInfoECF := InfoECF;
end;

procedure TTef.DepoisCancelarTransacoes(
  RespostasPendentes: TACBrTEFDRespostasPendentes);
begin
  //
end;

procedure TTef.DepoisCOnfirmarTransacoes(
  RespostasPendentes: TACBrTEFDRespostasPendentes);
begin
  //
end;

destructor TTef.Destroy;
begin
  FACBrTEFD.Free;
  inherited;
end;

procedure TTef.ECFImprimeVia(TipoRelatorio: TACBrTEFDTipoRelatorio;
  Via: Integer; ImagemComprovante: TStringList; var RetornoECF: Integer);
begin
  RetornoECF := 1;
end;

procedure TTef.ECFPagamento(IndiceECF: String; Valor: Double;
  var RetornoECF: Integer);
begin
  RetornoECF :=1;
end;

procedure TTef.ECFSubtotaliza(DescAcre: Double; var RetornoECF: Integer);
begin
  //
end;

procedure TTef.ExibeMSg(Operacao: TACBrTEFDOperacaoMensagem; Mensagem: String;
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

function TTef.ExibicaoQRCode(Value: Integer): ITef;
begin
  Result := Self;
  case Value of
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
  Tratado := false;
end;

function TTef.ImprimirViaClienteReduzida(Value: Boolean): ITef;
begin
  Result := SElf;
  FACBrTEFD.ImprimirViaClienteReduzida := VAlue;
end;

procedure TTef.InfoECF(Operacao: TACBrTEFDInfoECF; var RetornoECF: String);
begin
//
end;

function TTef.Inicializar(Value: INteger): ITef;
begin
  Result := SElf;
  FACBrTEFD.Inicializar(TACBrTEFDTipo(Value));
end;

procedure TTef.MensagemTEF(const MsgOperador, MsgCliente: String);
begin
  Application.ProcessMessages;
end;

function TTef.MultiplosCartoes(Value: Boolean): ITef;
begin
  Result := SElf;
  FACBrTEFD.MultiplosCartoes := VAlue;
end;

class function TTef.New: ITef;
begin
  Result := SElf.Create;
end;

function TTef.NomeAplicacao(Value: String): ITef;
begin
  Result := SElf;
  FACBrTEFD.Identificacao.NomeAplicacao := VAlue;
end;

function TTef.NumeroMaximoCartoes(Value: Integer): ITef;
begin
  Result := SElf;
  FACBrTEFD.NumeroMaximoCartoes := VAlue;
end;

procedure TTef.PayGoWebExibeMensagem(Mensagem: String;
  Terminal: TACBrTEFPGWebAPITerminalMensagem; MilissegundosExibicao: Integer);
begin
  if Mensagem = '' then
    MensagemTEF(' ','');
end;

function TTef.RegistroCertificacao(Value: String): ITef;
begin
  Result := SElf;
  FACBrTEFD.Identificacao.RegistroCertificacao := Value;
end;

function TTef.SoftwareHouse(Value: String): ITef;
begin
  Result := SElf;
  FACBrTEFD.Identificacao.SoftwareHouse := Value;
end;

function TTef.SuportaDesconto(Value: Boolean): ITef;
begin
  Result := SElf;
  FACBrTEFD.SuportaDesconto := Value;
end;

function TTef.SuportaNSUEstendido(VAlue: Boolean): ITef;
begin
  Result := SElf;
  FACBrTEFD.TEFPayGo.SuportaNSUEstendido := VAlue;
end;

function TTef.SuportaReajusteValor(Value: Boolean): ITef;
begin
  Result := SElf;
  FACBrTEFD.TEFPayGo.SuportaReajusteValor := VAlue;
end;

function TTef.SuportaSaque(Value: Boolean): ITef;
begin
  Result := SElf;
  FACBrTEFD.SuportaSaque := VAlue;
end;

function TTef.SuportaViasDiferenciadas(Value: Boolean): ITef;
begin
  Result := SElf;
  FACBrTEFD.TEFPayGo.SuportaViasDiferenciadas := Value;
end;

function TTef.TrocoMaximo(Value: Double): ITef;
begin
  Result := SElf;
  FACBrTEFD.TrocoMaximo := Value;
end;

function TTef.VersaoAplicacao(Value: String): ITef;
begin
  Result := SElf;
  FACBrTEFD.Identificacao.VersaoAplicacao := VAlue;
end;

end.
