#!/usr/bin/env bash

function pre_introduction(){
  file="$ROOT/ocpi/introduction.asciidoc"

  gsed -i 's|EV Box|https://evbox.com[EV Box]|g' "$file"
  gsed -i 's|New Motion|https://newmotion.com[New Motion]|g' "$file"
  gsed -i 's|ElaadNL|https://elaad.nl[ElaadNL]|g' "$file"
  gsed -i 's|GreenFlux|https://greenflux.com[GreenFlux]|g' "$file"
  gsed -i 's|Last Mile Solutions|https://lastmilesolutions.com[Last Mile Solutions]|g' "$file"
  gsed -i 's|Plugsurfing|https://plugsurfing.com[Plugsurfing]|g' "$file"
  gsed -i 's|Next Charge|https://nextcharge.app[Next Charge]|g' "$file"
  gsed -i 's|Freshmile|https://freshmile.com[Freshmile]|g' "$file"
  gsed -i 's|E55C|https://e55c.com[E55C]|g' "$file"
  gsed -i 's|GIREVE|https://gireve.com[GIREVE]|g' "$file"
  gsed -i 's|ihomer|https://ihomer.nl[ihomer]|g' "$file"
  gsed -i 's|Rexel,|https://www.rexel.com[Rexel]\,|g' "$file"
  gsed -i 's|Stromnetz Hamburg|https://www.stromnetz-hamburg.de[Stromnetz Hamburg]|g' "$file"
  gsed -i 's|Enervalis|https://enervalis.com[Enervalis]|g' "$file"
  gsed -i 's|Place to plug|https://placetoplug.com[Place to plug]|g' "$file"
  gsed -i 's|Ecomovement|https://www.eco-movement.com[Ecomovement]|g' "$file"
  gsed -i 's|Allego|https://www.allego.eu[Allego]|g' "$file"
  gsed -i 's|ENIO|https://www.enio-management.com[ENIO]|g' "$file"

}

function fix_introduction() {
  file="$ROOT/docs/01-introduction.md"
  tempfile="$file.tmp"

  echo -e "---\nsidebar_position: 1\nslug: /\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"
  gsed -i -z 's/\n\n  - /\n  \* /gm' "$file"
  gsed -i -z 's/\n\n- /\n* /gm' "$file"
  gsed -i 's/^#\([^:]*\):$/#\1/' "$file"
  gsed -i 's/[[:blank:]]*$//' "$file"              # Delete Trailspace

  gsed -i 's/### Changes\/New functionality/### Changes\/New functionality\n/' "$file"
  gsed -i 's/\* A good/\n\* A good /' "$file"
    
  gsed -i 's/\*\*OCPI is developed with support of:\*\*/### OCPI is developed with support of/g' "$file"

  gsed -i 's/<figure>//gm' "$file"
  gsed -i 's/<\/figure>//gm' "$file"
  
  gsed -i "s|<img src=\"images/evroamingeu_logo.png\" alt=\"evRoaming4EU logo\" />|![evRoaming4EU logo](./images/evroamingeu_logo.png)|g" "$file"
  gsed -i "s|<img src=\"images/eciss_logo.png\" alt=\"ECISS logo\" />|![ECISS logo](./images/eciss_logo.png)|g" "$file"
  
  gsed -i 's|<https://github.com/ocpi/ocpi>|[OCPI Github Repository](https://github.com/ocpi/ocpi)|g' "$file"
  gsed -i '/^$/N;/\n$/D' "$file"
  gsed -i "s/’/'/gm" "$file"

}

function webFormat_introduction(){
  file="$ROOT/docs/01-introduction.md"
  tempfile="$file.tmp"

  gsed -i -z "s/For more information on detailed changes see \[changelog\](https:\/\/ocpi\.dev)\.\n\n//gm" "$file"

}