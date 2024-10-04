unit Unit6;

interface

uses
  Unit5;

type
  TExpandido<T: IInterface> = class(TInterfacedObject, IExpandido<T>)
  private
    [weak]
    FParent: T;

    constructor Create(Parent: T);
  public
    class function New(Parent: T): IExpandido<T>;

    function &Begin: IExpandido<T>;
    function Add(Value: String): IExpandido<T>;
    function &Continue: T;
    function &End: T;
  end;

implementation

{ TExpandido<T> }

function TExpandido<T>.Add(Value: String): IExpandido<T>;
begin

end;

function TExpandido<T>.&Begin: IExpandido<T>;
begin

end;

function TExpandido<T>.Continue: T;
begin

end;

function TExpandido<T>.&End: T;
begin

end;

constructor TExpandido<T>.Create(Parent: T);
begin
  FParent := Parent;
end;

class function TExpandido<T>.New(Parent: T): IExpandido<T>;
begin
  REsult := Self.Create(Parent);
end;

end.
