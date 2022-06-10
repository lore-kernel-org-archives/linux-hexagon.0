From: Alexander Lobakin <alexandr.lobakin@intel.com>
Subject: [PATCH v2 4/6] bitops: define const_*() versions of the non-atomics
Date: Fri, 10 Jun 2022 13:34:25 +0200
Message-ID: <20220610113427.908751-5-alexandr.lobakin@intel.com>
References: <20220610113427.908751-1-alexandr.lobakin@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654860934; x=1686396934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DT50KSu+dkwFmnyj0sxL9pF5VyPowriYXEyZrXDQToM=;
  b=lcGPITEXhFeWuv8JMWBs4qD++nxjzCSqQfjAqB74XhYStawkTuhGRNId
   OAHZTy20tIT4GhwM2ZIVUcTuCcn/nWTqTwQf21ZkntwnpMH8zgr6YYE5W
   IUNn3uEdlloXVVGst8XY1GC+cjqqYflHyADa38na3+NusUFB6ZT1M/0Ud
   sPzqFsZyex/vY2IkqKJdktVHTH9vvJXyVz7Cepf5DsI4roHGLTaVMZ6re
   q+fq68LVWvktziIrFaHDme3yOD+NEOh1t0RA+UL/c8o1AwWGGw4Cx5mRw
   83l13Ske7ZYeHsEy8O9CDYeFeG84r5TvnzvM5i9M7mJjmd3Cfm3zQp/nC
   g==;
In-Reply-To: <20220610113427.908751-1-alexandr.lobakin@intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Matt Turner <mattst88@gmail.com>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org

Define const_*() variants of the non-atomic bitops to be used when
the input arguments are compile-time constants, so that the compiler
will be always to resolve those to compile-time constants as well.
Those are mostly direct aliases for generic_*() with one exception
for const_test_bit(): the original one is declared atomic-safe and
thus doesn't discard the `volatile` qualifier, so in order to let
optimize the code, define it separately disregarding the qualifier.
Add them to the compile-time type checks as well just in case.

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 .../asm-generic/bitops/generic-non-atomic.h   | 31 +++++++++++++++++++
 include/linux/bitops.h                        |  3 +-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/bitops/generic-non-atomic.h b/include/asm-generic/bitops/generic-non-atomic.h
index 3ce0fa0ab35f..9a77babfff35 100644
--- a/include/asm-generic/bitops/generic-non-atomic.h
+++ b/include/asm-generic/bitops/generic-non-atomic.h
@@ -121,4 +121,35 @@ generic_test_bit(unsigned long nr, const volatile unsigned long *addr)
 	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
 }
 
+/*
+ * const_*() definitions provide good compile-time optimizations when
+ * the passed arguments can be resolved at compile time.
+ */
+#define const___set_bit			generic___set_bit
+#define const___clear_bit		generic___clear_bit
+#define const___change_bit		generic___change_bit
+#define const___test_and_set_bit	generic___test_and_set_bit
+#define const___test_and_clear_bit	generic___test_and_clear_bit
+#define const___test_and_change_bit	generic___test_and_change_bit
+
+/**
+ * const_test_bit - Determine whether a bit is set
+ * @nr: bit number to test
+ * @addr: Address to start counting from
+ *
+ * A version of generic_test_bit() which discards the `volatile` qualifier to
+ * allow the compiler to optimize code harder. Non-atomic and to be used only
+ * for testing compile-time constants, e.g. from the corresponding macro, or
+ * when you really know what you are doing.
+ */
+static __always_inline bool
+const_test_bit(unsigned long nr, const volatile unsigned long *addr)
+{
+	const unsigned long *p = (const unsigned long *)addr + BIT_WORD(nr);
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long val = *p;
+
+	return !!(val & mask);
+}
+
 #endif /* __ASM_GENERIC_BITOPS_GENERIC_NON_ATOMIC_H */
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 87087454a288..51c22b8667b4 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -36,7 +36,8 @@ extern unsigned long __sw_hweight64(__u64 w);
 
 /* Check that the bitops prototypes are sane */
 #define __check_bitop_pr(name)						\
-	static_assert(__same_type(arch_##name, generic_##name) &&	\
+	static_assert(__same_type(const_##name, generic_##name) &&	\
+		      __same_type(arch_##name, generic_##name) &&	\
 		      __same_type(name, generic_##name))
 
 __check_bitop_pr(__set_bit);
-- 
2.36.1

