From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] provide arch_test_bit_acquire for architectures that define
 test_bit
Date: Fri, 26 Aug 2022 16:03:28 -0400 (EDT)
Message-ID: <alpine.LRH.2.02.2208261550380.6969@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com> <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
 <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wh7ystLBs7r=KrgFhuYpNULoTY1FFPgq=a=Kr2mxc3jdg@mail.gmail.com> <alpine.LRH.2.02.2208260508360.26588@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMuHMdWQXqi__8q66R7cL4VVgr4r7WwqNmDExFFsi4aC=K3NPw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661544214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pGiL/wFCui2ekwiPy88y1EJnxLA/VbwmHPhh3BhqAuQ=;
        b=ieLhzeoy5KLVlBPhWOzlMNTpVnCByBVc2vRYNlPq1ecpJl+Lgm5qrZhbrB5w63dQYXbKJe
        PrfQy4/k1f+bIsqtD00TthGzslksuidUPDWvQBhAD6XQ1czYQHkfiWsx85pVDyGOmx0arm
        cqjmWWkjvlTGnslrPGNnqi3ph55prGg=
In-Reply-To: <CAMuHMdWQXqi__8q66R7cL4VVgr4r7WwqNmDExFFsi4aC=K3NPw@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>, Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>



On Fri, 26 Aug 2022, Geert Uytterhoeven wrote:

> Hi Mikulas,
> 
> noreply@ellerman.id.au reports lots of build failures on m68k:
> 
>     include/asm-generic/bitops/non-instrumented-non-atomic.h:15:33:
> error: implicit declaration of function 'arch_test_bit_acquire'; did
> you mean '_test_bit_acquire'? [-Werror=implicit-function-declaration]
> 
> which I've bisected to this commit.
> 
> http://kisskb.ellerman.id.au/kisskb/head/3e5c673f0d75bc22b3c26eade87e4db4f374cd34

Does this patch fix it? It is untested.

I'm not sure about the hexagon architecture, it is presumably in-order so 
that test_bit and test_bit_acquire are equivalent, but I am not sure about 
that - I'm adding hexagon maintainer to the recipient field.

Mikulas



provide arch_test_bit_acquire for architectures that define test_bit

Some architectures define their own arch_test_bit and they also need
arch_test_bit_acquire, otherwise they won't compile.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 8238b4579866 ("wait_on_bit: add an acquire memory barrier")

---
 arch/alpha/include/asm/bitops.h   |    7 +++++++
 arch/hexagon/include/asm/bitops.h |   15 +++++++++++++++
 arch/ia64/include/asm/bitops.h    |    7 +++++++
 arch/m68k/include/asm/bitops.h    |    7 +++++++
 arch/s390/include/asm/bitops.h    |    7 +++++++
 5 files changed, 43 insertions(+)

Index: linux-2.6/arch/m68k/include/asm/bitops.h
===================================================================
--- linux-2.6.orig/arch/m68k/include/asm/bitops.h
+++ linux-2.6/arch/m68k/include/asm/bitops.h
@@ -163,6 +163,13 @@ arch_test_bit(unsigned long nr, const vo
 	return (addr[nr >> 5] & (1UL << (nr & 31))) != 0;
 }
 
+static __always_inline bool
+arch_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
+{
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+	return 1UL & (smp_load_acquire(p) >> (nr & (BITS_PER_LONG-1)));
+}
+
 static inline int bset_reg_test_and_set_bit(int nr,
 					    volatile unsigned long *vaddr)
 {
Index: linux-2.6/arch/alpha/include/asm/bitops.h
===================================================================
--- linux-2.6.orig/arch/alpha/include/asm/bitops.h
+++ linux-2.6/arch/alpha/include/asm/bitops.h
@@ -289,6 +289,13 @@ arch_test_bit(unsigned long nr, const vo
 	return (1UL & (((const int *) addr)[nr >> 5] >> (nr & 31))) != 0UL;
 }
 
+static __always_inline bool
+arch_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
+{
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+	return 1UL & (smp_load_acquire(p) >> (nr & (BITS_PER_LONG-1)));
+}
+
 /*
  * ffz = Find First Zero in word. Undefined if no zero exists,
  * so code should check against ~0UL first..
Index: linux-2.6/arch/hexagon/include/asm/bitops.h
===================================================================
--- linux-2.6.orig/arch/hexagon/include/asm/bitops.h
+++ linux-2.6/arch/hexagon/include/asm/bitops.h
@@ -179,6 +179,21 @@ arch_test_bit(unsigned long nr, const vo
 	return retval;
 }
 
+static __always_inline bool
+arch_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
+{
+	int retval;
+
+	asm volatile(
+	"{P0 = tstbit(%1,%2); if (P0.new) %0 = #1; if (!P0.new) %0 = #0;}\n"
+	: "=&r" (retval)
+	: "r" (addr[BIT_WORD(nr)]), "r" (nr % BITS_PER_LONG)
+	: "p0", "memory"
+	);
+
+	return retval;
+}
+
 /*
  * ffz - find first zero in word.
  * @word: The word to search
Index: linux-2.6/arch/ia64/include/asm/bitops.h
===================================================================
--- linux-2.6.orig/arch/ia64/include/asm/bitops.h
+++ linux-2.6/arch/ia64/include/asm/bitops.h
@@ -337,6 +337,13 @@ arch_test_bit(unsigned long nr, const vo
 	return 1 & (((const volatile __u32 *) addr)[nr >> 5] >> (nr & 31));
 }
 
+static __always_inline bool
+arch_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
+{
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+	return 1UL & (smp_load_acquire(p) >> (nr & (BITS_PER_LONG-1)));
+}
+
 /**
  * ffz - find the first zero bit in a long word
  * @x: The long word to find the bit in
Index: linux-2.6/arch/s390/include/asm/bitops.h
===================================================================
--- linux-2.6.orig/arch/s390/include/asm/bitops.h
+++ linux-2.6/arch/s390/include/asm/bitops.h
@@ -185,6 +185,13 @@ arch_test_bit(unsigned long nr, const vo
 	return *p & mask;
 }
 
+static __always_inline bool
+arch_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
+{
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+	return 1UL & (smp_load_acquire(p) >> (nr & (BITS_PER_LONG-1)));
+}
+
 static inline bool arch_test_and_set_bit_lock(unsigned long nr,
 					      volatile unsigned long *ptr)
 {

