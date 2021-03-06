//----------------------------------------------------------------------------
// C++Builder
// Copyright (c) 1995-2010 Embarcadero Technologies, Inc.

// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.
//----------------------------------------------------------------------------
// ConverIt : Conversion Utilities Demo v.1
//----------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include <convutils.hpp>
#include <stdconvs.hpp>
#include <memory>

#include "Unit1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
#pragma link "System.Stdconvs.obj" // workaround: header will include later
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner): TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TForm1::ConvFamiliesChange(TObject *Sender)
{
  TConvFamily LFamily;
  LFamily = TConvFamily(ConvFamilies->Tabs->Objects[ConvFamilies->TabIndex]);

  ConvTypes->Items->BeginUpdate();
  ConvTypes->Clear();

  TConvTypeArray LTypes;
  GetConvTypes(LFamily, LTypes);

  for (int i = 0; i <= LTypes.Length - 1; ++i)
    ConvTypes->Items->AddObject(ConvTypeToDescription(LTypes[i]),
                                reinterpret_cast<TObject*>(LTypes[i]));

  ConvTypes->ItemIndex = 0;
  ConvTypes->Items->EndUpdate();
  ConvTypesClick(Sender);
}
//---------------------------------------------------------------------------
void __fastcall TForm1::ConvTypesClick(TObject *Sender)
{
  ConvValueChange(Sender);
}
//---------------------------------------------------------------------------
void __fastcall TForm1::FormShow(TObject *Sender)
{
  ConvFamilies->Tabs->Clear();
  std::auto_ptr<TStringList> LStrings(new TStringList());

  TConvFamilyArray LFamilies;
  GetConvFamilies(LFamilies);

  for (int i = 0; i <= LFamilies.Length - 1; ++i)
	LStrings->AddObject(ConvFamilyToDescription(LFamilies[i]),
						  reinterpret_cast<TObject*>(LFamilies[i]));

  LStrings->Sort();
  ConvFamilies->Tabs->Assign(LStrings.get());
  ConvFamiliesChange(Sender);
}
//---------------------------------------------------------------------------
void __fastcall TForm1::ConvValueChange(TObject *Sender)
{
  TConvType LBaseType, LTestType;

  try
  {
    ConvResults->Items->BeginUpdate();
    ConvResults->Clear();

    try
    {
      double LValue = StrToFloatDef(ConvValue->Text, 0);
	  if ( ConvTypes->ItemIndex != -1 )
      {
        LBaseType = TConvType(ConvTypes->Items->Objects[ConvTypes->ItemIndex]);

        for (int i = 0; i <= ConvTypes->Items->Count - 1; ++i)
        {
          LTestType = TConvType(ConvTypes->Items->Objects[i]);
          TVarRec v[] = {Convert(LValue, LBaseType, LTestType),
                         ConvTypeToDescription(LTestType)};
          ConvResults->Items->Add(Format("%n %s", v, ARRAYSIZE(v) - 1));
        }
      }
      else
        ConvResults->Items->Add("No base type");
    }
    catch (Exception& e)
    {
      ConvResults->Items->Add("Cannot parse value");
    }
  }
  __finally
  {
    ConvResults->Items->EndUpdate();
  }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::mnCloseClick(TObject *Sender)
{
  Close();        
}
//---------------------------------------------------------------------------


void __fastcall TForm1::About1Click(TObject *Sender)
{
  ShowMessage("Conversion Utilities Demo v1.\nC++Builder 6.0.\n");
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Exit1Click(TObject *Sender)
{
  Close();
}
//---------------------------------------------------------------------------

