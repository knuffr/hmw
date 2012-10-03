## Makefile fuers Harvestmoon-Projekt:

# Variablen und Flags
# Version des Pakets
VERSION			= 0.1.1

# Name des Pakets
PKG_NAME		= HMP-CLIENT

# Quelldateien nur fuer das Spiel
MSRCS			= main.vala consts.vala types.vala

# XML-Sourcen
XSRCS			= io/xml/xmlFile.vala io/xml/tsxFile.vala io/xml/tmxFile.vala

# Utility-Sourcen
USRCS			= io/ResourceManager.vala io/TilesetManager.vala io/Tileset.vala

# Game-Sourcen
GSRCS			= game/GameState.vala game/GameWorld.vala game/map/Map.vala game/map/MapLayer.vala game/map/MapManager.vala game/entity/Entity.vala game/entity/Player.vala

# GLFW-Sourcen
GLSRCS			= io/glfw/glfwRenderer.vala io/glfw/glfwVideo.vala io/glfw/glfwIOHandler.vala io/glfw/glfwWindow.vala io/glfw/glfwInput.vala

# Gesamtheit der Sourcen
SRCS = $(MSRCS) $(GLSRCS) $(USRCS) $(GSRCS) $(XSRCS)

# ausfuehrbares Ziel
TARGET        = hmp
# Pakete
PACKAGES      = gl glu libglfw gee-1.0 cairo libxml-2.0
# C-Compileranweisungen
CFLAGS        = -lm

# Quellverzeichnis
SRC_DIR       = src/
# Vapiverzeichnis
VAPI_DIR      = vapi/
# Verzeichnis fuer erzeuge Binaries
BIN_DIR       = bin/
# Verzeichnis fuer Doku
DOC_DIR       = doc/
# Öffentliches Verzeichnis für die Dokumentationsveröffentlichung
PUB_DIR       = ~/Dropbox/Public/hmp/
# Verzeichnis fuer Temporaere Dateien
TMP_DIR		  = tmp/

# Bazaar-Repository
BZR_REPO      = bzr+ssh://bazaar.launchpad.net/%2Bbranch/hmproject/0.1/

# Vala-Compiler
VC            = valac

# Valadoc
VD            = valadoc
# Valadoc Driver
VDD           = 0.15.3

# Bazaar
BZR           = bzr

# Quelldateien mit Pfad
SRC_FILES      = $(SRCS:%.vala=$(SRC_DIR)%.vala)
# Test-Quelldateien mit Pfad
TSRC_FILES     = $(ASRC_FILES) $(TSRCS:%.vala=$(TSRC_DIR)%.vala)
# Zieldatei mit Pfad
TARGET_FILE   = $(TARGET:%=$(BIN_DIR)%)
# Paketflags
PKG_FLAGS     = $(PACKAGES:%=--pkg %)
# C-Flags
CC_FLAGS      = $(CFLAGS:%=-X %)
# Alle Kompileroptionen
COMP		  = $(-o $(TARGET_FILE) --vapidir=$(VAPI_DIR) $(PKG_FLAGS) $(CC_FLAGS) $(SRC_FILES))

# Targets

.PHONY: all run dirs pull commit commit-* push push-* help clean test

## * make (all): Programm compilieren
all: dirs $(TARGET_FILE)

## * make run: Programm compilieren und ausfuehren
run: all
	@echo "Running $(TARGET_FILE)..."
	$(TARGET_FILE)

## * make dirs: Noetige Verzeichnisse erstellen
dirs:
	@echo "Creating output directory..."
	@mkdir -p $(BIN_DIR)

$(TARGET_FILE): $(SRC_FILES)
	@echo "Compiling Binary..."
	@$(VC) -o $(TARGET_FILE) --vapidir=$(VAPI_DIR) $(PKG_FLAGS) $(CC_FLAGS) $(SRC_FILES)
	
c: dirs $(SRC_FILES)
	@echo "Compiling Binary..."
	@$(VC) -o $(TARGET_FILE) --vapidir=$(VAPI_DIR) $(PKG_FLAGS) $(CC_FLAGS) $(SRC_FILES) -C
## * make doc-test: Dokumentation fuer die Tests generieren, inkl. nicht oeffentlicher Bereiche
doc-test: $(SRC_FILES)
	@echo "Generating internal Documentation for Tests..."
	@$(VD) --driver $(VDD) -o $(TST_DOC_DIR) --vapidir=$(VAPI_DIR) $(PKG_FLAGS) $(CC_FLAGS) $(TSRC_FILES) --package-name $(PKG_NAME) --package-version=$(VERSION) --private --internal
## * make doc: Dokumentation generieren
doc: $(SRC_FILES)
	@echo "Generating Documentation..."
	@$(VD) --driver $(VDD) -o $(DOC_DIR) --vapidir=$(VAPI_DIR) $(PKG_FLAGS) $(CC_FLAGS) $(SRC_FILES) --package-name $(PKG_NAME) --package-version=$(VERSION)
	@gnome-open ./doc/index.html

## * make doc-internal: Dokumentation generieren, inkl. nicht oeffentlicher Bereiche
doc-internal: $(SRC_FILES)
	@echo "Generating internal Documentation"
	@$(VD) --driver $(VDD) -o $(DOC_DIR) --vapidir=$(VAPI_DIR) $(PKG_FLAGS) $(CC_FLAGS) $(SRC_FILES) --package-name $(PKG_NAME) --package-version=$(VERSION) --private --internal --importdir=$(TST_DOC_DIR) #fix importdir
	@gnome-open ./doc/index.html

## * make doc-publish: Zuvor generierte Doc veroeffentlichen
doc-publish: $(SRC_FILES)
	@mkdir -p $(PUB_DIR)
	@cp $(DOC_DIR) $(PUB_DIR) -r
	@gnome-open http://dl.dropbox.com/u/55722973/hmp/doc/index.html

## * make clean: Raeumt die erzeugten Dateien auf
clean:
	@echo "Cleaning up..."
	@rm -rf $(BIN_DIR)
	@rm -rf $(DOC_DIR)
	@rm -rf $(SRC_DIR)*.c
	@rm -rf $(SRC_DIR)/*/*.c
	@rm -rf $(TMP_DIR)
	@rm -rf $(TST_DOC_DIR)

## * make help: Diese Hilfe anzeigen
help:
	@grep '^##' 'Makefile' | sed -e 's/## //g'
