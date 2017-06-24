dnl Autoconf configure script for Ada Libscret

dnl Process this file with autoconf to produce a configure script.

AC_INIT(src/secret.ads)

AC_CANONICAL_SYSTEM
dnl AM_MAINTAINER_MODE

# Current release settings
SECRET_MAJOR_VERSION=0
SECRET_MINOR_VERSION=1
SECRET_MICRO_VERSION=0
SECRET_VERSION=$SECRET_MAJOR_VERSION.$SECRET_MINOR_VERSION.$SECRET_MICRO_VERSION
AM_GNAT_CHECK_GPRBUILD

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

AC_MSG_CHECKING([number of processors])
NR_CPUS=`getconf _NPROCESSORS_CONF 2>/dev/null || getconf NPROCESSORS_CONF 2>/dev/null || echo 1`
AC_MSG_RESULT($NR_CPUS)
AC_SUBST(NR_CPUS)
##########################################
# Check to enable/disable shared library
##########################################
AM_SHARED_LIBRARY_SUPPORT

##########################################
# Ada Util library
##########################################
AM_GNAT_FIND_PROJECT([ada-util],[Ada Utility Library],[util],
  [git@github.com:stcarrez/ada-util.git],
  [Building Secret requires the Ada Utility Library.],
  [
    UTIL_DIR=${gnat_project_dir_util}
  ])
AC_SUBST(UTIL_DIR)

AM_UTIL_CHECK_INSTALL
AC_OUTPUT(
Makefile secret.gpr secret_tests.gpr samples.gpr
)
