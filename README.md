# Prerequsites

Nasm for ASM compiling
Qemu for for Virtual Machine
Docker for running the compiler tools

```
brew install qemu nasm
```

## Cross Compilation

I skipped the whole cross-compiler process and instead rely on docker images provided by [dockcross project](https://hub.docker.com/u/dockcross). The make file will attempt to set this up as needed.

# Resources

This started with reading and working through [this paper](https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf)
