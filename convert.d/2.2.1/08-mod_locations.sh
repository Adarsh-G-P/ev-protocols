#!/usr/bin/env bash

function pre_mod_locations(){
  file="$ROOT/ocpi/mod_locations.asciidoc"
  gsed -i 's|+$||gm' "$file"

  gsed -i '/^.Location class diagram$/d' "$file"
  gsed -i '/^.Diagram showing a representation of the example 24\/7 open with exception closing.$/d' "$file"
  gsed -i '/^.Diagram showing a representation of the example Opening Hours with exceptional closing$/d' "$file"
  gsed -i '/^.Diagram showing a representation of the example Opening Hours with exceptional opening.$/d' "$file"
  gsed -i -z 's/schedule applies.\n\n/schedule applies.\n\n\[options="header"\]\n/' "$file"
  gsed -i -z 's/\[\[evse_delete_with_status_update\]\]/\[\[evse_delete_with_status_update\]\]\n==== Delete with status update/' "$file"

}

function fix_mod_locations() {
  file="$ROOT/website/docs/ocpi/08-mod_locations.md"
  tempfile="$file.tmp"

  echo -e "---\nid: locations\nslug: modules/locations\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"
  
  gsed -i -e "s|^\# \*Locations\* module|# Locations|gm" "$file"
  gsed -i    "s|^\*\*Module Identifier: \`locations\`\*\*|\:\:\:tip Module Identifier\nlocations\n\:\:\:|gm" "$file"
  gsed -i    "s|^\*\*Data owner: \`CPO\`\*\*|\:\:\:caution Data owner\nCPO\n\:\:\:|gm" "$file"
  gsed -i    "s|\*\*Type:\*\* Functional Module|\:\:\:info Type\nFunctional Module\n\:\:\:|gm" "$file"
  gsed -i    "s|^======|#####|gm" "$file"
  gsed -i -z "s|- |* |gm" "$file"

  gsed -i    "s/’/'/gm" "$file"
  gsed -i -z "s|\n\*\s|\* |gm" "$file"
  gsed -i -z "s|:\n\*\s|:\n\n\* |gm" "$file"

  gsed -i -z "s|<span class=\"line-through\">|~~|gm" "$file"
  gsed -i -z "s|</span>|~~|gm" "$file"

  gsed -i -z "s|\`-\`|-|gm" "$file"

  gsed -i -z "s|\`\n\n\`+|\`\n* \`|gm" "$file"
  gsed -i -e "s|+\`|\`|gm" "$file"
  gsed -i -z "s|\`+|* \`|gm" "$file"
  
  gsed -i -e "s|^\* \`publish\` =|\n\* \`publish\` =|gm" "$file"
  
  gsed -i    "/Choice: one of three/d" "$file"
  gsed -i    "s|\\\> ||gm" "$file"
  
  gsed -i    "s|The response contains the requested object.|The response contains the requested object.\n\nChoice: one of three|gm" "$file"

  gsed -i    "s|<img src=\"images/locations-class-diagram.svg\" alt=\"Location class diagram\" />|![Location class diagram](../../images/locations-class-diagram.svg)|g" "$file"
  gsed -i    "s|<img src=\"images/location_hours_247_open_exception_closing.svg\" alt=\"24/7 open with exception closing.\" />|![24/7 open with exception closing.](../../images/location_hours_247_open_exception_closing.svg)|g" "$file"
  gsed -i -z "s|<img src=\"images/location_hours_opening_hours_with_exceptional_closing.svg\"\nalt=\"Opening Hours with exceptional closing.\" />|![Opening Hours with exceptional closing.](../../images/location_hours_opening_hours_with_exceptional_closing.svg)|g" "$file"
  gsed -i -z "s|<img src=\"images/location_hours_opening_hours_with_exceptional_opening.svg\"\nalt=\"Opening Hours with exceptional opening.\" />|![Opening Hours with exceptional opening.](../../images/location_hours_opening_hours_with_exceptional_opening.svg)|g" "$file"

  gsed -i    "s|^##### Simple:$|##### Simple|gm" "$file"
  gsed -i    "s|^##### Tariff energy provider name:$|##### Tariff energy provider name|gm" "$file"
  gsed -i    "s|^##### Complete:$|##### Complete|gm" "$file"
  gsed -i    "s|^#### Example: 24/7 open with exceptional closing.$|#### Example: 24/7 open with exceptional closing|gm" "$file"
  gsed -i    "s|^#### Example: Opening Hours with exceptional closing.$|#### Example: Opening Hours with exceptional closing|gm" "$file"
  gsed -i    "s|^#### Example: Opening Hours with exceptional opening.$|#### Example: Opening Hours with exceptional opening|gm" "$file"

  gsed -i "s|\[requirement that EVSEs are never deleted\](https\://ocpi\.dev)|requirement that EVSEs are never deleted|gm" "$file"

  gsed -i -e 's|":" Regex:.*|":" Regex: [Regex Test](https://regex101.com/r/xaMwu6/1) \||gm' "$file" ## Change because for some bizzare reason, I cant render properly code inside of a Markdown Table, I have to find a solution for this

  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  echo "" >> "$file"

}

