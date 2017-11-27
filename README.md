# xamarin-android-linux

This project contains scripts, patches, and documentation on how to set up a Xamarin.Android build system on Debian/Ubuntu

## Debian preparation steps

1. Install required packages (from a root prompt)
`apt install git make sudo`

2. Add the following line to /etc/sudoers replacing <user> with your username
`<user>  ALL=(ALL:ALL) ALL`

3. Clone the repository
`git clone https://github.com/borishonman/xamarin-android-linux.git`

4. Change to repo dir & run preparation script
`cd xamarin-android-linux && make prepare`

5. Build Xamarin.Android
`make all && make package`

6. Install the package
`sudo dpkg -i xamarin-android.deb`

