# Hummingbird E603

**Hummingbird E603** is a free available RISC-V CPU IP core provided by
[Nuclei System Technology](https://www.nucleisys.com/), a leading RISC-V IP
and solutions company based in mainland China.

> [!IMPORTANT]
> Hummingbird E603 is **ONLY** permitted for **academic or educational**
use; commercial use is **NOT** allowed unless a commercial license is obtained from Nuclei.  
> For commercial inquiries, please contact: [contact@nucleisys.com](mailto:contact@nucleisys.com)

## Overview

The RISC-V open instruction set architecture (ISA) is rapidly gaining popularity
as a platform for education and research in computer architecture. However,
there remains a lack of high-quality processor IP cores that are both
**advanced** and **accessible** for academic use.

To bridge this gap, we present the **Nuclei Hummingbird E603**, a 64-bit RISC-V
core that is free to use for academic and non-commercial applications. It is
designed to be **user-friendly**, **extensible**, and suitable for a wide range
of teaching and research scenarios.

## Key Features

- Support **RV64IMAFDC** architecture
- Support **MMU** with Linux capable
- Support double-precision **FPU**, 32KBytes **ICache** and 32KBytes **DCache**
- **NICE** (Nuclei Instruction Co-processor Extension) –
  Supports custom instruction extensions
- **FPGA Prototyping** – Easily deployable on FPGA platforms
- **Rich Software Ecosystem** – Toolchain and SDK support for
  easy application development

## Performance

When synthesized with **TSMC 22nm** technology under worst-case conditions,
the E603 can achieve **over 1 GHz** operating frequency.

| Benchmark | Performance |
| -- | -- |
| CoreMark | 3.379 CoreMark/MHz |
| Dhrystone | 1.724 DMIPS/MHz |

## Documentation

For technical details and usage guide, please refer to the [doc](doc) directory.

## Quick Start

For RTL simulation and FPGA synthesis, please refer to the documentations in
the [doc](doc) directory.

To help you get started quickly, we provide prebuilt materials that allow you
to run the Hummingbird E603 Evaluation SoC on hardware without building everything
from scratch.

Here is a list of prebuilt materials:

```text
prebuilt
├── bitstream
│   ├── e603_ddr200t.bit        # FPGA bitstream
│   └── e603_ddr200t.mcs        # FPGA Memory Configuration System
├── boot                        # linux boot meterials for Hummingbird E603
│   ├── boot.scr
│   ├── uImage.lz4
│   └── uInitrd.lz4
└── freeloader                  # First stage bootloader for Hummingbird E603
    └── freeloader.elf
```

The prebuilt bitstream, Linux boot images, and Freeloader target a 50 MHz CPU.
FPGA builds also generate a 50 MHz bitstream by default. To build the Linux
image and Freeloader yourself, follow the [Nuclei Linux SDK Evalsoc README](https://github.com/Nuclei-Software/nuclei-linux-sdk/blob/dev_nuclei_6.6_v3_e603/conf/evalsoc/README.md).

You need to prepare a DDR200T board and a Hummingbird Debugger Kit to get started.

- [Nuclei DDR200T Evaluation Board](https://www.nucleisys.com/developboard.php#ddr200t)
- [A Hummingbird Debugger Kit](https://www.nucleisys.com/developboard.php#debuggerkit)

About how to program the Bitstream (BIT or MCS format) into the FPGA board,
please refer to the document [Nuclei RISC-V FPGA Evaluation Introduction](https://www.nucleisys.com/upload/files/fpga/doc/Nuclei_FPGA_DebugKit_Intro.pdf).

### Nuclei NICE-Wizard/Profiling

The Nuclei **NICE Wizard** and realated **profiling tools** provide essential support
for practicing custom instruction extension on the **Hummingbird E603**

The following Bilibili videos demostrate their usage in various scenarios:

- [Nuclei NICE Wizard](https://www.bilibili.com/video/BV1Df5Xz9Ei9)
- [Profiling Tools in Nuclei Studio](https://www.bilibili.com/video/BV1gf5Xz9EAw)
- [Code Coverage and Profiling - Part 1](https://www.bilibili.com/video/BV1Df5Xz9EF1)
- [Code Coverage and Profiling - Part 2](https://www.bilibili.com/video/BV1gf5Xz9ETh)

### Nuclei SDK

The `nuclei-sdk` folder in this repository contains a customized version of the
[Nuclei SDK](nuclei-sdk) tailored for the Hummingbird E603.

For usage instructions, please refer to [Quick Start with Nuclei SDK](https://doc.nucleisys.com/nuclei_sdk/quickstart.html)

### Nuclei Linux SDK

To build and run the freeloader and Linux boot images, please refer to the
dedicated [README](https://github.com/Nuclei-Software/nuclei-linux-sdk/tree/dev_nuclei_6.6_v3_e603/conf/evalsoc/README.md)
in the Nuclei Linux SDK repository.

## Also Available: Hummingbird E203

We also provide the open-source **Hummingbirdv2 E203** Core and SoC, a 32-bit RISC-V
implementation designed for microcontroller applications.

Check it out here: [riscv-mcu/e203_hbirdv2](https://github.com/riscv-mcu/e203_hbirdv2)

## WeChat Group

If you would like to join our WeChat group for discussion and support,
please scan the following QR code:

![wechat QR code](./pics/QR_code.png)
