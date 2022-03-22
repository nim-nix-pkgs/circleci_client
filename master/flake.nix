{
  description = ''CircleCI API client'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-circleci_client-master.flake = false;
  inputs.src-circleci_client-master.owner = "FedericoCeratto";
  inputs.src-circleci_client-master.ref   = "master";
  inputs.src-circleci_client-master.repo  = "nim-circleci";
  inputs.src-circleci_client-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-circleci_client-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-circleci_client-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}