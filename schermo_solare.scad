$fn = 60;
num_piattelli = 6;
diametro_esterno = 85;
foro_centrale = 28;
spessore_parete = 2.2;
altezza_piattello = 14;
spazio_aria = 10;

module piattello(aperto = true) {
    difference() {
        cylinder(h = altezza_piattello, d1 = diametro_esterno, d2 = diametro_esterno - 18);
        translate([0, 0, -0.1])
            cylinder(h = altezza_piattello - spessore_parete + 0.1, 
                     d1 = diametro_esterno - (spessore_parete * 2.5), 
                     d2 = diametro_esterno - 18 - (spessore_parete * 2.5));
        if (aperto) { translate([0, 0, -1]) cylinder(h = altezza_piattello + 5, d = foro_centrale); }
    }
    for (angolo = [0, 120, 240]) {
        rotate([0, 0, angolo])
            translate([(foro_centrale / 2) + 5, 0, altezza_piattello - 2])
                cylinder(h = spazio_aria + 2, d = 4.5);
    }
}

union() {
    for (i = [0 : num_piattelli - 1]) {
        translate([0, 0, i * spazio_aria]) {
            if (i == num_piattelli - 1) { piattello(aperto = false); } 
            else { piattello(aperto = true); }
        }
    }
}
