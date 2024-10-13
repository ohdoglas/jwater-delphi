program delphiJwater;

uses
  Vcl.Forms,
  unitPrincipal in '..\Delphi J-Water\unitPrincipal.pas' {frmWater};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmWater, frmWater);
  Application.Run;
end.
