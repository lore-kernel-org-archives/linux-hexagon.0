From: Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v9 01/42] mm: Rename arch pte_mkwrite()'s to pte_mkwrite_novma()
Date: Mon, 12 Jun 2023 17:10:27 -0700
Message-ID: <20230613001108.3040476-2-rick.p.edgecombe@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686615130; x=1718151130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+8Ah+gwuuWVdk3MaZgJFhmVmdzU+WHC34h/afb7gaAY=;
  b=LQp277AQF+AhGUDJYeavNrVreevL5C/aPRLewBH6YDBgycnSvl3F6Zic
   UdKOSVFsHGWZfRHgpMraTnzzOGiu8tssta+tkrce18NOoDtE+d+RTdpMx
   rUOQaxVuzGX58Y9Bcc+eqJV7qdXY1fxFZXWYCcy3hj4MxnlA+RE5eTn9o
   pTq8M+EE+civ9APJKvQlQIouV2x1ThvFxQ5fOkSkKtS8jmpDDP2fGj/7r
   h/qW7YxUCQiAtc0DfCJvs4ev2i/zqM4FEJ/jaoyzKPOpQjBb1YQyOX3L9
   YLHHbCIhacZOluir8aC086+WlAgAp2Cyus0tp8W1QcnMuLQqbmryQAmY9
   Q==;
In-Reply-To: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>
Cc: rick.p.edgecombe@intel.com, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, Linus Torvalds <torvalds@linuxfoundation.org>

The x86 Shadow stack feature includes a new type of memory called shadow
stack. This shadow stack memory has some unusual properties, which requires
some core mm changes to function properly.

One of these unusual properties is that shadow stack memory is writable,
but only in limited ways. These limits are applied via a specific PTE
bit combination. Nevertheless, the memory is writable, and core mm code
will need to apply the writable permissions in the typical paths that
call pte_mkwrite(). Future patches will make pte_mkwrite() take a VMA, so
that the x86 implementation of it can know whether to create regular
writable memory or shadow stack memory.

But there are a couple of challenges to this. Modifying the signatures of
each arch pte_mkwrite() implementation would be error prone because some
are generated with macros and would need to be re-implemented. Also, some
pte_mkwrite() callers operate on kernel memory without a VMA.

So this can be done in a three step process. First pte_mkwrite() can be
renamed to pte_mkwrite_novma() in each arch, with a generic pte_mkwrite()
added that just calls pte_mkwrite_novma(). Next callers without a VMA can
be moved to pte_mkwrite_novma(). And lastly, pte_mkwrite() and all callers
can be changed to take/pass a VMA.

Start the process by renaming pte_mkwrite() to pte_mkwrite_novma() and
adding the pte_mkwrite() wrapper in linux/pgtable.h. Apply the same
pattern for pmd_mkwrite(). Since not all archs have a pmd_mkwrite_novma(),
create a new arch config HAS_HUGE_PAGE that can be used to tell if
pmd_mkwrite() should be defined. Otherwise in the !HAS_HUGE_PAGE cases the
compiler would not be able to find pmd_mkwrite_novma().

No functional change.

Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-csky@vger.kernel.org
Cc: linux-hexagon@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
Cc: loongarch@lists.linux.dev
Cc: linux-m68k@lists.linux-m68k.org
Cc: Michal Simek <monstr@monstr.eu>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: openrisc@lists.librecores.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-um@lists.infradead.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Link: https://lore.kernel.org/lkml/CAHk-=3DwiZjSu7c9sFYZb3q04108stgHff2wfbo=
kGCCgW7riz+8Q@mail.gmail.com/
---
Hi Non-x86 Arch=E2=80=99s,

x86 has a feature that allows for the creation of a special type of
writable memory (shadow stack) that is only writable in limited specific
ways. Previously, changes were proposed to core MM code to teach it to
decide when to create normally writable memory or the special shadow stack
writable memory, but David Hildenbrand suggested[0] to change
pXX_mkwrite() to take a VMA, so awareness of shadow stack memory can be
moved into x86 code. Later Linus suggested a less error-prone way[1] to go
about this after the first attempt had a bug.

Since pXX_mkwrite() is defined in every arch, it requires some tree-wide
changes. So that is why you are seeing some patches out of a big x86
series pop up in your arch mailing list. There is no functional change.
After this refactor, the shadow stack series goes on to use the arch
helpers to push arch memory details inside arch/x86 and other arch's
with upcoming shadow stack features.

