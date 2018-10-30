From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 0/2] kgdb: Fix kgdb_roundup_cpus()
Date: Tue, 30 Oct 2018 15:18:41 -0700
Message-ID: <20181030221843.121254-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SPVTCN7yB3EvcS3VgTBTPuwRPE6icIQDbNo/cFgw8x4=;
        b=F5MtIjUSmfPSLlRLUcvlxb8bgwO944Vzlwsrb+STW1m9SKp+FbIUnhKepFgX1d/6zY
         WFEsTME5GAO3fNxqCMjL5qf9DfZtUWW/0eu+pQx31M+moNIAPuITstIM3gP6+QCFd8p4
         spMZEp8n6pfvs7QIBWD5+GLOMia4bijBqXNww=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>
Cc: kgdb-bugreport@lists.sourceforge.net, Peter Zijlstra <peterz@infradead.org>, Douglas Anderson <dianders@chromium.org>, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Paul Burton <paul.burton@mips.com>, sparclinux@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>, linux-hexagon@vger.kernel.org, x86@kernel.org, Vineet Gupta <vgupta@synopsys.com>, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Will Deacon <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>, linux-snps-arc@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Yoshinori Sato <>

This series was originally part of the series ("serial: Finish kgdb on
qcom_geni; fix many lockdep splats w/ kgdb") but it made sense to
split it up.

It's believed that dropping into kgdb should be more robust once these
patches are applied.

Changes in v2:
- Removing irq flags separated from fixing lockdep splat.
- Don't use smp_call_function (Daniel).

Douglas Anderson (2):
  kgdb: Remove irq flags from roundup
  kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()

 arch/arc/kernel/kgdb.c     | 10 ++--------
 arch/arm/kernel/kgdb.c     | 12 ------------
 arch/arm64/kernel/kgdb.c   | 12 ------------
 arch/hexagon/kernel/kgdb.c | 32 --------------------------------
 arch/mips/kernel/kgdb.c    |  9 +--------
 arch/powerpc/kernel/kgdb.c |  6 +++---
 arch/sh/kernel/kgdb.c      | 12 ------------
 arch/sparc/kernel/smp_64.c |  2 +-
 arch/x86/kernel/kgdb.c     |  9 ++-------
 include/linux/kgdb.h       | 22 ++++++++++++++--------
 kernel/debug/debug_core.c  | 38 +++++++++++++++++++++++++++++++++++++-
 11 files changed, 60 insertions(+), 104 deletions(-)

-- 
2.19.1.568.g152ad8e336-goog

