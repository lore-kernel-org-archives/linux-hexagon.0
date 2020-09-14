From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 09/13] ARM: Clenaup PREEMPT_COUNT leftovers
Date: Mon, 14 Sep 2020 22:42:18 +0200
Message-ID: <20200914204441.888971282@linutronix.de>
References: <20200914204209.256266093@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Subject:To:From:Date:
	Message-Id:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=I71J+tY3K7bCtkqejLsb9MPjtDrWCqj3hU6eT3s2ltA=; b=QiqdjeVBnacB6p6o2jCkzEEwj
	Iee9BxEIRU84Hdq09mLduEN0++oD+2EP9t7O1Nr6nPb5erikJvKRkVTR33KFCauB4C9AaY9nbbSHW
	eSebN41a81d+bXhwCQMmUd1gAZNk93daSON9tvsz6nbaDEKHH18cr47XKyr1AEm6Yvhe92s/iIdRd
	QLgHEYbNFJoo0z/5qpnywp/vror7hrVAFF8Gze/1ufoYYaHulGOLz3Ug/4CAjIzHeaStzNMgKe9/U
	me7X66woDxmN/7uWDaL9E5+3N7oUicdXSPGv+ZngqqOeEaUVIDfFWanJtXob9rYy3RgACzumYSorN
	B2H01Y9XA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1600116315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=8jOReEDZljlqa4dRpw6zeMP+ergwjtpRGdTwRrkKdMw=;
 b=vFnjOhcm6A5rkHvga94OSbt2wSr9aZ4/4+Gjp2chF1ha6JRKuOU3CNHmQq7Rg0ucK7RjRq
 d1D2Op6P1EtRbiw1cEqLOfkMOTw5M9OBQCUWIX2Vc7AfVnYS9V/tDPBpJkwrvrHwRdU1d7
 7DUDLh3A28EHsBiZZaaiZ4XcKkxPFqmL/FjArWA/u2rDiLgyAiFFZv/ZPgW3uVZZIF0hNt
 SO4D6rz5myLzg+OIBie1VxAn7tKs9mhq1R5tw2SsZ+K8oofgfxbHrAuKz3D8rHzFCar81p
 rprjoEA30lfX7K/ss6o941PuhINzOHmOt/SOQ4kR19H9U8YiCZtP9wbcNIoZtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1600116315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=8jOReEDZljlqa4dRpw6zeMP+ergwjtpRGdTwRrkKdMw=;
 b=JU7ChlHF+O/eQcV9Z/9GQyaR7D5Z3O57wqZXnRf3e7Ecka8E/GQOwYqD+fJd5CXXar201W
 f9H0fImrNN7UHEDQ==
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Lai Jiangshan <jiangshanlai@gmail.com>, dri-devel@lists.freedesktop.org, Ben Segall <bsegall@google.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-hexagon@vger.kernel.org, Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-arch@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Brian Cain <bcain@codeaurora.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, David Airlie <airlied@linux.ie>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, intel-gfx@lists.freedesktop.org, Matt Turner <mattst88@gmail.com>, Valentin

CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
removed. Cleanup the leftovers before doing so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/include/asm/assembler.h   |   11 -----------
 arch/arm/kernel/iwmmxt.S           |    2 --
 arch/arm/mach-ep93xx/crunch-bits.S |    2 --
 3 files changed, 15 deletions(-)

--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -212,7 +212,6 @@
 /*
  * Increment/decrement the preempt count.
  */
-#ifdef CONFIG_PREEMPT_COUNT
 	.macro	inc_preempt_count, ti, tmp
 	ldr	\tmp, [\ti, #TI_PREEMPT]	@ get preempt count
 	add	\tmp, \tmp, #1			@ increment it
@@ -229,16 +228,6 @@
 	get_thread_info \ti
 	dec_preempt_count \ti, \tmp
 	.endm
-#else
-	.macro	inc_preempt_count, ti, tmp
-	.endm
-
-	.macro	dec_preempt_count, ti, tmp
-	.endm
-
-	.macro	dec_preempt_count_ti, ti, tmp
-	.endm
-#endif
 
 #define USERL(l, x...)				\
 9999:	x;					\
--- a/arch/arm/kernel/iwmmxt.S
+++ b/arch/arm/kernel/iwmmxt.S
@@ -94,9 +94,7 @@ ENTRY(iwmmxt_task_enable)
 	mov	r2, r2				@ cpwait
 	bl	concan_save
 
-#ifdef CONFIG_PREEMPT_COUNT
 	get_thread_info r10
-#endif
 4:	dec_preempt_count r10, r3
 	ret	r9				@ normal exit from exception
 
--- a/arch/arm/mach-ep93xx/crunch-bits.S
+++ b/arch/arm/mach-ep93xx/crunch-bits.S
@@ -191,9 +191,7 @@ ENTRY(crunch_task_enable)
 	cfldr64		mvdx15, [r0, #CRUNCH_MVDX15]
 
 1:
-#ifdef CONFIG_PREEMPT_COUNT
 	get_thread_info r10
-#endif
 2:	dec_preempt_count r10, r3
 	ret	lr