Testing was just 0-day build testing.

Hopefully that is enough context. Thanks!

[0] https://lore.kernel.org/lkml/0e29a2d0-08d8-bcd6-ff26-4bea0e4037b0@redha=
t.com/
[1] https://lore.kernel.org/lkml/CAHk-=3DwiZjSu7c9sFYZb3q04108stgHff2wfbokG=
CCgW7riz+8Q@mail.gmail.com/
---
 Documentation/mm/arch_pgtable_helpers.rst    |  6 ++++++
 arch/Kconfig                                 |  3 +++
 arch/alpha/include/asm/pgtable.h             |  2 +-
 arch/arc/include/asm/hugepage.h              |  2 +-
 arch/arc/include/asm/pgtable-bits-arcv2.h    |  2 +-
 arch/arm/include/asm/pgtable-3level.h        |  2 +-
 arch/arm/include/asm/pgtable.h               |  2 +-
 arch/arm64/include/asm/pgtable.h             |  4 ++--
 arch/csky/include/asm/pgtable.h              |  2 +-
 arch/hexagon/include/asm/pgtable.h           |  2 +-
 arch/ia64/include/asm/pgtable.h              |  2 +-
 arch/loongarch/include/asm/pgtable.h         |  4 ++--
 arch/m68k/include/asm/mcf_pgtable.h          |  2 +-
 arch/m68k/include/asm/motorola_pgtable.h     |  2 +-
 arch/m68k/include/asm/sun3_pgtable.h         |  2 +-
 arch/microblaze/include/asm/pgtable.h        |  2 +-
 arch/mips/include/asm/pgtable.h              |  6 +++---
 arch/nios2/include/asm/pgtable.h             |  2 +-
 arch/openrisc/include/asm/pgtable.h          |  2 +-
 arch/parisc/include/asm/pgtable.h            |  2 +-
 arch/powerpc/include/asm/book3s/32/pgtable.h |  2 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h |  4 ++--
 arch/powerpc/include/asm/nohash/32/pgtable.h |  4 ++--
 arch/powerpc/include/asm/nohash/32/pte-8xx.h |  4 ++--
 arch/powerpc/include/asm/nohash/64/pgtable.h |  2 +-
 arch/riscv/include/asm/pgtable.h             |  6 +++---
 arch/s390/include/asm/hugetlb.h              |  2 +-
 arch/s390/include/asm/pgtable.h              |  4 ++--
 arch/sh/include/asm/pgtable_32.h             |  4 ++--
 arch/sparc/include/asm/pgtable_32.h          |  2 +-
 arch/sparc/include/asm/pgtable_64.h          |  6 +++---
 arch/um/include/asm/pgtable.h                |  2 +-
 arch/x86/include/asm/pgtable.h               |  4 ++--
 arch/xtensa/include/asm/pgtable.h            |  2 +-
 include/asm-generic/hugetlb.h                |  2 +-
 include/linux/pgtable.h                      | 14 ++++++++++++++
 36 files changed, 70 insertions(+), 47 deletions(-)

diff --git a/Documentation/mm/arch_pgtable_helpers.rst b/Documentation/mm/a=
rch_pgtable_helpers.rst
index af3891f895b0..69ce1f2aa4d1 100644
--- a/Documentation/mm/arch_pgtable_helpers.rst
+++ b/Documentation/mm/arch_pgtable_helpers.rst
@@ -48,6 +48,9 @@ PTE Page Table Helpers
 +---------------------------+---------------------------------------------=
-----+
 | pte_mkwrite               | Creates a writable PTE                      =
     |
 +---------------------------+---------------------------------------------=
-----+
+| pte_mkwrite_novma         | Creates a writable PTE, of the conventional =
type |
+|                           | of writable.                                =
     |
++---------------------------+---------------------------------------------=
-----+
 | pte_wrprotect             | Creates a write protected PTE               =
     |
 +---------------------------+---------------------------------------------=
-----+
 | pte_mkspecial             | Creates a special PTE                       =
     |
@@ -120,6 +123,9 @@ PMD Page Table Helpers
 +---------------------------+---------------------------------------------=
-----+
 | pmd_mkwrite               | Creates a writable PMD                      =
     |
 +---------------------------+---------------------------------------------=
