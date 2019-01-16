-- cc/ccrunx-image | 15.09.2018
-- By daelvn
--> # ccrunx-image
--> Generate images of CCRunX instances
{:title, :arrow, :dart, :bullet, :error} = require "ltext"
argparse                                 = require "argparse"

table.unpack or= unpack or ->

--> Collect arguments
local argl
with argparse!
  \name "ccrunx-image"
  \description "Package instances of CCRunX instances"
  \epilog "https://ccrunx.daelvn.ga"

  \command_target "action"

  with \option "-v --version"
    \description "Prints the ccrunx-image version"
    \action -> print "ccrunx-image 0.2"

  with \flag "--embed"
    \description "Embeds the command in another such as ccrunx-compose"

  with \command "compress c"
    \description "Compress an instance"
    \target "compress"
    with \argument "environment"
      \description "Package this environment"
      \args 1

  with \command "decompress d"
    \description "Decompress an image"
    \target "decompress"
    with \argument "file"
      \description "File to decompress"
      \args 1

  argl = \parse!

switch argl.action
  when "compress"
    env = argl.environment
    print arrow "#{argl.embed and "  " or ""}Compressing environment #{env} at .ccrunx/#{env}"
    --> Use zip -r
    zip = io.popen "zip ccrunx-image_#{env}.ccrunx -r #{env} .ccrunx/#{env}"
    for line in zip\lines!
      print bullet (argl.embed and "   " or "") .. line
    zip\close!
    --
    print arrow "#{argl.embed and "  " or ""}Created archive ccrunx-image_#{env}.ccrunx"
  when "decompress"
    file = argl.file
    print arrow "#{argl.embed and "  " or ""}Decompressing image #{file}"
    --> Use unzip
    unzip = io.popen "unzip #{file}"
    for line in unzip\lines!
      print bullet (argl.embed and "   " or "") .. line
    unzip\close!
    --
    print arrow "#{argl.embed and "  " or ""}Decompressed image #{file}"
