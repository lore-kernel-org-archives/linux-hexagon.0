From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 19/44] cpuidle,intel_idle: Fix CPUIDLE_FLAG_INIT_XSTATE
Date: Mon, 19 Sep 2022 11:59:58 +0200
Message-ID: <20220919101521.609602902@infradead.org>
References: <20220919095939.761690562@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9057F41702
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BE0504171C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 90CE860BC3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 913CC6FB91
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=jlMVapcDkKa+q5r/dVIZrQzWqwQOPh4aNsx9pv05CFo=; b=buhX52S0N8GfdrpPROTvjfDI65
 vo2N72F8ANzTI8iX5yZu4448eTVjHyPggkwJJfRKxs1txYZ+DUykF1keHi9dJ3FYJIVgjO+Dv7BtO
 JXYwk6PDa0+sp3kc5Rvvb8/Ozy1R5v2F0Ol45g7fuR3UdZWhBnqCsW78Po84SfQbz64I7hort1cFr
 g13XSo10LkBMNLAyuExTJtjyY46T4cXU/beQLLdxRHU6aP5d+5hLJXADRxRrHdk/ecdvH0VaVvyLT
 ehnX8ZndOukmUSwZ46v+BOtBKQRM0tk1W3kROcANilt30UO816DEUkSwR0/b0qiDh5Is5urKmLXW+
 Bw+kCTLg==;
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

vmlinux.o: warning: objtool: intel_idle_s2idle+0xd5: call to fpu_idle_fpregs() leaves .noinstr.text section
vmlinux.o: warning: objtool: intel_idle_xstate+0x11: call to fpu_idle_fpregs() leaves .noinstr.text section
vmlinux.o: warning: objtool: fpu_idle_fpregs+0x9: call to xfeatures_in_use() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/fpu/xcr.h       |    4 ++--
 arch/x86/include/asm/special_insns.h |    2 +-
 arch/x86/kernel/fpu/core.c           |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/fpu/xcr.h
+++ b/arch/x86/include/asm/fpu/xcr.h
@@ -5,7 +5,7 @@
 #define XCR_XFEATURE_ENABLED_MASK	0x00000000
 #define XCR_XFEATURE_IN_USE_MASK	0x00000001
 
-static inline u64 xgetbv(u32 index)
+static __always_inline u64 xgetbv(u32 index)
 {
 	u32 eax, edx;
 
@@ -27,7 +27,7 @@ static inline void xsetbv(u32 index, u64
  *
  * Callers should check X86_FEATURE_XGETBV1.
  */
-static inline u64 xfeatures_in_use(void)
+static __always_inline u64 xfeatures_in_use(void)
 {
 	return xgetbv(XCR_XFEATURE_IN_USE_MASK);
 }
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -295,7 +295,7 @@ static inline int enqcmds(void __iomem *
 	return 0;
 }
 
-static inline void tile_release(void)
+static __always_inline void tile_release(void)
 {
 	/*
 	 * Instruction opcode for TILERELEASE; supported in binutils
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -856,12 +856,12 @@ int fpu__exception_code(struct fpu *fpu,
  * Initialize register state that may prevent from entering low-power idle.
  * This function will be invoked from the cpuidle driver only when needed.
  */
-void fpu_idle_fpregs(void)
+noinstr void fpu_idle_fpregs(void)
 {
 	/* Note: AMX_TILE being enabled implies XGETBV1 support */
 	if (cpu_feature_enabled(X86_FEATURE_AMX_TILE) &&
 	    (xfeatures_in_use() & XFEATURE_MASK_XTILE)) {
 		tile_release();
-		fpregs_deactivate(&current->thread.fpu);
+		__this_cpu_write(fpu_fpregs_owner_ctx, NULL);
 	}
 }
