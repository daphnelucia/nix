{ config, lib, symlinkRoot, ... }: let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (lib) flatten flip map mergeAttrsList;
  
  pipe = flip lib.pipe;
  flatMerge = pipe [flatten mergeAttrsList];
  
  toSrcFile = name: "${symlinkRoot}/${name}";
  link = pipe [toSrcFile mkOutOfStoreSymlink];

  linkFile = name: {${name}.source = link name;};
  linkDir = name: {
    ${name} = {
      source = link name;
      recursive = true;
    };
  };

  linkConfFiles = map linkFile;
  linkConfDirs = map linkDir;

  confFiles = linkConfFiles [ ];
  confDirs = linkConfDirs [
    "hypr"
  ];

  links = flatMerge [confFiles confDirs];
in {
  xdg.configFile = links;
}
