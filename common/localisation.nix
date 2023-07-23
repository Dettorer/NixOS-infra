{ ... }:

{
  console.keyMap = "fr-bepo";
  time.timeZone = "Europe/Paris";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "all" ];
    extraLocaleSettings = {
      "LC_TIME" = "fr_FR.UTF-8";
      "LC_MEASUREMENT" = "fr_FR.UTF-8";
      "LC_PAPER" = "fr_FR.UTF-8";
    };
  };
}
