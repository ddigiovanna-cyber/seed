function decodeUplink(input) {
  var bytes = input.bytes;
  var tempRaw = (bytes[0] << 8) | bytes[1];
  if (tempRaw & 0x8000) { tempRaw = tempRaw - 0x10000; }
  var temperature = tempRaw / 100.0;
  var humRaw = (bytes[2] << 8) | bytes[3];
  var humidity = humRaw / 100.0;

  return {
    data: {
      temperature_c: Number(temperature.toFixed(2)),
      humidity_percent: Number(humidity.toFixed(2)),
      leaf_wetness_percent: bytes[4],
      alien_pest_count: bytes[5],
      battery_v: Number((bytes[6] / 50.0).toFixed(2))
    }
  };
}
