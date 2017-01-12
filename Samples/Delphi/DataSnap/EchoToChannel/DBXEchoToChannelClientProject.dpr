
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program DBXEchoToChannelClientProject;

uses
  Forms,
  DBXEchoToChannelForm in 'DBXEchoToChannelForm.pas' {Form4},
  DBXEchoToChannelClientClasses in 'DBXEchoToChannelClientClasses.pas',
  DBXEchoToChannelClientModule in 'DBXEchoToChannelClientModule.pas' {ClientModule1: TDataModule},
  Vcl.Themes in 'Vcl.Themes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TClientModule1, ClientModule1);
  Application.Run;
end.
