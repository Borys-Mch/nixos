{ ... }:

{
  fileSystems."/" = {
    options = [
      "noatime"
      "compress=zstd:3"
      "space_cache=v2"
    ];
  };
}
