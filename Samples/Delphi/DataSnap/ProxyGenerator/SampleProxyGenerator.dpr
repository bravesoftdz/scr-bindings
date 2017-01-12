
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program SampleProxyGenerator;

uses
  Forms,
  FormUnit in 'FormUnit.pas' {MainForm},
  SampleProxyGeneratorUnit in 'SampleProxyGeneratorUnit.pas',
  ProxyGeneratorSettings in 'ProxyGeneratorSettings.pas',
  Vcl.Themes in 'Vcl.Themes.pas';

{$R *.res}

type
  TNeverFreedObject = class

  end;
begin
//  TNeverFreedObject.Create;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
