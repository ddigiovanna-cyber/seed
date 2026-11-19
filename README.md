# PROGETTO SEED
## Piattaforma IoT Compatta di Controllo Ambientale e Monitoraggio delle Specie Aliene Invasive

Contenuto dell'archivio:
- `Progetto_SEED_Documentazione.docx`: Documento tecnico completo in formato Word con rendering del prototipo.
- `README.md`: Panoramica rapida e istruzioni d'uso.
- `firmware_nodo.ino`: Codice sorgente C++ per Seeed Studio XIAO ESP32S3 Sense + LoRa SX1262.
- `decoder_ttn.js`: Payload Formatter JavaScript per server LoRaWAN (The Things Network / ChirpStack).
- `schema_db.sql`: Script SQL per la creazione delle hypertable su PostgreSQL + TimescaleDB.
- `calcolo_gdd.py`: Microservizio Python per il calcolo automatico dei Gradi Giorno (GDD).
- `schermo_solare.scad`: Modello 3D parametrico OpenSCAD dello schermo solare per sensore SHT40.
- `camera_trappola.scad`: Modello 3D parametrico OpenSCAD della camera ottica e supporto piastra collante.
- `dashboard_grafana.json`: Configurazione dashboard importabile in Grafana.
- `render_prototipo_seed.png`: Immagine concettuale del nodo installato in campo.
