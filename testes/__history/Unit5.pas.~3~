unit Unit5;

interface

type
  TTipoTag = (tgExpandido);

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

  IPrinter = interface
    function Expandido: IExpandido<IPrinter>;
    function Imprimir: String;
  end;

implementation

end.
