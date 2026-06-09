{
  flake.modules.nixos.location-services = {
    location.provider = "geoclue2";
    services.geoclue2 = {
      geoProviderUrl = "https://api.beacondb.net/v1/geolocate";
    };
  };
}
