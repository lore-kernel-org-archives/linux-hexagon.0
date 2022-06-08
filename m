From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 26/36] cpuidle,sched: Remove annotations from TIF_{POLLING_NRFLAG,NEED_RESCHED}
Date: Wed, 08 Jun 2022 16:27:49 +0200
Message-ID: <20220608144517.570101266@infradead.org>
References: <20220608142723.103523089@infradead.org>
Mime-Version: 1.0
Return-path: <linux-acpi-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=o5HILV8lXWZVR34kQkfXu7ELtM3PHvDf12JWqGFz8as=; b=IHv5dA5xONKsf6YvlQ/r5zZAXC
        z8+ORB0iuI9NP+6CPk0aEmrUBqk0vF+4sxBwbSZMsZ/NC3S3ZS38ZU9G35HcA+0UaCrG/E9E2EDya
        UReQc8yVMX9pQI9jRJz7p1XHl/kZg0b9sz5G4w60p8kG48dZM3JHI9u9B3cwEc9mWpdE1irkTHwHv
        vFAuUWNdgGncaOHJ29M9zRZ7mTLIHItHgHZTBRk/yw0+J5vvdVaXpILAqvpeL4ZG4iFIXkLeni8oT
        hj5R5Sb8cBmHtO4CcW0rlPwzsaXP+dBDNey1h5Tusr3iBUhw4anJ2Y7TMiZYOXMDPrxId092Aephk
        NIa0kBnw==;
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, paul.walmsley@sifive.com, palmer@dabbelt.com, ao

vmlinux.o: warning: objtool: mwait_idle+0x5: call to current_set_polling_and_test() leaves .noinstr.text section
vmlinux.o: warning: objtool: acpi_processor_ffh_cstate_enter+0xc5: call to current_set_polling_and_test() leaves .noinstr.text section
vmlinux.o: warning: objtool: cpu_idle_poll.isra.0+0x73: call to test_ti_thread_flag() leaves .noinstr.text section
vmlinux.o: warning: objtool: intel_idle+0xbc: call to current_set_polling_and_test() leaves .noinstr.text section
vmlinux.o: warning: objtool: intel_idle_irq+0xea: call to current_set_polling_and_test() leaves .noinstr.text section
vmlinux.o: warning: objtool: intel_idle_s2idle+0xb4: call to current_set_polling_and_test() leaves .noinstr.text section

vmlinux.o: warning: objtool: intel_idle+0xa6: call to current_clr_polling() leaves .noinstr.text section
vmlinux.o: warning: objtool: intel_idle_irq+0xbf: call to current_clr_polling() leaves .noinstr.text section
vmlinux.o: warning: objtool: intel_idle_s2idle+0xa1: call to current_clr_polling() leaves .noinstr.text section

vmlinux.o: warning: objtool: mwait_idle+0xe: call to __current_set_polling() leaves .noinstr.text section
vmlinux.o: warning: objtool: acpi_processor_ffh_cstate_enter+0xc5: call to __current_set_polling() leaves .noinstr.text section
vmlinux.o: warning: objtool: cpu_idle_poll.isra.0+0x73: call to test_ti_thread_flag() leaves .noinstr.text section
vmlinux.o: warning: objtool: intel_idle+0xbc: call to __current_set_polling() leaves .noinstr.text section
vmlinux.o: warning: objtool: intel_idle_irq+0xea: call to __current_set_polling() leaves .noinstr.text section
vmlinux.o: warning: objtool: intel_idle_s2idle+0xb4: call to __current_set_polling() leaves .noinstr.text section

vmlinux.o: warning: objtool: cpu_idle_poll.isra.0+0x73: call to test_ti_thread_flag() leaves .noinstr.text section
vmlinux.o: warning: objtool: intel_idle_s2idle+0x73: call to test_ti_thread_flag.constprop.0() leaves .noinstr.text section
vmlinux.o: warning: objtool: intel_idle_irq+0x91: call to test_ti_thread_flag.constprop.0() leaves .noinstr.text section
vmlinux.o: warning: objtool: intel_idle+0x78: call to test_ti_thread_flag.constprop.0() leaves .noinstr.text section
vmlinux.o: warning: objtool: acpi_safe_halt+0xf: call to test_ti_thread_flag.constprop.0() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched/idle.h  |   40 ++++++++++++++++++++++++++++++----------
 include/linux/thread_info.h |   18 +++++++++++++++++-
 2 files changed, 47 insertions(+), 11 deletions(-)

--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -23,12 +23,37 @@ static inline void wake_up_if_idle(int c
  */
 #ifdef TIF_POLLING_NRFLAG
 
-static inline void __current_set_polling(void)
+#ifdef _ASM_GENERIC_BITOPS_INSTRUMENTED_ATOMIC_H
+
+static __always_inline void __current_set_polling(void)
 {
-	set_thread_flag(TIF_POLLING_NRFLAG);
+	arch_set_bit(TIF_POLLING_NRFLAG,
+		     (unsigned long *)(&current_thread_info()->flags));
 }
 
-static inline bool __must_check current_set_polling_and_test(void)
+static __always_inline void __current_clr_polling(void)
+{
+	arch_clear_bit(TIF_POLLING_NRFLAG,
+		       (unsigned long *)(&current_thread_info()->flags));
+}
+
+#else
+
+static __always_inline void __current_set_polling(void)
+{
+	set_bit(TIF_POLLING_NRFLAG,
+		(unsigned long *)(&current_thread_info()->flags));
+}
+
+static __always_inline void __current_clr_polling(void)
+{
+	clear_bit(TIF_POLLING_NRFLAG,
+		  (unsigned long *)(&current_thread_info()->flags));
+}
+
+#endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_ATOMIC_H */
+
+static __always_inline bool __must_check current_set_polling_and_test(void)
 {
 	__current_set_polling();
 
@@ -41,12 +66,7 @@ static inline bool __must_check current_
 	return unlikely(tif_need_resched());
 }
 
-static inline void __current_clr_polling(void)
-{
-	clear_thread_flag(TIF_POLLING_NRFLAG);
-}
-
-static inline bool __must_check current_clr_polling_and_test(void)
+static __always_inline bool __must_check current_clr_polling_and_test(void)
 {
 	__current_clr_polling();
 
@@ -73,7 +93,7 @@ static inline bool __must_check current_
 }
 #endif
 
-static inline void current_clr_polling(void)
+static __always_inline void current_clr_polling(void)
 {
 	__current_clr_polling();
 
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -177,7 +177,23 @@ static __always_inline unsigned long rea
 	clear_ti_thread_flag(task_thread_info(t), TIF_##fl)
 #endif /* !CONFIG_GENERIC_ENTRY */
 
-#define tif_need_resched() test_thread_flag(TIF_NEED_RESCHED)
+#ifdef _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H
+
+static __always_inline bool tif_need_resched(void)
+{
+	return arch_test_bit(TIF_NEED_RESCHED,
+			     (unsigned long *)(&current_thread_info()->flags));
+}
+
+#else
+
+static __always_inline bool tif_need_resched(void)
+{
+	return test_bit(TIF_NEED_RESCHED,
+			(unsigned long *)(&current_thread_info()->flags));
+}
+
+#endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H */
 
 #ifndef CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES
 static inline int arch_within_stack_frames(const void * const stack,


