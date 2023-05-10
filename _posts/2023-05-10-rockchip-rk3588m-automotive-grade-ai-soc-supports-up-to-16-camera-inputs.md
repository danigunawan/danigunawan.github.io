---
layout: post
title: Rockchip RK3588M automotive-grade AI SoC dengan kualitas tinggi yang mendukung hingga 16 input kamera
modified: 2023-05-10T17:00:28+07:00
categories:
description: "Rockchip RK3588M automotive-grade AI SoC dengan kualitas tinggi yang mendukung hingga 16 input kamera"
tags: [cython, python, c++]
image:
  background: triangular.png
comments: true
share: true
date: 2023-05-10T17:00:28+07:00
---

![Rockchip-RK3588M](/images/2023/Rockchip-RK3588M-2.png)

Rockchip RK3588M adalah varian otomotif dari Rockchip RK3588, sebuah SoC Cortex-A76/A55 octa-core yang mendukung setidaknya 6 tampilan Full HD dan 16 input kamera, serta dapat menjalankan secara simultan dashboard mobil, hiburan di dalam kendaraan, cermin belakang digital, monitor sandaran kepala, sistem ADAS, dan lain-lain.

Frekuensi inti Cortex-A76 dibatasi hingga 2.1 GHz, dan inti Cortex-A55 hingga 1.7 GHz, berbeda dengan RK3588 yang memiliki frekuensi 2.4 dan 1.8 GHz, mungkin untuk beroperasi dalam rentang suhu yang lebih luas yang dibutuhkan oleh pasar otomotif. Saat ini saya belum menemukan lembar data RK3588M, namun kita dapat menemukan lebih banyak detail melalui papan utama otomotif Firefly AIO-3588MQ yang dibangun di sekitar prosesor RK3588M.

Rockchip RK3588M adalah SBC otomotif (Single Board Computer).

![Rockchip-RK3588M](/images/2023/Rockchip-RK3588M-sbc.png)


Firefly AIO-3588MQ specifications:

    SoC – Rockchip RK3588M octa-core processor with
        CPU 4x Cortex-A76 cores @ up to 2.1 GHz, 4x Cortex-A55 cores @ up to 1.7 GHz
        Arm Mali-G610 MP4 GPU with OpenGL ES 3.2, OpenCL 2.2, Vulkan 1.1 support
        6 TOPS AI accelerator
        Video decoding:
            8Kp60 H.265/VP9/AVS2
             8Kp30 H.264 AVC/MVC
             4Kp60 AV1
            1080p60 MPEG-2/-1/VC-1/VP8
        Video encoding – 8Kp30 H.265 / H.264
        Up to 32-channel 1080p30 decoding and 16-channel 1080p30 encoding can be achieved.
    System Memory – 4GB, 8GB, or 16GB (Up to 32GB optional) 64-bit LPDDR4/LPDDR4x/LPDDR5
    Storage – M.2 SATA3.0 SSD (2242), microSD card slot
    Video Output
        HDMI 2.1 up to 8Kp60 or 4Kp120
        DisplayPort 1.4 up to 8Kp30fps (via USB-C)
        VGA up to 1080p60
        eDP1.3 connector up to 4Kp60Hz
        2x MIPI DSI display interfaces up to 4Kp60
        Up to 6 independent displays
    Video Input
        Dual 16M ISP on RK3588M
        HDMI input up to 4Kp60 with support for HDCP 2.3
        30-pin MIPI-CSI(0) connector configurable as 1x 4-lane or 2x 2-lane
        Board-to-board connector with 4-lane MIPI_CSI(1) or 2x 2-lane MIPI-CSI(1) + 2x MIPI_D/C (4-lane DPHY v2.0 or 3-lane CPHY V1.1)
    Audio
        3.5mm audio jack
        Digital audio output via HDMI 2.1 and DP 1.4 ports
        Line-in via header
        Microphone input
    Networking
        2x Gigabit Ethernet RJ45 ports
        2.4GHz/5GHz dual-band WiFi 6 (802.11a/b/g/n/ac/ax), Bluetooth 5.0
        Optional 4G LTE/5G cellular
    USB – 4x USB 3.1 Gen1, 1x USB Type-C (OTG/DP1.4) port, and 3x USB 2.0 (via pin header)
    Serial – 2x RS232, RS485, CAN Bus
    Expansion
        4-lane PCIe 3.0 slot
        mPCIe and M.2 sockets for wireless modules
        20-pin 2mm-pitch header with GPIO, ADC, SPI, I2C, LED, REV, PWR, RST
    Power Supply – 12V DC / 2A recommended via 5.5/2.1mm DC jack or 4-pin header
    Power Consumption
        Idle – About 0.72W (12V/60mA)
        Typical – About 2.4W(12V/200mA)
        Max – About 14.4W(12V/1200mA)
    Dimensions – 146 x 102 x 37.5mm
    Weight – Around 200 grams
    Temperature Range – Operating: -40°C to 85°C in product page but -20°C to 60°C in the board’s datasheet
    Humidity – 10%～80 % (storage)

![Rockchip-RK3588M](/images/2023/Rockchip-RK3588M-sbc-board.png)

Perusahaan ini menyediakan dukungan untuk Android 12.0, Ubuntu Desktop dan Server, Debian 11, dan buildroot RTLinux untuk papan // sistem-on-module. Firefly juga menyebutkan dukungan Kernel-based Virtual Machine (KVM) dan Docker container, karena akan diperlukan untuk mendukung bagian-bagian perangkat lunak yang kritis (misalnya, dashboard) dan non-kritis (misalnya, infotainment) dengan sistem operasi terisolasi yang mungkin berbeda. Dokumentasi teknis dapat ditemukan di Wiki (https://wiki.t-firefly.com/en/iCore-3588MQ/started.html) untuk memulai dengan Android, Linux, dan RTLinux.

Pertama kali saya mengetahui tentang RK3588M adalah dalam sebuah demo pada bulan Februari lalu di RKDC (Rockchip Developer Conference), yang menunjukkan sistem yang mengoperasikan empat tampilan independen dan dua gamepad.