-----+
+| pmd_mkwrite_novma         | Creates a writable PMD, of the conventional =
type |
+|                           | of writable.                                =
     |
++---------------------------+---------------------------------------------=
-----+
 | pmd_wrprotect             | Creates a write protected PMD               =
     |
 +---------------------------+---------------------------------------------=
-----+
 | pmd_mkspecial             | Creates a special PMD                       =
     |
diff --git a/arch/Kconfig b/arch/Kconfig
index 205fd23e0cad..3bc11c9a2ac1 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -919,6 +919,9 @@ config HAVE_ARCH_HUGE_VMALLOC
 config ARCH_WANT_HUGE_PMD_SHARE
 	bool
=20
+config HAS_HUGE_PAGE
+	def_bool HAVE_ARCH_HUGE_VMAP || TRANSPARENT_HUGEPAGE || HUGETLBFS
+
 config HAVE_ARCH_SOFT_DIRTY
 	bool
=20
diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgta=
ble.h
index ba43cb841d19..af1a13ab3320 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -256,7 +256,7 @@ extern inline int pte_young(pte_t pte)		{ return pte_va=
l(pte) & _PAGE_ACCESSED;
 extern inline pte_t pte_wrprotect(pte_t pte)	{ pte_val(pte) |=3D _PAGE_FOW=
; return pte; }
 extern inline pte_t pte_mkclean(pte_t pte)	{ pte_val(pte) &=3D ~(__DIRTY_B=
ITS); return pte; }
 extern inline pte_t pte_mkold(pte_t pte)	{ pte_val(pte) &=3D ~(__ACCESS_BI=
TS); return pte; }
-extern inline pte_t pte_mkwrite(pte_t pte)	{ pte_val(pte) &=3D ~_PAGE_FOW;=
 return pte; }
+extern inline pte_t pte_mkwrite_novma(pte_t pte){ pte_val(pte) &=3D ~_PAGE=
_FOW; return pte; }
 extern inline pte_t pte_mkdirty(pte_t pte)	{ pte_val(pte) |=3D __DIRTY_BIT=
S; return pte; }
 extern inline pte_t pte_mkyoung(pte_t pte)	{ pte_val(pte) |=3D __ACCESS_BI=
TS; return pte; }
=20
diff --git a/arch/arc/include/asm/hugepage.h b/arch/arc/include/asm/hugepag=
e.h
index 5001b796fb8d..ef8d4166370c 100644
--- a/arch/arc/include/asm/hugepage.h
+++ b/arch/arc/include/asm/hugepage.h
@@ -21,7 +21,7 @@ static inline pmd_t pte_pmd(pte_t pte)
 }
=20
 #define pmd_wrprotect(pmd)	pte_pmd(pte_wrprotect(pmd_pte(pmd)))
-#define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
+#define pmd_mkwrite_novma(pmd)	pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)))
 #define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
 #define pmd_mkold(pmd)		pte_pmd(pte_mkold(pmd_pte(pmd)))
 #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
diff --git a/arch/arc/include/asm/pgtable-bits-arcv2.h b/arch/arc/include/a=
sm/pgtable-bits-arcv2.h
index 6e9f8ca6d6a1..5c073d9f41c2 100644
--- a/arch/arc/include/asm/pgtable-bits-arcv2.h
+++ b/arch/arc/include/asm/pgtable-bits-arcv2.h
@@ -87,7 +87,7 @@
=20
 PTE_BIT_FUNC(mknotpresent,     &=3D ~(_PAGE_PRESENT));
 PTE_BIT_FUNC(wrprotect,	&=3D ~(_PAGE_WRITE));
-PTE_BIT_FUNC(mkwrite,	|=3D (_PAGE_WRITE));
+PTE_BIT_FUNC(mkwrite_novma,	|=3D (_PAGE_WRITE));
 PTE_BIT_FUNC(mkclean,	&=3D ~(_PAGE_DIRTY));
 PTE_BIT_FUNC(mkdirty,	|=3D (_PAGE_DIRTY));
 PTE_BIT_FUNC(mkold,	&=3D ~(_PAGE_ACCESSED));
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/p=
gtable-3level.h
index 106049791500..71c3add6417f 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -202,7 +202,7 @@ static inline pmd_t pmd_##fn(pmd_t pmd) { pmd_val(pmd) =
op; return pmd; }
=20
 PMD_BIT_FUNC(wrprotect,	|=3D L_PMD_SECT_RDONLY);
 PMD_BIT_FUNC(mkold,	&=3D ~PMD_SECT_AF);
