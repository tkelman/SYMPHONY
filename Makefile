##############################################################################
##############################################################################
#                                                                            #
# This file is part of the SYMPHONY Branch, Cut, and Price Library.          #
#                                                                            #
# SYMPHONY was jointly developed by Ted Ralphs (tkralphs@lehigh.edu) and     #
# Laci Ladanyi (ladanyi@us.ibm.com).                                         #
#                                                                            #
# (c) Copyright 2000-2005  Ted Ralphs. All Rights Reserved.                  #
#                                                                            #
# This software is licensed under the Common Public License. Please see      #
# accompanying file for terms.                                               #
#                                                                            #
##############################################################################
##############################################################################

##############################################################################
#-----------------------------------------------------------------------------
# 
# The variables, to be set by user, have been moved with SYMPHONY 5.1! Please 
# see the 'config' file for further information and available user variables. 
# The user should not need to modify this file. 
#
#-----------------------------------------------------------------------------
##############################################################################

CONFIG_FILE_DIR = $(PWD)
ifeq ($(USE_SYM_APPL), TRUE)
CONFIG_FILE_DIR = $(SYMPHONYROOT)
endif

CONFIG_FILE = config
UNAME = $(shell uname -a)

ifeq ($(findstring Linux,${UNAME}),Linux)
    ARCH = LINUX
else
ifeq ($(findstring alpha,${UNAME}),alpha)
    ARCH = ALPHA
else
ifeq ($(findstring AIX,${UNAME}),AIX)
    ARCH = RS6K
