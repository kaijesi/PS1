#!/bin/bash

orgname="$1"
echo "$orgname"
if [ -z "$orgname" ] ;  then

    echo "No org name provided. Usage = ./scripts/CreateScratchOrg.sh ORGNAME"

else

    sfdx force:org:create -f config/project-scratch-def.json -a $orgname

    sfdx config:set defaultusername=$orgname

    sfdx force:source:push -u $orgname

    sfdx force:user:permset:assign -n DX_Changes -u $orgname

    sfdx force:org:open -u $orgname

    sfdx force:org:list

fi
