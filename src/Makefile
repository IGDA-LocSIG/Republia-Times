MXMLC = mxmlc
FLIXEL = ~/Projects/LudumDare/flixel/
SRC = *.as
PNG = assets/*.png
TTF = assets/*.ttf
MP3 = assets/*.mp3
MAIN = Main.as
SWF = ../www/RepubliaTimes.swf
 
$(SWF) : $(SRC) $(PNG) $(TTF) $(MP3)
	$(MXMLC) -static-link-runtime-shared-libraries=true -sp $(FLIXEL) -o $(SWF) -- $(MAIN)
