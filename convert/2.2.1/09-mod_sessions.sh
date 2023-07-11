#!/usr/bin/env bash

function pre_mod_sessions(){
  file="$ROOT/ocpi/mod_sessions.asciidoc"
  gsed -i 's|+$||gm' "$file"
}

function fix_mod_sessions() {
  file="$ROOT/website/docs/09-mod_sessions.md"
  tempfile="$file.tmp"

  echo -e "---\nsidebar_position: 9\nslug: sessions\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  gsed -i -e "s|^\# \*Sessions\* module|# Sessions module|gm" "$file"
  gsed -i    "s|^\*\*Module Identifier: \`sessions\`\*\*|\:\:\:tip Module Identifier\nsessions\n\:\:\:|gm" "$file"
  gsed -i    "s|^\*\*Data owner: \`CPO\`\*\*|\:\:\:caution Data owner\nCPO\n\:\:\:|gm" "$file"
  gsed -i    "s|\*\*Type:\*\* Functional Module|\:\:\:info Type\nFunctional Module\n\:\:\:|gm" "$file"
  gsed -i    "s/’/'/gm" "$file"

  gsed -i -z "s|\`\n\n\`+|\`\n* \`|gm" "$file"
  gsed -i -e "s|+\`|\`|gm" "$file"
  gsed -i -z "s|\`+|* \`|gm" "$file"

  gsed -i -z "s/<div class=\"note\">\n/\:\:\:note\n/gm" "$file"
  gsed -i -z "s|\n</div>|\n\:\:\:|gm" "$file"

  gsed -i    "s|^======|#####|gm" "$file"
  gsed -i 's|^- |* |gm' "$file"

  gsed -i -z "s|\`\`\` json\nPATCH https://www.server.com/ocpi/cpo/2.2.1/sessions/NL/TNM/101\n\n|Example Request:\n\n\`\`\`shell\ncurl --request PUT --header \"Authorization: Token <OCPI_TOKEN>\" \"https://www.server.com/ocpi/cpo/2.2.1/sessions/NL/TNM/101\"\n\`\`\`\n\nExample Response:\n\n\`\`\`json\n|gm" "$file"

  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  echo "" >> "$file"
}
