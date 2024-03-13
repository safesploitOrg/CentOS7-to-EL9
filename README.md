# CentOS7-to-EL9
Upgrade CentOS 7 systems to Enterprise Linux 9 (EL9)


## Check CPU Compatibility

Upgrading from CentOS 7 to EL9 requires ensuring that the underlying hardware supports the necessary CPU features. Particularly x86-64-v2 architecture support.

### How it Works

The script reads the `/proc/cpuinfo` file to detect the CPU features of the system.

### Usage

```bash
chmod +x check_cpu.sh
./check_cpu.sh
```