-PMD_BIT_FUNC(mkwrite,   &=3D ~L_PMD_SECT_RDONLY);
+PMD_BIT_FUNC(mkwrite_novma,   &=3D ~L_PMD_SECT_RDONLY);
 PMD_BIT_FUNC(mkdirty,   |=3D L_PMD_SECT_DIRTY);
 PMD_BIT_FUNC(mkclean,   &=3D ~L_PMD_SECT_DIRTY);
 PMD_BIT_FUNC(mkyoung,   |=3D PMD_SECT_AF);
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index a58ccbb406ad..f37ba2472eae 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -227,7 +227,7 @@ static inline pte_t pte_wrprotect(pte_t pte)
 	return set_pte_bit(pte, __pgprot(L_PTE_RDONLY));
 }
=20
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	return clear_pte_bit(pte, __pgprot(L_PTE_RDONLY));
 }
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgta=
ble.h
index 0bd18de9fd97..7a3d62cb9bee 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -180,7 +180,7 @@ static inline pmd_t set_pmd_bit(pmd_t pmd, pgprot_t pro=
t)
 	return pmd;
 }
=20
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	pte =3D set_pte_bit(pte, __pgprot(PTE_WRITE));
 	pte =3D clear_pte_bit(pte, __pgprot(PTE_RDONLY));
@@ -487,7 +487,7 @@ static inline int pmd_trans_huge(pmd_t pmd)
 #define pmd_cont(pmd)		pte_cont(pmd_pte(pmd))
 #define pmd_wrprotect(pmd)	pte_pmd(pte_wrprotect(pmd_pte(pmd)))
 #define pmd_mkold(pmd)		pte_pmd(pte_mkold(pmd_pte(pmd)))
-#define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
+#define pmd_mkwrite_novma(pmd)	pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)))
 #define pmd_mkclean(pmd)	pte_pmd(pte_mkclean(pmd_pte(pmd)))
 #define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
 #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtabl=
e.h
index d4042495febc..aa0cce4fc02f 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -176,7 +176,7 @@ static inline pte_t pte_mkold(pte_t pte)
 	return pte;
 }
=20
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	pte_val(pte) |=3D _PAGE_WRITE;
 	if (pte_val(pte) & _PAGE_MODIFIED)
diff --git a/arch/hexagon/include/asm/pgtable.h b/arch/hexagon/include/asm/=
pgtable.h
index 59393613d086..fc2d2d83368d 100644
--- a/arch/hexagon/include/asm/pgtable.h
+++ b/arch/hexagon/include/asm/pgtable.h
@@ -300,7 +300,7 @@ static inline pte_t pte_wrprotect(pte_t pte)
 }
=20
 /* pte_mkwrite - mark page as writable */
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	pte_val(pte) |=3D _PAGE_WRITE;
 	return pte;
diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtabl=
e.h
index 21c97e31a28a..f80aba7cad99 100644
--- a/arch/ia64/include/asm/pgtable.h
+++ b/arch/ia64/include/asm/pgtable.h
@@ -268,7 +268,7 @@ ia64_phys_addr_valid (unsigned long addr)
  * access rights:
  */
 #define pte_wrprotect(pte)	(__pte(pte_val(pte) & ~_PAGE_AR_RW))
-#define pte_mkwrite(pte)	(__pte(pte_val(pte) | _PAGE_AR_RW))
+#define pte_mkwrite_novma(pte)	(__pte(pte_val(pte) | _PAGE_AR_RW))
 #define pte_mkold(pte)		(__pte(pte_val(pte) & ~_PAGE_A))
 #define pte_mkyoung(pte)	(__pte(pte_val(pte) | _PAGE_A))
 #define pte_mkclean(pte)	(__pte(pte_val(pte) & ~_PAGE_D))
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/=
asm/pgtable.h
index d28fb9dbec59..8245cf367b31 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -390,7 +390,7 @@ static inline pte_t pte_mkdirty(pte_t pte)
 	return pte;
 }
=20
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	pte_val(pte) |=3D _PAGE_WRITE;
 	if (pte_val(pte) & _PAGE_MODIFIED)
@@ -490,7 +490,7 @@ static inline int pmd_write(pmd_t pmd)
 	return !!(pmd_val(pmd) & _PAGE_WRITE);
 }
