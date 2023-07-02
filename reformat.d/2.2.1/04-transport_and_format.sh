#!/usr/bin/env bash

function pre_transport_and_format(){
  file="$ROOT/ocpi/transport_and_format.asciidoc"
  $SED -i "s|\[source\]|\[source, text\]|gm" "$file"
  $SED -i -e "s| {object-id} | \`object-id\` |gm" "$file"
  $SED -i -e "s|{base-ocpi-url}/{end-point}/{country-code}/{party-id}/{object-id}|\`{base-ocpi-url}/{end-point}/{country-code}/{party-id}/{object-id}\`|gm" "$file"
  
  $SED -i '/^.Example sequence diagram of a GET for 1 Object from a CPO to an eMSP.$/d' "$file"
  $SED -i '/^.Example sequence diagram of a PUT via 2 Hubs.$/d' "$file"
  $SED -i '/^.Example sequence diagram of a Broadcast Push from a CPO to multiple eMSPs.$/d' "$file"
  $SED -i '/^.Example sequence diagram of a open routing GET from a CPO via the Hub.$/d' "$file"
  $SED -i '/^.Example sequence diagram of a GET All via the Hub, .$/d' "$file"
  $SED -i '/^.Example sequence diagram of a GET for 1 Object from a CPO on one platform to an MSP on another platform directly (without a Hub)$/d' "$file"
  $SED -i '/^.Example sequence diagram of a GET for 1 Object from one Platform to another Platform via a Hub$/d' "$file"
  $SED -i '/^.Example sequence diagram of Broadcast Push from one Platform to another Platform via a Hub$/d' "$file"
  $SED -i '/^.Example sequence diagram of a open routing between platforms  GET from a CPO via the Hub$/d' "$file"
  $SED -i '/^.Example sequence diagram of the uses of X-Request-ID and X-Correlation-ID in a peer-to-peer topology.$/d' "$file"
  $SED -i '/^.Example sequence diagram of the uses of X-Request-ID and X-Correlation-ID in a topology with a Hub.$/d' "$file"

}

