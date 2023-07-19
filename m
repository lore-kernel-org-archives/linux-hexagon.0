From: Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH v2 9/9] efi: move screen_info into efi init code
Date: Wed, 19 Jul 2023 14:39:44 +0200
Message-ID: <20230719123944.3438363-10-arnd@kernel.org>
References: <20230719123944.3438363-1-arnd@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NwXdZBktxsV3/W4Bh7CFOG6SmJ0D01JF6VLDyLPV4ek=; b=M8w/DWGiP9zl7h
	RjIfmJtebDSCtZeVfcKcm57BkAdMtIw4pvA/ZkVQ9XA6KOYz6a8xlQf8TfJKMhiQTabMCBImP0ArZ
	S381d8XgzoKVeAIU5I+pkHNMXRTtRlI28AdotqIEQXi5uqiS3QCO0slR/P4MreJIrpmmEFiWUbpWa
	Ydziz/akddRheq94Y76O9PdvMO2RJ2Jao+F54S+YLiGi8RDvQXyujpx8J16JC6X+m+Vsk7xrwLMQ5
	17w5gs8tU7h4VcRzyifhpZp5CQK8XwBJZUyA8np6B9Kf1YGevXp/r0xAq1jP8AdplDnDn5rPS95mm
	QG+J10iKipZWCl5+1yyQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689770502;
	bh=QY56G9sStLrW/jpZJL34RSfA39Lgimj77x9wAgnTwKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sjP1r68GhqPeRtXe827oZjgvfqsr2Kz6jrTRHHaJXY1QqllMVnXytbGdGLmFx1DYl
	 ZZ4jZLtG3wB/uEuHgmX4UvxjdfvODxXuclsAx+unckRlkE6K3Q4uoOvZicqqZ6eDY/
	 lVLPdUylNAotLohfrI6a0VEs89nV9Z338ZvAcu60wvJa91d7tTZ42ko4IDJLV/AWoI
	 +G0GuXTTwO/InerZqm+4HNgDF0/x2I/Kon118vYZAOx3lhMtaWNawYlxLIfXwgUTRU
	 w8Oyu6p/x9InB4vHL0N6VEA0KCfr4KA6E+eyPDhU0janG05aYXnmXUzd7z7YT6GMHR
	 Um+08NCtT/Y7Q==
In-Reply-To: <20230719123944.3438363-1-arnd@kernel.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>, Javier Martinez Canillas <javierm@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, "K. Y. Srinivasan" <kys@microsoft.com>, Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>, Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Daniel Vetter <daniel@ffwll.ch>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@gmail.com>, Deepak Rawat <drawat.floss@gmail.com>, Dexuan Cui <decui@microsoft.com>, Dinh Nguyen <dinguyen@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guo Ren <guoren@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Khalid Aziz <khalid@gonehiking.org>, Linus Walleij <linus.walleij@linaro.org>, Matt Turner <mattst88@gmail.com>

From: Arnd Bergmann <arnd@arndb.de>

After the vga console no longer relies on global screen_info, there are
only two remaining use cases:

 - on the x86 architecture, it is used for multiple boot methods
   (bzImage, EFI, Xen, kexec) to commicate the initial VGA or framebuffer
   settings to a number of device drivers.

 - on other architectures, it is only used as part of the EFI stub,
   and only for the three sysfb framebuffers (simpledrm, simplefb, efifb).

Remove the duplicate data structure definitions by moving it into the
efi-init.c file that sets it up initially for the EFI case, leaving x86
as an exception that retains its own definition for non-EFI boots.

