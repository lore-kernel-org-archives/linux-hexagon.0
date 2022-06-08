From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 27/36] cpuidle,mwait: Make noinstr clean
Date: Wed, 08 Jun 2022 16:27:50 +0200
Message-ID: <20220608144517.633293983@infradead.org>
References: <20220608142723.103523089@infradead.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=pxqjaMyXYMAIciLaWxKe0qnmRXZim+cyW3iOuZrk594=; b=ViqRPs1VYf9fGaMwnUeukkQR8N
        4opAWUOASRD0k91h5KRfUzfNbwG02AJ5Xy4ihvtgf4z4TOkhwOaDRlGMoAIRUP1SNcvvyYZ2Mwcv7
        4Ltpok9uBduW3gGExmHzi6EjO9GzvTNTOKtgESzadI4fkPrUhC/WcKqOtw9nTOxeTTVythZifYw33
        J4z2qhSxWyq1sMYyvtUWAYI+3X7ANKjgCZA7XdkM5jjmcfyZzRbN4fef2tgKyJebOICY7Gy8HEqc/
        8T/1JwzpYcJa1IHMGfOFIy6BvvrLy608z/jtZq34wyDltGhqbi/mMUUcaZ65tA4CjugxA9Q6l2jLe
        pA7tgBww==;
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, paul.walmsley@sifive.com, palmer@dabbelt.com, ao

vmlinux.o: warning: objtool: intel_idle_s2idle+0x6e: call to __monitor.constprop.0() leaves .noinstr.text section
vmlinux.o: warning: objtool: intel_idle_irq+0x8c: call to __monitor.constprop.0() leaves .noinstr.text section
vmlinux.o: warning: objtool: intel_idle+0x73: call to __monitor.constprop.0() leaves .noinstr.text section

vmlinux.o: warning: objtool: mwait_idle+0x88: call to clflush() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/mwait.h         |   12 ++++++------
 arch/x86/include/asm/special_insns.h |    2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -25,7 +25,7 @@
 #define TPAUSE_C01_STATE		1
 #define TPAUSE_C02_STATE		0
 
-static inline void __monitor(const void *eax, unsigned long ecx,
+static __always_inline void __monitor(const void *eax, unsigned long ecx,
 			     unsigned long edx)
 {
 	/* "monitor %eax, %ecx, %edx;" */
@@ -33,7 +33,7 @@ static inline void __monitor(const void
 		     :: "a" (eax), "c" (ecx), "d"(edx));
 }
 
-static inline void __monitorx(const void *eax, unsigned long ecx,
+static __always_inline void __monitorx(const void *eax, unsigned long ecx,
 			      unsigned long edx)
 {
 	/* "monitorx %eax, %ecx, %edx;" */
@@ -41,7 +41,7 @@ static inline void __monitorx(const void
 		     :: "a" (eax), "c" (ecx), "d"(edx));
 }
 
-static inline void __mwait(unsigned long eax, unsigned long ecx)
+static __always_inline void __mwait(unsigned long eax, unsigned long ecx)
 {
 	mds_idle_clear_cpu_buffers();
 
@@ -76,8 +76,8 @@ static inline void __mwait(unsigned long
  * EAX                     (logical) address to monitor
  * ECX                     #GP if not zero
  */
-static inline void __mwaitx(unsigned long eax, unsigned long ebx,
-			    unsigned long ecx)
+static __always_inline void __mwaitx(unsigned long eax, unsigned long ebx,
+				     unsigned long ecx)
 {
 	/* No MDS buffer clear as this is AMD/HYGON only */
 
@@ -86,7 +86,7 @@ static inline void __mwaitx(unsigned lon
 		     :: "a" (eax), "b" (ebx), "c" (ecx));
 }
 
-static inline void __sti_mwait(unsigned long eax, unsigned long ecx)
+static __always_inline void __sti_mwait(unsigned long eax, unsigned long ecx)
 {
 	mds_idle_clear_cpu_buffers();
 	/* "mwait %eax, %ecx;" */
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -196,7 +196,7 @@ static inline void load_gs_index(unsigne
 
 #endif /* CONFIG_PARAVIRT_XXL */
 
-static inline void clflush(volatile void *__p)
+static __always_inline void clflush(volatile void *__p)
 {
 	asm volatile("clflush %0" : "+m" (*(volatile char __force *)__p));
 }