=20
-static inline pmd_t pmd_mkwrite(pmd_t pmd)
+static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 {
 	pmd_val(pmd) |=3D _PAGE_WRITE;
 	if (pmd_val(pmd) & _PAGE_MODIFIED)
diff --git a/arch/m68k/include/asm/mcf_pgtable.h b/arch/m68k/include/asm/mc=
f_pgtable.h
index d97fbb812f63..42ebea0488e3 100644
--- a/arch/m68k/include/asm/mcf_pgtable.h
+++ b/arch/m68k/include/asm/mcf_pgtable.h
@@ -211,7 +211,7 @@ static inline pte_t pte_mkold(pte_t pte)
 	return pte;
 }
=20
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	pte_val(pte) |=3D CF_PAGE_WRITABLE;
 	return pte;
diff --git a/arch/m68k/include/asm/motorola_pgtable.h b/arch/m68k/include/a=
sm/motorola_pgtable.h
index ec0dc19ab834..ba28ca4d219a 100644
--- a/arch/m68k/include/asm/motorola_pgtable.h
+++ b/arch/m68k/include/asm/motorola_pgtable.h
@@ -155,7 +155,7 @@ static inline int pte_young(pte_t pte)		{ return pte_va=
l(pte) & _PAGE_ACCESSED;
 static inline pte_t pte_wrprotect(pte_t pte)	{ pte_val(pte) |=3D _PAGE_RON=
LY; return pte; }
 static inline pte_t pte_mkclean(pte_t pte)	{ pte_val(pte) &=3D ~_PAGE_DIRT=
Y; return pte; }
 static inline pte_t pte_mkold(pte_t pte)	{ pte_val(pte) &=3D ~_PAGE_ACCESS=
ED; return pte; }
-static inline pte_t pte_mkwrite(pte_t pte)	{ pte_val(pte) &=3D ~_PAGE_RONL=
Y; return pte; }
+static inline pte_t pte_mkwrite_novma(pte_t pte){ pte_val(pte) &=3D ~_PAGE=
_RONLY; return pte; }
 static inline pte_t pte_mkdirty(pte_t pte)	{ pte_val(pte) |=3D _PAGE_DIRTY=
; return pte; }
 static inline pte_t pte_mkyoung(pte_t pte)	{ pte_val(pte) |=3D _PAGE_ACCES=
SED; return pte; }
 static inline pte_t pte_mknocache(pte_t pte)
diff --git a/arch/m68k/include/asm/sun3_pgtable.h b/arch/m68k/include/asm/s=
un3_pgtable.h
index e582b0484a55..4114eaff7404 100644
--- a/arch/m68k/include/asm/sun3_pgtable.h
+++ b/arch/m68k/include/asm/sun3_pgtable.h
@@ -143,7 +143,7 @@ static inline int pte_young(pte_t pte)		{ return pte_va=
l(pte) & SUN3_PAGE_ACCESS
 static inline pte_t pte_wrprotect(pte_t pte)	{ pte_val(pte) &=3D ~SUN3_PAG=
E_WRITEABLE; return pte; }
 static inline pte_t pte_mkclean(pte_t pte)	{ pte_val(pte) &=3D ~SUN3_PAGE_=
MODIFIED; return pte; }
 static inline pte_t pte_mkold(pte_t pte)	{ pte_val(pte) &=3D ~SUN3_PAGE_AC=
CESSED; return pte; }
-static inline pte_t pte_mkwrite(pte_t pte)	{ pte_val(pte) |=3D SUN3_PAGE_W=
RITEABLE; return pte; }
+static inline pte_t pte_mkwrite_novma(pte_t pte){ pte_val(pte) |=3D SUN3_P=
AGE_WRITEABLE; return pte; }
 static inline pte_t pte_mkdirty(pte_t pte)	{ pte_val(pte) |=3D SUN3_PAGE_M=
ODIFIED; return pte; }
 static inline pte_t pte_mkyoung(pte_t pte)	{ pte_val(pte) |=3D SUN3_PAGE_A=
CCESSED; return pte; }
 static inline pte_t pte_mknocache(pte_t pte)	{ pte_val(pte) |=3D SUN3_PAGE=
_NOCACHE; return pte; }
diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/includ=
e/asm/pgtable.h
index d1b8272abcd9..9108b33a7886 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -266,7 +266,7 @@ static inline pte_t pte_mkread(pte_t pte) \
 	{ pte_val(pte) |=3D _PAGE_USER; return pte; }
 static inline pte_t pte_mkexec(pte_t pte) \
 	{ pte_val(pte) |=3D _PAGE_USER | _PAGE_EXEC; return pte; }
-static inline pte_t pte_mkwrite(pte_t pte) \
+static inline pte_t pte_mkwrite_novma(pte_t pte) \
 	{ pte_val(pte) |=3D _PAGE_RW; return pte; }
 static inline pte_t pte_mkdirty(pte_t pte) \
 	{ pte_val(pte) |=3D _PAGE_DIRTY; return pte; }
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtabl=
e.h
index 574fa14ac8b2..40a54fd6e48d 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -309,7 +309,7 @@ static inline pte_t pte_mkold(pte_t pte)
 	return pte;
 }
=20
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	pte.pte_low |=3D _PAGE_WRITE;
 	if (pte.pte_low & _PAGE_MODIFIED) {
@@ -364,7 +364,7 @@ static inline pte_t pte_mkold(pte_t pte)
 	return pte;
 }
=20
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	pte_val(pte) |=3D _PAGE_WRITE;
 	if (pte_val(pte) & _PAGE_MODIFIED)
@@ -627,7 +627,7 @@ static inline pmd_t pmd_wrprotect(pmd_t pmd)
 	return pmd;
 }
