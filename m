From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5/8] unicore32: Fix __ARCH_WANT_STAT64 definition
Date: Mon, 18 Feb 2019 22:07:09 +0100
Message-ID: <20190218210712.3503891-6-arnd@arndb.de>
References: <20190218210712.3503891-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iSY7UgecMBXmTnIL22E7Dc/WTllPNd/I/ZYrdgm+bsU=; b=djJ0GaRTlni3w3
	w3IoQvpNEAlTAMTAlJKUQi8vko4y6l8ZKkxTQdN2TrrDZgDhHXlPc1rdsyzXI1OMHZAaepZb4eaj+
	I9Hf0GBo+qNHwJE/NttPwRpi7PNBJL0T6/CHiJaGMlxo3MUmT9m7pkep4GAey55F8DV4I9gjdIAlm
	yDnOX107knti+OC8tCqrpmbnY+CB2GkaB88AkjKMuf2wFx8GxrN8KhhFVGdue3m+iYHJcqi+hiMlW
	i20MAzH+1pqigjn6Du9AeqekYAjub26Sfj0KiW3phvXnMFxholGtkLAYwjWhb+Jj+ln3dV4mk9Bts
	IuH1GiBxk5NoSJc5ujfA==;
In-Reply-To: <20190218210712.3503891-1-arnd@arndb.de>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: y2038@lists.linaro.org
Cc: linux-arch@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, arnd@arndb.de, yury.norov@gmail.com, linux-api@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Vineet Gupta <vgupta@synopsys.com>, Guo Ren <guoren@kernel.org>, Greentime Hu <green.hu@gmail.com>, linux-hexagon@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Guan Xuetao <gxt@pku.edu.cn>, Stafford Horne <shorne@gmail.com>, linux-arm-kernel@lists.infradead.org

The __ARCH_WANT_STAT64 macro must be defined before including
asm-generic/unistd.h. I got this right for everything except
unicore32.

Fixes: bf4b6a7d371e ("y2038: Remove stat64 family from default syscall set")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/unicore32/include/uapi/asm/unistd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/unicore32/include/uapi/asm/unistd.h b/arch/unicore32/include/uapi/asm/unistd.h
index 4e5e624f5d7e..54a7378a70b1 100644
--- a/arch/unicore32/include/uapi/asm/unistd.h
+++ b/arch/unicore32/include/uapi/asm/unistd.h
@@ -13,9 +13,9 @@
 
 #define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_SET_GET_RLIMIT
+#define __ARCH_WANT_STAT64
 #define __ARCH_WANT_TIME32_SYSCALLS
 
 /* Use the standard ABI for syscalls. */
 #include <asm-generic/unistd.h>
-#define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_CLONE
-- 
2.20.0
