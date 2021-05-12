From: Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/5] kbuild: require all architectures to have
 arch/$(SRCARCH)/Kbuild
Date: Wed, 12 May 2021 16:57:25 +0900
Message-ID: <20210512075729.60291-1-masahiroy@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DkEBxxqsCsgFMuds30XSzsEpBj9V/HRoUK3+HiIicdE=; b=AlNRVeYeprDTNVLx0dVOWrnSpf
	pj4I/T31yLpG3TEaNKNabl2JTL1Zi2G01kfXIXk6AF+7rzTllsxyLpInH1eGTZWuZ4biYkENmyo+e
	p1CJvbV//wVoMrY7r88FrOEn9nL+9d+mU8rrVtvoaKcPptPKtOU6BJS9LghDoN0d7a9dxMa5av7Ie
	/Ks/u17dBQrqdVZ2wFJ7wcgOWSKDt2miSO0SfVw5OsYWGk1aqEpJyvhxieKwIox5Sn+oarnHP3GY6
	0OL7NfRNAg+y55QAxO0eogBlC2wAmYVs7+5CfEKF6qes0ZNWltBgHGDVwdGXawoPISv+ltzl/E54a
	DSgRX4KA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=wIUNhcOB6btFOL0gSpr92RlYruAqiaKJ+SP4MHn4OAA=; b=FI8zXmg5sLIHg8DA47goUGY4Fs
 /K59lDjguqORrzL2TOIPeMbtuHI//uFR8kZ+mQyu7CxTEzSlkdStEDOZACQ/krbiaQUqYJSyldrcC
 p912yqLNP/vOteplI+fRnC58WPrNw97X8S6XtaDGZYbIKPzOE1GjdyobE/1Jekw2zuwZbgNHTnvCj
 MVSygv1ulZjKRRt/CT3C4utLP/JxYNRgGXtFKhWCiAbl9hpJVfAD8gFiBPq7UI+hLN7wHwgKojr1f
 cpPoJd8mXzkn+0n+sAThhh73lEGihJI4rjDxvekixGkit22DhdSXRP+fK4+28oM1vk10R/pQAhPOv
 FQ7KX+aQ==;
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 14C7vbPs028192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1620806261;
 bh=wIUNhcOB6btFOL0gSpr92RlYruAqiaKJ+SP4MHn4OAA=;
 h=From:To:Cc:Subject:Date:From;
 b=MEPfaL+dgaQHelu1aORa4dkshKUoXyML9ToegfF2X/+DDlDkT2NTxvVtRobsDkp3y
 w6q0OMUPClkMLevvjlJySVaAGk9chQn5JmHYb+Sby+ocz18EmUyh5EfwgbghPbCUMs
 BfqHu2GczlJunlpKBWtiGYnb5THa+fwMAHT17a+4GK1J+KWFOc18MvDzUYfMdu9apT
 X6Smfz3LDGjObml+5VUPVmYQNjXkkTpqKOuY3LDfkxKy7PEEqqJdMx9ujR6UWsgJpM
 n0Q+gHtNpnXSYPWFtp4AhWmiwdi6gcYpdR3mkS/pbX/h/3dXftILrjdVKvAqW4utJB
 bGXpxDJOBDv8Q==
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
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Chris Zankel <chris@zankel.net>, Christian Borntraeger <borntraeger@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Greentime Hu <green.hu@gmail.com>, Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Jeff Dike <jdike@addtoit.com>, Jonas Bonn <jonas@southpole.se>, Ley Foon Tan <ley.foon.tan@intel.com>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>

arch/$(SRCARCH)/Kbuild is useful for Makefile cleanups because you can
use the obj-y syntax.

Add an empty file if it is missing in arch/$(SRCARCH)/.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile               | 2 +-
 arch/alpha/Kbuild      | 1 +
 arch/arc/Makefile      | 3 ---
 arch/arm/Makefile      | 1 -
 arch/arm64/Makefile    | 1 -
 arch/csky/Kbuild       | 1 +
 arch/h8300/Kbuild      | 1 +
 arch/hexagon/Kbuild    | 1 +
 arch/ia64/Kbuild       | 1 +
 arch/microblaze/Kbuild | 1 +
 arch/mips/Makefile     | 3 ---
 arch/nds32/Kbuild      | 1 +
 arch/nios2/Kbuild      | 1 +
 arch/openrisc/Makefile | 1 -
 arch/parisc/Kbuild     | 1 +
 arch/powerpc/Makefile  | 3 ---
 arch/riscv/Makefile    | 1 -
 arch/s390/Makefile     | 3 ---
 arch/sh/Kbuild         | 1 +
 arch/sparc/Makefile    | 3 ---
 arch/um/Kbuild         | 1 +
 arch/x86/Makefile      | 3 ---
 arch/xtensa/Kbuild     | 1 +
 23 files changed, 13 insertions(+), 23 deletions(-)
 create mode 100644 arch/alpha/Kbuild
 create mode 100644 arch/csky/Kbuild
 create mode 100644 arch/h8300/Kbuild
 create mode 100644 arch/hexagon/Kbuild
 create mode 100644 arch/ia64/Kbuild
 create mode 100644 arch/microblaze/Kbuild
 create mode 100644 arch/nds32/Kbuild
 create mode 100644 arch/nios2/Kbuild
 create mode 100644 arch/parisc/Kbuild
 create mode 100644 arch/sh/Kbuild
 create mode 100644 arch/um/Kbuild
 create mode 100644 arch/xtensa/Kbuild

