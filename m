From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/31] arm64: fix the flush_icache_range arguments in machine_kexec
Date: Sun, 10 May 2020 09:54:41 +0200
Message-ID: <20200510075510.987823-3-hch@lst.de>
References: <20200510075510.987823-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3tS2yoYzMrg0UOZvWJ9XhJh/dvXLnNSqXxggBe17EKo=; b=WXL6M2CDigCoTrrOTQbYj3cAL8
        E3deOWdrOEf/MvabJAGLRmta3cWNWwpUQLs9O9xPQTtKR/zny74Qqodf5q0i+dtZQurd7PprMP02Z
        zCH+GTfTy8/EdSdq0QXQphF2VrBTPB2QC+j/W5SBqTyJfjF4Ir7yViug7OoflVJe01E5mkja6Zolt
        CDsmE1SOYiKE5y3yZTdhBjekedUaYvAaMvsWqPMmtfn/Rk0vH+dbLKa5ocleIqEB79TyGBfS64OjP
        bRL1ISrh+zpzxAAawzcuf8lAmCNy3FMHgbJZrBMAp7jiYeGkwYsrNMVSSM7ORDs4kqkCf9ABdjlfh
        PSvEFN7g==;
In-Reply-To: <20200510075510.987823-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Roman Zippel <zippel@linux-m68k.org>
Cc: Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org

The second argument is the end "pointer", not the length.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/kernel/machine_kexec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 8e9c924423b4e..a0b144cfaea71 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -177,6 +177,7 @@ void machine_kexec(struct kimage *kimage)
 	 * the offline CPUs. Therefore, we must use the __* variant here.
 	 */
 	__flush_icache_range((uintptr_t)reboot_code_buffer,
+			     (uintptr_t)reboot_code_buffer +
 			     arm64_relocate_new_kernel_size);
 
 	/* Flush the kimage list and its buffers. */
-- 
2.26.2

