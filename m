From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: [PATCH] arch: hexagon: include: asm: add "vga.h" in Kbuild
Date: Tue, 19 Nov 2013 13:17:21 +0800
Message-ID: <528AF461.4020502@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=8kk2tf1U31p8vRw9mmVN4zin343dSRMCjVcVWcNRvtg=;
        b=OiaQHckLA5Xrg1FUF47+2SryT6H1uCOxT3cxnFAdvEa8fmapalZMKidd2r5DIXcqtX
         7oiOtIXvXTifnxcVe96Id0CjuWR2Omc2wDj/4rt8CCyetX2n/Fd9m9tepfv3/wd6s55V
         hNy80ZqbXXSI4oomBC3/0S0Od6inHIlj9ePb2k/m4lyKfCKzRCCEv5hJn9l2tpq+MXhH
         QsgJJYb9FZqmgUVi/lohXneu7iI3aqmBP3GAGeaKsS1RU2CnGY6sgQgtWa7aJ5kQqaju
         j/nIj/sjkk8+qW9K3Fj7DiJL/t3tN7gegcyJMalzWdz91GfD5pcCaQ6HtMZUm7ckqUEw
         LKIQ==
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-hexagon@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Need include generic "vga.h", or can not pass compiling with
allmodconfig, the related error:

    CC [M]  drivers/gpu/drm/drm_irq.o
  In file included from include/linux/vgaarb.h:34:0,
                   from drivers/gpu/drm/drm_irq.c:42:
  include/video/vga.h:22:21: fatal error: asm/vga.h: No such file or directory

Also move "preempt.h" upper to match sort order.


Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 arch/hexagon/include/asm/Kbuild |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index 67c3450..424e28e 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -31,6 +31,7 @@ generic-y += pci.h
 generic-y += percpu.h
 generic-y += poll.h
 generic-y += posix_types.h
+generic-y += preempt.h
 generic-y += resource.h
 generic-y += rwsem.h
 generic-y += scatterlist.h
@@ -52,5 +53,5 @@ generic-y += trace_clock.h
 generic-y += types.h
 generic-y += ucontext.h
 generic-y += unaligned.h
+generic-y += vga.h
 generic-y += xor.h
-generic-y += preempt.h
-- 
1.7.7.6
