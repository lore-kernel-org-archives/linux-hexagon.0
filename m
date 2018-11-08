From: Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH -next-akpm 3/3] mm: select HAVE_MOVE_PMD in x86 for faster
 mremap
Date: Thu,  8 Nov 2018 10:12:01 -0800
Message-ID: <20181108181201.88826-4-joelaf@google.com>
References: <20181108181201.88826-1-joelaf@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vOmGpS+xE0zcmUE48zeU9vsU8JY3XV5cOEvkstaN+5Q=; b=Hrv+JghhhO9eoY
	EH7m/lX0OZjUTmzF/zOd7PFbjJO4rI2oZairVNqUujBzrRd3uoZdyXeWJo4Jwefg1RvGV8QCN09h8
	R3NA77rQTiwlOzcMP534GQ2RUZHbNUfkuGWsoz6K6szdywqdQ3Ng+7Fxkucj4frlMadXHG+1W1txX
	O77Po03ZeZTUXZkMrHFcUk4NxFG2OJdmcu+7OSr3K0pfAaCJBA0u/lpDF3cJo5i+Uu09AFTKG0MCm
	j5NCpBkox1jZyW1sEMwhjVlfTeL2G90ayxU1b5cdhXM1yB1YTc4cXI+Pm2bzngSv7BqscOCDv+Fdn
	RvZx9ueIhK7e0z+iMU5w==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ba1SMLAqIgmFI6NH+RBLXEYzItBpgF4xQcT0H6ilVn4=;
 b=Sd/TmY9ueaUX+dApcoIPz7eAiunY6S8dWblAnYCegng0zsspcZ/BAyYvXqKHGnfFnr
 jrW93Eh4p6ZETBfFvU23lIxT3wP6dIvp1WSxOZnUAcSq8Wm9nP/e0Wijn/ien3UEVX4p
 QX1eigA/kEAUmS4Qut12n2rTOw/aGSwvEtyjY=
In-Reply-To: <20181108181201.88826-1-joelaf@google.com>
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
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, lokeshgidra@google.com, "Joel Fernandes (Google)" <joel@joelfernandes.org>, linux-riscv@lists.infradead.org, anton.ivanov@kot-begemot.co.uk, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, dancol@google.com, Yoshinori Sato <ysato@users.sourceforge.jp>, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>, hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com, kvmarm@l

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Moving page-tables at the PMD-level on x86 is known to be safe. Enable
this option so that we can do fast mremap when possible.

Suggested-by: Kirill A. Shutemov <kirill@shutemov.name>
Acked-by: Kirill A. Shutemov <kirill@shutemov.name>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 605bec0c228f..05f3667de0d2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -173,6 +173,7 @@ config X86
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_MIXED_BREAKPOINTS_REGS
 	select HAVE_MOD_ARCH_SPECIFIC
+	select HAVE_MOVE_PMD
 	select HAVE_NMI
 	select HAVE_OPROFILE
 	select HAVE_OPTPROBES
-- 
2.19.1.930.g4563a0d9d0-goog
