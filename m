Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C6518FC75;
	Mon, 28 Oct 2024 21:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730149957; cv=none; b=TXHta0fBLPEuJ7O1SXvoTR3MrJl41MySCi/ud/3fO/RNME7JBQg3h3Hc4QPmUxizj3LaBRY8ssRFdtek4uiO5IQd4xzcmws8CtOEtFdzF3Q25p0bpLJ4Bb3aSnr4Q8Aexl/kBvVZCfBzFRReZdz+trSwRwTCKzKhUsMjTRi+M1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730149957; c=relaxed/simple;
	bh=7vCr84x2AXd3twwPgs0aq4d+w7w8USJk6QglSiPPE+M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gYl6EXFd4GIfU300MUeVrSXfGI0vMNRHW5xKnkx9kFqNXmC/SHXzQk5lzDf7J6E4jA//bU/OdNXip5T5CGFcBDju3JKMXIGSBZyxBKied4+ZgEm0BcVhiWDcgfEvyDkafrZxqjYw22v10YSd4OdFK0NkSfI46VXDsdgN5gp2WG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayhiQMB+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayhiQMB+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B89C4CEC3;
	Mon, 28 Oct 2024 21:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730149956;
	bh=7vCr84x2AXd3twwPgs0aq4d+w7w8USJk6QglSiPPE+M=;
	h=From:To:Cc:Subject:Date:From;
	b=ayhiQMB+JHNBvGXrTPu/rbRAY60U5F5spMjiE59t0810MWp/2E+5Wtlan39RiVEY0
	 w198fX9aeT+XvzUqYEseL7EgVPzyDs1xCFVvOCcAHSw0eeJk54GgVpmTZW7CZzDSRN
	 6usWy3MIhcn0QRSC1vcPQTKz6R5I+kkLWg95q3bHKj+GKnDU34uecASpUUKWCTaVzU
	 2qyVbXqsB2Z4JsVwfFK8ul03wzki6kVYyqfYEaB3DnOPNPY0/2p4i7V+nTtsO1k9/o
	 VEoXduY9CnQzjLSyFTfJSVv75ExN86sl2Ey6F+aGsURlcN9Xg7iiQAqqeqHIxF2fN2
	 zFJUhbm+c820w==
From: Arnd Bergmann <arnd@kernel.org>
To: Brian Cain <bcain@quicinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hexagon: simplify asm/io.h for !HAS_IOPORT
Date: Mon, 28 Oct 2024 21:12:03 +0000
Message-Id: <20241028211227.2294887-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Hexagon fails to build after the final patch that makes CONFIG_HAS_IOPORT
optional:

In file included from arch/hexagon/include/asm/io.h:328:
include/asm-generic/io.h:854:18: error: static declaration of 'ioread8' follows non-static declaration
  854 | static inline u8 ioread8(const volatile void __iomem *addr)
      |                  ^
include/asm-generic/io.h:853:17: note: expanded from macro 'ioread8'
  853 | #define ioread8 ioread8
      |                 ^
include/asm-generic/iomap.h:29:21: note: previous declaration is here
   29 | extern unsigned int ioread8(const void __iomem *);
      |                     ^

As it turns out, most of its asm/io.h and lib/io.c files is redundant now,
and just removing all that makes it build again.

As with the other architectures, defining the __raw_readl()/__raw_writel()
type functions instead of the non-__raw ones is better here for consistency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I've applied this in the asm-generic tree on top of the HAS_IOPORT series
as a fixup, let me know if I should change anything.

 arch/hexagon/Kconfig          |   4 +-
 arch/hexagon/include/asm/io.h | 223 ++--------------------------------
 arch/hexagon/lib/Makefile     |   2 +-
 arch/hexagon/lib/io.c         |  82 -------------
 4 files changed, 16 insertions(+), 295 deletions(-)
 delete mode 100644 arch/hexagon/lib/io.c

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 5ea1bf4b7d4f..3eb51fbe804e 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -30,7 +30,6 @@ config HEXAGON
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
 	select NEED_SG_DMA_LENGTH
-	select NO_IOPORT_MAP
 	select GENERIC_IOREMAP
 	select GENERIC_SMP_IDLE_THREAD
 	select STACKTRACE_SUPPORT