The added #ifdefs here are optional, I added them to further limit the
reach of screen_info to configurations that have at least one of the
users enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/setup.c                       |  4 ----
 arch/arm64/kernel/efi.c                       |  4 ----
 arch/arm64/kernel/image-vars.h                |  2 ++
 arch/ia64/kernel/setup.c                      |  4 ----
 arch/loongarch/kernel/efi.c                   |  3 ++-
 arch/loongarch/kernel/image-vars.h            |  2 ++
 arch/loongarch/kernel/setup.c                 |  5 -----
 arch/riscv/kernel/image-vars.h                |  2 ++
 arch/riscv/kernel/setup.c                     |  5 -----
 drivers/firmware/efi/efi-init.c               | 14 +++++++++++++-
 drivers/firmware/efi/libstub/efi-stub-entry.c |  8 +++++++-
 11 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 86c2751f56dcf..135b7eff03f72 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -939,10 +939,6 @@ static struct screen_info vgacon_screen_info = {
 };
 #endif
 
-#if defined(CONFIG_EFI)
-struct screen_info screen_info;
-#endif
-
 static int __init customize_machine(void)
 {
 	/*
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 3afbe503b066f..ff2d5169d7f1f 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -71,10 +71,6 @@ static __init pteval_t create_mapping_protection(efi_memory_desc_t *md)
 	return pgprot_val(PAGE_KERNEL_EXEC);
 }
 
-/* we will fill this structure from the stub, so don't put it in .bss */
-struct screen_info screen_info __section(".data");
-EXPORT_SYMBOL(screen_info);
-
 int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
 {
 	pteval_t prot_val = create_mapping_protection(md);
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 35f3c79595137..5e4dc72ab1bda 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -27,7 +27,9 @@ PROVIDE(__efistub__text			= _text);
 PROVIDE(__efistub__end			= _end);
 PROVIDE(__efistub___inittext_end       	= __inittext_end);
 PROVIDE(__efistub__edata		= _edata);
+#if defined(CONFIG_EFI_EARLYCON) || defined(CONFIG_SYSFB)
 PROVIDE(__efistub_screen_info		= screen_info);
+#endif
 PROVIDE(__efistub__ctype		= _ctype);
 
 PROVIDE(__pi___memcpy			= __pi_memcpy);
diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index 82feae1323f40..e91a91b5e9142 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -86,10 +86,6 @@ EXPORT_SYMBOL(local_per_cpu_offset);
 #endif
 unsigned long ia64_cycles_per_usec;
 struct ia64_boot_param *ia64_boot_param;
-#if defined(CONFIG_EFI)
-/* No longer used on ia64, but needed for linking */
-struct screen_info screen_info;
-#endif
 #ifdef CONFIG_VGA_CONSOLE
 unsigned long vga_console_iobase;
 unsigned long vga_console_membase;
diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
index 9fc10cea21e10..df7db34024e61 100644
--- a/arch/loongarch/kernel/efi.c
+++ b/arch/loongarch/kernel/efi.c
@@ -115,7 +115,8 @@ void __init efi_init(void)
 
 	set_bit(EFI_CONFIG_TABLES, &efi.flags);
 
-	init_screen_info();
+	if (IS_ENABLED(CONFIG_EFI_EARLYCON) || IS_ENABLED(CONFIG_SYSFB))
+		init_screen_info();
 
 	if (boot_memmap == EFI_INVALID_TABLE_ADDR)
 		return;
diff --git a/arch/loongarch/kernel/image-vars.h b/arch/loongarch/kernel/image-vars.h
index e561989d02de9..5087416b9678d 100644
--- a/arch/loongarch/kernel/image-vars.h
+++ b/arch/loongarch/kernel/image-vars.h
@@ -12,7 +12,9 @@ __efistub_kernel_entry		= kernel_entry;
 __efistub_kernel_asize		= kernel_asize;
 __efistub_kernel_fsize		= kernel_fsize;
 __efistub_kernel_offset		= kernel_offset;
+#if defined(CONFIG_EFI_EARLYCON) || defined(CONFIG_SYSFB)
 __efistub_screen_info		= screen_info;
+#endif
 
 #endif
 
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 77e7a3722caa6..4570c3149b849 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -16,7 +16,6 @@
 #include <linux/dmi.h>
 #include <linux/efi.h>
 #include <linux/export.h>
-#include <linux/screen_info.h>
 #include <linux/memblock.h>
 #include <linux/initrd.h>
 #include <linux/ioport.h>
@@ -57,10 +56,6 @@
 #define SMBIOS_CORE_PACKAGE_OFFSET	0x23
 #define LOONGSON_EFI_ENABLE		(1 << 3)
 
-#ifdef CONFIG_EFI
-struct screen_info screen_info __section(".data");
-#endif
-
 unsigned long fw_arg0, fw_arg1, fw_arg2;
 DEFINE_PER_CPU(unsigned long, kernelsp);
 struct cpuinfo_loongarch cpu_data[NR_CPUS] __read_mostly;
diff --git a/arch/riscv/kernel/image-vars.h b/arch/riscv/kernel/image-vars.h
index 15616155008cc..89d92f9644d5e 100644
--- a/arch/riscv/kernel/image-vars.h
+++ b/arch/riscv/kernel/image-vars.h
@@ -27,7 +27,9 @@ __efistub__start		= _start;
 __efistub__start_kernel		= _start_kernel;
 __efistub__end			= _end;
 __efistub__edata		= _edata;
+#if defined(CONFIG_EFI_EARLYCON) || defined(CONFIG_SYSFB)
 __efistub_screen_info		= screen_info;
+#endif
 
 #endif
 
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index a3dbe13f45fb3..aea585dc8e8f3 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -15,7 +15,6 @@
 #include <linux/memblock.h>
 #include <linux/sched.h>
 #include <linux/console.h>
-#include <linux/screen_info.h>
 #include <linux/of_fdt.h>
 #include <linux/sched/task.h>
 #include <linux/smp.h>
@@ -39,10 +38,6 @@
 
 #include "head.h"
 
-#if defined(CONFIG_EFI)
-struct screen_info screen_info __section(".data");
-#endif
-
 /*
  * The lucky hart to first increment this variable will boot the other cores.
  * This is used before the kernel initializes the BSS so it can't be in the
diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index ef0820f1a9246..d4987d0130801 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -55,6 +55,15 @@ static phys_addr_t __init efi_to_phys(unsigned long addr)
 
 extern __weak const efi_config_table_type_t efi_arch_tables[];
 
+/*
+ * x86 defines its own screen_info and uses it even without EFI,
+ * everything else can get it from here.
+ */
+#if !defined(CONFIG_X86) && (defined(CONFIG_SYSFB) || defined(CONFIG_EFI_EARLYCON))
+struct screen_info screen_info __section(".data");
+EXPORT_SYMBOL_GPL(screen_info);
+#endif
+
 static void __init init_screen_info(void)
 {
 	struct screen_info *si;
@@ -240,5 +249,8 @@ void __init efi_init(void)
 	memblock_reserve(data.phys_map & PAGE_MASK,
 			 PAGE_ALIGN(data.size + (data.phys_map & ~PAGE_MASK)));
 
-	init_screen_info();
+	if (IS_ENABLED(CONFIG_X86) ||
+	    IS_ENABLED(CONFIG_SYSFB) ||
+	    IS_ENABLED(CONFIG_EFI_EARLYCON))
+		init_screen_info();
 }
diff --git a/drivers/firmware/efi/libstub/efi-stub-entry.c b/drivers/firmware/efi/libstub/efi-stub-entry.c
index 2f1902e5d4075..a6c0498351905 100644
--- a/drivers/firmware/efi/libstub/efi-stub-entry.c
+++ b/drivers/firmware/efi/libstub/efi-stub-entry.c
@@ -13,7 +13,13 @@ struct screen_info *alloc_screen_info(void)
 {
 	if (IS_ENABLED(CONFIG_ARM))
 		return __alloc_screen_info();
-	return (void *)&screen_info + screen_info_offset;
+
+	if (IS_ENABLED(CONFIG_X86) ||
+	    IS_ENABLED(CONFIG_EFI_EARLYCON) ||
+	    IS_ENABLED(CONFIG_SYSFB))
+		return (void *)&screen_info + screen_info_offset;
+
+	return NULL;
 }
 
 /*
-- 
2.39.2
