From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 11/13] drm/i915: Clenaup PREEMPT_COUNT leftovers
Date: Mon, 14 Sep 2020 22:42:20 +0200
Message-ID: <20200914204442.098732980@linutronix.de>
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
	 bh=f/SOJ5CWk4eYwwtTstBCFeuXygvThe957j/HsSXUh5A=; b=RbslokA0rGOMFIJ+KFbMy5SHb
	GnaCTN8GDtYlbsOGwCbismkjbkjsW0095diH6wN+FDBn8GyRtSSu7m/2R5dKEHblS6l8OSAgcvbg3
	wZdr7dhZFxpaayn2wWnkkPCMvGsEiDIXYBT9QpNHyL+bLYqIZ9i/4Fo8JZhVo2lkltvsez6rQNZhV
	LYH6mijE5wtCTnAnqqwMX7VcBpFJPHerXS9IeFmK9Nn/Y76ALfYooj1Ji+iOrIsPecMRKWhl4bHEH
	DkT+ppZNj3HOMCUKzoPzUv2eZq/Vre0J+2iSpnab4DIuR/6Xhb8t+KXJAhbvAoTKkgyenLBBTylgm
	5OgX4jc8w==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1600116317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=Npom2EuTd1Uo7psEmtBh4sk2VgJVlpo8NVJUnRcKB8Y=;
 b=W4+uvZLgtQPO+glf5eld0ZiR3ISK15YAJdt6WwDfLADo+AFztlldWd6dnTxcOG/enrCJ4/
 7u32/7TCACBuN+lo9boB/TOBAm6lrW4MkZvhScrz2WB81lO817FQoWuHqGyf0TAAuP0Ksy
 bQAQSul1hAW3wOWSLEfq17ljxGNiuOhar1IwVKgwHYhek9tw/3yrLDOa9DFoBNHou7Q8sL
 Le6TVnnkHmmXl+4IiF/zt1wPOBUG50o5ppXwlIGJ70nYtKJmMdCTQo/NKnxVnjfwqRAD6b
 vnHkPQvTNh5QiYsQhxa5/jPIbzb3YqssC6+bhpF8Ptsv7cCXWCB03aLYCfb3oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1600116317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=Npom2EuTd1Uo7psEmtBh4sk2VgJVlpo8NVJUnRcKB8Y=;
 b=rmUXqBTTaScVxDZkMGFWRq5utqR7uYKuoMeo7quwxFSAzx9Kf0xGyQn88w3XHaSrv5KeED
 X25Q3ysRxDcMBzBA==
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
Cc: Juri Lelli <juri.lelli@redhat.com>, David Airlie <airlied@linux.ie>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Lai Jiangshan <jiangshanlai@gmail.com>, dri-devel@lists.freedesktop.org, Ben Segall <bsegall@google.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-hexagon@vger.kernel.org, Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-arch@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Brian Cain <bcain@codeaurora.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, Matt Turner <mattst88@gmail.com>, intel-gfx@lists.freedesktop.org, linux-xtensa@lin

CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
removed. Cleanup the leftovers before doing so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/i915/Kconfig.debug |    1 -
 drivers/gpu/drm/i915/i915_utils.h  |    3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/gpu/drm/i915/Kconfig.debug
+++ b/drivers/gpu/drm/i915/Kconfig.debug
@@ -20,7 +20,6 @@ config DRM_I915_DEBUG
 	bool "Enable additional driver debugging"
 	depends on DRM_I915
 	select DEBUG_FS
-	select PREEMPT_COUNT
 	select I2C_CHARDEV
 	select STACKDEPOT
 	select DRM_DP_AUX_CHARDEV
--- a/drivers/gpu/drm/i915/i915_utils.h
+++ b/drivers/gpu/drm/i915/i915_utils.h
@@ -337,8 +337,7 @@ wait_remaining_ms_from_jiffies(unsigned
 						   (Wmax))
 #define wait_for(COND, MS)		_wait_for((COND), (MS) * 1000, 10, 1000)
 
-/* If CONFIG_PREEMPT_COUNT is disabled, in_atomic() always reports false. */
-#if defined(CONFIG_DRM_I915_DEBUG) && defined(CONFIG_PREEMPT_COUNT)
+#ifdef CONFIG_DRM_I915_DEBUG
 # define _WAIT_FOR_ATOMIC_CHECK(ATOMIC) WARN_ON_ONCE((ATOMIC) && !in_atomic())
 #else
 # define _WAIT_FOR_ATOMIC_CHECK(ATOMIC) do { } while (0)
