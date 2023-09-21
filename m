From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 3/4] arch/*/io.h: remove ioremap_uc in some architectures
Date: Thu, 21 Sep 2023 19:04:23 +0800
Message-ID: <20230921110424.215592-4-bhe@redhat.com>
References: <20230921110424.215592-1-bhe@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695294304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tn5ZDFUI6iPOIWmja0Ms5+F66UgwvJBJvQvpQLjnla0=;
	b=SWBKMLvih6qwkDFPntieOfkgn+qrC6NQ1e1XZMNNQcxVToqayGZlZKDvBdEGpW/AajTEPz
	32QbLcR6Z7eHppKzb15bYXRuC7+3AGj4hVFPdS2P7BJoLh038EMJKiKHaJU773uL/LIRbg
	e8I9qQ40xCQEx8BkUaKdrSvK+qtLkwE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695294304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tn5ZDFUI6iPOIWmja0Ms5+F66UgwvJBJvQvpQLjnla0=;
	b=SWBKMLvih6qwkDFPntieOfkgn+qrC6NQ1e1XZMNNQcxVToqayGZlZKDvBdEGpW/AajTEPz
	32QbLcR6Z7eHppKzb15bYXRuC7+3AGj4hVFPdS2P7BJoLh038EMJKiKHaJU773uL/LIRbg
	e8I9qQ40xCQEx8BkUaKdrSvK+qtLkwE=
In-Reply-To: <20230921110424.215592-1-bhe@redhat.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, tsbogend@alpha.franken.de, Baoquan He <bhe@redhat.com>, arnd@arndb.de, linux-sh@vger.kernel.org, deller@gmx.de, linux-m68k@lists.linux-m68k.org, jiaxun.yang@flygoat.com, linux-mips@vger.kernel.org, hch@infradead.org, linux-mm@kvack.org, mcgrof@kernel.org, f.fainelli@gmail.com, geert@linux-m68k.org, linux-parisc@vger.kernel.org, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org

ioremap_uc() is only meaningful on old x86-32 systems with the PAT
extension, and on ia64 with its slightly unconventional ioremap()
behavior. So remove the ioremap_uc() definition in architecutures
other than x86 and ia64. These architectures all have asm-generic/io.h
included and will have the default ioremap_uc() definition which
returns NULL.

This changes the existing behaviour, while no need to worry about
any breakage because in the only callsite of ioremap_uc(), code
has been adjusted to eliminate the impact. Please see
atyfb_setup_generic() of drivers/video/fbdev/aty/atyfb_base.c.

If any new invocation of ioremap_uc() need be added, please consider
using ioremap() intead or adding a ARCH specific version if necessary.

Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Acked-by: Helge Deller <deller@gmx.de>  # parisc
Cc: linux-alpha@vger.kernel.org
Cc: linux-hexagon@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
---
 Documentation/driver-api/device-io.rst | 9 +++++----
 arch/alpha/include/asm/io.h            | 1 -
 arch/hexagon/include/asm/io.h          | 3 ---
 arch/m68k/include/asm/kmap.h           | 1 -
 arch/mips/include/asm/io.h             | 1 -
 arch/parisc/include/asm/io.h           | 2 --
 arch/powerpc/include/asm/io.h          | 1 -
 arch/sh/include/asm/io.h               | 2 --
 arch/sparc/include/asm/io_64.h         | 1 -
 9 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/Documentation/driver-api/device-io.rst b/Documentation/driver-api/device-io.rst
index 2c7abd234f4e..d55384b106bd 100644
--- a/Documentation/driver-api/device-io.rst
+++ b/Documentation/driver-api/device-io.rst
@@ -408,11 +408,12 @@ functions for details on the CPU side of things.
 ioremap_uc()
 ------------
 
-ioremap_uc() behaves like ioremap() except that on the x86 architecture without
-'PAT' mode, it marks memory as uncached even when the MTRR has designated
-it as cacheable, see Documentation/arch/x86/pat.rst.
+ioremap_uc() is only meaningful on old x86-32 systems with the PAT extension,
+and on ia64 with its slightly unconventional ioremap() behavior, everywhere
+elss ioremap_uc() defaults to return NULL.
 
-Portable drivers should avoid the use of ioremap_uc().
+
+Portable drivers should avoid the use of ioremap_uc(), use ioremap() instead.
 
 ioremap_cache()
 ---------------
diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
index 7aeaf7c30a6f..076f0e4e7f1e 100644
--- a/arch/alpha/include/asm/io.h
+++ b/arch/alpha/include/asm/io.h
@@ -308,7 +308,6 @@ static inline void __iomem *ioremap(unsigned long port, unsigned long size)
 }
 
 #define ioremap_wc ioremap
-#define ioremap_uc ioremap
 
 static inline void iounmap(volatile void __iomem *addr)
 {
diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
index e2b308e32a37..b7bc246dbcb1 100644
--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -174,9 +174,6 @@ static inline void writel(u32 data, volatile void __iomem *addr)
 #define _PAGE_IOREMAP (_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
 		       (__HEXAGON_C_DEV << 6))
 
-#define ioremap_uc(addr, size) ioremap((addr), (size))
-
-
 #define __raw_writel writel
 
 static inline void memcpy_fromio(void *dst, const volatile void __iomem *src,
diff --git a/arch/m68k/include/asm/kmap.h b/arch/m68k/include/asm/kmap.h
index 4efb3efa593a..b778f015c917 100644
--- a/arch/m68k/include/asm/kmap.h
+++ b/arch/m68k/include/asm/kmap.h
@@ -25,7 +25,6 @@ static inline void __iomem *ioremap(unsigned long physaddr, unsigned long size)
 	return __ioremap(physaddr, size, IOMAP_NOCACHE_SER);
 }
 
-#define ioremap_uc ioremap
 #define ioremap_wt ioremap_wt
 static inline void __iomem *ioremap_wt(unsigned long physaddr,
 				       unsigned long size)
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 41d8bd5adef8..1ecf255efb40 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -170,7 +170,6 @@ void iounmap(const volatile void __iomem *addr);
  */
 #define ioremap(offset, size)						\
 	ioremap_prot((offset), (size), _CACHE_UNCACHED)