=20
-static inline pmd_t pmd_mkwrite(pmd_t pmd)
+static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 {
 	pmd_val(pmd) |=3D _PAGE_WRITE;
 	if (pmd_val(pmd) & _PAGE_MODIFIED)
diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgta=
ble.h
index 0f5c2564e9f5..cf1ffbc1a121 100644
--- a/arch/nios2/include/asm/pgtable.h
+++ b/arch/nios2/include/asm/pgtable.h
@@ -129,7 +129,7 @@ static inline pte_t pte_mkold(pte_t pte)
 	return pte;
 }
=20
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	pte_val(pte) |=3D _PAGE_WRITE;
 	return pte;
diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/as=
m/pgtable.h
index 3eb9b9555d0d..828820c74fc5 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -250,7 +250,7 @@ static inline pte_t pte_mkold(pte_t pte)
 	return pte;
 }
=20
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	pte_val(pte) |=3D _PAGE_WRITE;
 	return pte;
diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pg=
table.h
index e715df5385d6..79d1cef2fd7c 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -331,7 +331,7 @@ static inline pte_t pte_mkold(pte_t pte)	{ pte_val(pte)=
 &=3D ~_PAGE_ACCESSED; retu
 static inline pte_t pte_wrprotect(pte_t pte)	{ pte_val(pte) &=3D ~_PAGE_WR=
ITE; return pte; }
 static inline pte_t pte_mkdirty(pte_t pte)	{ pte_val(pte) |=3D _PAGE_DIRTY=
; return pte; }
 static inline pte_t pte_mkyoung(pte_t pte)	{ pte_val(pte) |=3D _PAGE_ACCES=
SED; return pte; }
-static inline pte_t pte_mkwrite(pte_t pte)	{ pte_val(pte) |=3D _PAGE_WRITE=
; return pte; }
+static inline pte_t pte_mkwrite_novma(pte_t pte)	{ pte_val(pte) |=3D _PAGE=
_WRITE; return pte; }
 static inline pte_t pte_mkspecial(pte_t pte)	{ pte_val(pte) |=3D _PAGE_SPE=
CIAL; return pte; }
=20
 /*
diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/in=
clude/asm/book3s/32/pgtable.h
index 7bf1fe7297c6..67dfb674a4c1 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -498,7 +498,7 @@ static inline pte_t pte_mkpte(pte_t pte)
 	return pte;
 }
=20
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_RW);
 }
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/in=
clude/asm/book3s/64/pgtable.h
index 4acc9690f599..0328d917494a 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -600,7 +600,7 @@ static inline pte_t pte_mkexec(pte_t pte)
 	return __pte_raw(pte_raw(pte) | cpu_to_be64(_PAGE_EXEC));
 }
=20
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	/*
 	 * write implies read, hence set both
@@ -1071,7 +1071,7 @@ static inline pte_t *pmdp_ptep(pmd_t *pmd)
 #define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
 #define pmd_mkclean(pmd)	pte_pmd(pte_mkclean(pmd_pte(pmd)))
 #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
-#define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
+#define pmd_mkwrite_novma(pmd)	pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)))
=20
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
 #define pmd_soft_dirty(pmd)    pte_soft_dirty(pmd_pte(pmd))
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/in=
clude/asm/nohash/32/pgtable.h
index fec56d965f00..33213b31fcbb 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -170,8 +170,8 @@ void unmap_kernel_page(unsigned long va);
 #define pte_clear(mm, addr, ptep) \
 	do { pte_update(mm, addr, ptep, ~0, 0, 0); } while (0)
=20
-#ifndef pte_mkwrite
-static inline pte_t pte_mkwrite(pte_t pte)
+#ifndef pte_mkwrite_novma
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_RW);
 }
diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/in=
clude/asm/nohash/32/pte-8xx.h
index 1a89ebdc3acc..21f681ee535a 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -101,12 +101,12 @@ static inline int pte_write(pte_t pte)
=20
 #define pte_write pte_write
=20
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	return __pte(pte_val(pte) & ~_PAGE_RO);
 }
=20
-#define pte_mkwrite pte_mkwrite
+#define pte_mkwrite_novma pte_mkwrite_novma
=20
 static inline bool pte_user(pte_t pte)
 {
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/in=
clude/asm/nohash/64/pgtable.h
index 287e25864ffa..abe4fd82721e 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -85,7 +85,7 @@
 #ifndef __ASSEMBLY__
 /* pte_clear moved to later in this file */
=20
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_RW);
 }
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgta=
ble.h
index 2258b27173b0..b38faec98154 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -379,7 +379,7 @@ static inline pte_t pte_wrprotect(pte_t pte)
=20
 /* static inline pte_t pte_mkread(pte_t pte) */