function fix_transport_and_format() {
  file="$ROOT/docs/04-transport_and_format.md"
  tempfile="$file.tmp"

  echo -e "---\nsidebar_position: 4\nslug: transport-and-format\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  $SED -i -z "s/<div class=\"note\">\n/\:\:\:note/gm" "$file"
  $SED -i -z "s|\n</div>|\:\:\:|gm" "$file"
  $SED -i -z "s|======|######|gm" "$file"
  $SED -i "s|^\s\sAuthorization|Authorization|gm" "$file"
  $SED -i "s/’/'/gm" "$file"
  $SED -i "s|\#\#\#\#\# |\#\#\#\# |gm" "$file"
  $SED -i "s|^  Link|Link|gm" "$file"
  $SED -i -z "s|=100\n|=100|gm" "$file"
  $SED -i -z "s|100                 |100|gm" "$file"
  $SED -i -z 's|- |* |gm' "$file"
  $SED -i -e 's|^  https|https|gm' "$file"
  $SED -i 's|^#### Example\:|\* \*\*Example:\*\*|gm' "$file"
  $SED -i "s|^\`\`\`\sjson|\`\`\`json|gm" "$file"
  $SED -i "s|^\`\`\`\stext|\`\`\`text|gm" "$file"
  $SED -i 's|^        "status_code"|  "status_code"|gm' "$file"
  $SED -i 's|^        "status_message"|  "status_message"|gm' "$file"
  $SED -i 's|^        "timestamp"|  "timestamp"|gm' "$file"
  $SED -i '/<figure>/d' "$file"
  $SED -i '/<\/figure>/d' "$file"

  $SED -i -z 's|.svg"\nalt="|.svg" alt="|gm' "$file"

  $SED -i "s|<img src=\"images/sd_get_simple.svg\" alt=\"OCPI Sequence Diagram Hub GET\" />|![OCPI Sequence Diagram Hub GET](./images/sd_get_simple.svg)|g" "$file"
  $SED -i "s|<img src=\"images/sd_put_2_hubs.svg\" alt=\"OCPI Sequence Diagram Hub PUT with 2 Hubs\" />|![OCPI Sequence Diagram Hub PUT with 2 Hubs](./images/sd_put_2_hubs.svg)|g" "$file"
  $SED -i "s|<img src=\"images/sd_put_boardcast.svg\" alt=\"OCPI Sequence Diagram of a Broadcast Push from a CPO to multiple eMSPs\" />|![OCPI Sequence Diagram of a Broadcast Push from a CPO to multiple eMSPs](./images/sd_put_boardcast.svg)|g" "$file"
  $SED -i "s|<img src=\"images/sd_get_openrouting.svg\" alt=\"Example sequence diagram of a open routing GET from a CPO via the Hub\" />|![Example sequence diagram of a open routing GET from a CPO via the Hub](./images/sd_get_openrouting.svg)|g" "$file"
  $SED -i "s|<img src=\"images/sd_get_all.svg\" alt=\"OCPI Sequence Diagram of a GET All via the Hub.\" />|![OCPI Sequence Diagram of a GET All via the Hub.](./images/sd_get_all.svg)|g" "$file"
  $SED -i "s|<img src=\"images/sd_platform_to_platform_direct.svg\" alt=\"Example sequence diagram of a GET for 1 Object from a CPO on one platform to an MSP on another platform directly (without a Hub)\" />|![Example sequence diagram of a GET for 1 Object from a CPO on one platform to an MSP on another platform directly (without a Hub)](./images/sd_platform_to_platform_direct.svg)|g" "$file"
  $SED -i "s|<img src=\"images/sd_platform_hub_platform.svg\" alt=\"Example sequence diagram of a GET for 1 Object from one Platform to another Platform via a Hub\" />|![Example sequence diagram of a GET for 1 Object from one Platform to another Platform via a Hub](./images/sd_platform_hub_platform.svg)|g" "$file"
  $SED -i "s|<img src=\"images/sd_platform_hub_platform_broadcast.svg\" alt=\"Example sequence diagram of Broadcast Push from one Platform to another Platform via a Hub\" />|![Example sequence diagram of Broadcast Push from one Platform to another Platform via a Hub](./images/sd_platform_hub_platform_broadcast.svg)|g" "$file"
  $SED -i "s|<img src=\"images/sd_get_openrouting_platform.svg\" alt=\"Example sequence diagram of a open routing between platforms GET from a CPO via the Hub\" />|![Example sequence diagram of a open routing between platforms GET from a CPO via the Hub](./images/sd_get_openrouting_platform.svg)|g" "$file"
  $SED -i "s|<img src=\"images/sd_get_all_platform.svg\" alt=\"OCPI Sequence Diagram of a GET All via the Hub.\" />|![OCPI Sequence Diagram of a GET All via the Hub](./images/sd_get_all_platform.svg)|g" "$file"
  $SED -i "s|<img src=\"images/unqiue_ids_pair2pair.svg\" alt=\"Example sequence diagram of the uses of X-Request-ID and X-Correlation-ID in a peer-to-peer topology.\" />|![Example sequence diagram of the uses of X-Request-ID and X-Correlation-ID in a peer-to-peer topology.](./images/unqiue_ids_pair2pair.svg)|g" "$file"
  $SED -i "s|<img src=\"images/unqiue_ids_via_hub.svg\" alt=\"Example sequence diagram of the uses of X-Request-ID and X-Correlation-ID in a topology with a Hub.\" />|![Example sequence diagram of the uses of X-Request-ID and X-Correlation-ID in a topology with a Hub.](./images/unqiue_ids_via_hub.svg)|g" "$file"

  $SED -i -e "s|\`+|\`|gm" "$file"
  $SED -i -e "s|+\`|\`|gm" "$file"

  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  echo "" >> "$file"
}