-#define ioremap_uc		ioremap
 
 /*
  * ioremap_cache -	map bus memory into CPU space
diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index 366537042465..48630c78714a 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -132,8 +132,6 @@ static inline void gsc_writeq(unsigned long long val, unsigned long addr)
 
 #define ioremap_wc(addr, size)  \
 	ioremap_prot((addr), (size), _PAGE_IOREMAP)
-#define ioremap_uc(addr, size)  \
-	ioremap_prot((addr), (size), _PAGE_IOREMAP)
 
 #define pci_iounmap			pci_iounmap
 
diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 0732b743e099..21bd3e8bffce 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -900,7 +900,6 @@ void __iomem *ioremap_wt(phys_addr_t address, unsigned long size);
 #endif
 
 void __iomem *ioremap_coherent(phys_addr_t address, unsigned long size);
-#define ioremap_uc(addr, size)		ioremap((addr), (size))
 #define ioremap_cache(addr, size) \
 	ioremap_prot((addr), (size), pgprot_val(PAGE_KERNEL))
 
diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index f2f38e9d489a..790bea22c9b5 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -302,8 +302,6 @@ unsigned long long poke_real_address_q(unsigned long long addr,
 	ioremap_prot((addr), (size), pgprot_val(PAGE_KERNEL))
 #endif /* CONFIG_MMU */
 
-#define ioremap_uc	ioremap
-
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
index 9303270b22f3..d8ee1442f303 100644
--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -423,7 +423,6 @@ static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
 	return (void __iomem *)offset;
 }
 
-#define ioremap_uc(X,Y)			ioremap((X),(Y))
 #define ioremap_wc(X,Y)			ioremap((X),(Y))
 #define ioremap_wt(X,Y)			ioremap((X),(Y))
 static inline void __iomem *ioremap_np(unsigned long offset, unsigned long size)
-- 
2.41.0

