From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH 20/21] mm: simplify find_min_pfn_with_active_regions()
Date: Sun, 12 Apr 2020 22:48:58 +0300
Message-ID: <20200412194859.12663-21-rppt@kernel.org>
References: <20200412194859.12663-1-rppt@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ctep9LhuSKUk5lBAABKLg3/VoVULRRluSQqB+u/n6TI=; b=tGbbQqBMhxcjSD
	zuYVMLpBOUESM+4cnoPJoQnuxSoCrnyXLP05Zy4weJmFe0V2NlXePtYEDIOZv+9H5bKbP295gYHpU
	h1xsW1CQStiXy8uHIqGn0BcAYMSm0+SNeGgyA2QoBU2Nojr1ZUDlNC6r5NNVEAiXVepaG41RY029T
	50kl5OnpwHLsCHjWGkuELtznpkgS6htOLlTmdGdHtp+edd3lFN+DOxSRPpQlsGwrraqLpgSpWCjVG
	XpDkAKZ+EpRZ/mcRO3llMNYPwlHdSjcilo90cR3H4rpe7yAUFDojPj1NUuJtF3GZ8A8qwKU+rGLUQ
	yucUg4ul+2HlY0M1Wbng==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586721253;
 bh=myYkWprg+WWiUHcdd6ZwCH3br4gnq7CtJsGPm4IVpVQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G2zxEyanO6auX9PlgDUIwafXaMtYsug93RcjOLLHmt/Mx4m5WfSWEfSMjB/3vOco8
 HD6WsW6NQOCBPpWxm7mQPG5SxNsta85Ooh54ZaibuDr4VLhx9Kf6+MK770FacD1L+U
 R99Kq+yNI2/XUURnheTplxnGlHscZKCl6IyGM+yo=
In-Reply-To: <20200412194859.12663-1-rppt@kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Mike Rapoport <rppt@linux.ibm.com>, Greg Ungerer <gerg@linux-m68k.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@in>

From: Mike Rapoport <rppt@linux.ibm.com>

The find_min_pfn_with_active_regions() calls find_min_pfn_for_node() with
nid parameter set to MAX_NUMNODES. This makes the find_min_pfn_for_node()
traverse all memblock memory regions although the first PFN in the system
can be easily found with memblock_start_of_DRAM().

Use memblock_start_of_DRAM() in find_min_pfn_with_active_regions() and drop
now unused find_min_pfn_for_node().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/page_alloc.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9af27ee784c7..e83f28d6074a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7071,24 +7071,6 @@ unsigned long __init node_map_pfn_alignment(void)
 	return ~accl_mask + 1;
 }
 
-/* Find the lowest pfn for a node */
-static unsigned long __init find_min_pfn_for_node(int nid)
-{
-	unsigned long min_pfn = ULONG_MAX;
-	unsigned long start_pfn;
-	int i;
-
-	for_each_mem_pfn_range(i, nid, &start_pfn, NULL, NULL)
-		min_pfn = min(min_pfn, start_pfn);
-
-	if (min_pfn == ULONG_MAX) {
-		pr_warn("Could not find start_pfn for node %d\n", nid);
-		return 0;
-	}
-
-	return min_pfn;
-}
-
 /**
  * find_min_pfn_with_active_regions - Find the minimum PFN registered
  *
@@ -7097,7 +7079,7 @@ static unsigned long __init find_min_pfn_for_node(int nid)
  */
 unsigned long __init find_min_pfn_with_active_regions(void)
 {
-	return find_min_pfn_for_node(MAX_NUMNODES);
+	return PHYS_PFN(memblock_start_of_DRAM());
 }
 
 /*
-- 
2.25.1


