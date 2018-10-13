From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 4/4] x86: select HAVE_MOVE_PMD for faster mremap (v1)
Date: Fri, 12 Oct 2018 18:32:00 -0700
Message-ID: <20181013013200.206928-5-joel@joelfernandes.org>
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
	List-Owner; bh=ON/gv0lkaw9MFzoqzIvquFOECS/57RdJ9D6T+OjDJ5Y=; b=FZOXszWU3CO3wI
	sRiszIF2RIdTniX07yUo9KquL5a1PgIz1kiQ8SjsiGxESw4IDW/JZUdNfx4cdaXWKsrNhs3bY0rA1
	0s06DMnk123tZT1hsSIC/uTw3pWtzEmv+s4iKfifgBj50GqXTZR/R+IJLrSfuyUc8dB5/GKia7KqE
	GQGpwJdoTIiPj7C1RNpm3jS/YmOdnGzKY4/Hx4GednIQaYZrtCa3CKfrMamFX9bIBJUntIdCwJzCG
	/Uwh1FWVrLLXLO8UA97IG2XVacmqnvKPHJg96KjiOQbNDs1stBwSeyQGgikcaa3b7mzdsh286Q79o
	eGH1FebUCtllks897Zlw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jtAK3pAlFMeOO6SUm8Lh3Bmb29tPAciRzUtn881iM5M=;
 b=hu1RRoD4zGFkh1NvswXMY0Mcf7RReZIxK6TbDCgMDMi1xCXvjQWNtmb8jA6UW1Q5ZI
 bybcFeJfratqjTeqEb7mRWAGReU9tL9VCuSkWsUqyCZbL3y+XtXFIKgHbMuC6INYU+VH
 z4FmPqYFb3J2yvvfenwn9pAR6sobi8QuQFyFE=
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

Moving page-tables at the PMD-level on x86 is known to be safe. Enable
this option so that we can do fast mremap when possible.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1a0be022f91d..01c02a9d7825 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -171,6 +171,7 @@ config X86
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_MIXED_BREAKPOINTS_REGS
 	select HAVE_MOD_ARCH_SPECIFIC
+	select HAVE_MOVE_PMD
 	select HAVE_NMI
 	select HAVE_OPROFILE
 	select HAVE_OPTPROBES
-- 
2.19.0.605.g01d371f741-goog
