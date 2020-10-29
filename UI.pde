final float UI_GROOTTE = 1;
final int REM = round(16 * UI_GROOTTE);

boolean muisBovenGebied(int x1, int y1, int x2, int y2) {
	boolean muisGroterDan = mouseX > x1 && mouseY > y1;
	boolean muisKleinerDan = mouseX < x2 && mouseY < y2;
	
	return muisGroterDan && muisKleinerDan;
}

int tekenWisselschakelaar(int[] opties, int x, int y, int breedte, int hoogte, int geselecteerd) {
	int hoverBovenIndex = -1;
	int knopBreedte = breedte / opties.length;

	for(int i = 0; i < opties.length; i++) {
		if(tekenKnop(str(opties[i]), x + knopBreedte * i, y, knopBreedte, hoogte, geselecteerd == i)) {
			hoverBovenIndex = i;
		};
	}

	if(hoverBovenIndex != -1 && mousePressed) {
		return hoverBovenIndex;
	} else {
		return geselecteerd;
	}
}

boolean tekenKnop(String text, int x, int y, int breedte, int hoogte, boolean geselecteerd) {
	boolean muisBovenKnop = muisBovenGebied(x, y, x + breedte, y + hoogte);
	
	if(muisBovenKnop || geselecteerd) {
		fill(#000000, 25);
	} else {
		fill(#FFFFFF, 100);
	}

	rect(x, y, breedte, hoogte);
	
	if(muisBovenKnop || geselecteerd) {
		fill(#FFFFFF, 255);
	} else {
		fill(#000000, 100);
	}
	textAlign(CENTER, CENTER);
	text(text, x + breedte / 2, y + hoogte / 2);
	
	return muisBovenKnop;
}