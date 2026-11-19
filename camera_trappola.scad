$fn = 50;
larghezza_piastra = 130;
profondita_piastra = 100;
distanza_focale = 160;
spessore = 3;

module guida_piastra() {
    difference() {
        cube([larghezza_piastra + (spessore * 2), profondita_piastra + (spessore * 2), 12]);
        translate([spessore, -1, 4]) cube([larghezza_piastra, profondita_piastra + 2, 4]);
        translate([spessore + 5, spessore + 5, 7]) cube([larghezza_piastra - 10, profondita_piastra - 10, 10]);
    }
}

module tetto_ottico() {
    difference() {
        cube([larghezza_piastra + (spessore * 2), profondita_piastra + (spessore * 2), 15]);
        translate([(larghezza_piastra / 2) + spessore, (profondita_piastra / 2) + spessore, -1])
            cylinder(h = 20, d = 9.5);
        for (dx = [-22, 22], dy = [-22, 22]) {
            translate([(larghezza_piastra / 2) + spessore + dx, (profondita_piastra / 2) + spessore + dy, -1])
                cylinder(h = 20, d = 5.2);
        }
        translate([spessore + 15, spessore + 15, 6])
            cube([larghezza_piastra - 30, profondita_piastra - 30, 12]);
    }
}

union() {
    guida_piastra();
    for (x = [0, larghezza_piastra - 10 + spessore], y = [0, profondita_piastra - 10 + spessore]) {
        translate([x, y, 12]) cube([10 + spessore, 10 + spessore, distanza_focale]);
    }
    translate([0, 0, distanza_focale + 12]) tetto_ottico();
}
