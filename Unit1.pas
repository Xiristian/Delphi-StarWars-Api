unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, REST.Types, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.Bind.EngExt, Vcl.Bind.DBEngExt,
  System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors, Vcl.Bind.Grid,
  Data.Bind.Grid, Vcl.Grids, Data.Bind.Components, Data.Bind.DBScope, Data.DB,
  REST.Response.Adapter, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Client,
  Data.Bind.ObjectScope, Vcl.DBGrids, Vcl.DBCGrids, Vcl.StdCtrls,
  Data.Bind.Controls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.Bind.Navigator, System.Threading,
  FireDAC.Stan.StorageBin, Vcl.WinXCtrls, Vcl.Samples.Spin;

type
  TForm1 = class(TForm)
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    Dados: TFDMemTable;
    RESTResponseDataSetAdapter: TRESTResponseDataSetAdapter;
    DataSource: TDataSource;
    BindSourceDB1: TBindSourceDB;
    Personagens: TButton;
    Planetas: TButton;
    Filmes: TButton;
    SearchBox1: TSearchBox;
    Voltar: TButton;
    Avançar: TButton;
    ComboBox1: TComboBox;
    Grid: TStringGrid;
    Clima: TComboBox;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    procedure PersonagensClick(Sender: TObject);
    procedure PlanetasClick(Sender: TObject);
    procedure FilmesClick(Sender: TObject);
    procedure VoltarClick(Sender: TObject);
    procedure AvançarClick(Sender: TObject);
    procedure Request();
    procedure Pesquisa(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure PesquisaClima(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  maxPage, page : Integer;
  firstColumn, res, lista : String;

implementation

{$R *.dfm}

uses Unit2;
procedure TForm1.FormCreate(Sender: TObject);
begin
  page := 1;
  maxPage := 6;
  res := 'api/planets/?page=';
  firstColumn := 'Name';
  lista := 'Planetas';
  ComboBox1.Items.Add('Unknown');
  ComboBox1.Items.Add('0-99999');
  ComboBox1.Items.Add('100000-9999999');
  ComboBox1.Items.Add('10000000-999999999');
  ComboBox1.Items.Add('1000000000-99999999999');
  ComboBox1.Items.Add('100000000000-9999999999999');
  comboBox1.ItemIndex := 0;
  Clima.Items.Add('Arid');
  Clima.Items.Add('Temperate');
  Clima.Items.Add('Tropical');
  Clima.Items.Add('Frozen');
  Clima.Items.Add('Murky');
  Clima.Items.Add('Windy');
  Clima.Items.Add('Hot');
  Clima.Items.Add('Artificial Temperate');
  Clima.Items.Add('Frigid');
  Clima.Items.Add('Humid');
  Clima.Items.Add('Moist');
  Clima.Items.Add('Polluted');
  Clima.Items.Add('Unknown');
  Clima.Items.Add('Superheated');
  Clima.Items.Add('Subartic');
  Clima.Items.Add('Artic');
  Clima.Items.Add('Rocky');
  Clima.Items.Add('Frigid');
  Clima.ItemIndex := 0;
end;

procedure TForm1.GridDblClick(Sender: TObject);
var
url : String;
begin
  Form2.LinkPropertyToFieldCaption.FieldName:='url';
  url := Form2.Label1.Caption;
  url := Copy(url, 19);
  Form2.RESTRequest.Resource := url;

  Form2.LinkPropertyToFieldCaption.FieldName:='';

  if lista = 'Planetas' then
  begin
    Form2.LinkPropertyToFieldCaption.FieldName:='Name';
    Form2.LinkPropertyToFieldCaption2.FieldName:='rotation_period';
    Form2.LinkPropertyToFieldCaption3.FieldName:='orbital_period';
    Form2.LinkPropertyToFieldCaption4.FieldName:='diameter';
    Form2.LinkPropertyToFieldCaption5.FieldName:='climate';
    Form2.LinkPropertyToFieldCaption6.FieldName:='population';

    Form2.LinkGridToDataSourceBindSourceDB2.Columns.Clear;
    Form2.LinkGridToDataSourceBindSourceDB3.Columns.Clear;
    Form2.RESTResponseDataSetAdapter1.RootElement := 'films';
    Form2.LinkGridToDataSourceBindSourceDB2.Columns.Add.
    MemberNAme:='Array';
    Form2.LinkGridToDataSourceBindSourceDB2.Columns.Items
    [Form2.LinkGridToDataSourceBindSourceDB2.Columns.Count-1].Header:='Filmes';
    Form2.LinkGridToDataSourceBindSourceDB2.Columns.Items
    [Form2.LinkGridToDataSourceBindSourceDB2.Columns.Count-1].Width:=100;

    Form2.StringGrid2.Visible:=true;
    Form2.RESTResponseDataSetAdapter2.RootElement := 'residents';
    Form2.LinkGridToDataSourceBindSourceDB3.Columns.Add.
    MemberNAme:='Array';
    Form2.LinkGridToDataSourceBindSourceDB3.Columns.Items
    [Form2.LinkGridToDataSourceBindSourceDB3.Columns.Count-1].Header:='Residentes';
    Form2.LinkGridToDataSourceBindSourceDB3.Columns.Items
    [Form2.LinkGridToDataSourceBindSourceDB3.Columns.Count-1].Width:=100;

  end;
  if lista = 'Personagens' then
  begin
    Form2.LinkPropertyToFieldCaption.FieldName:='Name';
    Form2.LinkPropertyToFieldCaption2.FieldName:='birth_year';
    Form2.LinkPropertyToFieldCaption3.FieldName:='gender';

    Form2.LinkGridToDataSourceBindSourceDB2.Columns.Clear;
    Form2.LinkGridToDataSourceBindSourceDB3.Columns.Clear;
    Form2.RESTResponseDataSetAdapter1.RootElement := 'films';
    Form2.LinkGridToDataSourceBindSourceDB2.Columns.Add.
    MemberNAme:='Array';
    Form2.LinkGridToDataSourceBindSourceDB2.Columns.Items
    [Form2.LinkGridToDataSourceBindSourceDB2.Columns.Count-1].Header:='Filmes';
    Form2.LinkGridToDataSourceBindSourceDB2.Columns.Items
    [Form2.LinkGridToDataSourceBindSourceDB2.Columns.Count-1].Width:=100;

    Form2.StringGrid2.Visible:=false;
    Form2.RESTResponseDataSetAdapter2.RootElement := '';
    Form2.LinkGridToDataSourceBindSourceDB3.Columns.Add.
    MemberNAme:='';
    Form2.LinkGridToDataSourceBindSourceDB3.Columns.Items
    [Form2.LinkGridToDataSourceBindSourceDB3.Columns.Count-1].Header:='Residentes';
    Form2.LinkGridToDataSourceBindSourceDB3.Columns.Items
    [Form2.LinkGridToDataSourceBindSourceDB3.Columns.Count-1].Width:=100;
  end;
  if lista = 'Filmes' then
  begin
    Form2.LinkPropertyToFieldCaption.FieldName:='Title';
    Form2.LinkPropertyToFieldCaption2.FieldName:='episode_id';
    Form2.LinkPropertyToFieldCaption6.FieldName:='opening_crawl';
    Form2.LinkPropertyToFieldCaption3.FieldName:='release_date';
    Form2.LinkPropertyToFieldCaption4.FieldName:='characters';
    Form2.LinkPropertyToFieldCaption5.FieldName:='planets';

    Form2.LinkGridToDataSourceBindSourceDB2.Columns.Clear;
    Form2.LinkGridToDataSourceBindSourceDB3.Columns.Clear;
    Form2.RESTResponseDataSetAdapter1.RootElement := 'characters';
    Form2.LinkGridToDataSourceBindSourceDB2.Columns.Add.
    MemberNAme:='Array';
    Form2.LinkGridToDataSourceBindSourceDB2.Columns.Items
    [Form2.LinkGridToDataSourceBindSourceDB2.Columns.Count-1].Header:='Personagens';
    Form2.LinkGridToDataSourceBindSourceDB2.Columns.Items
    [Form2.LinkGridToDataSourceBindSourceDB2.Columns.Count-1].Width:=100;

    Form2.StringGrid2.Visible:=true;
    Form2.RESTResponseDataSetAdapter2.RootElement := 'planets';
    Form2.LinkGridToDataSourceBindSourceDB3.Columns.Add.
    MemberNAme:='Array';
    Form2.LinkGridToDataSourceBindSourceDB3.Columns.Items
    [Form2.LinkGridToDataSourceBindSourceDB3.Columns.Count-1].Header:='Planetas';
    Form2.LinkGridToDataSourceBindSourceDB3.Columns.Items
    [Form2.LinkGridToDataSourceBindSourceDB3.Columns.Count-1].Width:=100;
  end;
  Form2.RESTRequest.Execute;
  Form2 := Form2.CreateNew(nil);
  Form2.Width:=600;
  Form2.Height:=300;
  Form2.Show;
end;

procedure TForm1.Request();
begin
  RESTRequest.resource:= res + IntToStr(page);
  Form2.RESTRequest.resource:= res + IntToStr(page);
end;

procedure TForm1.PlanetasClick(Sender: TObject);
begin
  LinkGridToDataSourceBindSourceDB1.Columns.Clear;
  Clima.Visible:=true;
  Dados.Filtered := False;

  page := 1;
  firstColumn := 'Name';
  lista := 'Planetas';
  maxPage := 6;
  res := 'api/planets/?page=';
  Request;
  RESTRequest.execute;

  LinkGridToDataSourceBindSourceDB1.Columns.Add.
  MemberName:='Name';
  LinkGridToDataSourceBindSourceDB1.Columns.Items
  [LinkGridToDataSourceBindSourceDB1.Columns.Count-1].Width:=300;
  LinkGridToDataSourceBindSourceDB1.Columns.Add.
  MemberNAme:='Population';
  LinkGridToDataSourceBindSourceDB1.Columns.Items
  [LinkGridToDataSourceBindSourceDB1.Columns.Count-1].Width:=300;
  LinkGridToDataSourceBindSourceDB1.Columns.Add.
  MemberNAme:='Climate';
  LinkGridToDataSourceBindSourceDB1.Columns.Items
  [LinkGridToDataSourceBindSourceDB1.Columns.Count-1].Width:=300;

  ComboBox1.Clear;
  ComboBox1.Items.Add('Unknown');
  ComboBox1.Items.Add('0-99999');
  ComboBox1.Items.Add('100000-9999999');
  ComboBox1.Items.Add('10000000-999999999');
  ComboBox1.Items.Add('1000000000-99999999999');
  ComboBox1.Items.Add('100000000000-9999999999999');
  comboBox1.ItemIndex := 0;
end;

procedure TForm1.PersonagensClick(Sender: TObject);
begin
  LinkGridToDataSourceBindSourceDB1.Columns.Clear;
  Clima.Visible:=false;
  Dados.Filtered := False;

  page := 1;
  maxPage := 9;
  firstColumn := 'Name';
  lista := 'Personagens';
  res := 'api/people/?page=';
  Request;
  RESTRequest.execute;

  LinkGridToDataSourceBindSourceDB1.Columns.Add.
  MemberName:='Name';
  LinkGridToDataSourceBindSourceDB1.Columns.Items
  [LinkGridToDataSourceBindSourceDB1.Columns.Count-1].Width:=300;
  LinkGridToDataSourceBindSourceDB1.Columns.Add.
  MemberNAme:='Gender';
  LinkGridToDataSourceBindSourceDB1.Columns.Items
  [LinkGridToDataSourceBindSourceDB1.Columns.Count-1].Width:=300;

  ComboBox1.Clear;
  ComboBox1.Items.Add('N/A');
  ComboBox1.Items.Add('Male');
  ComboBox1.Items.Add('Female');
  ComboBox1.Items.Add('Hermaphrodite');
  comboBox1.ItemIndex := 0;
end;

procedure TForm1.FilmesClick(Sender: TObject);
begin
  LinkGridToDataSourceBindSourceDB1.Columns.Clear;
  Clima.Visible:=false;
  Dados.Filtered := False;

  lista := 'Filmes';
  page := 1;
  maxPage := 1;
  firstColumn := 'Title';
  res := 'api/films/?page=';
  Request;
  RESTRequest.execute;

  LinkGridToDataSourceBindSourceDB1.Columns.Add.
  MemberNAme:='Title';
  LinkGridToDataSourceBindSourceDB1.Columns.Items
  [LinkGridToDataSourceBindSourceDB1.Columns.Count-1].Width:=300;
  LinkGridToDataSourceBindSourceDB1.Columns.Add.
  MemberNAme:='release_date';
  LinkGridToDataSourceBindSourceDB1.Columns.Items
  [LinkGridToDataSourceBindSourceDB1.Columns.Count-1].Width:=300;

  ComboBox1.Clear;
  ComboBox1.Items.AddStrings(Grid.Cols[1]);
  comboBox1.ItemIndex := 0;
end;

procedure TForm1.Pesquisa(Sender: TObject);
var
  pages : Integer;
begin
  for pages := 1 to maxPage do
  begin
    RESTRequest.resource:= res + IntToStr(pages);
    RESTRequest.Execute;
    if dados.Locate(firstColumn, SearchBox1.Text, [loPartialKey, loCaseInsensitive]) then
    begin
      page := pages;
      break;
    end
    else
    begin
      RESTRequest.resource:= res + IntToStr(1);
      RESTRequest.Execute;
    end;
  end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
var
  pages : Integer;
begin
  if lista = 'Personagens' then
  begin
    Dados.Filter := 'Gender = ' + QuotedStr(ComboBox1.Text);
    Dados.Filtered := True;
    RESTRequest.resource:= res + IntToStr(page);
    RESTRequest.Execute;
  end;
  if lista = 'Planetas' then
  begin

    case ComboBox1.ItemIndex of
      0:begin
        Dados.Filter := 'Population = ' + QuotedStr('Unknown');
        Dados.Filtered := True;
        RESTRequest.resource:= res + IntToStr(page);
        RESTRequest.Execute;
      end;
      1:begin
        Dados.Filter := 'Population > ' + QuotedStr('0') +
        ' AND Population <= ' + QuotedStr('99999');
        Dados.Filtered := True;
        RESTRequest.resource:= res + IntToStr(page);
        RESTRequest.Execute;
      end;
      2:begin
        Dados.Filter := 'Population > ' + QuotedStr('100000')
        + ' AND ' + 'Population <=' + QuotedStr('9999999');
        Dados.Filtered := True;
        RESTRequest.resource:= res + IntToStr(page);
        RESTRequest.Execute;
      end;
      3:begin
        Dados.Filter := 'Population >' + QuotedStr('10000000')
        + ' AND ' + 'Population <=' + QuotedStr('999999999');
        Dados.Filtered := True;
        RESTRequest.resource:= res + IntToStr(page);
        RESTRequest.Execute;
      end;
      4:begin
        Dados.Filter := 'Population >' + QuotedStr('100000000000')
        + ' AND ' + 'Population <=' + QuotedStr('9999999999999');
        Dados.Filtered := True;
        RESTRequest.resource:= res + IntToStr(page);
        RESTRequest.Execute;
      end;
      5:begin
        Dados.Filter := 'Population >' + QuotedStr('10000000000000')
        + ' AND ' + 'Population <=' + QuotedStr('999999999999999');
        Dados.Filtered := True;
        RESTRequest.resource:= res + IntToStr(page);
        RESTRequest.Execute;
      end;
    end;
  end;
  if lista = 'Filmes' then
  begin
    for pages := 1 to maxPage do
    begin
      RESTRequest.resource:= res + IntToStr(pages);
      RESTRequest.Execute;
      if dados.Locate('release_date', ComboBox1.Text, [loCaseInsensitive]) then
      begin
        page := pages;
        break;
      end
      else
      begin
        RESTRequest.resource:= res + IntToStr(1);
        RESTRequest.Execute;
      end;
    end;
  end;
end;

procedure TForm1.PesquisaClima(Sender: TObject);
begin
  Dados.Filter := 'Climate Like ' + QuotedStr('%'+Clima.Text+'%');
  Dados.Filtered := True;
  RESTRequest.resource:= res + IntToStr(page);
  RESTRequest.Execute;
end;

procedure TForm1.VoltarClick(Sender: TObject);
begin
  if page > 1 then
  begin
    page := page - 1;
    Request;
    RESTRequest.Execute;
  end;
end;

procedure TForm1.AvançarClick(Sender: TObject);
begin
  if page < maxPage then
    page := page + 1;

  Request;
  RESTRequest.Execute;
end;

end.
