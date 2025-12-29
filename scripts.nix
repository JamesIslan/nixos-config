{ pkgs, ... }:

let
  # The Python script from your Gist
  pythonGist = pkgs.fetchurl {
    url = "https://gist.githubusercontent.com/JamesIslan/eda7e8143dd4d0231aa2090b4339204e/raw/42e67422f2dd6f0949db92b8fbc8b29632d8a086/extract_subs.py";
    sha256 = "186nx4s2g20viq0jfhk3pgvdkqp7g3glcj9apdb6y9s6q1skfvbi"; 
  };

  # The wrapper for terminal and Nautilus
  extract-subs = pkgs.writeShellApplication {
    name = "extract-subs";
    runtimeInputs = [ pkgs.python3 pkgs.mkvtoolnix pkgs.libnotify ];
    text = ''
          # No more pipes, just run the script
          python3 ${pythonGist} "$@"
    '';
  };
in
{
  # Install the package
  home.packages = [ extract-subs ];

  # Add to Nautilus right-click menu
  home.file.".local/share/nautilus/scripts/Extract Subtitles".source = 
    "${extract-subs}/bin/extract-subs";
}
