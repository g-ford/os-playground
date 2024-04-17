set -x
set -e

pushd bootloader
make build
popd

pushd src
make link
popd

cat ./bootloader/bootloader.bin ./src/kernal.bin > os-image
qemu-system-i386 os-image