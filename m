From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 0/2] arm64: Cut rebuild time when changing
 CONFIG_BLK_DEV_INITRD
Date: Tue, 23 Oct 2018 16:40:41 -0700
Message-ID: <20181023234044.1138-1-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=YZ6W36Ou6pHvijaT8GrexddleITW+X749z+oVWljvCw=; b=HhF
	RoECzbjhT/5LOY5EjAvDlUj8HYgISIjoWoBf8ApU8odoCNzDnFq5aDnY2wLcshmIK4iS8vf4LnOUk
	RLDDN5siamEThAxUkxG3W/nHT9snADfbSBFMQLB41lmDKDi9C76xlAMcLj7+Y+YbQrh2Ufpsn8D4N
	YqO+1MRS7d+Gjyj25DbTz20F6xfB1tTseZ/ukI+2fpZra1qWSr/EEgIMm+HICtdHATWBZHByKDMi2
	jv+SBlKecpRJ5HSR4HBaMS0mJtjVvvegLu8mIGbIQASXXgcKqEx6UFZrDKDZiAhhz9+RGFjS2Pw2F
	ccpw3TXqtOCfSAyOfHtrb+8qKpfK4xw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=7OS2r3euy1TczlyR46QbFm62nalquqEBBOjTowUcAkM=;
 b=JZ1FQW2sjznoZVhwKxRvzGXbACgNDowsPsyxlWZVVG7INAURVS5jcxx915CmrAtFRB
 8hWt+dLKEAVaszN//gmUjAYoT7FDyiMui97wYDmRNVObbg407myVHSOQQZ2tzM6HKXjZ
 mHfpSVcF4JVoAjUiAlqOz8+OgLkgiyNTMN4slZ2nQdl2qnD25v68X/twk29GWgHctS5W
 xnYbKMErl9Jjcz+rWWWrl4jqwHUvFwF5J4+jg0wCCfi+5wfY10suO+glJ/huiOk8gQQR
 VFWKT2AnmDQl75D4iT3d+hUeGJI3o/5MTq/bf6m/xNvsxIAEvup7H34zIhNHpVjgjKte
 er4Q==
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: "open list:MIPS" <linux-mips@linux-mips.org>, Alan Kao <alankao@andestech.com>, "open list:SUPERH" <linux-sh@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Matt Turner <mattst88@gmail.com>, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, Marc Zyngier <marc.zyngier@arm.com>, "open list:USER-MODE LINUX UML" <linux-um@lists.infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>, Matt Redfearn <matt.redfearn@mips.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ralf

Hi all,

While investigating why ARM64 required a ton of objects to be rebuilt
when toggling CONFIG_DEV_BLK_INITRD, it became clear that this was
because we define __early_init_dt_declare_initrd() differently and we do
that in arch/arm64/include/asm/memory.h which gets included by a fair
amount of other header files, and translation units as well.

This patch series proposes adding an empty initrd.h to satisfy the need
for drivers/of/fdt.c to unconditionally include that file, and moves the
custom __early_init_dt_declare_initrd() definition away from
asm/memory.h

This cuts the number of objects rebuilds from 1920 down to 26, so a
factor 73 approximately.

Apologies for the long CC list, please let me know how you would go
about merging that and if another approach would be preferable, e.g:
introducing a CONFIG_ARCH_INITRD_BELOW_START_OK Kconfig option or
something like that.

Florian Fainelli (2):
  arch: Add asm-generic/initrd.h and make use of it for most
    architectures
  arm64: Create asm/initrd.h

 arch/alpha/include/asm/Kbuild      |  1 +
 arch/arc/include/asm/Kbuild        |  1 +
 arch/arm/include/asm/Kbuild        |  1 +
 arch/arm64/include/asm/initrd.h    | 13 +++++++++++++
 arch/arm64/include/asm/memory.h    |  8 --------
 arch/c6x/include/asm/Kbuild        |  1 +
 arch/h8300/include/asm/Kbuild      |  1 +
 arch/hexagon/include/asm/Kbuild    |  1 +
 arch/ia64/include/asm/Kbuild       |  1 +
 arch/m68k/include/asm/Kbuild       |  1 +
 arch/microblaze/include/asm/Kbuild |  1 +
 arch/mips/include/asm/Kbuild       |  1 +
 arch/nds32/include/asm/Kbuild      |  1 +
 arch/nios2/include/asm/Kbuild      |  1 +
 arch/openrisc/include/asm/Kbuild   |  1 +
 arch/parisc/include/asm/Kbuild     |  1 +
 arch/powerpc/include/asm/Kbuild    |  1 +
 arch/riscv/include/asm/Kbuild      |  1 +
 arch/s390/include/asm/Kbuild       |  1 +
 arch/sh/include/asm/Kbuild         |  1 +
 arch/sparc/include/asm/Kbuild      |  1 +
 arch/um/include/asm/Kbuild         |  1 +
 arch/unicore32/include/asm/Kbuild  |  1 +
 arch/x86/include/asm/Kbuild        |  1 +
 arch/xtensa/include/asm/Kbuild     |  1 +
 drivers/of/fdt.c                   |  1 +
 include/asm-generic/initrd.h       |  1 +
 27 files changed, 38 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/include/asm/initrd.h
 create mode 100644 include/asm-generic/initrd.h

-- 
2.17.1
