# Microsoft Developer Studio Project File - Name="cnrp" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=cnrp - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "cnrp.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "cnrp.mak" CFG="cnrp - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "cnrp - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "cnrp - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "cnrp - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "cnrp___Win32_Release"
# PROP BASE Intermediate_Dir "cnrp___Win32_Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib  kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib  kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386

!ELSEIF  "$(CFG)" == "cnrp - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "cnrp___Win32_Debug0"
# PROP BASE Intermediate_Dir "cnrp___Win32_Debug0"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /GZ  /c
# ADD CPP /nologo /W2 /Gm /GR /GX /ZI /Od /I "..\..\..\..\include" /I "..\..\include" /I "..\..\..\..\..\Osi\src" /I "..\..\..\..\..\CoinUtils\src" /I "..\..\..\..\..\Clp\src" /I "..\..\..\..\..\Cgl\src" /I "..\..\..\..\..\Cgl\src\CglLiftAndProject" /I "..\..\..\..\..\Cgl\src\CglGomory" /I "..\..\..\..\..\Cgl\src\CglClique" /I "..\..\..\..\..\Cgl\src\CglKnapsackCover" /I "..\..\..\..\..\Cgl\src\CglProbing" /I "..\..\..\..\..\Cgl\src\CglFlowCover" /I "..\..\..\..\..\Cgl\src\CglOddHole" /I "..\..\..\..\..\Cgl\src\CglMixedIntegerRounding" /I "..\..\..\..\..\Cgl\src\CglSimpleRounding" /I "..\..\..\..\..\Osi\src\OsiClp" /I "..\..\..\..\..\BuildTools\headers" /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /D "INTEL" /D "COMPILE_IN_CG" /D "COMPILE_IN_CP" /D "COMPILE_IN_LP" /D "COMPILE_IN_TM" /D "__OSI_CLP__" /D "DIRECTED_X_VARS" /D "ADD_FLOW_VARS" /D "SAVE_CUT_POOL" /D "MULTI_CRITERIA" /FD /GZ /c /Tp
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib  kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib  kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept

!ENDIF 

# Begin Target

# Name "cnrp - Win32 Release"
# Name "cnrp - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Group "Common"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\src\Common\cnrp_macros.c

!IF  "$(CFG)" == "cnrp - Win32 Release"

!ELSEIF  "$(CFG)" == "cnrp - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\src\Common\compute_cost.c

!IF  "$(CFG)" == "cnrp - Win32 Release"

!ELSEIF  "$(CFG)" == "cnrp - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\src\Common\network.c

!IF  "$(CFG)" == "cnrp - Win32 Release"

!ELSEIF  "$(CFG)" == "cnrp - Win32 Debug"

!ENDIF 

# End Source File
# End Group
# Begin Group "CutPool"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\src\CutPool\cnrp_cp.c

!IF  "$(CFG)" == "cnrp - Win32 Release"

!ELSEIF  "$(CFG)" == "cnrp - Win32 Debug"

!ENDIF 

# End Source File
# End Group
# Begin Group "CutGen"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\src\CutGen\biconnected.c

!IF  "$(CFG)" == "cnrp - Win32 Release"

!ELSEIF  "$(CFG)" == "cnrp - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\src\CutGen\cnrp_cg.c

!IF  "$(CFG)" == "cnrp - Win32 Release"

!ELSEIF  "$(CFG)" == "cnrp - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\src\CutGen\shrink.c

!IF  "$(CFG)" == "cnrp - Win32 Release"

!ELSEIF  "$(CFG)" == "cnrp - Win32 Debug"

!ENDIF 

# End Source File
# End Group
# Begin Group "Master"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\src\Master\cnrp_io.c

!IF  "$(CFG)" == "cnrp - Win32 Release"

!ELSEIF  "$(CFG)" == "cnrp - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\src\Master\cnrp_main.c

!IF  "$(CFG)" == "cnrp - Win32 Release"

!ELSEIF  "$(CFG)" == "cnrp - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\src\Master\cnrp_master.c

!IF  "$(CFG)" == "cnrp - Win32 Release"

!ELSEIF  "$(CFG)" == "cnrp - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\src\Master\cnrp_master_functions.c

!IF  "$(CFG)" == "cnrp - Win32 Release"

!ELSEIF  "$(CFG)" == "cnrp - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\src\Master\small_graph.c

!IF  "$(CFG)" == "cnrp - Win32 Release"

!ELSEIF  "$(CFG)" == "cnrp - Win32 Debug"

!ENDIF 

# End Source File
# End Group
# Begin Group "DrawGraph"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\src\DrawGraph\cnrp_dg_functions.c

!IF  "$(CFG)" == "cnrp - Win32 Release"

!ELSEIF  "$(CFG)" == "cnrp - Win32 Debug"

!ENDIF 

# End Source File
# End Group
# Begin Group "LP"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\src\LP\cnrp_lp.c

!IF  "$(CFG)" == "cnrp - Win32 Release"

!ELSEIF  "$(CFG)" == "cnrp - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\src\LP\cnrp_lp_branch.c

!IF  "$(CFG)" == "cnrp - Win32 Release"

!ELSEIF  "$(CFG)" == "cnrp - Win32 Debug"

!ENDIF 

# End Source File
# End Group
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# End Group
# End Target
# End Project
