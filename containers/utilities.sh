#!/usr/bin/env bash

# Usage: increment_version <version> [<position>]
increment_version ()
{
  declare -a part=( ${1//\./ } )
  declare    new
  declare -i carry=1

  for (( CNTR=${#part[@]}-1; CNTR>=0; CNTR-=1 )); do
    len=${#part[CNTR]}
    new=$((part[CNTR]+carry))
    [ ${#new} -gt $len ] && carry=1 || carry=0
    [ $CNTR -gt 0 ] && part[CNTR]=${new: -len} || part[CNTR]=${new}
  done
  new="${part[*]}"
  echo -e "${new// /.}"
}

get_docker_image_version()
{
  if [[ -z "$1" ]]
   then
     echo "-Parameter #1 is zero length.-"
     return
   else
     echo "-Parameter #1 is \"$1\".-"
   fi

    VERSION=`docker run -v $(pwd):/usr/src/app \
                    -w /usr/src/app \
                    maven:3.6.0-jdk-8-alpine mvn org.apache.maven.plugins:maven-help-plugin:3.1.0:evaluate -Dexpression=project.version \
                                                                                                           -q \
                                                                                                          -DforceStdout`
    echo "Current image version : $VERSION"
    return ${VERSION};
}