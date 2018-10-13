From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 3/4] arm64: select HAVE_MOVE_PMD for faster mremap (v1)
Date: Fri, 12 Oct 2018 18:31:59 -0700
Message-ID: <20181013013200.206928-4-joel@joelfernandes.org>
References: <20181013013200.206928-1-joel@joelfernandes.org>
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
	List-Owner; bh=7nbaYAZCArkwulWcph7mnWBdigkVmF+XmR+PMMvt/cc=; b=i5fuiKu2eQo613
	Ab6hpclGDFS1Vo5SYmtyLQ1/6ezXH8OO+KZVcKLDRrSDN5cni9jAOe3wwVjYJM0D0cIsB+OXdvHQk
	JRtfmmA80qVkOX3nEc9uxnQuQhFxbKv0txubdmBU5efVY2eDJXn3AYdPyecCjYD4+SS4KWW7u2c5o
	yb3mIkSOD84BMydBXRFBVWtt+yAnO/LW4qt6b+hqqAhylr9nfCkt3LF4yGlT8WvENEyeImLSpv1bi
	nhox6wWhgvOkOrO8KWt3BLZAcFtdNAzBkrHAPlcnJhU6I8pYpYiIaEkfuUKhbo9lzSC+lYeNVmPSm
	kNEfpU+abMnK4IlhnXpg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bjYTsH4Iq69Ub7N2c7p2HOCfpyLGuHcm9WhDWE1Dnwg=;
 b=pvEfVikziMJRWxtTRTm3WwDM1z7pcXybcAtnjCIyQdfWN8O5jRGdCgjUlGTjsMAT/F
 saWeGlI2HK0vC3ro6vBYXn3xIZY1BMwuP8djzpt6M+eKMtkHqPqZ+mldfVclfk22srUA
 b5EsPUgxygKFL8hgKZ6UMDusfAYxbbW7exB4M=
In-Reply-To: <20181013013200.206928-1-joel@joelfernandes.org>
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
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, mhocko@kernel.org, linux-mm@kvack.org, lokeshgidra@google.com, "Joel Fernandes (Google)" <joel@joelfernandes.org>, linux-riscv@lists.infradead.org, elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>, kvmarm@lists.cs.columbia.edu, dancol@google.com, Yoshinori Sato <ysato@users.sourceforge.jp>, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>, hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com, anton.ivanov@kot-begem

Moving page-tables at the PMD-level on arm64 is known to be safe. Enable
this option so that we can do fast mremap when possible.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b1a0e95c751..5d7c35c6f90c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -135,6 +135,7 @@ config ARM64
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP if NUMA
+	select HAVE_MOVE_PMD
 	select HAVE_NMI
 	select HAVE_PATA_PLATFORM
 	select HAVE_PERF_EVENTS
-- 
2.19.0.605.g01d371f741-goog