@@ -58,6 +57,9 @@ config EARLY_PRINTK
 config MMU
 	def_bool y
 
+config NO_IOPORT_MAP
+	def_bool y
+
 config GENERIC_CSUM
 	def_bool y
 
diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
index 522d321ea85a..83b2eb5de60c 100644
--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -8,38 +8,13 @@
 #ifndef _ASM_IO_H
 #define _ASM_IO_H
 
-#ifdef __KERNEL__
-
 #include <linux/types.h>
-#include <asm/iomap.h>
 #include <asm/page.h>
 #include <asm/cacheflush.h>
 
-/*
- * We don't have PCI yet.
- * _IO_BASE is pointing at what should be unused virtual space.
- */
-#define IO_SPACE_LIMIT 0xffff
-#define _IO_BASE ((void __iomem *)0xfe000000)
-
-#define IOMEM(x)        ((void __force __iomem *)(x))
-
 extern int remap_area_pages(unsigned long start, unsigned long phys_addr,
 				unsigned long end, unsigned long flags);
 
-/* Defined in lib/io.c, needed for smc91x driver. */
-extern void __raw_readsw(const void __iomem *addr, void *data, int wordlen);
-extern void __raw_writesw(void __iomem *addr, const void *data, int wordlen);
-
-extern void __raw_readsl(const void __iomem *addr, void *data, int wordlen);
-extern void __raw_writesl(void __iomem *addr, const void *data, int wordlen);
-
-#define readsw(p, d, l)	__raw_readsw(p, d, l)
-#define writesw(p, d, l) __raw_writesw(p, d, l)
-
-#define readsl(p, d, l)   __raw_readsl(p, d, l)
-#define writesl(p, d, l)  __raw_writesl(p, d, l)
-
 /*
  * virt_to_phys - map virtual address to physical
  * @address:  address to map
@@ -58,21 +33,12 @@ static inline void *phys_to_virt(unsigned long address)
 	return __va(address);
 }
 
-/*
- * IO port access primitives.  Hexagon doesn't have special IO access
- * instructions; all I/O is memory mapped.
- *
- * in/out are used for "ports", but we don't have "port instructions",
- * so these are really just memory mapped too.
- */
-
 /*
  * readb - read byte from memory mapped device
  * @addr:  pointer to memory
  *
- * Operates on "I/O bus memory space"
  */
-static inline u8 readb(const volatile void __iomem *addr)
+static inline u8 __raw_readb(const volatile void __iomem *addr)
 {
 	u8 val;
 	asm volatile(
@@ -82,8 +48,9 @@ static inline u8 readb(const volatile void __iomem *addr)
 	);
 	return val;
 }
+#define __raw_readb __raw_readb
 
-static inline u16 readw(const volatile void __iomem *addr)
+static inline u16 __raw_readw(const volatile void __iomem *addr)
 {
 	u16 val;
 	asm volatile(
@@ -93,8 +60,9 @@ static inline u16 readw(const volatile void __iomem *addr)
 	);
 	return val;
 }
+#define __raw_readw __raw_readw
 
-static inline u32 readl(const volatile void __iomem *addr)
+static inline u32 __raw_readl(const volatile void __iomem *addr)
 {
 	u32 val;
 	asm volatile(
@@ -104,6 +72,7 @@ static inline u32 readl(const volatile void __iomem *addr)
 	);
 	return val;
 }
+#define __raw_readl __raw_readl
 
 /*
  * writeb - write a byte to a memory location
@@ -111,7 +80,7 @@ static inline u32 readl(const volatile void __iomem *addr)
  * @addr:  pointer to memory
  *
  */
-static inline void writeb(u8 data, volatile void __iomem *addr)
+static inline void __raw_writeb(u8 data, volatile void __iomem *addr)
 {
 	asm volatile(
 		"memb(%0) = %1;"
@@ -120,8 +89,9 @@ static inline void writeb(u8 data, volatile void __iomem *addr)
 		: "memory"
 	);
 }
+#define __raw_writeb __raw_writeb
 
-static inline void writew(u16 data, volatile void __iomem *addr)
+static inline void __raw_writew(u16 data, volatile void __iomem *addr)
 {
 	asm volatile(
 		"memh(%0) = %1;"
@@ -131,8 +101,9 @@ static inline void writew(u16 data, volatile void __iomem *addr)
 	);
 
 }
