From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v5 0/4] kgdb: Fix kgdb_roundup_cpus()
Date: Mon, 26 Nov 2018 19:51:29 -0800
Message-ID: <20181127035133.225592-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ckFwfWrXDG7mbBgtIA9ywF+G24oiGIeq/mDuQRgaBZM=;
        b=SstBiiGWzw5dBJG/3tQu6dyCWZzwOYkKa8t0/fa0w5gcDTZaE47UUcy03dPrz4/uvH
         mFYss26Ji3dfFsBbZtXM9Fkiw7fyvNZFThjXOqmer3sdiz1pAVn1Ulbd0owmzDDRP5vg
         d+8ef2cthPwUtXBypN4pDgp8cmiqJR5m56fcE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>, kgdb-bugreport@lists.sourceforge.net, Peter Zijlstra <peterz@infradead.org>, Douglas Anderson <dianders@chromium.org>, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>, linux-hexagon@vger.kernel.org, x86@kernel.org, Vineet Gupta <vgupta@synopsys.com>, Thomas Gleixner <tglx@linutronix.de>, Michal Hocko <mhocko@suse.com>, Ralf Baechle <ralf@linux-mips.org>, linux-snps-arc@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Benjamin Herrenschmidt <benh@kernel.cras>

This series was originally part of the series ("serial: Finish kgdb on
qcom_geni; fix many lockdep splats w/ kgdb") but it made sense to
split it up.

It's believed that dropping into kgdb should be more robust once these
patches are applied.

Changes in v5:
- Add a comment about get_irq_regs().
- get_cpu() => raw_smp_processor_id() in kgdb_roundup_cpus().
- for_each_cpu() => for_each_online_cpu()
- Error check smp_call_function_single_async()

Changes in v4:
- Removed smp_mb() calls.
- Also clear out .debuggerinfo.
- Also clear out .debuggerinfo and .task for the master.
- Remove clearing out in kdb_stub for offline CPUs; it's now redundant.

Changes in v3:
- No separate init call.
- Don't round up the CPU that is doing the rounding up.
- Add "#ifdef CONFIG_SMP" to match the rest of the file.
- Updated desc saying we don't solve the "failed to roundup" case.
- Document the ignored parameter.
- Don't round up a CPU that failed rounding up before new for v3.
- Don't back trace on a cpu that didn't round up new for v3.

Changes in v2:
- Removing irq flags separated from fixing lockdep splat.
- Don't use smp_call_function (Daniel).

Douglas Anderson (4):
  kgdb: Remove irq flags from roundup
  kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()
  kgdb: Don't round up a CPU that failed rounding up before
  kdb: Don't back trace on a cpu that didn't round up

 arch/arc/kernel/kgdb.c          | 10 +----
 arch/arm/kernel/kgdb.c          | 12 ------
 arch/arm64/kernel/kgdb.c        | 12 ------
 arch/hexagon/kernel/kgdb.c      | 32 ----------------
 arch/mips/kernel/kgdb.c         |  9 +----
 arch/powerpc/kernel/kgdb.c      |  6 +--
 arch/sh/kernel/kgdb.c           | 12 ------
 arch/sparc/kernel/smp_64.c      |  2 +-
 arch/x86/kernel/kgdb.c          |  9 +----
 include/linux/kgdb.h            | 22 +++++++----
 kernel/debug/debug_core.c       | 65 ++++++++++++++++++++++++++++++++-
 kernel/debug/debug_core.h       |  1 +
 kernel/debug/kdb/kdb_bt.c       | 11 +++++-
 kernel/debug/kdb/kdb_debugger.c |  7 ----
 14 files changed, 98 insertions(+), 112 deletions(-)

-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

