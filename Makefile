# ToolBox installation / update makefile
# 
# Allows you to install or update files from version tracking.
#

TB_USER       = root
TB_SERVER     = 
TB_INSTALLDIR = /usr/local/share/toolkit/
ALL_SERVER  = local devsrv0 devsrv1 devsrv2 testsrv0 testsrv1 preprodsrv0 prodsrv0 prodsrv1 prodsrv2 prodsrv3
DEV =  devsrv0 devsrv1 devsrv2
TEST = testsrv0 testsrv1
PREPROD = preprodsrv0
PROD =  prodsrv0 prodsrv1 prodsrv2 prodsrv3

# By default, don't do anything
default: 
	@echo "Please provide server group name (all, dev, prod) or one specificly..."
all:
	@for i in $(ALL_SERVER); do (make $$i); done
dev:
	@for i in $(DEV); do (make $$i); done
test:
	@for i in $(TEST); do (make $$i); done
preprod:
	@for i in $(PREPROD); do (make $$i); done
prod:
	@for i in $(PROD); do (make $$i); done

# Define localhost for testing
local: TB_SERVER  = localhost
local: synchro

# Define here your developpement servers, clone lines as much as you need
devsrv0: TB_SERVER  = devsrv0.example.fqdn
devsrv0: synchro

devsrv1: TB_SERVER  = devsrv1.example.fqdn
devsrv1: synchro

devsrv2: TB_SERVER  = devsrv2.example.fqdn
devsrv2: synchro

# Define here your testing servers, clone lines as much as you need
testsrv0: TB_SERVER  = testsrv0.example.fqdn
testsrv0: synchro

testsrv1: TB_SERVER  = testsrv1.example.fqdn
testsrv1: synchro

# Define here your pre-production servers, clone lines as much as you need
preprodsrv0: TB_SERVER  = preprodsrv0.example.fqdn
preprodsrv0: synchro

# Define here your production servers, clone lines as much as you need
prodsrv0: TB_SERVER  = prodsrv0.example.fqdn
prodsrv0: synchro

prodsrv1: TB_SERVER  = prodsrv1.example.fqdn
prodsrv1: synchro

prodsrv2: TB_SERVER  = prodsrv2.example.fqdn
prodsrv2: synchro

prodsrv3: TB_SERVER  = prodsrv3.example.fqdn
prodsrv3: synchro

# Synchronize toolbox files on each defined servers
synchro:
	@echo "ToolBox synchronization on $(TB_SERVER)"
	@rsync -avz -e ssh --checksum --cvs-exclude --exclude-from=excludeList . $(TB_USER)@$(TB_SERVER):$(TB_INSTALLDIR)
	@echo "ToolBox rights update on $(TB_SERVER)"
	@ssh $(TB_USER)@$(TB_SERVER) chmod -R 755 $(TB_INSTALLDIR)
