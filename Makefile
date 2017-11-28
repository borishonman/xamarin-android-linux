PKG := xamarin-android.deb

all:
	cd xamarin-android
	make prepare
	make jenkins
	rm -r external samples tests tools bin/Debug
	cd ..
	#patch xabuild
	patch --silent xamarin-android/tools/scripts/xabuild xabuild.patch
	#patch Configuration.props
	patch --silent xamarin-android/Configuration.props config.props.patch

.SILENT:
package:
	echo "Copying build files to package dir..."
	rm -rf deb/opt
	mkdir -p deb/opt/xamarin.android
	cp -r xamarin-android/* deb/opt/xamarin.android
	echo "Building package $(PKG)..."
	dpkg-deb --build deb
	mv deb.deb $(PKG)

prepare:
	#get the submodule
	git submodule init
	git submodule update
	#get java.interop - at the time of writing this fails to clone when
	#xamarin-android is run with make prepare
	#NOT APPLICABLE - after fixing working directory problem
	#git clone https://github.com/xamarin/java.interop.git xamarin-android/external/Java.Interop
	#add the mono alpha repository
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
	echo "deb http://download.mono-project.com/repo/ubuntu xenial main" | sudo tee /etc/apt/sources.list.d/mono-official.list
	echo "deb http://download.mono-project.com/repo/ubuntu alpha-xenial main" | sudo tee /etc/apt/sources.list.d/mono-official-alpha.list
	sudo apt-get update
	#install other dependencies
	sudo apt install mono-csharp-shell mono-complete nuget openjdk-8-jdk zip unzip zlib1g-dev dirmngr gcc g++ autoconf cmake libzip4
