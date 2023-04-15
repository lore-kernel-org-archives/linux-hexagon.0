From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Subject: [PATCH 0/7] Expect immutable pointer in virt_to_phys/isa_virt_to_bus
 prototypes
Date: Sat, 15 Apr 2023 04:17:19 -0700
Message-ID: <168155718437.13678.714141668943813263.stgit@skinsburskii.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ia64-owner@vger.kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2EDFA21C33DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1682617312;
        bh=tQBmtbcpqnp+RILjBR0oqwhW0pMzwxDvx3m4tXPmSeg=;
        h=Subject:From:Cc:Date:From;
        b=koFTR0U8zfUvb5Uc+C+Hbp/AJH8F6PVoyRgqvwqagczF7i9s34sgxAtQuetm20+XS
         5Qm+28Pt+pSiCHLtISTWzADXqXkirskMRFVFEdzGl5W3ecGwC3+rdF73jW6Ou0nhTs
         O5MdjQWqF4ihM7lRjxSdq9BjhqMcNktql7ZPF+I0=
List-ID: <linux-hexagon.vger.kernel.org>
To: 
Cc: Matt Turner <mattst88@gmail.com>, x86@kernel.org, Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>, Borislav Petkov <bp@alien8.de>, linux-ia64@vger.kernel.org, Mark Brown <broonie@kernel.org>, Richard Henderson <richard.henderson@linaro.org>, linux-kernel@vger.kernel.org, Brian Cain <bcain@quicinc.com>, linux-mips@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Linus Walleij <linus.walleij@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Bjorn Helgaas <bhelgaas@google.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>, Omar Sandoval <osandov@fb.com>, Helge Deller <deller@gmx.de>, linuxppc-dev@lists.ozla

This series is aimed to address compilation warnings when a constant pointer
is passed to virt_to_phys and isa_virt_to_bus functions:

  warning: passing argument 1 of ‘virt_to_phys’ discards ‘const’ qualifier from pointer target type
  warning: passing argument 1 of ‘isa_virt_to_bus’ discards ‘const’ qualifier from pointer target type

The change(s) is the same for all architectures, but it's split into a series on
per-arch basis to simplify applying and testing on the maintainers side.

The following series implements...

---

Stanislav Kinsburskii (7):
      x86: asm/io.h: Expect immutable pointer in virt_to_phys/isa_virt_to_bus prototypes
      alpha: asm/io.h: Expect immutable pointer in virt_to_phys/isa_virt_to_bus prototypes
      mips: asm/io.h: Expect immutable pointer in isa_virt_to_bus prototype
      hexagon: asm/io.h: Expect immutable pointer in virt_to_phys prototype
      ia64: asm/io.h: Expect immutable pointer in virt_to_phys prototype
      powerpc: asm/io.h: Expect immutable pointer in virt_to_phys prototype
      asm-generic/io.h: Expect immutable pointer in virt_to_phys


 arch/alpha/include/asm/io.h   |    6 +++---
 arch/hexagon/include/asm/io.h |    2 +-
 arch/ia64/include/asm/io.h    |    2 +-
 arch/mips/include/asm/io.h    |    2 +-
 arch/powerpc/include/asm/io.h |    2 +-
 arch/x86/include/asm/io.h     |    4 ++--
 include/asm-generic/io.h      |    2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)


