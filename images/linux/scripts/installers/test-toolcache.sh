#!/bin/bash -e
################################################################################
##  File:  test-toolcache.sh
##  Desc:  Test Python and Ruby versions in tools cache
################################################################################

# Must be procecessed after tool cache setup(hosted-tool-cache.sh).

Test_Hostedtoolcache_Tool() {
   TOOL_NAME=$1
   TOOL_EXEC_TEST=$2

   if [ -d "$AGENT_TOOLSDIRECTORY/$TOOL_NAME" ]; then
      cd $AGENT_TOOLSDIRECTORY/$TOOL_NAME

      tool_dirs=($(find . -mindepth 1 -maxdepth 1 -type d | sed "s|^\./||"))

      echo "--------------------------------------------"
      echo "$TOOL_NAME versions folders: ${tool_dirs[@]}"
      echo "--------------------------------------------"

      if [ -n "$tool_dirs" ]; then
         tool_key=$(echo $TOOL_NAME | tr "[:upper:]" "[:lower:]")
         package_versions=($(jq -r ".[\"${TOOLCACHE_KEY_VALUE[$tool_key]}\"] | .[]" "$INSTALLER_SCRIPT_FOLDER/toolcache.json"))

         for tool_version in ${package_versions[@]}
         do
            version_dir=$(find . -name "$tool_version.*" -print -quit)

            echo "Test $AGENT_TOOLSDIRECTORY/$TOOL_NAME/$version_dir:"

            actual_version=$(eval $AGENT_TOOLSDIRECTORY/$TOOL_NAME/$version_dir/$TOOL_EXEC_TEST)

            if [ "$actual_version" = "$tool_version" ]; then
                  echo "Passed!"
            else
                  echo "Expected: $tool_version; Actual: $actual_version"

                  exit 1
            fi
         done;
      else
         echo "$AGENT_TOOLSDIRECTORY/$tool_version does not include any folders"

         exit 1
      fi
   else
      echo "$AGENT_TOOLSDIRECTORY/$tool_version does not exist"

      exit 1
   fi
}

# define dictionary for key_alias and its values
declare -A TOOLCACHE_KEY_VALUE

package_list=($(jq -r 'keys | .[]' "$INSTALLER_SCRIPT_FOLDER/toolcache.json"))

for package_name in ${package_list[@]}; do
   # get key alias
   key_alias=$(echo $package_name | cut -f2 -d-)

   # set dictionary
   TOOLCACHE_KEY_VALUE+=(["$key_alias"]="$package_name")
done;

AGENT_TOOLSDIRECTORY=/opt/hostedtoolcache

Test_Hostedtoolcache_Tool "Ruby" "x64/bin/ruby -e 'puts RUBY_VERSION' | egrep -o '[0-9]+\.[0-9]+'"
