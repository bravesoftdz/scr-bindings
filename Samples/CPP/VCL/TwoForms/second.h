//----------------------------------------------------------------------------
//C++Builder
// Copyright (c) 1995-2010 Embarcadero Technologies, Inc.
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
#ifndef SecondH
#define SecondH
//----------------------------------------------------------------------------
#include <Dialogs.hpp>
#include <Forms.hpp>
#include <Controls.hpp>
#include <Graphics.hpp>
#include <Classes.hpp>
#include <SysUtils.hpp>
#include <Messages.hpp>
#include <Windows.hpp>
#include <System.hpp>
#include <StdCtrls.hpp>
//----------------------------------------------------------------------------
class TForm2 : public TForm
{
__published:
	TButton *Button1;
public:
    virtual __fastcall TForm2(TComponent *Owner);
};
//----------------------------------------------------------------------------
extern TForm2 *Form2;
//----------------------------------------------------------------------------
#endif	
