from std/json import JNull, JsonNode, getBool

import instagram/api/types/user

proc renameHook*(v: var IgPost; fieldName: var string) =
  if fieldName.len > 2 and fieldName[0..1] == "__":
    fieldName = fieldName[2..^1]
