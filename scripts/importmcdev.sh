decompiledir="$workdir/Minecraft/$minecraftversion/forge"
function importLibrary {
    group=$1
    lib=$2
    prefix=$3
    shift 3
    for file in "$@"; do
        file="$prefix/$file"
        target="$workdir/Spigot/Spigot-Server/src/main/java/${file}"
        targetdir=$(dirname "$target")
        mkdir -p "${targetdir}"
        base="$workdir/Minecraft/$minecraftversion/libraries/${group}/${lib}/$file"
        if [ ! -f "$base" ]; then
            echo "Missing $base"
            exit 1
        fi
        export MODLOG="$MODLOG  Imported $file from $lib\n";
        cp "$base" "$target" || exit 1
    done
}

nonnms=$(grep -R "new file mode" -B 1 "$basedir/Spigot-Server-Patches/" | grep -v "new file mode" | grep -oE "net\/minecraft\/server\/.*.java" | grep -oE "[A-Za-z]+?.java$" --color=none | sed 's/.java//g')
########################################################
########################################################
########################################################
#                   NMS IMPORTS
# we do not need any lines added to this file for NMS
########################################################
########################################################
########################################################
#              LIBRARY IMPORTS
# These must always be mapped manually, no automatic stuff
#
#             # group    # lib          # prefix               # many files
importLibrary com.mojang datafixerupper com/mojang/datafixers \
    schemas/Schema.java \
    DataFixerUpper.java \
    NamedChoiceFinder.java \
    functions/PointFree.java \
    types/Type.java \
    types/DynamicOps.java \
    types/templates/Tag.java \
    types/templates/TaggedChoice.java \
    types/families/RecursiveTypeFamily.java

# dont forget \ at end of each line but last

########################################################
########################################################
########################################################