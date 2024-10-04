unit tefacdemo.interfaces;

interface

type
  IGeneric<T> = interface
    function &Begin: IGeneric<T>;
    function Add(Value: String): IGeneric<T>;
    function &Continue: T;
    function &End: T;
  end;

  IExpandido<T: IInterface> = interface
    function Tag: IGeneric<IExpandido<T>>;
    function &Contine: T;
  end;

  IFormater<T> = interface
    function LigaExpadindo: IFormater<T>;
    function DesligaExpandito: IFormater<T>;
    function LigaAlturaDupla: IFormater<T>;
    function DesligaAlturaDupla: IFormater<T>;
    function LigaNegrito: IFormater<T>;
    function DesligaNegrito: IFormater<T>;
    function LigaSublinhado: IFormater<T>;
    function DesligaSublinhado: IFormater<T>;
    function LigaCondensado: IFormater<T>;
    function DesligaCondensado: IFormater<T>;
    function LigaItalico: IFormater<T>;
    function DesligaItalico: IFormater<T>;
    function FonteNoraml: IFormater<T>;
    function LigaFonteTipoA: IFormater<T>;
    function LigaFonteTipoB: IFormater<T>;
    function LigaFonteInvertida: IFormater<T>;
    function DeligaFonteInvertida: IFormater<T>;
    function LigaAlinhamentoEsqueda: IFormater<T>;
    function LigaAlinhamentoCentro: IFormater<T>;
    function LigaAlinhamentoDireto: IFormater<T>;
    function ImprimeLinhaSimples: IFormater<T>;
    function ImprimeLinhaDupla: IFormater<T>;
    function PulaLinha: IFormater<T>;
    function ImprimeLogotipoImpressoa: IFormater<T>;
    function EfetuaCorte: IFormater<T>;
    function EfetuaCorteParcial: IFormater<T>;
    function EfetuaCorteTotal: IFormater<T>;
    function AcionaAbertudaGaveta: IFormater<T>;
    function EmiteBeepImpressora: IFormater<T>;
    function ZeraConfiguracoes: IFormater<T>;
    function PulaProximaLinha: IFormater<T>;
    function RetornaInicioLinha: IFormater<T>;
    function ResetaConfiguracoes: IFormater<T>;
    function BlocoAlinhadoDireta: IFormater<T>;
    function BlocoAlinhadoEsquerda: IFormater<T>;
    function BlocoAlinhadoCentro: IFormater<T>;
    function BlocoEAN8: IFormater<T>;
    function BlocoEAN13: IFormater<T>;
    function BlocoStandard2fo5: IFormater<T>;
    function Build: T;
  end;

  IPosPrinter = interface
    function Ativar: IPosPrinter;
    function Desativar: IPosPrinter;
    function Modelo(Value: Integer): IPosPrinter;
    function PaginaCodificacao(Value: Integer): IPosPrinter;
    function Porta(Value: String): IPosPrinter;
    function ColunasFonteNormal(Value: Integer): IPosPrinter;
    function LinhasEntreCupons(Value: Integer): IPosPrinter;
    function EspacoEntreLinhas(Value: Integer): IPosPrinter;
    function Colunas: Integer;
    function Ativo: Boolean;
    procedure Imprimir(Value: String);
  end;

  ITef = interface
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

  IFactoryComponentes = interface
    function PosPrinter: IPosPrinter;
    function Tef: ITef;
  end;

implementation

end.
