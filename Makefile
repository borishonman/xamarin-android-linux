all:
	make -C xamarin-android prepare
	make -C xamarin-android jenkins

prepare:
	#get the submodule
	git submodule init
	#patch xabuild
	patch --dry-run xamarin-android/tools/scripts/xabuild xabuild.patch
	#add the mono alpha repository
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
	echo "deb http://download.mono-project.com/repo/ubuntu xenial main" | sudo tee /etc/apt/sources.list.d/mono-official.list
	echo "deb http://download.mono-project.com/repo/ubuntu alpha-xenial main" | sudo tee /etc/apt/sources.list.d/mono-official-alpha.list
	sudo apt-get update
	#install other dependencies
	sudo apt install mono-csharp-shell mono-complete nuget openjdk-8-jdk unzip zlib1g-dev
