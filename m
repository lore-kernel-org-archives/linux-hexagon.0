From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 43/44] sched: Always inline __this_cpu_preempt_check()
Date: Mon, 19 Sep 2022 12:00:22 +0200
Message-ID: <20220919101523.244550344@infradead.org>
References: <20220919095939.761690562@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E7FB26FB85
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 13BC46FB8E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AE4374251A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9AC2F4170E
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=eYoUngVW9N27gIhULqYrRlt6uLJ7xBInAkMSAu6ULjk=; b=Ij73wphXljMJWUVviTKuDqPZhp
 17e2HpP2XUZvIm72WBG7HRFIFj+7gfL8MzcE2u8uVZa75Ug0NOLh6Jo9K0OzCAAbmFXzQGTGsr3no
 wU+nQSRqmaoK4oh5m7eCdzV4ayTPQhHWh3bXZszmdpw53MzLGQ4TxfnnDnyOMCth1WFLh9R8fUYmK
 /6EYCH2gb/vXiihmgHFnsduufEMZY5OcI61sbS6ewGPmyKgeJRB221D8HstksAgGk6ZaxYB5igHxB
 K5S7A+j6jWOoio3pKI4So9hGF/Yc4sXdIGfZhqJOma/Bv6Afx77/wHaFynD9cIU0w6i7MArAN9NVa
 lRcOIM+A==;
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: peterz@infradead.org
Cc: juri.lelli@redhat.com, rafael@kernel.org, catalin.marinas@arm.com, linus.walleij@linaro.org, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz, agordeev@linux.ibm.com, linux-arch@vger.kernel.org, vincent.guittot@linaro.org, mpe@ellerman.id.au, chenhuacai@kernel.org, christophe.leroy@csgroup.eu, linux-acpi@vger.kernel.org, agross@kernel.org, geert@linux-m68k.org, linux-imx@nxp.com, vgupta@kernel.org, mattst88@gmail.com, mturquette@baylibre.com, sammy@sammy.net, pmladek@suse.com, linux-pm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org, npiggin@gmail.com, tglx@linutronix.de, linux-omap@vger.kernel.org, dietmar.eggemann@arm.com, andreyknvl@gmail.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, senozhatsky@chromium.org, svens@linux.ibm.com, jolsa@kernel.org, tj@kernel.org, Andrew Morton <a>

vmlinux.o: warning: objtool: in_entry_stack+0x9: call to __this_cpu_preempt_check() leaves .noinstr.text section
vmlinux.o: warning: objtool: default_do_nmi+0x10: call to __this_cpu_preempt_check() leaves .noinstr.text section
vmlinux.o: warning: objtool: fpu_idle_fpregs+0x41: call to __this_cpu_preempt_check() leaves .noinstr.text section
vmlinux.o: warning: objtool: kvm_read_and_reset_apf_flags+0x1: call to __this_cpu_preempt_check() leaves .noinstr.text section
vmlinux.o: warning: objtool: lockdep_hardirqs_on+0xb0: call to __this_cpu_preempt_check() leaves .noinstr.text section
vmlinux.o: warning: objtool: lockdep_hardirqs_off+0xae: call to __this_cpu_preempt_check() leaves .noinstr.text section
vmlinux.o: warning: objtool: irqentry_nmi_enter+0x69: call to __this_cpu_preempt_check() leaves .noinstr.text section
vmlinux.o: warning: objtool: irqentry_nmi_exit+0x32: call to __this_cpu_preempt_check() leaves .noinstr.text section
vmlinux.o: warning: objtool: acpi_processor_ffh_cstate_enter+0x9: call to __this_cpu_preempt_check() leaves .noinstr.text section
vmlinux.o: warning: objtool: acpi_idle_enter+0x43: call to __this_cpu_preempt_check() leaves .noinstr.text section
vmlinux.o: warning: objtool: acpi_idle_enter_s2idle+0x45: call to __this_cpu_preempt_check() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/percpu-defs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -310,7 +310,7 @@ extern void __bad_size_call_parameter(vo
 #ifdef CONFIG_DEBUG_PREEMPT
 extern void __this_cpu_preempt_check(const char *op);
 #else
-static inline void __this_cpu_preempt_check(const char *op) { }
+static __always_inline void __this_cpu_preempt_check(const char *op) { }
 #endif
 
 #define __pcpu_size_call_return(stem, variable)				\
