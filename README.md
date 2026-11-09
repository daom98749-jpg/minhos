MinhOS ISO Builder Script (build-minhos-iso.sh)

A Shell script designed to automate the process of customizing and building an ISO installation image for MinhOS, built on top of Arch Linux's archiso framework (releng profile).

📌 Key Features

Automated Workspace Setup: Configures an isolated build environment at /build/minhos-build.

Custom Branding:

Modifies distribution name in releng.profdef.

Updates system release metadata at /etc/os-release (affects neofetch, system info, etc.).

Sets up a custom terminal Message of the Day (/etc/motd).

Rebrands EFI and Syslinux boot menu entries.

Optimized ISO Build: Utilizes mkarchiso to package the ISO into /build/out.

📋 Requirements

Before executing the script, ensure that your host system (Arch Linux host or Arch-based Docker container) has the required dependencies installed:

sudo pacman -S --needed archiso bash


Note: Root privileges (sudo) are required to run this script because mkarchiso performs low-level filesystem and mount operations.

🚀 Usage Guide

1. Make the Script Executable

Grant execution permissions to the script:

chmod +x build-minhos-iso.sh


2. Run the Build Script

Execute the script with root privileges:

sudo ./build-minhos-iso.sh


3. Output Location

Once the build completes, the generated MinhOS ISO image will be stored in:

/build/out/


📁 Build Workspace Structure

Directory

Description

/build/minhos-build

Main working directory containing the custom profile.

/build/work

Temporary working directory used by mkarchiso during compilation.

/build/out

Output directory containing the final ISO image.

🛠️ Advanced Customization

If you want to customize the system further before generating the ISO:

Add/Remove Packages: Edit the packages.x86_64 file inside the profile directory before executing mkarchiso.

Custom System Files: Add files to airootfs/etc/ or other airootfs subdirectories within the script prior to the build phase.

⚠️ Troubleshooting & Cleanup

Storage Space Requirements: Ensure your disk has at least 10GB of free space available for /build.

Clean Rebuilds: If a build fails or you want to start fresh, clean the temporary workspace by running:

sudo rm -rf /build/work /build/minhos-build