else
ifeq ($(findstring SunOS,${UNAME}),SunOS)
     ifeq ($(findstring i86pc,${UNAME}),i86pc)
           ARCH = X86SOL2
     else
     ifeq ($(findstring 5.,$(UNAME)),5.)
           ARCH = SUN4SOL2
           NP = $(shell mpstat | wc -l -gt -a)
                  ifeq ($(NP,ON)
                         ARCH = SUNMP
                  endif
     endif
     endif
else
ifeq ($(findstring CYGWIN,${UNAME}),CYGWIN)
    ARCH = CYGWIN
endif
ifeq ($(findstring Darwin,${UNAME}),Darwin)
    ARCH = DARWIN
endif
endif
endif
endif
endif

include $(CONFIG_FILE_DIR)/$(CONFIG_FILE)

##############################################################################
##############################################################################

ifeq ($(USE_CGL_CUTS),TRUE)
LPLIB += -lCgl
ifneq ($(LP_SOLVER),OSI)
LPINCDIR += $(COINROOT)/include
LPLIBPATHS += $(COINROOT)/lib
LPLIB += -lCoin -lOsi
endif
endif

##############################################################################
##############################################################################

ifeq ($(USE_OSI_INTERFACE),TRUE)
OSISYM_INCDIR     = $(COINROOT)/Osi/OsiSym/include
OSISYM_LIB        = -lOsiSym
ifneq ($(LP_SOLVER),OSI)
OSISYM_INCDIR     += $(COINROOT)/include
OSISYM_LIBPATH    += $(COINROOT)/lib      
OSISYM_LIB        += -lCoin -lOsi
endif
endif


##############################################################################
##############################################################################
# Determine if COIN is using lapack
##############################################################################
##############################################################################

include $(COINROOT)/Makefiles/Makefile.location
ifneq ($(filter COIN_lapack,$(CoinLibsDefined)),)
	LPINCDIR += lapackIncDir
	LPLIBPATHS += lapackLibDir
	LPLIB += -llapack -lblas -lg2c
endif

##############################################################################
##############################################################################
# Set the paths for PVM
##############################################################################
##############################################################################

ifeq ($(COMM_PROTOCOL),PVM)
	COMMINCDIR = $(PVM_ROOT)/include
	COMMLIBPATHS = $(PVM_ROOT)/lib/$(PVM_ARCH)
	COMMLIBS = -lgpvm3 -lpvm3
endif

##############################################################################
##############################################################################
# OS dependent flags, paths, libraries
# Set separate variable values for each architecture here
##############################################################################
##############################################################################

##############################################################################
# LINUX Definitions
##############################################################################

ifeq ($(ARCH),LINUX)
	SHLINKPREFIX := -Wl,-rpath,
	X11LIBPATHS = /usr/X11R6/lib
	ifeq ($(LP_SOLVER),CPLEX)
	   LPSOLVER_DEFS = -DSYSFREEUNIX
	endif
	MACH_DEP = -DHAS_RANDOM -DHAS_SRANDOM
	SYSLIBS = -lpthread #-lefence
	ifeq ($(HAS_READLINE), TRUE)
		SYSLIBS += -lreadline -ltermcap
	endif
endif

##############################################################################
# CYGWIN Definitions
##############################################################################

ifeq ($(ARCH),CYGWIN)
	SHLINKPREFIX := -Wl,-rpath,
	X11LIBPATHS = /usr/X11R6/lib
	ifeq ($(LP_SOLVER),CPLEX)
	   LPSOLVER_DEFS = -DSYSFREEUNIX
	endif
	MACH_DEP = -DHAS_RANDOM -DHAS_SRANDOM
	SYSLIBS = -lpthread #-lefence
	LIBTYPE = STATIC #SHARED is not supported on CYGWIN
	HAS_READLINE = FALSE
endif

##############################################################################
# RS6K Definitions
##############################################################################

ifeq ($(ARCH),RS6K)
	MACH_DEP = -DHAS_RANDOM -DHAS_SRANDOM
	SYSLIBS = -lbsd
	ifeq ($(ARCH),RS6KMP)
	   SYSLIBS += -lpthreads
	endif
endif

##############################################################################
# Sun Sparc Solaris Definitions
##############################################################################

ifeq ($(ARCH),SUN4SOL2)
	SHLINKPREFIX = -Wl,-R,
	X11LIBPATHS = /usr/local/X11/lib
	ifeq ($(LP_SOLVER),CPLEX)
	   LPSOLVER_DEFS = -DSYSGNUSOLARIS
	endif
	MACH_DEP = -DHAS_RANDOM -DHAS_SRANDOM 
	SYSLIBS = -lsocket -lnsl
endif

##############################################################################
# Sun MP Definitions
##############################################################################

ifeq ($(ARCH),SUNMP)
	SHLINKPREFIX = -Wl,-R,
	X11LIBPATHS = /usr/local/X11/lib
	ifeq ($(LP_SOLVER),CPLEX)
	   LPSOLVER_DEFS = -DSYSGNUSOLARIS
	endif
	MACH_DEP = -DHAS_RANDOM -DHAS_SRANDOM 
	SYSLIBS = -lsocket -lnsl
endif

##############################################################################
# X86 Solaris Definitions
##############################################################################

ifeq ($(ARCH),X86SOL2)
	SHLINKPREFIX = -Wl,-R,
	X11LIBPATHS = /usr/local/X11/lib
	ifeq ($(LP_SOLVER),CPLEX)
	   LPSOLVER_DEFS = -DSYSGNUSOLARIS
	endif
	MACH_DEP = -DHAS_RANDOM -DHAS_SRANDOM
	SYSLIBS = -lsocket -lnsl
endif

##############################################################################
# Alpha Definitions
##############################################################################

ifeq ($(ARCH),ALPHA)
	X11LIBPATHS = /usr/local/X11/lib
	MACH_DEP = -DHAS_RANDOM -DHAS_SRANDOM
	SYSLIBS =
endif

##############################################################################
# Darwin Definitions
##############################################################################

ifeq ($(ARCH),DARWIN)
	X11LIBPATHS = /usr/local/X11/lib
	MACH_DEP = -DHAS_RANDOM -DHAS_SRANDOM
	SYSLIBS =
	EXTRAINCDIR = /usr/include/malloc
	LIBTYPE = STATIC #SHARED is not supported on Darwin
	HAS_READLINE = FALSE
endif

##############################################################################
##############################################################################
# !!!!!!!!!!!!!!!!!!!USER SHOULD NOT EDIT BELOW THIS LINE !!!!!!!!!!!!!!!!!!!!
##############################################################################
##############################################################################

##############################################################################
# Set the VER to "g" if using gcc
##############################################################################

ifeq ($(CC),gcc)
	VER = g
else
	VER = x
endif
ifeq ($(VER),g)
	VERSION=GNU
else
	VERSION=NOGNU
endif

##############################################################################
# Paths
##############################################################################
##############################################################################

##############################################################################
# Set the configuration and path
##############################################################################

ifeq ($(USE_SYM_APPL),TRUE)
SYM_COMPILE_IN_CG = $(COMPILE_IN_CG)
SYM_COMPILE_IN_CP = $(COMPILE_IN_CP)
SYM_COMPILE_IN_LP = $(COMPILE_IN_LP)
SYM_COMPILE_IN_TM = $(COMPILE_IN_TM)
else
SYMPHONYROOT = $(PWD)
endif

ifneq ($(USE_SYM_APPL),TRUE)
ifeq ($(SYMBUILDDIR),)
SYMBUILDDIR = $(SYMPHONYROOT)
endif
endif

ifeq ($(SYM_COMPILE_IN_TM),TRUE)
	CONFIG:=1
else
	CONFIG:=0
endif 
ifeq ($(SYM_COMPILE_IN_LP),TRUE)
	CONFIG:=1$(CONFIG)
else
	CONFIG:=0$(CONFIG)
endif 
ifeq ($(SYM_COMPILE_IN_CG),TRUE)
	CONFIG:=1$(CONFIG)
else
	CONFIG:=0$(CONFIG)
endif 
ifeq ($(SYM_COMPILE_IN_CP),TRUE)
	CONFIG:=1$(CONFIG)
else
	CONFIG:=0$(CONFIG)
endif 

INCDIR       = $(EXTRAINCDIR) -I$(SYMPHONYROOT)/include 
ifeq ($(USE_SYM_APPL),TRUE)
INCDIR      += -I$(USERROOT)/include 
endif
INCDIR 	    += $(USER_INCDIR)

#__BEGIN_EXPERIMENTAL_SECTION__#
ifeq ($(DECOMP),TRUE)
INCDIR 	    += -I$(SYMPHONYROOT)/include/decomp
endif
#___END_EXPERIMENTAL_SECTION___#

USER_OBJDIR  = $(USERBUILDDIR)/objects/$(ARCH)/$(CONFIG)
DEPDIR       = $(SYMBUILDDIR)/dep/$(ARCH)
USER_DEPDIR  = $(USERBUILDDIR)/dep/$(ARCH)

ifeq ($(USE_GLPMPL), TRUE)
GMPLINCDIR   = $(SYMPHONYROOT)/src/GMPL
LPINCDIR    += $(GMPLINCDIR)
GMPL_OBJDIR  = $(SYMBUILDDIR)/src/GMPL/objects/$(ARCH)
endif

ifeq ($(LP_SOLVER),OSI)
ifeq ($(USE_SYM_APPL), TRUE)
OBJDIR	     = $(SYMBUILDDIR)/objects/$(ARCH)/$(CONFIG)/APPL_$(LP_SOLVER)_$(OSI_INTERFACE)
LIBDIR	     = $(SYMBUILDDIR)/lib/$(ARCH)/APPL_$(LP_SOLVER)_$(OSI_INTERFACE)
BINDIR       = $(USERBUILDDIR)/bin/$(ARCH)/$(LP_SOLVER)_$(OSI_INTERFACE)
else
OBJDIR   = $(SYMBUILDDIR)/objects/$(ARCH)/$(CONFIG)/$(LP_SOLVER)_$(OSI_INTERFACE)
LIBDIR   = $(SYMBUILDDIR)/lib/$(ARCH)/$(LP_SOLVER)_$(OSI_INTERFACE)
BINDIR   = $(SYMBUILDDIR)/bin/$(ARCH)/$(LP_SOLVER)_$(OSI_INTERFACE)
endif
else
ifeq ($(USE_SYM_APPL), TRUE)
OBJDIR	     = $(SYMBUILDDIR)/objects/$(ARCH)/$(CONFIG)/APPL_$(LP_SOLVER)
LIBDIR	     = $(SYMBUILDDIR)/lib/$(ARCH)/APPL_$(LP_SOLVER)
BINDIR       = $(USERBUILDDIR)/bin/$(ARCH)/$(LP_SOLVER)
else
OBJDIR   = $(SYMBUILDDIR)/objects/$(ARCH)/$(CONFIG)/$(LP_SOLVER)
LIBDIR   = $(SYMBUILDDIR)/lib/$(ARCH)/$(LP_SOLVER)
BINDIR   = $(SYMBUILDDIR)/bin/$(ARCH)/$(LP_SOLVER)
endif
endif

SRCDIR  = \
	$(SYMPHONYROOT)/src/Common      :\
	$(SYMPHONYROOT)/src/LP          :\
	$(SYMPHONYROOT)/src/CutGen      :\
	$(SYMPHONYROOT)/src/CutPool     :\
	$(SYMPHONYROOT)/src/SolPool     :\
	$(SYMPHONYROOT)/src/DrawGraph   :\
	$(SYMPHONYROOT)/src/Master      :\
	$(SYMPHONYROOT)/include     :\
	$(SYMPHONYROOT)             :\
	$(SYMPHONYROOT)/src/TreeManager :\
	$(SYMPHONYROOT)/src/GMPL

USER_SRCDIR += \
	$(USERROOT)/src/Common    :\
	$(USERROOT)/src/LP        :\
	$(USERROOT)/src/CutGen    :\
	$(USERROOT)/src/CutPool   :\
	$(USERROOT)/src/SolPool   :\
	$(USERROOT)/src/DrawGraph :\
	$(USERROOT)/src/Master    :\
	$(USERROOT)/include   :\
	$(USERROOT)           

VPATH  = $(SRCDIR):$(USER_SRCDIR)

##############################################################################
# Put it together
##############################################################################

LIBPATHS      = $(LIBDIR) $(X11LIBPATHS) $(COMMLIBPATHS) $(LPLIBPATHS) \
		$(OSISYM_LIBPATH)
LIBPATHS     += $(USERLIBPATHS)
INCPATHS      = $(X11INCDIR) $(COMMINCDIR) $(LPINCDIR) $(LPSINCDIR)\
		$(OSISYM_INCDIR)

EXTRAINCDIR   = $(addprefix -I,${INCPATHS})
LDFLAGS       = $(addprefix -L,${LIBPATHS})
ifneq (${SHLINKPREFIX},)
     LDFLAGS += $(addprefix ${SHLINKPREFIX},${LIBPATHS})
endif

ifeq ($(CC),ompcc)
	LIBS  = -lX11 -lm -lompc -ltlog -lthread $(COMMLIBS) $(SYSLIBS) \
	$(USERLIBS)
else
	LIBS  = -lX11 -lm $(SYSLIBS) $(USERLIBS) $(COMMLIBS) 
endif

ifeq ($(OPT),-O)
    ifeq ($(CC),gcc)
	OPT = -O3 
    endif
    ifeq ($(ARCH),RS6K)
	ifeq ($(CC),xlC)
	    OPT = -O3 -qmaxmem=16384 -qarch=pwr2 -qtune=pwr2s
            OPT += -bmaxdata:0x80000000 -bloadmap:main.map
	endif
    endif
endif

ifeq ($(OPT),-g)
   ifeq ($(VERSION),GNU)
      OPT = -g 
      EFENCE = -lefence
   endif
   ifeq ($(ARCH),RS6K)
      ifeq ($(CC),xlC)
         OPT = -bmaxdata:0x80000000 -bloadmap:main.map
         OPT += -bnso -bnodelcsect -bI:/lib/syscalls.exp
         EFENCE = -lefence
      endif
   endif
endif

##############################################################################
##############################################################################
# Purify related flags
##############################################################################
##############################################################################

ifeq ($(ARCH),SUN4SOL2)
	PURIFYCACHEDIR=$(HOME)/purify-quantify/cache/SUN4SOL2
	PUREBIN = /home/purify/purify-4.1-solaris2/purify
endif
ifeq ($(ARCH),X86SOL2)
	PURIFYCACHEDIR=$(HOME)/purify-quantify/cache/X86SOL2
	PUREBIN = /home/purify/purify-4.1-solaris2/purify
endif

PFLAGS = -cache-dir=$(PURIFYCACHEDIR) -chain-length=10 \
	 -user-path=$(USERBUILDDIR)/bin/$(ARCH) \
         #-log-file=$(USERROOT)/purelog_%v.%p \
         #-mail-to-user=$(USER) # -copy-fd-output-to-logfile=1,2
PURIFY = $(PUREBIN) $(PFLAGS)

##############################################################################
##############################################################################
# Quantify related flags
##############################################################################
##############################################################################

ifeq ($(ARCH),SUN4SOL2)
	QUANTIFYCACHEDIR=$(HOME)/purify-quantify/cache/SUN4SOL2
	QUANTIFYBIN = /opts/pure/quantify-2.1-solaris2/quantify
endif
ifeq ($(ARCH),X86SOL2)
	QUANTIFYCACHEDIR=$(HOME)/purify-quantify/cache/X86SOL2
	QUANTIFYBIN = /opts/pure/quantify-2.1-solaris2/quantify
endif
QFLAGS   = -cache-dir=$(QUANTIFYCACHEDIR) 
QFLAGS  += -user-path=$(USERROOT)/bin/$(ARCH)
QUANTIFY = $(QUANTIFYBIN) $(QFLAGS)

##############################################################################
##############################################################################
#  Extensions and filenames for various configurations
##############################################################################
##############################################################################

ifeq ($(SYM_COMPILE_IN_CG),TRUE)
LPEXT = _cg
endif
ifeq ($(SYM_COMPILE_IN_CP),TRUE)
CPEXT = _cp
endif
ifeq ($(SYM_COMPILE_IN_LP),TRUE)
TMEXT = _lp$(LPEXT)$(CPEXT)
else
TMEXT = $(CPEXT)
endif
ifeq ($(SYM_COMPILE_IN_TM),TRUE)
MASTEREXT = _m_tm$(TMEXT)
endif

ifeq ($(MASTERNAME),)
MASTERNAME = symphony
endif

##############################################################################
##############################################################################
# Putting together DEF's, FLAGS
##############################################################################
##############################################################################

SYSDEFINES  = -D__$(COMM_PROTOCOL)__ $(LPSOLVER_DEFS) 
SYSDEFINES += $(MACH_DEP) -D__$(ARCH)

ifeq ($(USE_CGL_CUTS),TRUE)
SYSDEFINES += -DUSE_CGL_CUTS
endif
#ifneq ($(MAKECMDGOALS), symphony)
#SYSDEFINES += -DUSE_SYM_APPLICATION
#endif
ifeq ($(USE_SYM_APPL),TRUE)
SYSDEFINES += -DUSE_SYM_APPLICATION
endif
ifeq ($(USE_OSI_INTERFACE),TRUE)
SYSDEFINES += -DUSE_OSI_INTERFACE
endif
ifeq ($(LP_SOLVER), OSI)
SYSDEFINES += -D__OSI_$(OSI_INTERFACE)__
else
SYSDEFINES += -D__$(LP_SOLVER)__
endif
ifeq ($(USE_GLPMPL),TRUE)
SYSDEFINES += -DUSE_GLPMPL
endif
ifeq ($(HAS_READLINE),TRUE)
SYSDEFINES += -DHAS_READLINE
endif

BB_DEFINES  = $(USER_BB_DEFINES)
ifeq ($(SENSITIVITY_ANALYSIS),TRUE)
BB_DEFINES += -DSENSITIVITY_ANALYSIS
endif
ifeq ($(ROOT_NODE_ONLY),TRUE)
BB_DEFINES += -DROOT_NODE_ONLY
endif
ifeq ($(TRACE_PATH),TRUE)
BB_DEFINES += -DTRACE_PATH 
endif
ifeq ($(CHECK_CUT_VALIDITY),TRUE)
BB_DEFINES += -DCHECK_CUT_VALIDITY
endif
ifeq ($(CHECK_LP),TRUE)
BB_DEFINES += -DCOMPILE_CHECK_LP
endif

ifeq ($(SYM_COMPILE_IN_CG),TRUE)
BB_DEFINES += -DCOMPILE_IN_CG
endif
ifeq ($(SYM_COMPILE_IN_CP),TRUE)
BB_DEFINES += -DCOMPILE_IN_CP
endif
ifeq ($(SYM_COMPILE_IN_LP),TRUE)
BB_DEFINES+= -DCOMPILE_IN_LP
endif
ifeq ($(SYM_COMPILE_IN_TM), TRUE)
BB_DEFINES += -DCOMPILE_IN_TM
endif
ifeq ($(COMPILE_FRAC_BRANCHING),TRUE)
BB_DEFINES  += -DCOMPILE_FRAC_BRANCHING
endif
ifeq ($(DO_TESTS),TRUE)
BB_DEFINES  += -DDO_TESTS
endif
ifeq ($(BIG_PROBLEM),TRUE)
BB_DEFINES  += -DBIG_PROBLEM
endif
ifeq ($(TM_BASIS_TESTS),TRUE)
BB_DEFINES  += -DTM_BASIS_TESTS
endif
ifeq ($(EXACT_MACHINE_HANDLING),TRUE)
BB_DEFINES  += -DEXACT_MACHINE_HANDLING
endif
ifeq ($(STATISTICS),TRUE)
BB_DEFINES  += -DSTATISTICS
endif
ifeq ($(PSEUDO_COSTS),TRUE)
BB_DEFINES  += -DPSEUDO_COSTS
endif

#__BEGIN_EXPERIMENTAL_SECTION__#
##############################################################################
# DECOMP related stuff 
##############################################################################

ifeq ($(DECOMP),TRUE)
BB_DEFINES += -DCOMPILE_DECOMP
endif

#___END_EXPERIMENTAL_SECTION___#
##############################################################################
# Compiler flags
##############################################################################

STRICT_CHECKING = FALSE

DEFAULT_FLAGS = $(OPT) $(SYSDEFINES) $(BB_DEFINES) $(INCDIR)

MORECFLAGS =

ifeq ($(STRICT_CHECKING),TRUE)
ifeq ($(VERSION),GNU)
	MORECFLAGS = -ansi -pedantic -Wall -Wid-clash-81 -Wpointer-arith -Wwrite-strings -Wstrict-prototypes -Wmissing-prototypes -Wnested-externs -Winline -fnonnull-objects #-pipe
endif
else 
MOREFLAGS = 
endif

ifeq ($(LIBTYPE),SHARED)
ifneq ($(ARCH),CYGWIN)
MORECFLAGS += -fPIC
endif
endif

CFLAGS = $(DEFAULT_FLAGS) $(MORECFLAGS) $(MOREFLAGS)

LD             = $(AR)
LIBLDFLAGS     =

##############################################################################
##############################################################################
# Global source files
##############################################################################
##############################################################################

MASTER_SRC	= master.c master_wrapper.c master_io.c master_func.c

MASTER_MAIN_SRC =
ifneq ($(USE_SYM_APPL),TRUE)
MASTER_MAIN_SRC     = main.c
endif

DG_SRC		= draw_graph.c

ifeq ($(SYM_COMPILE_IN_TM), TRUE)
TM_SRC		= tm_func.c tm_proccomm.c
else
TM_SRC          = treemanager.c tm_func.c tm_proccomm.c
endif
ifeq ($(SYM_COMPILE_IN_LP),TRUE)
TM_SRC         += lp_solver.c lp_varfunc.c lp_rowfunc.c lp_genfunc.c
TM_SRC         += lp_proccomm.c lp_wrapper.c lp_free.c
ifeq ($(PSEUDO_COSTS),TRUE)
TM_SRC         += lp_pseudo_branch.c
else
TM_SRC         += lp_branch.c
endif
ifeq ($(SYM_COMPILE_IN_CG),TRUE)
TM_SRC         += cg_func.c cg_wrapper.c
#__BEGIN_EXPERIMENTAL_SECTION__#
ifeq ($(DECOMP),TRUE)
TM_SRC		+= decomp.c decomp_lp.c
endif
#___END_EXPERIMENTAL_SECTION___#
endif
else
MASTER_SRC += lp_solver.c
endif

ifeq ($(SYM_COMPILE_IN_CP),TRUE)
TM_SRC	       += cp_proccomm.c cp_func.c cp_wrapper.c
endif
ifeq ($(SYM_COMPILE_IN_TM),TRUE)
MASTER_SRC     += $(TM_SRC)
endif

LP_SRC		= lp_solver.c lp_varfunc.c lp_rowfunc.c lp_genfunc.c \
		  lp_proccomm.c lp_wrapper.c lp.c lp_free.c
ifeq ($(PSEUDO_COSTS),TRUE)
LP_SRC         += lp_pseudo_branch.c
else
LP_SRC         += lp_branch.c
endif

ifeq ($(SYM_COMPILE_IN_CG),TRUE)
LP_SRC         += cg_func.c cg_wrapper.c
#__BEGIN_EXPERIMENTAL_SECTION__#
ifeq ($(DECOMP),TRUE)
TM_SRC		+= decomp.c decomp_lp.c
endif
#___END_EXPERIMENTAL_SECTION___#
endif

CP_SRC		= cut_pool.c cp_proccomm.c cp_func.c cp_wrapper.c

CG_SRC		= cut_gen.c cg_proccomm.c cg_func.c cg_wrapper.c

QSORT_SRC	= qsortucb.c qsortucb_i.c qsortucb_ii.c qsortucb_id.c \
		  qsortucb_di.c qsortucb_ic.c
TIME_SRC	= timemeas.c
PROCCOMM_SRC	= proccomm.c
PACKCUT_SRC	= pack_cut.c
PACKARRAY_SRC	= pack_array.c

ifeq ($(USE_GLPMPL),TRUE)
GMPL_SRC        = glpmpl1.c glpmpl2.c glpmpl3.c glpmpl4.c glpdmp.c \
glpavl.c glprng.c glplib1a.c glplib2.c glplib3.c
endif

BB_SRC = $(MASTER_SRC) $(DG_SRC) $(TM_SRC) $(LP_SRC) $(CP_SRC) $(CG_SRC) \
	 $(QSORT_SRC) $(TIME_SRC) $(PROCCOMM_SRC) $(PACKCUT_SRC) \
	 $(PACKARRAY_SRC)

ALL_SRC = $(BB_SRC) $(USER_SRC)

##############################################################################
##############################################################################
# Global rules
##############################################################################
##############################################################################


$(OBJDIR)/%.o : %.c
	mkdir -p $(OBJDIR)
	@echo Compiling $*.c
	$(CC) $(CFLAGS) $(EFENCE_LD_OPTIONS) -c $< -o $@

$(SYM_OBJDIR)/%.o : %.c
	mkdir -p $(SYM_OBJDIR)
	@echo Compiling $*.c
	$(CC) $(CFLAGS) $(EFENCE_LD_OPTIONS) -c $< -o $@

$(GMPL_OBJDIR)/%.o : %.c
	mkdir -p $(GMPL_OBJDIR)
	@echo Compiling $*.c
	gcc -DHAVE_LIBM=1 -DSTDC_HEADERS=1 -I$(GMPLINCDIR) -g -c $< -o $@

$(DEPDIR)/%.d : %.c
	mkdir -p $(DEPDIR)
	@echo Creating dependency $*.d
	$(SHELL) -ec '$(CC) -MM $(CFLAGS) $< \
		| $(AWK) "(NR==1) {printf(\"$(OBJDIR)/$*.o \\\\\\n\"); \
                                 printf(\"$(DEPDIR)/$*.d :\\\\\\n \\\\\\n\"); \
                                } \
                        (NR!=1) {print;}" \
                > $@'

$(USER_OBJDIR)/%.o : %.c
	mkdir -p $(USER_OBJDIR)
	@echo Compiling $*.c
	$(CC) $(CFLAGS) $(EFENCE_LD_OPTIONS) -c $< -o $@

$(USER_DEPDIR)/%.d : %.c
	mkdir -p $(USER_DEPDIR)
	@echo Creating dependency $*.d
	$(SHELL) -ec '$(CC) -MM $(CFLAGS) $< \
		| $(AWK) "(NR==1) {printf(\"$(USER_OBJDIR)/$*.o \\\\\\n\"); \
                                 printf(\"$(USER_DEPDIR)/$*.d :\\\\\\n \\\\\\n\"); \
                                } \
                        (NR!=1) {print;}" \
                > $@'

##############################################################################
##############################################################################
# What to make ? This has to go here in case the user has any targets.
##############################################################################
##############################################################################

WHATTOMAKE = 
PWHATTOMAKE = 
QWHATTOMAKE = 

ifeq ($(SYM_COMPILE_IN_LP),FALSE)
WHATTOMAKE  += lplib lp
PWHATTOMAKE += plp
QWHATTOMAKE += qlp
endif

ifeq ($(SYM_COMPILE_IN_CP),FALSE)
WHATTOMAKE += cplib cp
PWHATTOMAKE += pcp
QWHATTOMAKE += qcp
endif

ifeq ($(SYM_COMPILE_IN_CG),FALSE)
WHATTOMAKE += cglib cg
PWHATTOMAKE += pcg
QWHATTOMAKE += qcg
endif

ifeq ($(SYM_COMPILE_IN_TM),FALSE)
WHATTOMAKE += tmlib tm
PWHATTOMAKE += ptm
QWHATTOMAKE += qtm
endif


ifeq ($(LP_SOLVER), OSI)
ifeq ($(OSI_INTERFACE), CPLEX)
LPXDIR = OsiCpx
LPXINCDIR = CpxIncDir
else 
ifeq ($(OSI_INTERFACE), CLP)
COIN_WHATTOMAKE += coin_clp
LPXDIR = OsiClp
LPXINCDIR = ClpIncDir
endif
ifeq ($(OSI_INTERFACE), OSL)
LPXDIR = OsiOsl
LPXINCDIR = OslIncDir
endif
ifeq ($(OSI_INTERFACE), GLPK)
LPXDIR = OsiGlpk
LPXINCDIR = GlpkIncDir
endif
ifeq ($(OSI_INTERFACE), XPRESS)
LPXDIR = OsiXpr
LPXINCDIR = XprIncDir
endif
endif

endif

ifeq ($(USE_CGL_CUTS), TRUE)
COIN_WHATTOMAKE += cgl
endif

ifeq ($(USE_OSI_INTERFACE), TRUE)
COIN_WHATTOMAKE += osisym
endif


WHATTOMAKE += masterlib master
PWHATTOMAKE += pmaster
QWHATTOMAKE += pmaster

all : 
	$(MAKE) $(WHATTOMAKE)

parallel : 
	$(MAKE) COMM_PROTOCOL=PVM SYM_COMPILE_IN_LP=FALSE $(WHATTOMAKE)

pall :
	$(MAKE) $(PWHATOTOMAKE)

qall :
	$(MAKE) $(QWHATOTOMAKE)

##############################################################################
##############################################################################
##############################################################################
#  Include the user specific makefile
##############################################################################
##############################################################################

#include $(USERROOT)/Makefile

ifeq ($(LIFO),TRUE)
USER_BB_DEFINES += -DLIFO
endif

ifeq ($(FIND_NONDOMINATED_SOLUTIONS),TRUE)
USER_BB_DEFINES += -DFIND_NONDOMINATED_SOLUTIONS
endif

ifeq ($(BINARY_SEARCH),TRUE)
USER_BB_DEFINES += -DBINARY_SEARCH
endif

##############################################################################
##############################################################################
# Master
##############################################################################
##############################################################################

ALL_MASTER	 = $(MASTER_SRC)
ALL_MASTER 	+= $(TIME_SRC)
ALL_MASTER 	+= $(QSORT_SRC)
ALL_MASTER 	+= $(PROCCOMM_SRC)
ALL_MASTER 	+= $(PACKCUT_SRC)
ALL_MASTER 	+= $(PACKARRAY_SRC)

MASTER_OBJS 	  = $(addprefix $(OBJDIR)/,$(notdir $(ALL_MASTER:.c=.o)))
MAIN_OBJ          = $(addprefix $(OBJDIR)/,$(notdir $(MASTER_MAIN_SRC:.c=.o))) 
ifeq ($(USE_GLPMPL),TRUE)
GMPL_OBJ          = $(addprefix $(GMPL_OBJDIR)/,$(notdir $(GMPL_SRC:.c=.o))) 
endif
MASTER_DEP        = $(addprefix $(DEPDIR)/,$(MASTER_MAIN_SRC:.c=.d))
MASTER_DEP 	 += $(addprefix $(DEPDIR)/,$(ALL_MASTER:.c=.d))
USER_MASTER_OBJS  = $(addprefix $(USER_OBJDIR)/,$(notdir $(USER_MASTER_SRC:.c=.o)))
USER_MASTER_DEP   = $(addprefix $(USER_DEPDIR)/,$(USER_MASTER_SRC:.c=.d))

DEPENDANTS = $(USER_MASTER_DEP)
OBJECTS = $(USER_MASTER_OBJS) $(MAIN_OBJ) 



ifeq ($(USE_SYM_APPL),TRUE)
LIBNAME = sym_app
else
LIBNAME = sym
endif

MASTERLIBNAME = $(LIBNAME)$(MASTEREXT)
ifeq ($(SYM_COMPILE_IN_CG),TRUE)
ifeq ($(SYM_COMPILE_IN_CP),TRUE)
ifeq ($(SYM_COMPILE_IN_LP),TRUE)
ifeq ($(SYM_COMPILE_IN_TM),TRUE)
ifeq ($(USE_SYM_APPL),TRUE)
MASTERLIBNAME = $(LIBNAME)
else
MASTERLIBNAME = $(LIBNAME)
endif
endif
endif
endif
endif

SYMLIBDIR  = $(SYMBUILDDIR)/lib
LN_S = ln -fs $(LIBDIR)/$(LIBNAME_TYPE) $(SYMLIBDIR)
ifeq ($(LIBTYPE),SHARED)
LIBNAME_TYPE      = $(addsuffix .so, $(addprefix lib, $(MASTERLIBNAME)))
LD = $(CC) $(OPT) 
LIBLDFLAGS = -shared -Wl,-soname,$(LIBNAME_TYPE) -o
MAKELIB        = 
else
LIBNAME_TYPE   = $(addsuffix .a, $(addprefix lib, $(MASTERLIBNAME)))
MKSYMLIBDIR    = mkdir -p $(SYMLIBDIR)
endif

MASTERBIN = $(MASTERNAME)$(MASTEREXT)
ifeq ($(SYM_COMPILE_IN_CG),TRUE)
ifeq ($(SYM_COMPILE_IN_CP),TRUE)
ifeq ($(SYM_COMPILE_IN_LP),TRUE)
ifeq ($(SYM_COMPILE_IN_TM),TRUE)
MASTERBIN = $(MASTERNAME)
endif
endif
endif
endif

MASTERLPLIB = $(LPLIB)

master : $(BINDIR)/$(MASTERBIN)
	true

masterlib : $(LIBDIR)/$(LIBNAME_TYPE)
	true

pmaster : $(BINDIR)/p$(MASTERBIN)
	true

qmaster : $(BINDIR)/q$(MASTERBIN)
	true

cmaster : $(BINDIR)/c$(MASTERBIN)
	true

master_clean :
	cd $(OBJDIR)
	rm -f $(MASTER_OBJS)
	rm -f $(MAIN_OBJ)
	cd $(DEPDIR)
	rm -f $(MASTER_DEP)

master_clean_user :
	cd $(USER_OBJDIR)
	rm -f $(USER_MASTER_OBJS)
	cd $(USER_DEPDIR)
	rm -f $(USER_MASTER_DEP)

$(BINDIR)/$(MASTERBIN) : $(USER_MASTER_DEP) $(USER_MASTER_OBJS) \
$(MAIN_OBJ) $(LIBDIR)/$(LIBNAME_TYPE) 
	@echo ""
	@echo "Linking $(notdir $@) ..."
	mkdir -p $(BINDIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(USER_MASTER_OBJS) $(MAIN_OBJ) \
	$(OSISYM_LIB) -l$(MASTERLIBNAME) $(MASTERLPLIB) $(MASTERLPLIB) $(LIBS) 
	@echo ""

$(LIBDIR)/$(LIBNAME_TYPE) : $(MASTER_DEP) $(MASTER_OBJS) $(GMPL_OBJ) 
	@echo ""
	@echo "Making $(notdir $@) ..."
	@echo ""
	mkdir -p $(LIBDIR)
	$(LD) $(LIBLDFLAGS) $@ $(MASTER_OBJS) $(GMPL_OBJ) 
	$(MAKELIB)
	$(MKSYMLIBDIR)
	$(LN_S)
	@echo ""

$(BINDIR)/p$(MASTERBIN) : $(USER_MASTER_DEP) $(USER_MASTER_OBJS) \
$(LIBDIR)/libmaster$(MASTEREXT).a 
	@echo ""
	@echo "Linking $(notdir $@) ..."
	@echo ""
	mkdir -p $(BINDIR)
	$(PURIFY) $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(USER_MASTER_OBJS) \
	-lmaster$(MASTEREXT) $(MASTERLPLIB) $(LIBS) 
	@echo ""

$(BINDIR)/q$(MASTERBIN) : $(USER_MASTER_DEP) $(USER_MASTER_OBJS) \
$(LIBDIR)/libmaster$(MASTEREXT).a 
	@echo ""
	@echo "Linking $(notdir $@) ..."
	@echo ""
	mkdir -p $(BINDIR)
	$(QUANTIFY) $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(USER_MASTER_OBJS) \
	-lmaster$(MASTEREXT) $(MASTERLPLIB) $(LIBS) 
	@echo ""

$(BINDIR)/c$(MASTERBIN) : $(USER_MASTER_DEP) $(USER_MASTER_OBJS) \
$(LIBDIR)/libmaster$(MASTEREXT).a
	@echo ""
	@echo "Linking $(notdir $@) ..."
	@echo ""
	mkdir -p $(BINDIR)
	$(CCMALLOC) $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(USER_MASTER_OBJS) \
	-lmaster$(MASTEREXT) $(MASTERLPLIB) $(LIBS)
	@echo ""

##############################################################################
##############################################################################
# DrawGraph
##############################################################################
##############################################################################

ALL_DG  = $(DG_SRC)
ALL_DG += $(PROCCOMM_SRC)

DG_OBJS 	= $(addprefix $(OBJDIR)/,$(notdir $(ALL_DG:.c=.o)))
DG_DEP  	= $(addprefix $(DEPDIR)/,$(ALL_DG:.c=.d))
USER_DG_OBJS 	= $(addprefix $(USER_OBJDIR)/,$(notdir $(USER_DG_SRC:.c=.o)))
USER_DG_DEP  	= $(addprefix $(USER_DEPDIR)/,$(USER_DG_SRC:.c=.d))

dg : $(BINDIR)/$(MASTERNAME)_dg
	true

dglib : $(LIBDIR)/lib$(LIBNAME)_dg.a
	true

pdg : $(BINDIR)/pdg
	true

dg_clean :
	cd $(OBJDIR)
	rm -f $(DG_OBJS)
	cd $(DEPDIR)
	rm -f $(DG_DEP)

dg_clean_user :
	cd $(USER_OBJDIR)
	rm -f $(USER_DG_OBJS)
	cd $(USER_DEPDIR)
	rm -f $(USER_DG_DEP))

$(BINDIR)/$(MASTERNAME)_dg : $(USER_DG_DEP) $(USER_DG_OBJS) $(LIBDIR)/lib$(LIBNAME)_dg.a
	@echo ""
	@echo "Linking $(notdir $@) ..."
	@echo ""
	mkdir -p $(BINDIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(USER_DG_OBJS) \
	-l$(LIBNAME)_dg $(LIBS) 
	@echo ""

$(LIBDIR)/lib$(LIBNAME)_dg.a : $(DG_DEP) $(DG_OBJS)
	@echo ""
	@echo "Making $(notdir $@) ..."
	@echo ""
	mkdir -p $(LIBDIR)
	$(AR) $(LIBDIR)/lib$(LIBNAME)_dg.a $(DG_OBJS)
	$(RANLIB) $(LIBDIR)/lib$(LIBNAME)_dg.a
	@echo ""

$(BINDIR)/pdg : $(USER_DG_DEP) $(USER_DG_OBJS) $(LIBDIR)/libdg.a
	@echo ""
	@echo "Linking $(notdir $@) ..."
	@echo ""
	mkdir -p $(BINDIR)
	$(PURIFY) $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(USER_DG_OBJS) -ldg \
	$(LIBS)
	@echo ""

##############################################################################
##############################################################################
# TreeManager
##############################################################################
##############################################################################

ALL_TM	 = $(TM_SRC)
ALL_TM 	+= $(TIME_SRC)
ALL_TM 	+= $(PROCCOMM_SRC)
ALL_TM 	+= $(PACKCUT_SRC)
ALL_TM 	+= $(PACKARRAY_SRC)
ifeq ($(SYM_COMPILE_IN_LP),TRUE)
ALL_TM  += $(QSORT_SRC)
endif

TM_OBJS 	= $(addprefix $(OBJDIR)/,$(notdir $(ALL_TM:.c=.o)))
TM_DEP  	= $(addprefix $(DEPDIR)/,$(ALL_TM:.c=.d))
USER_TM_OBJS 	= $(addprefix $(USER_OBJDIR)/,$(notdir $(USER_TM_SRC:.c=.o)))
USER_TM_DEP  	= $(addprefix $(USER_DEPDIR)/,$(USER_TM_SRC:.c=.d))

TMLPLIB = $(LPLIB)

tm : $(BINDIR)/$(MASTERNAME)_tm$(TMEXT)
	true

tmlib : $(LIBDIR)/lib$(LIBNAME)_tm$(TMEXT).a
	true

ptm : $(BINDIR)/ptm$(TMEXT)
	true

qtm : $(BINDIR)/qtm$(TMEXT)
	true

ctm : $(BINDIR)/ctm$(TMEXT)
	true

tm_clean :
	cd $(OBJDIR)
	rm -f $(TM_OBJS)
	cd $(DEPDIR)
	rm -f $(TM_DEP)

tm_clean_user :
	cd $(USER_OBJDIR)
	rm -f $(USER_TM_OBJS)
	cd $(USER_DEPDIR)
	rm -f $(USER_TM_DEP))

$(BINDIR)/$(MASTERNAME)_tm$(TMEXT) : $(USER_TM_DEP) $(USER_TM_OBJS) $(LIBDIR)/lib$(LIBNAME)_tm$(TMEXT).a
	@echo ""
	@echo "Linking $(notdir $@) ..."
	@echo ""
	mkdir -p $(BINDIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(USER_TM_OBJS) \
	-l$(LIBNAME)_tm$(TMEXT) \
	$(TMLPLIB) $(LIBS)
	@echo ""

$(LIBDIR)/lib$(LIBNAME)_tm$(TMEXT).a : $(TM_DEP) $(TM_OBJS)
	@echo ""
	@echo "Making $(notdir $@) ..."
	@echo ""
	mkdir -p $(LIBDIR)
	$(AR) $(LIBDIR)/lib$(LIBNAME)_tm$(TMEXT).a $(TM_OBJS)
	$(RANLIB) $(LIBDIR)/lib$(LIBNAME)_tm$(TMEXT).a
	@echo ""

$(BINDIR)/ptm$(TMEXT) : $(USER_TM_DEP) $(USER_TM_OBJS) \
$(LIBDIR)/libtm$(TMEXT).a
	@echo ""
	@echo "Linking purified $(notdir $@) ..."
	@echo ""
	mkdir -p $(BINDIR)
	$(PURIFY) $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(USER_TM_OBJS) \
	-ltm$(TMEXT) $(TMLPLIB) $(LIBS) 
	@echo ""

$(BINDIR)/qtm$(TMEXT) : $(USER_TM_DEP) $(USER_TM_OBJS) \
$(LIBDIR)/libtm$(TMEXT).a
	@echo ""
	@echo "Linking quantified $(notdir $@) ..."
	@echo ""
	mkdir -p $(BINDIR)
	$(QUANTIFY) $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(USER_TM_OBJS) \
	-ltm$(TMEXT) $(TMLPLIB) $(LIBS)
	@echo ""

$(BINDIR)/ctm$(TMEXT) : $(USER_TM_DEP) $(USER_TM_OBJS) \
$(LIBDIR)/libtm$(TMEXT).a
	@echo ""
	@echo "Linking quantified $(notdir $@) ..."
	@echo ""
	mkdir -p $(BINDIR)
	$(CCMALLOC) $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(USER_TM_OBJS) \
	-ltm$(TMEXT) $(TMLPLIB) $(LIBS)
	@echo ""

##############################################################################
##############################################################################
# LP
##############################################################################
##############################################################################

ALL_LP	 = $(LP_SRC)
ALL_LP 	+= $(TIME_SRC)
ALL_LP 	+= $(QSORT_SRC)
ALL_LP 	+= $(PROCCOMM_SRC)
ALL_LP 	+= $(PACKCUT_SRC)
ALL_LP 	+= $(PACKARRAY_SRC)

LP_OBJS 	= $(addprefix $(OBJDIR)/,$(notdir $(ALL_LP:.c=.o)))
LP_DEP 		= $(addprefix $(DEPDIR)/,$(ALL_LP:.c=.d))
USER_LP_OBJS 	= $(addprefix $(USER_OBJDIR)/,$(notdir $(USER_LP_SRC:.c=.o)))
USER_LP_DEP 	= $(addprefix $(USER_DEPDIR)/,$(USER_LP_SRC:.c=.d))

lp : $(BINDIR)/$(MASTERNAME)_lp$(LPEXT)
	true

lplib : $(LIBDIR)/lib$(LIBNAME)_lp$(LPEXT).a
	true

plp : $(BINDIR)/plp$(LPEXT)
	true

qlp : $(BINDIR)/qlp$(LPEXT)
	true

clp : $(BINDIR)/clp$(LPEXT)
	true

lp_clean :
	cd $(OBJDIR)
	rm -f $(LP_OBJS)
	cd $(DEPDIR)
	rm -f $(LP_DEP)

sym_lp_clean:
	cd $(SYM_OBJDIR)
	rm -f $(LP_OBJS)
	cd $(SYM_DEPDIR)
	rm -f $(LP_DEP)

lp_clean_user :
	cd $(USER_OBJDIR)
	rm -f $(USER_LP_OBJS)
	cd $(USER_DEPDIR)
	rm -f $(USER_LP_DEP))

$(BINDIR)/$(MASTERNAME)_lp$(LPEXT) : $(USER_LP_DEP) $(USER_LP_OBJS) $(LIBDIR)/lib$(LIBNAME)_lp$(LPEXT).a
	@echo ""
	@echo "Linking $(notdir $@) ..."
	@echo ""
	mkdir -p $(BINDIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
	$(USER_LP_OBJS) -l$(LIBNAME)_lp$(LPEXT) $(LPLIB) $(LIBS) \
	-l$(LIBNAME)_lp$(LPEXT) $(LPLIB) $(LIBS)
	@echo ""

$(LIBDIR)/lib$(LIBNAME)_lp$(LPEXT).a : $(LP_DEP) $(LP_OBJS) $(GMPL_OBJ) 
	@echo ""
	@echo "Making $(notdir $@) ..."
	@echo ""
	mkdir -p $(LIBDIR)
	$(AR) $(LIBDIR)/lib$(LIBNAME)_lp$(LPEXT).a $(LP_OBJS) $(GMPL_OBJ) 
	$(RANLIB) $(LIBDIR)/lib$(LIBNAME)_lp$(LPEXT).a
	@echo ""

$(BINDIR)/plp$(LPEXT) : $(USER_LP_DEP) $(USER_LP_OBJS) \
$(LIBDIR)/liblp$(LPEXT).a
	@echo ""
	@echo "Linking purified $(notdir $@) ..."
	@echo ""
	mkdir -p $(BINDIR)
	$(PURIFY) $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(USER_LP_OBJS) \
	-llp$(LPEXT) $(LPLIB) $(LIBS)
	@echo ""

$(BINDIR)/qlp$(LPEXT) : $(USER_LP_DEP) $(USER_LP_OBJS) \
$(LIBDIR)/liblp$(LPEXT).a
	@echo ""
	@echo "Linking quantified $(notdir $@) ..."
	@echo ""
	mkdir -p $(BINDIR)
	$(QUANTIFY) $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(USER_LP_OBJS) \
	-llp$(LPEXT) $(LPLIB) $(LIBS) 
	@echo ""

$(BINDIR)/clp$(LPEXT) : $(USER_LP_DEP) $(USER_LP_OBJS) \
$(LIBDIR)/liblp$(LPEXT).a
	@echo ""
	@echo "Linking quantified $(notdir $@) ..."
	@echo ""
	mkdir -p $(BINDIR)
	$(CCMALLOC) $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(USER_LP_OBJS) \
	-llp$(LPEXT) $(LPLIB) $(LIBS)
	@echo ""

##############################################################################
##############################################################################
# CutPool
##############################################################################
##############################################################################

ALL_CP	 = $(CP_SRC)
ALL_CP 	+= $(TIME_SRC)
ALL_CP 	+= $(QSORT_SRC)
ALL_CP 	+= $(PROCCOMM_SRC)
ALL_CP 	+= $(PACKCUT_SRC)

CP_OBJS 	= $(addprefix $(OBJDIR)/,$(notdir $(ALL_CP:.c=.o)))
CP_DEP  	= $(addprefix $(DEPDIR)/,$(ALL_CP:.c=.d))
USER_CP_OBJS 	= $(addprefix $(USER_OBJDIR)/,$(notdir $(USER_CP_SRC:.c=.o)))
USER_CP_DEP  	= $(addprefix $(USER_DEPDIR)/,$(USER_CP_SRC:.c=.d))

cp : $(BINDIR)/$(MASTERNAME)_cp
	true

cplib : $(LIBDIR)/lib$(LIBNAME)_cp.a
	true

pcp : $(BINDIR)/pcp
	true

qcp : $(BINDIR)/qcp
	true

ccp : $(BINDIR)/ccp
	true

cp_clean :
	cd $(OBJDIR)
	rm -f $(CP_OBJS)
	cd $(DEPDIR)
	rm -f $(CP_DEP)

cp_clean_user :
	cd $(USER_OBJDIR)
	rm -f $(USER_CP_OBJS)
	cd $(USER_DEPDIR)
	rm -f $(USER_CP_DEP))

$(BINDIR)/$(MASTERNAME)_cp : $(USER_CP_DEP) $(USER_CP_OBJS) $(LIBDIR)/lib$(LIBNAME)_cp.a
	@echo ""
	@echo "Linking $(notdir $@) ..."
	@echo ""
	mkdir -p $(BINDIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(USER_CP_OBJS) \
	-l$(LIBNAME)_cp $(LIBS) 
	@echo ""

$(LIBDIR)/lib$(LIBNAME)_cp.a : $(CP_DEP) $(CP_OBJS)
	@echo ""
	@echo "Making $(notdir $@) ..."
	@echo ""
	mkdir -p $(LIBDIR)
	$(AR) $(LIBDIR)/lib$(LIBNAME)_cp.a $(CP_OBJS)
	$(RANLIB) $(LIBDIR)/lib$(LIBNAME)_cp.a
	@echo ""

$(BINDIR)/pcp : $(USER_CP_DEP) $(USER_CP_OBJS) $(LIBDIR)/libcp.a
	@echo ""
	@echo "Linking purified $(notdir $@) ..."
	@echo ""
	mkdir -p $(BINDIR)
	$(PURIFY) $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(USER_CP_OBJS) -lcp \
	$(LIBS) 
	@echo ""

$(BINDIR)/qcp : $(USER_CP_DEP) $(USER_CP_OBJS) $(LIBDIR)/libcp.a
	@echo ""
	@echo "Linking purified $(notdir $@) ..."
	@echo ""
	mkdir -p $(BINDIR)
	$(QUANTIFY) $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(USER_CP_OBJS) -lcp \
	$(LIBS) 
	@echo ""

$(BINDIR)/ccp : $(USER_CP_DEP) $(USER_CP_OBJS) $(LIBDIR)/libcp.a
	@echo ""
	@echo "Linking purified $(notdir $@) ..."
	@echo ""
	mkdir -p $(BINDIR)
	$(CCMALLOC) $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(USER_CP_OBJS) -lcp \
	$(LIBS)
	@echo ""

##############################################################################
##############################################################################
# CutGen
##############################################################################
##############################################################################

ALL_CG	 = $(CG_SRC)
ALL_CG 	+= $(TIME_SRC)
ALL_CG 	+= $(QSORT_SRC)
ALL_CG 	+= $(PROCCOMM_SRC)
ALL_CG 	+= $(PACKCUT_SRC)

CG_OBJS = $(addprefix $(OBJDIR)/,$(notdir $(ALL_CG:.c=.o)))
CG_DEP  = $(addprefix $(DEPDIR)/,$(ALL_CG:.c=.d))
USER_CG_OBJS = $(addprefix $(USER_OBJDIR)/,$(notdir $(USER_CG_SRC:.c=.o)))
USER_CG_DEP  = $(addprefix $(USER_DEPDIR)/,$(USER_CG_SRC:.c=.d))

cg : $(BINDIR)/$(MASTERNAME)_cg
	true

cglib : $(LIBDIR)/lib$(LIBNAME)_cg.a
	true

pcg : $(BINDIR)/pcg
	true

qcg : $(BINDIR)/qcg
	true

ccg : $(BINDIR)/ccg
	true

cg_clean :
	cd $(OBJDIR)
	rm -f $(CG_OBJS)
	cd $(DEPDIR)
	rm -f $(CG_DEP)

cg_clean_user :
	cd $(USER_OBJDIR)
	rm -f $(USER_CG_OBJS)
	cd $(USER_DEPDIR)
	rm -f $(USER_CG_DEP))

$(BINDIR)/$(MASTERNAME)_cg : $(USER_CG_DEP) $(USER_CG_OBJS) $(LIBDIR)/lib$(LIBNAME)_cg.a
	@echo ""
	@echo "Linking $(notdir $@) ..."
	@echo ""
	mkdir -p $(BINDIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(USER_CG_OBJS) -l$(LIBNAME)_cg\
	 $(LPLIB) $(LIBS) 
	@echo ""

$(LIBDIR)/lib$(LIBNAME)_cg.a : $(CG_DEP) $(CG_OBJS)
	@echo ""
	@echo "Making $(notdir $@) ..."
	@echo ""
	mkdir -p $(LIBDIR)
	$(AR) $(LIBDIR)/lib$(LIBNAME)_cg.a $(CG_OBJS)
	$(RANLIB) $(LIBDIR)/lib$(LIBNAME)_cg.a
	@echo ""

$(BINDIR)/pcg : $(USER_CG_DEP) $(USER_CG_OBJS) $(LIBDIR)/libcg.a
	@echo ""
	@echo "Linking purified $(notdir $@) ..."
	@echo ""
	mkdir -p $(BINDIR)
	$(PURIFY) $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(USER_CG_OBJS) \
	-lcg $(LPLIB) $(LIBS) 
	@echo ""

$(BINDIR)/qcg : $(USER_CG_DEP) $(USER_CG_OBJS) $(LIBDIR)/libcg.a
	@echo ""
	@echo "Linking quantified $(notdir $@) ..."
	@echo ""
	mkdir -p $(BINDIR)
	$(QUANTIFY) $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(USER_CG_OBJS) \
	-lcg $(LPLIB) $(LIBS) 
	@echo ""

$(BINDIR)/ccg : $(USER_CG_DEP) $(USER_CG_OBJS) $(LIBDIR)/libcg.a
	@echo ""
	@echo "Linking quantified $(notdir $@) ..."
	@echo ""
	mkdir -p $(BINDIR)
	$(CCMALLOC) $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(USER_CG_OBJS) \
	-lcg $(LPLIB) $(LIBS)
	@echo ""

###############################################################################
##############################################################################
# COIN targets
###############################################################################
##############################################################################

coin: $(COIN_WHATTOMAKE)
	(cd $(COINROOT)/Coin && $(MAKE) CXX=$(CC) LibType=$(LIBTYPE) \
	OptLevel=$(COIN_OPT))
	(cd $(COINROOT)/Osi/$(LPXDIR) && \
	$(MAKE) CXX=$(CC) LibType=$(LIBTYPE) OptLevel=$(COIN_OPT) \
	$(LPXINCDIR)=$(LPSINCDIR))

coin_clp:
	(cd $(COINROOT)/Clp && $(MAKE) CXX=$(CC) LibType=$(LIBTYPE) \
	OptLevel=$(COIN_OPT))

cgl:
	(cd $(COINROOT)/Cgl && $(MAKE) CXX=$(CC) LibType=$(LIBTYPE) \
	OptLevel=$(COIN_OPT))

osisym:
	(cd $(COINROOT)/Osi/OsiSym && \
	$(MAKE) CXX=$(CC) LibType=$(LIBTYPE) OptLevel=$(COIN_OPT) \
	SymIncDir=$(SYMPHONYROOT)/include)

###############################################################################
##############################################################################
# Special targets
##############################################################################
##############################################################################

.PHONY:	clean clean_gmpl clean_all master_clean lp_clean cg_clean cp_clean \
	tm_clean dg_clean

clean :
	rm -rf $(OBJDIR)

clean_coin :
	(cd $(COINROOT)/Clp && $(MAKE) clean)
	(cd $(COINROOT)/Coin && $(MAKE) clean)
	(cd $(COINROOT)/Cgl && $(MAKE) clean)
	(cd $(COINROOT)/Osi && $(MAKE) clean)

clean_gmpl :
	rm -rf $(GMPL_OBJDIR)

clean_user :
	rm -rf $(USER_OBJDIR)

clean_dep :
	rm -rf $(DEPDIR)/ 

clean_user_dep :
	rm -rf $(USER_DEPDIR)/

clean_lib :
	rm -rf $(LIBDIR)
	rm -rf $(SYMLIBDIR)

clean_bin :
	rm -rf $(BINDIR)

clean_all : clean clean_gmpl clean_dep clean_user clean_user_dep\
	clean_lib clean_bin
	true

.SILENT:
