
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
// LiveBinding Sample Project
// Simple expression evaluator on TStringList
// Sample expressions:
//   Delimiter
//   Count
//   Add('abc')
//   Add(ToStr(200))
//   Add("abc " + ToStr(200))
//   Strings[0]
//   Self
program SimpleExpressionConsole;

{$APPTYPE CONSOLE}

uses
  System.Classes,
  System.SysUtils,
  System.Bindings.EvalProtocol,
  System.Bindings.EvalSys,
  System.Bindings.Expression,
  System.Bindings.Methods,
  System.Bindings.ObjEval,
  System.Bindings.Helper,
  System.Bindings.Outputs,
  System.Bindings.Consts,
  System.StrUtils,
  System.Rtti,
  System.TypInfo,
  Generics.Collections;

// Write an expression evaluation value to the console
procedure DisplayValue(AValueIntf: IValue);
var
  LValue: TValue;
  LType: PTypeInfo;
begin
  LValue := AValueIntf.GetValue;
  LType := AValueIntf.GetType;
  if LValue.IsEmpty then
    WriteLn('Empty')
  else
  begin
    if LValue.IsObject then
      WriteLn(Format('ClassName: %s', [LValue.AsObject.ClassName]))
    else
      try
        WriteLn(Format('%s ToString: "%s"', [LType.Name, LValue.ToString]));
      except
        on E: Exception do
          Writeln(E.ClassName, ': ', E.Message);
      end;
  end;
end;

// Write registered methods to the console
procedure DisplayMethods;
var
  LDescription: TMethodDescription;
  LStrings: TStringList;
begin
  LStrings := TStringList.Create;
  try
    for LDescription in TBindingMethodsFactory.GetRegisteredMethods do
      if LDescription.DefaultEnabled then
        LStrings.Add(LDescription.Name)
      else
        LStrings.Add(LDescription.Name + ' (disabled)');
    LStrings.Sort;
    WriteLn('Methods: ', ReplaceStr(LStrings.DelimitedText, LStrings.Delimiter, ', '));
    WriteLn;
  finally
    LStrings.Free;
  end;
end;

procedure ProcessExpressions;
  function PromptQuit: Boolean;
  var
    LInput: string;
  begin
    while True do
    begin
      System.Write('Quit (y/n)? ');
      ReadLn(LInput);
      if Length(LInput) > 0 then
        case LInput[1] of
          'y', 'Y': Exit(True);
          'n', 'N': Exit(False);
        end;
    end;
  end;

var
  LInputExpr: string;
  LBindingExpression: TBindingExpression;
  LScope: IScope;
  LTestObject: TObject;
begin
  LTestObject := nil;
  // Create test object
  LTestObject := TStringList.Create;
  WriteLn(Format('Object class: %s', [LTestObject.ClassName]));
  try
    while True do
    begin
      try
        // Get input expression
        System.Write('Input expression: ');
        ReadLn(LInputExpr);
        if LInputExpr = '' then
          if PromptQuit then
            Exit
          else
            Continue;

        // Create "Self" scope
        LScope := WrapObject(LTestObject);
        // Add register global methods to the scope
        LScope := TNestedScope.Create(LScope, TBindingMethodsFactory.GetMethodScope);

        WriteLn(Format('Evaluating Expression: "%s"', [LInputExpr]));
        WriteLn;
        // Evaluate input expression
        LBindingExpression := TBindings.CreateExpression(
          LScope,
          LInputExpr);
        try
          DisplayValue(LBindingExpression.Evaluate);
        finally
          LBindingExpression.Free;
        end;
      except
        on E: Exception do
          Writeln(E.ClassName, ': ', E.Message);
      end;
      WriteLn;
    end;
  finally
    LScope := nil;
    LTestObject.Free;
  end;
end;

begin
  try
    // Display registered methods
    DisplayMethods;
    // Prompt for expression strings and evaluate
    ProcessExpressions;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