diff --git a/Makefile b/Makefile
index 15b6476d0f89..7df040b1b023 100644
--- a/Makefile
+++ b/Makefile
@@ -658,7 +658,7 @@ endif
 
 ifeq ($(KBUILD_EXTMOD),)
 # Objects we will link into vmlinux / subdirs we need to visit
-core-y		:= init/ usr/
+core-y		:= init/ usr/ arch/$(SRCARCH)/
 drivers-y	:= drivers/ sound/
 drivers-$(CONFIG_SAMPLES) += samples/
 drivers-$(CONFIG_NET) += net/
diff --git a/arch/alpha/Kbuild b/arch/alpha/Kbuild
new file mode 100644
index 000000000000..a4e40e534e6a
--- /dev/null
+++ b/arch/alpha/Kbuild
@@ -0,0 +1 @@
+# SPDX-License-Identifier: GPL-2.0-only
diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index 4392c9c189c4..3e6d4b84797f 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -85,9 +85,6 @@ KBUILD_LDFLAGS	+= $(ldflags-y)
 
 head-y		:= arch/arc/kernel/head.o
 
-# See arch/arc/Kbuild for content of core part of the kernel
-core-y		+= arch/arc/
-
 # w/o this dtb won't embed into kernel binary
 core-y		+= arch/arc/boot/dts/
 
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 415c3514573a..173da685a52e 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -252,7 +252,6 @@ endif
 
 export	TEXT_OFFSET GZFLAGS MMUEXT
 
-core-y				+= arch/arm/
 # If we have a machine-specific directory, then include it in the build.
 core-y				+= $(machdirs) $(platdirs)
 
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 7ef44478560d..b73c151f3a53 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -149,7 +149,6 @@ KBUILD_CFLAGS += -DKASAN_SHADOW_SCALE_SHIFT=$(KASAN_SHADOW_SCALE_SHIFT)
 KBUILD_CPPFLAGS += -DKASAN_SHADOW_SCALE_SHIFT=$(KASAN_SHADOW_SCALE_SHIFT)
 KBUILD_AFLAGS += -DKASAN_SHADOW_SCALE_SHIFT=$(KASAN_SHADOW_SCALE_SHIFT)
 
-core-y		+= arch/arm64/
 libs-y		:= arch/arm64/lib/ $(libs-y)
 libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
diff --git a/arch/csky/Kbuild b/arch/csky/Kbuild
new file mode 100644
index 000000000000..a4e40e534e6a
--- /dev/null
+++ b/arch/csky/Kbuild
@@ -0,0 +1 @@
+# SPDX-License-Identifier: GPL-2.0-only
diff --git a/arch/h8300/Kbuild b/arch/h8300/Kbuild
new file mode 100644
index 000000000000..a4e40e534e6a
--- /dev/null
+++ b/arch/h8300/Kbuild
@@ -0,0 +1 @@
+# SPDX-License-Identifier: GPL-2.0-only
diff --git a/arch/hexagon/Kbuild b/arch/hexagon/Kbuild
new file mode 100644
index 000000000000..a4e40e534e6a
--- /dev/null
+++ b/arch/hexagon/Kbuild
@@ -0,0 +1 @@
+# SPDX-License-Identifier: GPL-2.0-only
diff --git a/arch/ia64/Kbuild b/arch/ia64/Kbuild
new file mode 100644
index 000000000000..a4e40e534e6a
--- /dev/null
+++ b/arch/ia64/Kbuild
@@ -0,0 +1 @@
+# SPDX-License-Identifier: GPL-2.0-only
diff --git a/arch/microblaze/Kbuild b/arch/microblaze/Kbuild
new file mode 100644
index 000000000000..a4e40e534e6a
--- /dev/null
+++ b/arch/microblaze/Kbuild
@@ -0,0 +1 @@
+# SPDX-License-Identifier: GPL-2.0-only
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 258234c35a09..4e942b7ef022 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -332,9 +332,6 @@ head-y := arch/mips/kernel/head.o
 libs-y			+= arch/mips/lib/
 libs-$(CONFIG_MIPS_FP_SUPPORT) += arch/mips/math-emu/
 
