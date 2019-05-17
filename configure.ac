dnl Autoconf configure script for Ada Libscret

dnl Process this file with autoconf to produce a configure script.

AC_INIT(src/secret.ads)

AC_CANONICAL_SYSTEM
dnl AM_MAINTAINER_MODE

# Current release settings
SECRET_MAJOR_VERSION=0
SECRET_MINOR_VERSION=2
SECRET_MICRO_VERSION=0
SECRET_VERSION=$SECRET_MAJOR_VERSION.$SECRET_MINOR_VERSION.$SECRET_MICRO_VERSION

AM_GNAT_LIBRARY_PROJECT(secretada)

# checking for local tools
AC_PROG_CC
AC_PROG_MAKE_SET
AC_PROG_INSTALL
AC_PROG_LN_S

# Set the version number of the project
AC_SUBST(SECRET_VERSION)
AC_SUBST(SECRET_MAJOR_VERSION)
AC_SUBST(SECRET_MINOR_VERSION)
AC_SUBST(SECRET_MICRO_VERSION)

EXEC_PREFIX="$prefix"
AC_SUBST(EXEC_PREFIX)
SECRET_LIBDIR="lib"
AC_SUBST(SECRET_LIBDIR)

AC_MSG_CHECKING([Ada Utility Library])
AC_ARG_WITH(ada-util,
AS_HELP_STRING([--with-ada-util=x], [Path for Ada Utility Library]),
[
  if test T${withval} = Tno ; then
    SECRET_USE_ADA_UTIL=no;
  else
    SECRET_USE_ADA_UTIL='yes';
  fi
],
[
  SECRET_USE_ADA_UTIL=yes;
])
AC_MSG_RESULT(${SECRET_USE_ADA_UTIL})

##########################################
# Ada Util library
##########################################
if test T${SECRET_USE_ADA_UTIL} = Tyes; then
AM_GNAT_FIND_PROJECT([ada-util],[Ada Utility Library],[utilada_sys],
  [git@github.com:stcarrez/ada-util.git],
  [Building Secret requires the Ada Utility Library.],
  [
    UTIL_DIR=${gnat_project_dir_utilada_sys}
  ])
  WITH_ADA_UTIL="with \"${UTIL_DIR}utilada_sys\";";
else
  WITH_ADA_UTIL=''
  UTIL_DIR=''
fi
AC_SUBST(UTIL_DIR)
AC_SUBST(WITH_ADA_UTIL)
AC_SUBST(SECRET_USE_ADA_UTIL)

AM_UTIL_CHECK_INSTALL
AC_OUTPUT(
Makefile.conf secretada.gpr secretada_tests.gpr samples.gpr
)