=20
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_WRITE);
 }
@@ -665,9 +665,9 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 	return pte_pmd(pte_mkyoung(pmd_pte(pmd)));
 }
=20
-static inline pmd_t pmd_mkwrite(pmd_t pmd)
+static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 {
-	return pte_pmd(pte_mkwrite(pmd_pte(pmd)));
+	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
 }
=20
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetl=
b.h
index ccdbccfde148..f07267875a19 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -104,7 +104,7 @@ static inline int huge_pte_dirty(pte_t pte)
=20
 static inline pte_t huge_pte_mkwrite(pte_t pte)
 {
-	return pte_mkwrite(pte);
+	return pte_mkwrite_novma(pte);
 }
=20
 static inline pte_t huge_pte_mkdirty(pte_t pte)
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtabl=
e.h
index 6822a11c2c8a..699406036f30 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1005,7 +1005,7 @@ static inline pte_t pte_wrprotect(pte_t pte)
 	return set_pte_bit(pte, __pgprot(_PAGE_PROTECT));
 }
=20
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	pte =3D set_pte_bit(pte, __pgprot(_PAGE_WRITE));
 	if (pte_val(pte) & _PAGE_DIRTY)
@@ -1488,7 +1488,7 @@ static inline pmd_t pmd_wrprotect(pmd_t pmd)
 	return set_pmd_bit(pmd, __pgprot(_SEGMENT_ENTRY_PROTECT));
 }
=20
-static inline pmd_t pmd_mkwrite(pmd_t pmd)
+static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 {
 	pmd =3D set_pmd_bit(pmd, __pgprot(_SEGMENT_ENTRY_WRITE));
 	if (pmd_val(pmd) & _SEGMENT_ENTRY_DIRTY)
diff --git a/arch/sh/include/asm/pgtable_32.h b/arch/sh/include/asm/pgtable=
_32.h
index 21952b094650..165b4fd08152 100644
--- a/arch/sh/include/asm/pgtable_32.h
+++ b/arch/sh/include/asm/pgtable_32.h
@@ -359,11 +359,11 @@ static inline pte_t pte_##fn(pte_t pte) { pte.pte_##h=
 op; return pte; }
  * kernel permissions), we attempt to couple them a bit more sanely here.
  */
 PTE_BIT_FUNC(high, wrprotect, &=3D ~(_PAGE_EXT_USER_WRITE | _PAGE_EXT_KERN=
_WRITE));
-PTE_BIT_FUNC(high, mkwrite, |=3D _PAGE_EXT_USER_WRITE | _PAGE_EXT_KERN_WRI=
TE);
+PTE_BIT_FUNC(high, mkwrite_novma, |=3D _PAGE_EXT_USER_WRITE | _PAGE_EXT_KE=
RN_WRITE);
 PTE_BIT_FUNC(high, mkhuge, |=3D _PAGE_SZHUGE);
 #else
 PTE_BIT_FUNC(low, wrprotect, &=3D ~_PAGE_RW);
