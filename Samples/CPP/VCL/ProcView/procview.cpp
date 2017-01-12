//----------------------------------------------------------------------------
//C++Builder
// Copyright (c) 1995-2010 Embarcadero Technologies, Inc.

// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.
//----------------------------------------------------------------------------
//---------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
//---------------------------------------------------------------------
USEFILE("readme.txt");
USEFORM("proc.cpp", FormMain);
USEFORM("another.cpp", Form2);
USERES("Procview.res");
//---------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
   try
   {
      Application->Initialize();
      Application->CreateForm(__classid(TFormMain), &FormMain);
      Application->CreateForm(__classid(TForm2), &Form2);
      Application->Run();
   }
   catch (Exception &exception)
   {
      Application->ShowException(&exception);
   }

   return 0;
}
//---------------------------------------------------------------------