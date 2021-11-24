unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, REST.Types, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.StorageBin,
  Data.Bind.EngExt, Vcl.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope, Data.DB,
  REST.Response.Adapter, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Client,
  Data.Bind.ObjectScope, Vcl.Grids, Vcl.Bind.Editors, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.CheckLst, Vcl.Bind.Grid, Vcl.DBCGrids;

type
  TForm2 = class(TForm)
    DataSource1: TDataSource;
    BindingsList1: TBindingsList;
    Label1: TLabel;
    BindSourceDB1: TBindSourceDB;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    LinkPropertyToFieldCaption: TLinkPropertyToField;
    LinkPropertyToFieldCaption2: TLinkPropertyToField;
    LinkPropertyToFieldCaption3: TLinkPropertyToField;
    LinkPropertyToFieldCaption4: TLinkPropertyToField;
    LinkPropertyToFieldCaption5: TLinkPropertyToField;
    StringGrid1: TStringGrid;
    LinkPropertyToFieldCaption6: TLinkPropertyToField;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    Dados: TFDMemTable;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    DataSource2: TDataSource;
    BindSourceDB2: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB2: TLinkGridToDataSource;
    StringGrid2: TStringGrid;
    RESTResponseDataSetAdapter2: TRESTResponseDataSetAdapter;
    FDMemTable1: TFDMemTable;
    BindSourceDB3: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB3: TLinkGridToDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses Unit1;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  LinkPropertyToFieldCaption.FieldName:='';
  LinkPropertyToFieldCaption2.FieldName:='';
  LinkPropertyToFieldCaption3.FieldName:='';
  LinkPropertyToFieldCaption4.FieldName:='';
  LinkPropertyToFieldCaption5.FieldName:='';
  LinkPropertyToFieldCaption6.FieldName:='';
end;
end.
