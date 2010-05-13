ovsdbmonitor_pyfiles = \
	ovsdb/ovsdbmonitor/OVEApp.py \
	ovsdb/ovsdbmonitor/OVECommonWindow.py \
	ovsdb/ovsdbmonitor/OVEConfig.py \
	ovsdb/ovsdbmonitor/OVEConfigWindow.py \
	ovsdb/ovsdbmonitor/OVEFetch.py \
	ovsdb/ovsdbmonitor/OVEFlowWindow.py \
	ovsdb/ovsdbmonitor/OVEHostWindow.py \
	ovsdb/ovsdbmonitor/OVELogWindow.py \
	ovsdb/ovsdbmonitor/OVELogger.py \
	ovsdb/ovsdbmonitor/OVEMainWindow.py \
	ovsdb/ovsdbmonitor/OVEStandard.py \
	ovsdb/ovsdbmonitor/OVEUtil.py \
	ovsdb/ovsdbmonitor/Ui_ConfigWindow.py \
	ovsdb/ovsdbmonitor/Ui_FlowWindow.py \
	ovsdb/ovsdbmonitor/Ui_HostWindow.py \
	ovsdb/ovsdbmonitor/Ui_LogWindow.py \
	ovsdb/ovsdbmonitor/Ui_MainWindow.py \
	ovsdb/ovsdbmonitor/qt4reactor.py
EXTRA_DIST += \
	$(ovsdbmonitor_pyfiles) \
	ovsdb/ovsdbmonitor/ConfigWindow.ui \
	ovsdb/ovsdbmonitor/FlowWindow.ui \
	ovsdb/ovsdbmonitor/HostWindow.ui \
	ovsdb/ovsdbmonitor/LogWindow.ui \
	ovsdb/ovsdbmonitor/MainWindow.ui \
	ovsdb/ovsdbmonitor/ovsdbmonitor.in

ovsdbmonitordir = ${pkgdatadir}/ovsdbmonitor
if BUILD_OVSDBMONITOR
noinst_SCRIPTS += ovsdb/ovsdbmonitor/ovsdbmonitor
ovsdbmonitor_DATA = $(ovsdbmonitor_pyfiles)
install-exec-local:
	sed -e '/NOINSTALL/d' < ovsdb/ovsdbmonitor/ovsdbmonitor > ovsdbmonitor.tmp
	chmod +x ovsdbmonitor.tmp
	$(INSTALL_PROGRAM) ovsdbmonitor.tmp $(DESTDIR)$(bindir)/ovsdbmonitor
endif

SUFFIXES += .ui .py
.ui.py:
	$(PYUIC4) $< | sed 's/from PyQt4 import QtCore, QtGui/\
try:\
    from OVEStandard import globalForcePySide\
    if globalForcePySide:\
        raise Exception()\
    from PyQt4 import QtCore, QtGui\
except:\
    from PySide import QtCore, QtGui/' > $@