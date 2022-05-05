#!/bin/zsh
download_proton(){

    tag_proton=$(curl -s https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest \
		     | grep "tag_name" \
		     | awk '{print substr($2, 2, length($2) -3)}')

    data_file=~/.glorious-data.txt

    if grep -q "proton-GE $tag_proton" "$data_file"; then
	echo "latest Glorious Eggroll Proton downloaded. Praise the Egg Roll."
    else
	Proton_Location=$(echo $tag_proton | awk '{print "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/" $1 "/" $1 ".tar.gz"}')
	
	Proton_Download=$(echo $tag_proton | awk '{print $1 ".tar.gz"}')

	echo "downloading glorious eggroll Proton!"
	echo "<"$Proton_Location">"
	echo $Proton_Download

	curl -L -o ~/Downloads/$Proton_Download $Proton_Location
	tar -xzvf ~/Downloads/$Proton_Download -C ~/.steam/root/compatibilitytools.d/
	echo "proton-GE $tag_proton" >> "$data_file"
    fi
}

download_wine() {
    tag_wine=$(curl -s https://api.github.com/repos/GloriousEggroll/wine-ge-custom/releases/latest \
		   | grep "tag_name" \
		   | awk '{print substr($2, 2, length($2) -3)}')
    data_file=~/.glorious-data.txt
    
    if grep -q "wine-GE $tag_wine" "$data_file"; then
	echo "latest Glorious Eggroll Wine downloaded. Praise the Egg Roll."
    else
	Wine_Location=$(echo $tag_wine | awk '{print "https://github.com/GloriousEggroll/wine-ge-custom/releases/download/" $1 "/wine-lutris-" $1 "-x86_64.tar.xz"}')
	
	Wine_Download=$(echo $tag_wine | awk '{print "wine-lutris-" $1 "-x86_64.tar.xz"}')

	echo "downloading glorious eggroll Wine!"
	echo "<"$Wine_Location">"
	echo $Wine_Download

	curl -L -o ~/Downloads/$Wine_Download $Wine_Location
	tar -xvf ~/Downloads/$Wine_Download -C ~/.local/share/lutris/runners/wine/
	echo "wine-GE $tag_wine" >> "$data_file"
    fi    
}

help_declaration(){
    echo "Usage:"
    echo "  glorious-eggroll-downloader.zsh <OPTION> -- downloads the latest GE custom variant\n"
    echo "help options:"
    echo "  -h    Displays this help screen\n"
    echo "Options"
    echo "  -a    Downloads both wine and proton"
    echo "  -p    Downloads proton"
    echo "  -w    Downloads wine"
}

main(){
    # if [ ! -z "$1" ]
    # then
    # 	help_declaration
    # 	exit
    # fi

    hflag=
    pflag=
    wflag=
    
    while getopts ":ahpw" opt
    do
	case $opt in
	    a)
	        pflag=1
		wflag=1
		;;
	    h)
		hflag=1
		;;
	    p)
		pflag=1
		;;
	    w)
		wflag=1
		;;
	    \?)
		echo "Invalid option: -$OPTARG" >&2
		exit 1
		;;
	esac
    done



    if [ "$pflag" -eq 1 ]; then
	download_proton
    fi

    if [ "$wflag" -eq 1 ]; then
	download_wine
    fi

    if [ "$hflag" -eq 1 ]; then
	help_declaration
	exit
    fi
    shift $(($OPTIND - 1))

    exit
}

main "$@"; exit