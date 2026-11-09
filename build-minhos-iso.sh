#!/bin/bash
set -e

WORKDIR="/build/minhos-build"
mkdir -p "$WORKDIR"
cd "$WORKDIR"

echo "=== Copy archiso releng profile (nhe, co san trong archiso) ==="
cp -r /usr/share/archiso/configs/releng ./minhos-iso
cd minhos-iso

echo "=== Doi branding: ten distro, motd, os-release ==="
# Doi ten hien thi trong iso
sed -i 's/Arch Linux/MinhOS/g' releng.profdef 2>/dev/null || true

# Doi os-release (anh huong neofetch, about system, 'cat /etc/os-release')
cat > airootfs/etc/os-release << 'OSEOF'
NAME="MinhOS"
PRETTY_NAME="Welcome MinhOS"
ID=minhos
ID_LIKE=arch
BUILD_ID=rolling
ANSI_COLOR="38;2;23;147;209"
HOME_URL="https://example.com/"
DOCUMENTATION_URL="https://example.com/"
SUPPORT_URL="https://example.com/"
BUG_REPORT_URL="https://example.com/"
LOGO=minhos-logo
OSEOF

# Doi MOTD hien thi khi login terminal
echo "Welcome MinhOS" > airootfs/etc/motd

# Doi ten trong efiboot/syslinux boot menu (man hinh chon boot, truoc ca Plymouth)
if [ -d efiboot ]; then
    grep -rl "Arch Linux" efiboot/ 2>/dev/null | while read -r file; do
        sed -i 's/Arch Linux/MinhOS/g' "$file"
        echo "Da sua: $file"
    done
fi
if [ -d syslinux ]; then
    grep -rl "Arch Linux" syslinux/ 2>/dev/null | while read -r file; do
        sed -i 's/Arch Linux/MinhOS/g' "$file"
        echo "Da sua: $file"
    done
fi

echo "=== Build ISO (profile nhe, nhanh hon desktop day du) ==="
mkarchiso -v -w /build/work -o /build/out .

echo "=== Xong ==="
ls -la /build/out/