-# See arch/mips/Kbuild for content of core part of the kernel
-core-y += arch/mips/
-
 drivers-y			+= arch/mips/crypto/
 
 # suspend and hibernation support
diff --git a/arch/nds32/Kbuild b/arch/nds32/Kbuild
new file mode 100644
index 000000000000..a4e40e534e6a
--- /dev/null
+++ b/arch/nds32/Kbuild
@@ -0,0 +1 @@
+# SPDX-License-Identifier: GPL-2.0-only
diff --git a/arch/nios2/Kbuild b/arch/nios2/Kbuild
new file mode 100644
index 000000000000..a4e40e534e6a
--- /dev/null
+++ b/arch/nios2/Kbuild
@@ -0,0 +1 @@
+# SPDX-License-Identifier: GPL-2.0-only
diff --git a/arch/openrisc/Makefile b/arch/openrisc/Makefile
index 410e7abfac69..c52de526e518 100644
--- a/arch/openrisc/Makefile
+++ b/arch/openrisc/Makefile
@@ -42,7 +42,6 @@ endif
 
 head-y 		:= arch/openrisc/kernel/head.o
 
-core-y		+= arch/openrisc/
 libs-y		+= $(LIBGCC)
 
 PHONY += vmlinux.bin
diff --git a/arch/parisc/Kbuild b/arch/parisc/Kbuild
new file mode 100644
index 000000000000..a4e40e534e6a
--- /dev/null
+++ b/arch/parisc/Kbuild
@@ -0,0 +1 @@
+# SPDX-License-Identifier: GPL-2.0-only
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 3212d076ac6a..af669aa75b73 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -267,9 +267,6 @@ head-$(CONFIG_PPC_FPU)		+= arch/powerpc/kernel/fpu.o
 head-$(CONFIG_ALTIVEC)		+= arch/powerpc/kernel/vector.o
 head-$(CONFIG_PPC_OF_BOOT_TRAMPOLINE)  += arch/powerpc/kernel/prom_init.o
 
-# See arch/powerpc/Kbuild for content of core part of the kernel
-core-y += arch/powerpc/
-
 # Default to zImage, override when needed
 all: zImage
 
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 3eb9590a0775..c5f359540862 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -90,7 +90,6 @@ endif
 
 head-y := arch/riscv/kernel/head.o
 
-core-y += arch/riscv/
 core-$(CONFIG_RISCV_ERRATA_ALTERNATIVE) += arch/riscv/errata/
 
 libs-y += arch/riscv/lib/
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index e443ed9947bd..37b61645694c 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -128,9 +128,6 @@ OBJCOPYFLAGS	:= -O binary
 
 head-y		:= arch/s390/kernel/head64.o
 
-# See arch/s390/Kbuild for content of core part of the kernel
-core-y		+= arch/s390/
-
 libs-y		+= arch/s390/lib/
 drivers-y	+= drivers/s390/
 
diff --git a/arch/sh/Kbuild b/arch/sh/Kbuild
new file mode 100644
index 000000000000..a4e40e534e6a
--- /dev/null
+++ b/arch/sh/Kbuild
@@ -0,0 +1 @@
+# SPDX-License-Identifier: GPL-2.0-only
diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index bee99e65fe23..4e65245bc755 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -58,9 +58,6 @@ endif
 
 head-y                 := arch/sparc/kernel/head_$(BITS).o
 
-# See arch/sparc/Kbuild for the core part of the kernel
-core-y                 += arch/sparc/
-
 libs-y                 += arch/sparc/prom/
 libs-y                 += arch/sparc/lib/
 
diff --git a/arch/um/Kbuild b/arch/um/Kbuild
new file mode 100644
index 000000000000..a4e40e534e6a
--- /dev/null
+++ b/arch/um/Kbuild
@@ -0,0 +1 @@
+# SPDX-License-Identifier: GPL-2.0-only
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index c77c5d8a7b3e..4307bf48ec53 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -239,9 +239,6 @@ head-y += arch/x86/kernel/platform-quirks.o
 
 libs-y  += arch/x86/lib/
 
-# See arch/x86/Kbuild for content of core part of the kernel
-core-y += arch/x86/
-
 # drivers-y are linked after core-y
 drivers-$(CONFIG_MATH_EMULATION) += arch/x86/math-emu/
 drivers-$(CONFIG_PCI)            += arch/x86/pci/
diff --git a/arch/xtensa/Kbuild b/arch/xtensa/Kbuild
new file mode 100644
index 000000000000..a4e40e534e6a
--- /dev/null
+++ b/arch/xtensa/Kbuild
@@ -0,0 +1 @@
+# SPDX-License-Identifier: GPL-2.0-only
-- 
2.27.0