+#define __raw_writew __raw_writew
 
-static inline void writel(u32 data, volatile void __iomem *addr)
+static inline void __raw_writel(u32 data, volatile void __iomem *addr)
 {
 	asm volatile(
 		"memw(%0) = %1;"
@@ -141,26 +112,7 @@ static inline void writel(u32 data, volatile void __iomem *addr)
 		: "memory"
 	);
 }
-
-#define __raw_writeb writeb
-#define __raw_writew writew
-#define __raw_writel writel
-
-#define __raw_readb readb
-#define __raw_readw readw
-#define __raw_readl readl
-
-/*
- * http://comments.gmane.org/gmane.linux.ports.arm.kernel/117626
- */
-
-#define readb_relaxed __raw_readb
-#define readw_relaxed __raw_readw
-#define readl_relaxed __raw_readl
-
-#define writeb_relaxed __raw_writeb
-#define writew_relaxed __raw_writew
-#define writel_relaxed __raw_writel
+#define __raw_writel __raw_writel
 
 /*
  * I/O memory mapping functions.
@@ -168,140 +120,6 @@ static inline void writel(u32 data, volatile void __iomem *addr)
 #define _PAGE_IOREMAP (_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
 		       (__HEXAGON_C_DEV << 6))
 
-#define __raw_writel writel
-
-static inline void memcpy_fromio(void *dst, const volatile void __iomem *src,
-	int count)
-{
-	memcpy(dst, (void *) src, count);
-}
-
-static inline void memcpy_toio(volatile void __iomem *dst, const void *src,
-	int count)
-{
-	memcpy((void *) dst, src, count);
-}
-
-static inline void memset_io(volatile void __iomem *addr, int value,
-			     size_t size)
-{
-	memset((void __force *)addr, value, size);
-}
-
-#define PCI_IO_ADDR	(volatile void __iomem *)
-
-/*
- * inb - read byte from I/O port or something
- * @port:  address in I/O space
- *
- * Operates on "I/O bus I/O space"
- */
-static inline u8 inb(unsigned long port)
-{
-	return readb(_IO_BASE + (port & IO_SPACE_LIMIT));
-}
-
-static inline u16 inw(unsigned long port)
-{
-	return readw(_IO_BASE + (port & IO_SPACE_LIMIT));
-}
-
-static inline u32 inl(unsigned long port)
-{
-	return readl(_IO_BASE + (port & IO_SPACE_LIMIT));
-}
-
-/*
- * outb - write a byte to a memory location
- * @data: data to write to
- * @addr:  address in I/O space
- */
-static inline void outb(u8 data, unsigned long port)
-{
-	writeb(data, _IO_BASE + (port & IO_SPACE_LIMIT));
-}
-
-static inline void outw(u16 data, unsigned long port)
-{
-	writew(data, _IO_BASE + (port & IO_SPACE_LIMIT));
-}
-
-static inline void outl(u32 data, unsigned long port)
-{
-	writel(data, _IO_BASE + (port & IO_SPACE_LIMIT));
-}
-
-#define outb_p outb
-#define outw_p outw
-#define outl_p outl
-
-#define inb_p inb
-#define inw_p inw
-#define inl_p inl
-
-static inline void insb(unsigned long port, void *buffer, int count)
-{
-	if (count) {
-		u8 *buf = buffer;
-		do {
-			u8 x = inb(port);
-			*buf++ = x;
-		} while (--count);
-	}
-}
-
-static inline void insw(unsigned long port, void *buffer, int count)
-{
-	if (count) {
-		u16 *buf = buffer;
-		do {
-			u16 x = inw(port);
-			*buf++ = x;
-		} while (--count);
-	}
-}
-
-static inline void insl(unsigned long port, void *buffer, int count)
-{
-	if (count) {
-		u32 *buf = buffer;
-		do {
-			u32 x = inw(port);
-			*buf++ = x;
-		} while (--count);
-	}
-}
-
-static inline void outsb(unsigned long port, const void *buffer, int count)
-{
-	if (count) {
-		const u8 *buf = buffer;
-		do {
-			outb(*buf++, port);
-		} while (--count);
-	}
-}
-
-static inline void outsw(unsigned long port, const void *buffer, int count)
-{
-	if (count) {
-		const u16 *buf = buffer;
-		do {
-			outw(*buf++, port);
-		} while (--count);
-	}
-}
-
-static inline void outsl(unsigned long port, const void *buffer, int count)
-{
-	if (count) {
-		const u32 *buf = buffer;
-		do {
-			outl(*buf++, port);
-		} while (--count);
-	}
-}
-
 /*
  * These defines are necessary to use the generic io.h for filling in
  * the missing parts of the API contract. This is because the platform
@@ -310,23 +128,6 @@ static inline void outsl(unsigned long port, const void *buffer, int count)
  */
 #define virt_to_phys virt_to_phys
 #define phys_to_virt phys_to_virt