-PTE_BIT_FUNC(low, mkwrite, |=3D _PAGE_RW);
+PTE_BIT_FUNC(low, mkwrite_novma, |=3D _PAGE_RW);
 PTE_BIT_FUNC(low, mkhuge, |=3D _PAGE_SZHUGE);
 #endif
=20
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/p=
gtable_32.h
index d4330e3c57a6..a2d909446539 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -241,7 +241,7 @@ static inline pte_t pte_mkold(pte_t pte)
 	return __pte(pte_val(pte) & ~SRMMU_REF);
 }
=20
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	return __pte(pte_val(pte) | SRMMU_WRITE);
 }
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/p=
gtable_64.h
index 5563efa1a19f..4dd4f6cdc670 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -517,7 +517,7 @@ static inline pte_t pte_mkclean(pte_t pte)
 	return __pte(val);
 }
=20
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	unsigned long val =3D pte_val(pte), mask;
=20
@@ -772,11 +772,11 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 	return __pmd(pte_val(pte));
 }
=20
-static inline pmd_t pmd_mkwrite(pmd_t pmd)
+static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 {
 	pte_t pte =3D __pte(pmd_val(pmd));
=20
-	pte =3D pte_mkwrite(pte);
+	pte =3D pte_mkwrite_novma(pte);
=20
 	return __pmd(pte_val(pte));
 }
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index a70d1618eb35..46f59a8bc812 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -207,7 +207,7 @@ static inline pte_t pte_mkyoung(pte_t pte)
 	return(pte);
 }
=20
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	if (unlikely(pte_get_bits(pte,  _PAGE_RW)))
 		return pte;
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 15ae4d6ba476..112e6060eafa 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -352,7 +352,7 @@ static inline pte_t pte_mkyoung(pte_t pte)
 	return pte_set_flags(pte, _PAGE_ACCESSED);
 }
=20
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	return pte_set_flags(pte, _PAGE_RW);
 }
@@ -453,7 +453,7 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 	return pmd_set_flags(pmd, _PAGE_ACCESSED);
 }
=20
-static inline pmd_t pmd_mkwrite(pmd_t pmd)
+static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 {
 	return pmd_set_flags(pmd, _PAGE_RW);
 }
diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/asm/pg=
table.h
index fc7a14884c6c..27e3ae38a5de 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -262,7 +262,7 @@ static inline pte_t pte_mkdirty(pte_t pte)
 	{ pte_val(pte) |=3D _PAGE_DIRTY; return pte; }
 static inline pte_t pte_mkyoung(pte_t pte)
 	{ pte_val(pte) |=3D _PAGE_ACCESSED; return pte; }
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_novma(pte_t pte)
 	{ pte_val(pte) |=3D _PAGE_WRITABLE; return pte; }
=20
 #define pgprot_noncached(prot) \
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index d7f6335d3999..4da02798a00b 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -22,7 +22,7 @@ static inline unsigned long huge_pte_dirty(pte_t pte)
=20
 static inline pte_t huge_pte_mkwrite(pte_t pte)
 {
-	return pte_mkwrite(pte);
+	return pte_mkwrite_novma(pte);
 }
=20
 #ifndef __HAVE_ARCH_HUGE_PTE_WRPROTECT
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index c5a51481bbb9..ae271a307584 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -507,6 +507,20 @@ extern pud_t pudp_huge_clear_flush(struct vm_area_stru=
ct *vma,
 			      pud_t *pudp);
 #endif
=20
+#ifndef pte_mkwrite
+static inline pte_t pte_mkwrite(pte_t pte)
+{
+	return pte_mkwrite_novma(pte);
+}
+#endif
+
+#if defined(CONFIG_HAS_HUGE_PAGE) && !defined(pmd_mkwrite)
+static inline pmd_t pmd_mkwrite(pmd_t pmd)
+{
+	return pmd_mkwrite_novma(pmd);
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_SET_WRPROTECT
 struct mm_struct;
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long =
address, pte_t *ptep)
--=20
2.34.1

