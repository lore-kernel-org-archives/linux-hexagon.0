From: Chen Gang <gang.chen@asianux.com>
Subject: [Suggestion] are they toolchains' issue?
Date: Fri, 01 Nov 2013 20:05:52 +0800
Message-ID: <52739920.4010905@asianux.com>
References: <527396BA.7050906@asianux.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <527396BA.7050906@asianux.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org

Hello Maintainers:

When compiling with allmodconfig for v4, an error occurs:

    CC      kernel/fork.o
  /tmp/ccTx69dj.s: Assembler messages:
  /tmp/ccTx69dj.s:7853: Error: invalid instruction `if (tstbit(r4.new,r0))jump:nt .L242'

Also when with allmodconfig (default for v2), it will cause error:

  /usr/local/bin/hexagon-ld: Relocatable linking with relocations from format elf32-littlehexagon (init/.tmp_main.o) to format elf32-littlehexagon (init/main.o) is not supported

Also when with defconfig, it will cause error:

    LD      init/mounts.o
  /usr/local/bin/hexagon-ld: Relocatable linking with relocations from format elf32-littlehexagon (init/do_mounts.o) to format elf32-littlehexagon (init/mounts.o) is not supported


Toolchain Information:

  https://www.codeaurora.org/patches/quic/hexagon/dev/
  gcc-4.4_full_111104.bz2 and gnutools_full_111104.bz2
  
  [root@gchenlinux hexagon]# hexagon-gcc -v
  Using built-in specs.
  Target: hexagon
  Configured with: ../gcc-4.4/configure --without-header --disable-nls --enable-language=c --disable-threads --disable-shared --enable-werror=no target_configargs=enable_vtable_verify=yes --target=hexagon
  Thread model: single
  gcc version 4.4.0 : Hexagon Build Version (UNKNOWN) UNKNOWN (GCC) 
  [root@gchenlinux hexagon]# hexagon-ld -v
  GNU ld (GNU Binutils) 2.20 20091016
  Hexagon Build Version X.Y.ZZ XXXXXXXXXXX_YYYY_ZZZZZ
  [root@gchenlinux hexagon]# hexagon-as -v
  GNU assembler version 2.20 (hexagon) using BFD version (GNU Binutils) 2.20 20091016
  Hexagon Build Version X.Y.ZZ XXXXXXXXXXX_YYYY_ZZZZZ


Please help check, and welcome any suggestions or completions.


Thanks.
--
Chen Gang.
