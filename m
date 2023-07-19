From: Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH v2 1/9] vgacon: rework Kconfig dependencies
Date: Wed, 19 Jul 2023 14:39:36 +0200
Message-ID: <20230719123944.3438363-2-arnd@kernel.org>
References: <20230719123944.3438363-1-arnd@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-ia64-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689770415;
        bh=2Mh2IaKPPNhzRZYphoca+mrfCEIgr8Qop4RzoTlfeXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kdnJnXZBopbW8ulNYqpU/DMRLnFvRdebMFTyM5ZbUz9uphIDnfM1bwXcJy4q98hV1
         YvkNVBvKC8yohU9kFV2O9rZzsV6BHo+Gp7r57jtuzwT2EGjbSI3SGel3uViBRPEhBb
         ip/PIfXyASkYOykVmYw18TlYUqquf6JTgcIuRtHIZikFIK7mW6+f54j0fN2gBg6Mo9
         33y9RPC8lI3s6GaxlRiG4j0ziax6mnCs9g+lTmKKsuJzAhAhhCpC6roDYXyvQfy8DJ
         QnH2m6TVUl1aV/rdXInE2gIEgG+xSamAjI3mkmHoaGPYauUBjJf5u1R0YwiqgRL3Hb
         2sr2V6misyjqQ==
In-Reply-To: <20230719123944.3438363-1-arnd@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>, Javier Martinez Canillas <javierm@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, "K. Y. Srinivasan" <kys@microsoft.com>, Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>, Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Daniel Vetter <daniel@ffwll.ch>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@gmail.com>, Deepak Rawat <drawat.floss@gmail.com>, Dexuan Cui <decui@microsoft.com>, Dinh Nguyen <dinguyen@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guo Ren <guoren@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu->

From: Arnd Bergmann <arnd@arndb.de>

The list of dependencies here is phrased as an opt-out, but this is missing
a lot of architectures that don't actually support VGA consoles, and some
of the entries are stale:

 - powerpc used to support VGA consoles in the old arch/ppc codebase, but
   the merged arch/powerpc never did

 - arm lists footbridge, integrator and netwinder, but netwinder is actually
   part of footbridge, and integrator does not appear to have an actual
   VGA hardware, or list it in its ATAG or DT.

 - mips has a few platforms (malta, sibyte, and sni) that initialize
   screen_info, on everything else the console is selected but cannot
   actually work.

 - csky, hexgagon, loongarch, nios2, riscv and xtensa are not listed
   in the opt-out table and declare a screen_info to allow building
   vga_con, but this cannot work because the console is never selected.

Replace this with an opt-in table that lists only the platforms that
remain. This is effectively x86, plus a couple of historic workstation
and server machines that reused parts of the x86 system architecture.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/console/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 1b5a319971ed0..6af90db6d2da9 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -7,9 +7,9 @@ menu "Console display driver support"
 
 config VGA_CONSOLE
 	bool "VGA text console" if EXPERT || !X86
-	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC &&  !SUPERH && \
-		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
-		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !S390 && !UML
+	depends on ALPHA || IA64 || X86 || \
+		(ARM && ARCH_FOOTBRIDGE) || \
+		(MIPS && (MIPS_MALTA || SIBYTE_BCM112X || SIBYTE_SB1250 || SIBYTE_BCM1x80 || SNI_RM))
 	select APERTURE_HELPERS if (DRM || FB || VFIO_PCI_CORE)
 	default y
 	help
-- 
2.39.2