function flavored_mod_locations() {
  file="$ROOT/website/docs/ocpi/08-mod_locations.md"
  tempfile="$file.tmp"
  echo "$file EV-protocols flavored"
  MODULE="03-locations"
  splitInH2 "$file"

  rm -rf "$ROOT/website/docs/ocpi/06-modules/03-locations"
  mkdir -p "$ROOT/website/docs/ocpi/06-modules/03-locations"

  # reserved
  # mv "$ROOT/tmp/usecases.md"                "$ROOT/website/docs/ocpi/06-modules/$MODULE/03-use-cases.md"
  mv "$ROOT/tmp/flowandlifecycle.md"        "$ROOT/website/docs/ocpi/06-modules/$MODULE/04-flow-and-lifecycle.md"
  mv "$ROOT/tmp/interfacesandendpoints.md"  "$ROOT/website/docs/ocpi/06-modules/$MODULE/05-interfaces-and-endpoints.md"
  mv "$ROOT/tmp/objectdescription.md"       "$ROOT/website/docs/ocpi/06-modules/$MODULE/06-object-description.md"
  mv "$ROOT/tmp/datatypes.md"               "$ROOT/website/docs/ocpi/06-modules/$MODULE/07-data-types.md"

  < "$file" gsed -n '1,/## Flow and Lifecycle/p' > "$ROOT/website/docs/ocpi/06-modules/$MODULE/01-intro.md"

  file="$ROOT/website/docs/ocpi/06-modules/$MODULE/01-intro.md"
  echo "flavoring $file"
  gsed -i '1,4d' "$file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: intro
slug: /ocpi/modules/locations
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i '/## Flow and Lifecycle/d' "$file"
  gsed -i '/^[[:space:]]*$/{N; /^\n\n$/d}' "$file"
  gsed -i -e :a -e '/^\n*$/{$d;N;ba' -e '}' -e 'P;D' "$file"

  file="$ROOT/website/docs/ocpi/06-modules/$MODULE/04-flow-and-lifecycle.md"
  echo "flavoring $file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: flow-and-lifecycle
slug: locations/flow-and-lifecycle
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"

  file="$ROOT/website/docs/ocpi/06-modules/$MODULE/05-interfaces-and-endpoints.md"
  echo "flavoring $file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: interfaces-and-endpoints
slug: locations/interfaces-and-endpoints
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  gsed -i "s/^#### /### /gm" "$file"
  gsed -i "s/^##### /#### /gm" "$file"

  file="$ROOT/website/docs/ocpi/06-modules/$MODULE/06-object-description.md"
  echo "flavoring $file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: object-description
slug: locations/object-description
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  gsed -i "s/^#### /### /gm" "$file"
  gsed -i '/^$/N;/^\n$/D' "$file"
  gsed -i -e :a -e '/^\n*$/{$d;N;ba' -e '}' -e 'P;D' "$file"
  
  file="$ROOT/website/docs/ocpi/06-modules/$MODULE/07-data-types.md"
  echo "flavoring $file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: data-types
slug: locations/data-types
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  gsed -i "s/^#### /### /gm" "$file"
  gsed -i "s/^##### /#### /gm" "$file"
  gsed -i '/^$/N;/^\n$/D' "$file"

  rm -rf "$ROOT/website/docs/ocpi/08-mod_locations.md"
}