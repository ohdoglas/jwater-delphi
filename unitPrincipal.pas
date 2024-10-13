unit unitPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus,
  Vcl.Mask;

type
  TfrmWater = class(TForm)
    lblTitleJWater: TLabel;
    cmbNvlAtv: TComboBox;
    radGender: TRadioGroup;
    lblIdade: TLabel;
    lblAltura: TLabel;
    lblPeso: TLabel;
    lblNvlAtividade: TLabel;
    lblCreatina: TLabel;
    btnJwater: TButton;
    mskIdade: TMaskEdit;
    mskCreatina: TMaskEdit;
    mskAltura: TMaskEdit;
    mskPeso: TMaskEdit;
    lblResultado: TLabel;
    pnlResultado: TPanel;
    procedure mskIdadeExit(Sender: TObject);
    procedure mskIdadeKeyPress(Sender: TObject; var Key: Char);
    procedure mskAlturaExit(Sender: TObject);
    procedure mskAlturaKeyPress(Sender: TObject; var Key: Char);
    procedure mskPesoExit(Sender: TObject);
    procedure mskPesoKeyPress(Sender: TObject; var Key: Char);
    procedure mskCreatinaKeyPress(Sender: TObject; var Key: Char);
    procedure btnJwaterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmWater: TfrmWater;

implementation

{$R *.dfm}

procedure TfrmWater.btnJwaterClick(Sender: TObject);
var
Peso, Altura, Idade, TmbH, TmbF, Creatine, NvlAtividade: Real;
AguaBaseHomem, AguaBaseMulher, AguaHomem, AguaMulher: Real;


begin
  if (mskPeso.Text = '') or (mskAltura.Text = '') or (mskIdade.Text = '') or (mskCreatina.Text = '') then
  begin
    Application.MessageBox('Por favor, preencha todos os campos para o calculo!','Preencha os campos', MB_ICONEXCLAMATION+MB_OK);
    Exit;
  end;

Peso := StrToFloat(mskPeso.Text);
Altura := StrToFloat(mskAltura.Text);
Idade := StrToFloat(mskIdade.Text);
Creatine := StrToFloat(mskCreatina.Text) * 500;

  case cmbNvlAtv.ItemIndex of
     0 : NvlAtividade := 1.2;
     1 : NvlAtividade := 1.375;
     2 : NvlAtividade := 1.55;
     3 : NvlAtividade := 1.725;
     4 : NvlAtividade := 1.9;
  end;


  if radGender.ItemIndex = 0 then
  begin
    AguaBaseHomem := 35 * Peso;
    TmbH := 88.362 + (13.397 * Peso) + (4.799 * Altura) - (5.677 * Idade);
    AguaHomem := AguaBaseHomem * NvlAtividade + Creatine + TmbH;
    lblResultado.Caption := FormatFloat('#,##0.00', AguaHomem) + 'mL de Água';
  end;

  if radGender.ItemIndex = 1 then
  begin
    AguaBaseMulher := 31 * Peso;
    TmbF := 447.593 + (9.247 * Peso) + (3.098 * Altura) - (4.330 * Idade);
    AguaMulher := AguaBaseMulher * NvlAtividade + Creatine + TmbF;
    lblResultado.Caption := FormatFloat('#,##0.00', AguaMulher) + 'mL de Água';
  end;


end;

procedure TfrmWater.mskAlturaExit(Sender: TObject);
var
  Value: Integer;
begin
  if TryStrToInt(mskAltura.Text, Value) then
  begin
    if (Value <= 0) or (Value >= 999) then
    begin
      ShowMessage('O valor Altura não pode ser maior que 999');
      mskAltura.SetFocus;
    end
    else
      ShowMessage('Por favor, insira uma altura válida!');
  end;
end;

procedure TfrmWater.mskAlturaKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then
    Key := #0;
end;

procedure TfrmWater.mskCreatinaKeyPress(Sender: TObject; var Key: Char);
begin
 if not (Key in ['0'..'9', #8]) then
    Key := #0
end;

procedure TfrmWater.mskIdadeExit(Sender: TObject);
var
 Value: Integer;
begin
   if TryStrToInt(mskIdade.Text, Value) then
   begin
      if (Value <= 0) or (Value > 110) then
      begin
        ShowMessage('O valor Idade deve estar entre 1 e 110');
        mskIdade.SetFocus;
      end
   end
   else
      ShowMessage('Por favor, insira um Idade válida!');
end;

procedure TfrmWater.mskIdadeKeyPress(Sender: TObject; var Key: Char);
begin
 if not (Key in ['0'..'9', #8]) then
  Key := #0;
end;

procedure TfrmWater.mskPesoExit(Sender: TObject);
var
  Peso: String;
begin
  Peso := mskPeso.Text;

  if Pos(' ', Peso) > 0 then
  begin
    ShowMessage('Por favor, preencha o peso de forma correta, para pesos abaixo de 100.00, acrescente um 0 no inicio, Ex: 099.00');
    mskPeso.SetFocus;
    Exit;
  end;
end;

procedure TfrmWater.mskPesoKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then
    Key := #0;
end;

end.
