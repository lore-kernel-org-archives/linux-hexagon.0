From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v3 0/4] kgdb: Fix kgdb_roundup_cpus()
Date: Tue,  6 Nov 2018 17:00:24 -0800
Message-ID: <20181107010028.184543-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AdAdeS4sZQ8YU1vAJNV5eR8xeGN1ehQuodDt1kCsI6A=;
        b=W7j4p7n6cVnICxU3fNbrsRLIna/24le2c2DHgzKLMFf5CQnUYOE2mZUtt2Rw7cFgi6
         K1v0NjXfenWwuPfGX4TL/6/Henxpcn35IpbF7yXLn6/NLFzfnwdGwXNL7gL4KSJTVfu4
         3gwDRe5HZSKr3bULeqf4DdS9aSwrikmCeHVEY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>
Cc: kgdb-bugreport@lists.sourceforge.net, Peter Zijlstra <peterz@infradead.org>, Douglas Anderson <dianders@chromium.org>, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>, linux-hexagon@vger.kernel.org, x86@kernel.org, Vineet Gupta <vgupta@synopsys.com>, Thomas Gleixner <tglx@linutronix.de>, Michal Hocko <mhocko@suse.com>, Ralf Baechle <ralf@linux-mips.org>, linux-snps-arc@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon>

This series was originally part of the series ("serial: Finish kgdb on
qcom_geni; fix many lockdep splats w/ kgdb") but it made sense to
split it up.

It's believed that dropping into kgdb should be more robust once these
patches are applied.

Changes in v3:
- No separate init call.
- Don't round up the CPU that is doing the rounding up.
- Add "#ifdef CONFIG_SMP" to match the rest of the file.
- Updated desc saying we don't solve the "failed to roundup" case.
- Document the ignored parameter.
- Patch #3 and #4 are new.

Changes in v2:
- Removing irq flags separated from fixing lockdep splat.
- Removing irq flags separated from fixing lockdep splat.
- Don't use smp_call_function (Daniel).

Douglas Anderson (4):
  kgdb: Remove irq flags from roundup
  kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()
  kgdb: Don't round up a CPU that failed rounding up before
  kdb: Don't back trace on a cpu that didn't round up

 arch/arc/kernel/kgdb.c     | 10 ++-----
 arch/arm/kernel/kgdb.c     | 12 ---------
 arch/arm64/kernel/kgdb.c   | 12 ---------
 arch/hexagon/kernel/kgdb.c | 32 ----------------------
 arch/mips/kernel/kgdb.c    |  9 +------
 arch/powerpc/kernel/kgdb.c |  6 ++---
 arch/sh/kernel/kgdb.c      | 12 ---------
 arch/sparc/kernel/smp_64.c |  2 +-
 arch/x86/kernel/kgdb.c     |  9 ++-----
 include/linux/kgdb.h       | 22 +++++++++------
 kernel/debug/debug_core.c  | 55 +++++++++++++++++++++++++++++++++++++-
 kernel/debug/debug_core.h  |  1 +
 kernel/debug/kdb/kdb_bt.c  | 11 +++++++-
 13 files changed, 88 insertions(+), 105 deletions(-)

-- 
2.19.1.930.g4563a0d9d0-goog