-#define memset_io memset_io
-#define memcpy_fromio memcpy_fromio
-#define memcpy_toio memcpy_toio
-#define readb readb
-#define readw readw
-#define readl readl
-#define writeb writeb
-#define writew writew
-#define writel writel
-#define insb insb
-#define insw insw
-#define insl insl
-#define outsb outsb
-#define outsw outsw
-#define outsl outsl
 #include <asm-generic/io.h>
 
-#endif /* __KERNEL__ */
-
 #endif
diff --git a/arch/hexagon/lib/Makefile b/arch/hexagon/lib/Makefile
index a64641e89d5f..107894c0910e 100644
--- a/arch/hexagon/lib/Makefile
+++ b/arch/hexagon/lib/Makefile
@@ -2,5 +2,5 @@
 #
 # Makefile for hexagon-specific library files.
 #
-obj-y = checksum.o io.o memcpy.o memset.o memcpy_likely_aligned.o \
+obj-y = checksum.o memcpy.o memset.o memcpy_likely_aligned.o \
          divsi3.o modsi3.o udivsi3.o  umodsi3.o
diff --git a/arch/hexagon/lib/io.c b/arch/hexagon/lib/io.c
deleted file mode 100644
index 55f75392857b..000000000000
--- a/arch/hexagon/lib/io.c
+++ /dev/null
@@ -1,82 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * I/O access functions for Hexagon
- *
- * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
- */
-
-#include <asm/io.h>
-
-/*  These are all FIFO routines!  */
-
-/*
- * __raw_readsw - read words a short at a time
- * @addr:  source address
- * @data:  data address
- * @len: number of shorts to read
- */
-void __raw_readsw(const void __iomem *addr, void *data, int len)
-{
-	const volatile short int *src = (short int *) addr;
-	short int *dst = (short int *) data;
-
-	if ((u32)data & 0x1)
-		panic("unaligned pointer to readsw");
-
-	while (len-- > 0)
-		*dst++ = *src;
-
-}
-EXPORT_SYMBOL(__raw_readsw);
-
-/*
- * __raw_writesw - read words a short at a time
- * @addr:  source address
- * @data:  data address
- * @len: number of shorts to read
- */
-void __raw_writesw(void __iomem *addr, const void *data, int len)
-{
-	const short int *src = (short int *)data;
-	volatile short int *dst = (short int *)addr;
-
-	if ((u32)data & 0x1)
-		panic("unaligned pointer to writesw");
-
-	while (len-- > 0)
-		*dst = *src++;
-
-
-}
-EXPORT_SYMBOL(__raw_writesw);
-
-/*  Pretty sure len is pre-adjusted for the length of the access already */
-void __raw_readsl(const void __iomem *addr, void *data, int len)
-{
-	const volatile long *src = (long *) addr;
-	long *dst = (long *) data;
-
-	if ((u32)data & 0x3)
-		panic("unaligned pointer to readsl");
-
-	while (len-- > 0)
-		*dst++ = *src;
-
-
-}
-EXPORT_SYMBOL(__raw_readsl);
-
-void __raw_writesl(void __iomem *addr, const void *data, int len)
-{
-	const long *src = (long *)data;
-	volatile long *dst = (long *)addr;
-
-	if ((u32)data & 0x3)
-		panic("unaligned pointer to writesl");
-
-	while (len-- > 0)
-		*dst = *src++;
-
-
-}
-EXPORT_SYMBOL(__raw_writesl);
-- 
2.39.5

